<?php

namespace App\Http\Controllers\API;

use App\Helpers\Tokens;
use App\Http\Controllers\Controller;
use App\Models\StudentIdInfo;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\RateLimiter;
use Illuminate\Http\JsonResponse;

class AuthenticationController extends Controller
{
  /**
   * Authenticate admin/super admin or student login (unified endpoint)
   */
  public function verify_user_account(Request $request): JsonResponse
  {
    try {
      // Check if it's admin login (username + password)
      $isAdminLogin = $request->has('username') && $request->has('password');

      // Check if it's student login (school_code + student_id + mobile_no)
      $isStudentLogin = $request->has('school_code') && $request->has('student_id') && $request->has('mobile_no');

      if (!$isAdminLogin && !$isStudentLogin) {
        return new JsonResponse([
          'success' => false,
          'error' => 'Invalid login credentials'
        ], 400);
      }

      $key = 'user_login:' . $request->ip();

      if (RateLimiter::tooManyAttempts($key, 5)) {
        return new JsonResponse([
          'success' => false,
          'error' => 'Too many login attempts'
        ], 429);
      }

      $user = null;

      // Handle Admin Login
      if ($isAdminLogin) {
        $user = User::where('username', $request->username)
          ->whereIn('user_role', ['Super Admin', 'Admin'])
          ->first();

        if (!$user) {
          RateLimiter::hit($key, 60);
          return new JsonResponse([
            'success' => false,
            'error' => 'Invalid username or password'
          ], 401);
        }

        if (!Hash::check($request->password, $user->password)) {
          RateLimiter::hit($key, 60);
          return new JsonResponse([
            'success' => false,
            'error' => 'Invalid username or password'
          ], 401);
        }
      }

      // Handle Student Login
      if ($isStudentLogin) {
        // Find the user
        $user = User::where('student_id', $request->student_id)
          ->where('school_code', $request->school_code)
          ->first();

        if (!$user) {
          // Get student info for creating user
          $studentInfo = StudentIdInfo::where('student_id', $request->student_id)
            ->where('school_code', $request->school_code)
            ->first();

          if (!$studentInfo) {
            RateLimiter::hit($key, 60);
            return new JsonResponse([
              'success' => false,
              'error' => 'Student record not found'
            ], 401);
          }

          // Create new user
          $user = User::create([
            'student_id' => $request->student_id,
            'school_code' => $request->school_code,
            'user_role' => 'Student',
            'mobile_number' => $request->mobile_no,
            'account_name' => trim(
              $studentInfo->first_name . ' ' .
              ($studentInfo->middle_initial ? $studentInfo->middle_initial . '. ' : '') .
              $studentInfo->surname .
              ($studentInfo->suffix_name ? ' ' . $studentInfo->suffix_name : '')
            ),
            'account_status' => $studentInfo->account_status ?? 'active',
            'email' => $studentInfo->parent_email,
          ]);
        } else {
          // Update existing user if needed
          $updated = false;

          if ($user->user_role !== 'Student') {
            $user->user_role = 'Student';
            $updated = true;
          }

          if ($user->mobile_number !== $request->mobile_no) {
            $user->mobile_number = $request->mobile_no;
            $updated = true;
          }

          if ($updated) {
            $user->save();
          }
        }
      }

      // Check account status
      if (strtolower($user->account_status) !== 'active') {
        return new JsonResponse([
          'success' => false,
          'error' => 'Account is not active'
        ], 403);
      }

      RateLimiter::clear($key);

      // Delete existing tokens
      Tokens::deleteAllUserTokens($user);

      // Create tokens
      $accessToken = Tokens::createAccessToken($user);
      $refreshToken = Tokens::createRefreshToken($user);
      $accessExpiresAt = now()->addHours(8);

      // Prepare user data
      $userData = [
        'id' => $user->id,
        'username' => $user->username,
        'email' => $user->email,
        'account_name' => $user->account_name,
        'role' => $user->user_role,
        'account_status' => $user->account_status,
        'user_level' => in_array($user->user_role, ['Super Admin', 'Admin']) ? 'admin' : 'student',
      ];

      // Add student_id and school_code for student login
      if ($user->user_role === 'Student') {
        $userData['student_id'] = $user->student_id;
        $userData['school_code'] = $user->school_code;

        $studentInfo = StudentIdInfo::where('student_id', $user->student_id)
          ->where('school_code', $user->school_code)
          ->first();

        if ($studentInfo) {
          $userData['student_info'] = [
            'first_name' => $studentInfo->first_name,
            'surname' => $studentInfo->surname,
            'level' => $studentInfo->level,
            'section_course' => $studentInfo->section_course,
          ];
        }
      }

      $responseMessage = in_array($user->user_role, ['Super Admin', 'Admin'])
        ? $user->user_role . ' login successful'
        : 'Student login successful';

      // Create response
      $response = new JsonResponse([
        'success' => true,
        'response' => $responseMessage,
        'user' => $userData,
        'access_token' => $accessToken,
        'access_expires_at' => $accessExpiresAt->toDateTimeString(),
      ], 200);

      // Set refresh token cookie
      $response->headers->setCookie(
        cookie(
          'refresh_token',
          $refreshToken,
          20160,
          '/',
          null,
          false,
          true,
          false,
          'lax'
        )
      );

      return $response;

    } catch (\Throwable $th) {
      return new JsonResponse([
        'success' => false,
        'error' => 'Cannot login: ' . $th->getMessage()
      ], 500);
    }
  }

