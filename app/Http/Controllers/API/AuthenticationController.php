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
use Illuminate\Support\Facades\Log;

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
      Log::error('Failed to check SMS registration status: ' . $e->getMessage());
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
          ->where('user_role', 'Student')
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

        // Check id_info_status to determine redirect
        if ($studentInfo && strtolower($studentInfo->id_info_status) === 'pending') {
          $redirectTo = '/student-profile';
        } else {
          $redirectTo = '/';
        }
      }

      // Check account status
      if (strtolower($user->account_status) !== 'active') {
        return new JsonResponse([
          'success' => false,
          'error' => 'Account is not active'
        ], 403);
      }

      // ✅ TASKS 3 & 4: Fix last_successful_login timestamp
      $currentTimestamp = Carbon::now();
      DB::table('users')
        ->where('id', $user->id)
        ->update([
          'last_successful_login' => $currentTimestamp
        ]);

      Log::info('Timestamp Debug:', [
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
      Log::error('Login error: ' . $th->getMessage());
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

  // ============================================================
  // ✅ USER MANAGEMENT FUNCTIONS
  // ============================================================

  /**
   * Get all Admin users (Super Admin only)
   */
  public function getAdminUsers(Request $request): JsonResponse
  {
    try {
      $user = $request->user();

      if (!$user || $user->user_role !== 'Super Admin') {
        return new JsonResponse([
          'success' => false,
          'error' => 'Unauthorized. Super Admin access required.'
        ], 403);
      }

      $query = User::where('user_role', 'Admin');

      if ($request->has('search') && !empty($request->search)) {
        $search = $request->search;
        $query->where(function ($q) use ($search) {
          $q->where('username', 'like', "%{$search}%")
            ->orWhere('school_email', 'like', "%{$search}%")
            ->orWhere('account_name', 'like', "%{$search}%");
        });
      }

      if ($request->has('account_status') && !empty($request->account_status)) {
        $query->where('account_status', $request->account_status);
      }

      if ($request->has('school_code') && !empty($request->school_code)) {
        $query->where('school_code', $request->school_code);
      }

      $admins = $query->orderBy('created_at', 'desc')->orderBy('id', 'desc')->get();

      return new JsonResponse([
        'success' => true,
        'data' => $admins
      ], 200);

    } catch (\Throwable $th) {
      Log::error('Failed to fetch admin users: ' . $th->getMessage());
      return new JsonResponse([
        'success' => false,
        'error' => 'Failed to fetch admin users: ' . $th->getMessage()
      ], 500);
    }
  }

  /**
   * Create a new Admin user (Super Admin only) - WITHOUT MOBILE NUMBER
   */
  public function createAdminUser(Request $request): JsonResponse
  {
    try {
      $user = $request->user();

      if (!$user || $user->user_role !== 'Super Admin') {
        return new JsonResponse([
          'success' => false,
          'error' => 'Unauthorized. Super Admin access required.'
        ], 403);
      }

      $rules = [
        'username' => 'required|string|max:255|unique:users,username',
        'school_email' => 'required|email|max:255|unique:users,school_email',
        'account_name' => 'required|string|max:255',
        'school_code' => 'required|string|max:50|exists:school_id,school_code',
        'password' => 'required|string|min:8',
        'account_status' => 'required|in:active,inactive',
      ];

      $messages = [
        'username.required' => 'Username is required',
        'username.unique' => 'Username already exists',
        'school_email.required' => 'Email is required',
        'school_email.email' => 'Invalid email format',
        'school_email.unique' => 'Email already exists',
        'account_name.required' => 'Full name is required',
        'school_code.required' => 'School is required',
        'school_code.exists' => 'School not found',
        'password.required' => 'Password is required',
        'password.min' => 'Password must be at least 8 characters',
        'account_status.required' => 'Account status is required',
        'account_status.in' => 'Invalid account status',
      ];

      $validated = $request->validate($rules, $messages);

      $now = Carbon::now('Asia/Manila');

      $newAdmin = User::create([
        'username' => $validated['username'],
        'school_email' => $validated['school_email'],
        'account_name' => $validated['account_name'],
        'school_code' => $validated['school_code'],
        'password' => Hash::make($validated['password']),
        'user_role' => 'Admin',
        'account_status' => $validated['account_status'],
        'created_at' => $now,
      ]);

      Log::info('Admin user created successfully', [
        'user_id' => $newAdmin->id,
        'username' => $newAdmin->username,
        'school_code' => $newAdmin->school_code,
        'created_at' => $now,
        'created_by' => $user->id
      ]);

      $newAdminData = $newAdmin->toArray();
      unset($newAdminData['password']);

      return new JsonResponse([
        'success' => true,
        'data' => $newAdminData,
        'message' => 'Admin user created successfully'
      ], 201); 

    } catch (\Illuminate\Validation\ValidationException $e) {
      return new JsonResponse([
        'success' => false,
        'error' => 'Validation failed',
        'errors' => $e->errors()
      ], 422);
    } catch (\Illuminate\Database\QueryException $e) {
      Log::error('Database Error: ' . $e->getMessage());

      if (str_contains($e->getMessage(), 'Duplicate entry')) {
        if (str_contains($e->getMessage(), 'username')) {
          return new JsonResponse([
            'success' => false,
            'error' => 'Username already exists'
          ], 422);
        }
        if (str_contains($e->getMessage(), 'school_email')) {
          return new JsonResponse([
            'success' => false,
            'error' => 'Email already exists'
          ], 422);
        }
      }

      return new JsonResponse([
        'success' => false,
        'error' => 'Database error: ' . $e->getMessage()
      ], 500);
    } catch (\Exception $e) {
      Log::error('Failed to create admin user: ' . $e->getMessage());
      return new JsonResponse([
        'success' => false,
        'error' => 'Failed to create admin user: ' . $e->getMessage()
      ], 500);
    }
  }

  /**
   * Get single Admin user by ID (Super Admin only)
   */
  public function getAdminUser($id, Request $request): JsonResponse
  {
    try {
      $user = $request->user();

      if (!$user || $user->user_role !== 'Super Admin') {
        return new JsonResponse([
          'success' => false,
          'error' => 'Unauthorized. Super Admin access required.'
        ], 403);
      }

      $admin = User::where('id', $id)->where('user_role', 'Admin')->first();

      if (!$admin) {
        return new JsonResponse([
          'success' => false,
          'error' => 'Admin user not found'
        ], 404);
      }

      return new JsonResponse([
        'success' => true,
        'data' => $admin
      ], 200);

    } catch (\Throwable $th) {
      Log::error('Failed to fetch admin user: ' . $th->getMessage());
      return new JsonResponse([
        'success' => false,
        'error' => 'Failed to fetch admin user'
      ], 500);
    }
  }

  /**
   * Update Admin user (Super Admin only) - WITHOUT MOBILE NUMBER
   */
  public function updateAdminUser($id, Request $request): JsonResponse
  {
    try {
      $user = $request->user();

      if (!$user || $user->user_role !== 'Super Admin') {
        return new JsonResponse([
          'success' => false,
          'error' => 'Unauthorized. Super Admin access required.'
        ], 403);
      }

      $admin = User::where('id', $id)->where('user_role', 'Admin')->first();

      if (!$admin) {
        return new JsonResponse([
          'success' => false,
          'error' => 'Admin user not found'
        ], 404);
      }

      $validated = $request->validate([
        'username' => [
          'required',
          'string',
          'max:255',
          \Illuminate\Validation\Rule::unique('users', 'username')->ignore($id)
        ],
        'school_email' => [
          'required',
          'email',
          'max:255',
          \Illuminate\Validation\Rule::unique('users', 'school_email')->ignore($id)
        ],
        'account_name' => 'required|string|max:255',
        'school_code' => 'required|string|max:50',
        'account_status' => 'required|in:active,inactive',
      ]);

      $school = DB::table('school_id')->where('school_code', $validated['school_code'])->first();
      if (!$school) {
        return new JsonResponse([
          'success' => false,
          'error' => 'School not found. Please check the school code.'
        ], 422);
      }

      $admin->update([
        'username' => $validated['username'],
        'school_email' => $validated['school_email'],
        'account_name' => $validated['account_name'],
        'school_code' => $validated['school_code'],
        'account_status' => $validated['account_status'],
      ]);

      Log::info('Admin user updated', [
        'user_id' => $admin->id,
        'username' => $admin->username,
        'updated_by' => $user->id
      ]);

      $adminData = $admin->toArray();
      unset($adminData['password']);

      return new JsonResponse([
        'success' => true,
        'data' => $adminData,
        'message' => 'Admin user updated successfully'
      ], 200);

    } catch (\Illuminate\Validation\ValidationException $e) {
      return new JsonResponse([
        'success' => false,
        'error' => 'Validation failed',
        'errors' => $e->errors()
      ], 422);
    } catch (\Exception $e) {
      Log::error('Failed to update admin user: ' . $e->getMessage());
      return new JsonResponse([
        'success' => false,
        'error' => 'Failed to update admin user: ' . $e->getMessage()
      ], 500);
    }
  }

  /**
   * Reset Admin user password (Super Admin only)
   */
  public function resetAdminUserPassword($id, Request $request): JsonResponse
  {
    try {
      $user = $request->user();

      if (!$user || $user->user_role !== 'Super Admin') {
        return new JsonResponse([
          'success' => false,
          'error' => 'Unauthorized. Super Admin access required.'
        ], 403);
      }

      $admin = User::where('id', $id)->where('user_role', 'Admin')->first();

      if (!$admin) {
        return new JsonResponse([
          'success' => false,
          'error' => 'Admin user not found'
        ], 404);
      }

      $validated = $request->validate([
        'password' => 'required|string|min:8',
      ]);

      $admin->password = Hash::make($validated['password']);
      $admin->save();

      Log::info('Password reset for admin user', [
        'user_id' => $admin->id,
        'username' => $admin->username,
        'reset_by' => $user->id
      ]);

      return new JsonResponse([
        'success' => true,
        'message' => 'Password reset successfully'
      ], 200);

    } catch (\Illuminate\Validation\ValidationException $e) {
      return new JsonResponse([
        'success' => false,
        'error' => 'Validation failed',
        'errors' => $e->errors()
      ], 422);
    } catch (\Exception $e) {
      Log::error('Failed to reset password: ' . $e->getMessage());
      return new JsonResponse([
        'success' => false,
        'error' => 'Failed to reset password: ' . $e->getMessage()
      ], 500);
    }
  }

  /**
   * Get all schools for dropdown (Super Admin only)
   */
  public function getSchoolsList(Request $request): JsonResponse
  {
    try {
      $user = $request->user();

      if (!$user || $user->user_role !== 'Super Admin') {
        return new JsonResponse([
          'success' => false,
          'error' => 'Unauthorized. Super Admin access required.'
        ], 403);
      }

      $schools = DB::table('school_id')
        ->select('school_code', 'school_name')
        ->orderBy('school_name')
        ->get();

      return new JsonResponse([
        'success' => true,
        'data' => $schools
      ], 200);

    } catch (\Throwable $th) {
      Log::error('Failed to fetch schools list: ' . $th->getMessage());
      return new JsonResponse([
        'success' => false,
        'error' => 'Failed to fetch schools'
      ], 500);
    }
  }
}