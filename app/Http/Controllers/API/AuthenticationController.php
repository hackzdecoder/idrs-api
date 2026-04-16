<?php

namespace App\Http\Controllers\API;

use App\Helpers\Tokens;
use App\Http\Controllers\Controller;
use App\Models\StudentIdInfo;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\RateLimiter;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\JsonResponse;
use Carbon\Carbon;

class AuthenticationController extends Controller
{
  /**
   * ✅ TASK 1 & 3: Check if mobile number and school code are already registered in SMS database
   * 
   * @param string $mobileNumber The emergency contact number
   * @param string $schoolCode The school code
   * @return array Registration status
   */
  private function checkSmsRegistrationStatus($mobileNumber, $schoolCode): array
  {
    try {
      if (empty($mobileNumber) || empty($schoolCode)) {
        return [
          'is_registered' => false,
          'has_credentials' => false
        ];
      }

      // Check if mobile number exists in SMS users database for this specific school
      $smsUser = DB::connection('sms_users')
        ->table('users')
        ->where('user_id', $mobileNumber)
        ->where('school_code', $schoolCode)
        ->first();

      if (!$smsUser) {
        $smsUser = DB::connection('sms_users')
          ->table('users')
          ->where('username', $mobileNumber)
          ->where('school_code', $schoolCode)
          ->first();
      }

      if (!$smsUser) {
        return [
          'is_registered' => false,
          'has_credentials' => false
        ];
      }

      // Check student_id_info for matching school_code and sms_app_credentials = 'yes'
      $studentInfo = StudentIdInfo::where('emergency_contact_number', $mobileNumber)
        ->where('school_code', $schoolCode)
        ->first();

      $hasCredentials = $studentInfo && $studentInfo->sms_app_credentials === 'yes';

      return [
        'is_registered' => true,
        'has_credentials' => $hasCredentials
      ];
    } catch (\Exception $e) {
      \Log::error('Failed to check SMS registration status: ' . $e->getMessage());
      return [
        'is_registered' => false,
        'has_credentials' => false
      ];
    }
  }

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
      $studentInfo = null;
      $redirectTo = null;
      $smsStatus = ['is_registered' => false, 'has_credentials' => false];

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
        // ✅ TASK 7: Only allow users with 'Student' role to login via student page
        $user = User::where('student_id', $request->student_id)
          ->where('school_code', $request->school_code)
          ->where('mobile_number', $request->mobile_no)
          ->where('user_role', 'Student')  // ✅ Prevents Super Admin/Admin from student login
          ->first();

        if (!$user) {
          RateLimiter::hit($key, 60);
          return new JsonResponse([
            'success' => false,
            'error' => 'Invalid student credentials'
          ], 401);
        }

        // Get student info from student_id_info table
        $studentInfo = StudentIdInfo::where('student_id', $request->student_id)
          ->where('school_code', $request->school_code)
          ->first();

        // ✅ TASK 1: Check SMS registration status with mobile number AND school code
        $smsStatus = $this->checkSmsRegistrationStatus($request->mobile_no, $request->school_code);

        // Log the result for debugging
        \Log::info('SMS Registration Check Result', [
          'student_id' => $request->student_id,
          'mobile_number' => $request->mobile_no,
          'school_code' => $request->school_code,
          'is_registered' => $smsStatus['is_registered'],
          'has_credentials' => $smsStatus['has_credentials']
        ]);

        // Check id_info_status to determine redirect
        if ($studentInfo && strtolower($studentInfo->id_info_status) === 'pending') {
          $redirectTo = '/profile'; // Redirect to profile page for pending approval
        } else {
          $redirectTo = '/'; // Redirect to dashboard for approved/completed
        }
      }

      // Check account status
      if (strtolower($user->account_status) !== 'active') {
        return new JsonResponse([
          'success' => false,
          'error' => 'Account is not active'
        ], 403);
      }

      // ✅ TASKS 3 & 4: Fix last_successful_login timestamp (matching working pattern)
      $currentTimestamp = Carbon::now();
      DB::table('users')
        ->where('id', $user->id)
        ->update([
          'last_successful_login' => $currentTimestamp
        ]);

      \Log::info('Timestamp Debug:', [
        'carbon_now' => Carbon::now()->toDateTimeString(),
        'carbon_asia' => Carbon::now('Asia/Manila')->toDateTimeString(),
        'php_timezone' => date_default_timezone_get(),
        'config_timezone' => config('app.timezone'),
        'timestamp_saved' => $currentTimestamp
      ]);

      RateLimiter::clear($key);

      // Delete existing tokens
      Tokens::deleteAllUserTokens($user);

      // Create tokens
      $accessToken = Tokens::createAccessToken($user);
      $refreshToken = Tokens::createRefreshToken($user);
      $accessExpiresAt = Carbon::now('Asia/Manila')->addHours(8);

      // Prepare user data
      $userData = [
        'id' => $user->id,
        'username' => $user->username,
        'email' => $user->school_email ?? $user->email ?? null,
        'account_name' => $user->account_name,
        'role' => $user->user_role,
        'account_status' => $user->account_status,
        'user_level' => in_array($user->user_role, ['Super Admin', 'Admin']) ? 'admin' : 'student',
      ];

      // Add student_id and school_code for student login
      if ($user->user_role === 'Student') {
        $userData['student_id'] = $user->student_id;
        $userData['school_code'] = $user->school_code;
        $userData['redirect_to'] = $redirectTo;

        // ✅ TASK 1: Add SMS registration status to login response
        $userData['sms_registered'] = $smsStatus['is_registered'];
        $userData['sms_credentials_exist'] = $smsStatus['has_credentials'];

        if ($studentInfo) {
          $userData['student_info'] = [
            'first_name' => $studentInfo->first_name,
            'surname' => $studentInfo->surname,
            'level' => $studentInfo->level,
            'section_course' => $studentInfo->section_course,
            'id_info_status' => $studentInfo->id_info_status,
            'sms_app_credentials' => $studentInfo->sms_app_credentials,
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
        'redirect_to' => $redirectTo,
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
      \Log::error('Login error: ' . $th->getMessage());
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
        'access_expires_at' => Carbon::now('Asia/Manila')->addHours(8)->toDateTimeString()
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
          'email' => $user->school_email ?? null,
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