  /**
   * Refresh access token
   */
  public function refresh(Request $request): JsonResponse
  {
    try {
      $refreshToken = $request->cookie('refresh_token');

      if (!$refreshToken) {
        return new JsonResponse([
          'success' => false,
          'error' => 'No refresh token provided'
        ], 401);
      }

      // Use helper to refresh token
      $newAccessToken = Tokens::refreshToken($refreshToken);

      if (!$newAccessToken) {
        return new JsonResponse([
          'success' => false,
          'error' => 'Invalid or expired refresh token'
        ], 401);
      }

      return new JsonResponse([
        'success' => true,
        'access_token' => $newAccessToken,
        'access_expires_at' => now()->addHours(8)->toDateTimeString()
      ], 200);

    } catch (\Throwable $th) {
      return new JsonResponse([
        'success' => false,
        'error' => 'Failed to refresh token'
      ], 500);
    }
  }

  /**
   * Logout user
   */
  public function logout(Request $request): JsonResponse
  {
    try {
      $user = $request->user();

      if (!$user) {
        return new JsonResponse([
          'success' => false,
          'error' => 'Please login first'
        ], 401);
      }

      // Delete all user tokens using helper
      Tokens::deleteAllUserTokens($user);

      $response = new JsonResponse([
        'success' => true,
        'response' => 'Logged out successfully'
      ], 200);

      $response->headers->setCookie(cookie()->forget('refresh_token'));

      return $response;

    } catch (\Throwable $th) {
      return new JsonResponse([
        'success' => false,
        'error' => 'Failed to logout'
      ], 500);
    }
  }

  /**
   * Get authenticated user
   */
  public function user(Request $request): JsonResponse
  {
    try {
      $user = $request->user();

      if (!$user) {
        return new JsonResponse([
          'success' => false,
          'error' => 'Unauthenticated'
        ], 401);
      }

      return new JsonResponse([
        'success' => true,
        'user' => [
          'id' => $user->id,
          'username' => $user->username,
          'email' => $user->email,
          'role' => $user->user_role,
          'account_status' => $user->account_status,
        ]
      ], 200);

    } catch (\Throwable $th) {
      return new JsonResponse([
        'success' => false,
        'error' => 'Failed to get user'
      ], 500);
    }
  }

  /**
   * Get user role (for frontend)
   */
  public function user_role(Request $request): JsonResponse
  {
    try {
      $user = $request->user();

      if (!$user) {
        return new JsonResponse([
          'success' => false,
          'error' => 'Unauthenticated'
        ], 401);
      }

      return new JsonResponse([
        'success' => true,
        'role' => $user->user_role
      ], 200);

    } catch (\Throwable $th) {
      return new JsonResponse([
        'success' => false,
        'error' => 'Failed to get user role'
      ], 500);
    }
  }
}