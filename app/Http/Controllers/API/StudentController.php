<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\StudentIdInfo;
use App\Models\SchoolId;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Mail;
use Carbon\Carbon;
use App\Helpers\DatabaseManager;

class StudentController extends Controller
{
  /**
   * Get student profile (for student dashboard)
   */
  public function student_profile(Request $request): JsonResponse
  {
    try {
      $user = $request->user();

      if (!$user) {
        return new JsonResponse([
          'success' => false,
          'error' => 'Unauthorized - No user found'
        ], 401);
      }

      if ($user->user_role !== 'Student') {
        return new JsonResponse([
          'success' => false,
          'error' => 'Unauthorized - User is not a student'
        ], 403);
      }

      if (!$user->student_id || !$user->school_code) {
        return new JsonResponse([
          'success' => false,
          'error' => 'Student information not found - missing student_id or school_code'
        ], 404);
      }

      $studentInfo = StudentIdInfo::withUser()
        ->where('student_id', $user->student_id)
        ->where('school_code', $user->school_code)
        ->first();

      if (!$studentInfo) {
        return new JsonResponse([
          'success' => false,
          'error' => 'Student profile not found'
        ], 404);
      }

      // Check if SMS credentials already exist
      $smsCredentialsExist = $studentInfo->sms_app_credentials === 'yes';

      $fullName = trim(
        $studentInfo->first_name . ' ' .
        ($studentInfo->middle_initial ? $studentInfo->middle_initial . '. ' : '') .
        $studentInfo->surname .
        ($studentInfo->suffix_name ? ' ' . $studentInfo->suffix_name : '')
      );

      return new JsonResponse([
        'success' => true,
        'data' => [
          'id' => $studentInfo->id,
          'student_id' => $studentInfo->student_id,
          'school_code' => $studentInfo->school_code,
          'first_name' => $studentInfo->first_name,
          'middle_initial' => $studentInfo->middle_initial,
          'surname' => $studentInfo->surname,
          'suffix_name' => $studentInfo->suffix_name,
          'full_name' => $fullName,
          'email' => $studentInfo->user->school_email ?? null,
          'username' => $studentInfo->user->username ?? null,
          'name_to_appear_on_id' => $studentInfo->name_to_appear_on_id,
          'nick_name' => $studentInfo->nick_name,
          'birth_date' => $studentInfo->birth_date,
          'gender' => $studentInfo->gender,
          'residential_address' => $studentInfo->residential_address,
          'emergency_contact_person' => $studentInfo->emergency_contact_person,
          'emergency_contact_number' => $studentInfo->emergency_contact_number,
          'level' => $studentInfo->level,
          'section_course' => $studentInfo->section_course,
          'lrn' => $studentInfo->lrn,
          'student_type' => $studentInfo->student_type,
          'esc_voucher_recipient' => $studentInfo->esc_voucher_recipient,
          'esc_number' => $studentInfo->esc_number,
          'parent_first_name' => $studentInfo->parent_first_name,
          'parent_surname' => $studentInfo->parent_surname,
          'parent_email' => $studentInfo->parent_email,
          'id_info_status' => $studentInfo->id_info_status,
          'class_details_status' => $studentInfo->class_details_status,
          'id_print_status' => $studentInfo->id_print_status,
          'id_reprint_status' => $studentInfo->id_reprint_status,
          'id_reprint_count' => $studentInfo->id_reprint_count,
          'created_at' => $studentInfo->created_at,
          'sms_app_credentials' => $studentInfo->sms_app_credentials,
          'sms_app_created_at' => $studentInfo->sms_app_created_at,
          'sms_credentials_exist' => $smsCredentialsExist,
        ]
      ], 200);

    } catch (\Throwable $th) {
      Log::error('Student profile fetch error: ' . $th->getMessage());
      return new JsonResponse([
        'success' => false,
        'error' => 'Failed to fetch student profile'
      ], 500);
    }
  }

  /**
   * Get student information list (for authenticated student)
   */
  public function student_information_lists(Request $request): JsonResponse
  {
    try {
      $user = $request->user();

      if (!$user) {
        return new JsonResponse([
          'success' => false,
          'error' => 'Unauthorized'
        ], 401);
      }

      if (!$user->student_id || !$user->school_code) {
        return new JsonResponse([
          'success' => false,
          'error' => 'Student information not found'
        ], 404);
      }

      $student = StudentIdInfo::withUser()
        ->where('student_id', $user->student_id)
        ->where('school_code', $user->school_code)
        ->first();

      if (!$student) {
        return new JsonResponse([
          'success' => false,
          'error' => 'Student profile not found'
        ], 404);
      }

      $fullName = trim(
        $student->first_name . ' ' .
        ($student->middle_initial ? $student->middle_initial . '. ' : '') .
        $student->surname .
        ($student->suffix_name ? ' ' . $student->suffix_name : '')
      );

      $studentData = [
        'id' => $student->id,
        'student_id' => $student->student_id,
        'school_code' => $student->school_code,
        'full_name' => $fullName,
        'first_name' => $student->first_name,
        'surname' => $student->surname,
        'middle_initial' => $student->middle_initial,
        'suffix_name' => $student->suffix_name,
        'email' => $student->user->school_email ?? null,
        'username' => $student->user->username ?? null,
        'level' => $student->level,
        'section_course' => $student->section_course,
        'lrn' => $student->lrn,
        'student_type' => $student->student_type,
        'id_info_status' => $student->id_info_status,
        'class_details_status' => $student->class_details_status,
        'id_print_status' => $student->id_print_status,
        'id_reprint_count' => $student->id_reprint_count,
        'residential_address' => $student->residential_address,
        'parent_full_name' => $student->parent_first_name && $student->parent_surname
          ? $student->parent_first_name . ' ' . $student->parent_surname
          : null,
        'parent_email' => $student->parent_email,
        'emergency_contact' => $student->emergency_contact_person && $student->emergency_contact_number
          ? $student->emergency_contact_person . ' - ' . $student->emergency_contact_number
          : null,
        'created_at' => $student->created_at,
      ];

      return new JsonResponse([
        'success' => true,
        'data' => $studentData
      ], 200);

    } catch (\Throwable $th) {
      Log::error('Failed to fetch student information: ' . $th->getMessage());
      return new JsonResponse([
        'success' => false,
        'error' => 'Failed to fetch student information'
      ], 500);
    }
  }

  /**
   * Get all students list with filters using Query Scopes
   * For Admin: filters by their school_code
   * For Super Admin: shows all students
   */
  public function index(Request $request): JsonResponse
  {
    try {
      $user = $request->user();

      $query = StudentIdInfo::query()
        ->withUser()
        ->bySchoolCode($request->school_code)
        ->byStudentId($request->student_id)
        ->byStudentType($request->student_type)
        ->byLevel($request->level)
        ->bySectionCourse($request->section_course)
        ->byIdInfoStatus($request->id_info_status)
        ->byClassDetailsStatus($request->class_details_status)
        ->byIdPrintStatus($request->id_print_status)
        ->byIdReprintStatus($request->id_reprint_status)
        ->byAccountStatus($request->account_status)
        ->byDateRange($request->date_from, $request->date_to)
        ->byIdInfoApprovalDateRange($request->id_info_approval_date_from, $request->id_info_approval_date_to)
        ->byClassDetailsApprovalDateRange($request->class_details_approval_date_from, $request->class_details_approval_date_to)
        ->byEmail($request->email)
        ->latest();

      if ($user && $user->user_role === 'Admin') {
        $query->where('school_code', $user->school_code);
      }

      $students = $query->get();

      $studentData = $students->map(function ($student) {
        $fullName = trim(
          $student->first_name . ' ' .
          ($student->middle_initial ? $student->middle_initial . '. ' : '') .
          $student->surname .
          ($student->suffix_name ? ' ' . $student->suffix_name : '')
        );

        return [
          'id' => $student->id,
          'student_id' => $student->student_id,
          'school_code' => $student->school_code,
          'full_name' => $fullName,
          'first_name' => $student->first_name,
          'surname' => $student->surname,
          'middle_initial' => $student->middle_initial,
          'suffix_name' => $student->suffix_name,
          'email' => $student->user->school_email ?? null,
          'username' => $student->user->username ?? null,
          'level' => $student->level,
          'section_course' => $student->section_course,
          'lrn' => $student->lrn,
          'student_type' => $student->student_type,
          'id_info_status' => $student->id_info_status,
          'class_details_status' => $student->class_details_status,
          'id_print_status' => $student->id_print_status,
          'id_reprint_status' => $student->id_reprint_status,
          'id_reprint_count' => $student->id_reprint_count ?? 0,
          'residential_address' => $student->residential_address,
          'parent_full_name' => $student->parent_first_name && $student->parent_surname
            ? $student->parent_first_name . ' ' . $student->parent_surname
            : null,
          'parent_email' => $student->parent_email,
          'emergency_contact' => $student->emergency_contact_person && $student->emergency_contact_number
            ? $student->emergency_contact_person . ' - ' . $student->emergency_contact_number
            : null,
          'created_at' => $student->created_at,
          'name_to_appear_on_id' => $student->name_to_appear_on_id,
          'nick_name' => $student->nick_name,
          'birth_date' => $student->birth_date,
          'gender' => $student->gender,
          'esc_voucher_recipient' => $student->esc_voucher_recipient,
          'esc_number' => $student->esc_number,
          'id_info_approval_date' => $student->id_info_approval_date,
          'class_details_approval_date' => $student->class_details_approval_date,
          'id_print_date' => $student->id_print_date,
          'id_reprint_date' => $student->id_reprint_date,
          'sms_app_credentials' => $student->sms_app_credentials,
          'sms_app_created_at' => $student->sms_app_created_at,
        ];
      });

      return new JsonResponse([
        'success' => true,
        'data' => $studentData
      ], 200);

    } catch (\Throwable $th) {
      Log::error('Failed to fetch students: ' . $th->getMessage());
      return new JsonResponse([
        'success' => false,
        'error' => 'Failed to fetch students'
      ], 500);
    }
  }

  /**
   * Update student profile
   */
  public function student_profile_update(Request $request): JsonResponse
  {
    try {
      $user = $request->user();

      if (!$user || $user->user_role !== 'Student') {
        return new JsonResponse([
          'success' => false,
          'error' => 'Unauthorized'
        ], 401);
      }

      $studentInfo = StudentIdInfo::where('student_id', $user->student_id)
        ->where('school_code', $user->school_code)
        ->first();

      if (!$studentInfo) {
        return new JsonResponse([
          'success' => false,
          'error' => 'Student profile not found'
        ], 404);
      }

      $validated = $request->validate([
        'first_name' => 'sometimes|string|max:255',
        'middle_initial' => 'nullable|string|max:255',
        'surname' => 'sometimes|string|max:255',
        'suffix_name' => 'nullable|string|max:50',
        'nick_name' => 'nullable|string|max:255',
        'birth_date' => 'nullable|date',
        'gender' => 'nullable|string|in:Male,Female,Other',
        'residential_address' => 'nullable|string',
        'emergency_contact_person' => 'nullable|string|max:255',
        'emergency_contact_number' => 'nullable|string|max:20',
        'parent_first_name' => 'nullable|string|max:255',
        'parent_surname' => 'nullable|string|max:255',
        'parent_email' => 'nullable|email|max:255',
        'name_to_appear_on_id' => 'nullable|string|max:255',
        'esc_voucher_recipient' => 'nullable|boolean',
        'esc_number' => 'nullable|string|max:255',
        'password' => 'nullable|string|min:8',
      ]);

      $dataToUpdate = [];
      foreach ($validated as $key => $value) {
        if ($value === '') {
          $dataToUpdate[$key] = null;
        } else {
          $dataToUpdate[$key] = $value;
        }
      }

      $dataToUpdate['id_info_status'] = 'approved';

      $studentInfo->update($dataToUpdate);

      // ✅ TASK 1: Update id_info_approval_date using DB facade directly
      if (app()->environment('production')) {
        DB::table('student_id_info')
          ->where('student_id', $user->student_id)
          ->where('school_code', $user->school_code)
          ->update([
            'id_info_approval_date' => DB::raw("NOW()")
          ]);
      } else {
        DB::table('student_id_info')
          ->where('student_id', $user->student_id)
          ->where('school_code', $user->school_code)
          ->update([
            'id_info_approval_date' => Carbon::now('Asia/Manila')
          ]);
      }

      // Update user record with required fields (IDRS users table)
      $userUpdates = [];
      $userUpdates['account_status'] = 'active';

      if (!empty($studentInfo->emergency_contact_number)) {
        $userUpdates['mobile_number'] = $studentInfo->emergency_contact_number;
      }

      if (!empty($validated['password'])) {
        $userUpdates['password'] = Hash::make($validated['password']);
      }

      if (!empty($studentInfo->parent_email)) {
        $userUpdates['school_email'] = $studentInfo->parent_email;
      }

      if (empty($user->username)) {
        $username = strtolower(substr($studentInfo->first_name, 0, 1) . $studentInfo->surname);
        $userUpdates['username'] = $username;
      }

      // Update account name
      $fullName = trim(
        ($validated['first_name'] ?? $studentInfo->first_name) . ' ' .
        (($validated['middle_initial'] ?? $studentInfo->middle_initial) ? ($validated['middle_initial'] ?? $studentInfo->middle_initial) . ' ' : '') .
        ($validated['surname'] ?? $studentInfo->surname)
      );
      $userUpdates['account_name'] = $fullName;

      if (!empty($userUpdates)) {
        $user->update($userUpdates);
      }

      // ============================================================
      // CHECK IF USER ALREADY EXISTS IN SMS DATABASE
      // ============================================================
      $userId = $studentInfo->emergency_contact_number;
      $email = $studentInfo->parent_email;
      $existingSmsUser = null;
      $smsUserCreated = false;

      if (!empty($userId)) {
        try {
          $existingSmsUser = DB::connection('sms_users')
            ->table('users')
            ->where('user_id', $userId)
            ->orWhere('username', $userId)
            ->orWhere('email', $email)
            ->first();

          Log::info('SMS User check', [
            'user_id' => $userId,
            'email' => $email,
            'found' => $existingSmsUser ? 'Yes' : 'No'
          ]);
        } catch (\Exception $e) {
          Log::error('Failed to check existing SMS user: ' . $e->getMessage());
        }
      } else {
        Log::warning("No emergency contact number for student: {$studentInfo->student_id}");
      }

      // ============================================================
      // TASK 13: Create OR UPDATE login credential in SMS users database
      // ============================================================
      try {
        $this->syncSmsUser($studentInfo, $validated);
        $smsUserCreated = true;
      } catch (\Exception $e) {
        Log::error('TASK 13 FAILED (SMS User): ' . $e->getMessage());
      }

      if ($smsUserCreated) {
        $studentInfo->sms_app_credentials = 'yes';
        $studentInfo->save();

        // ✅ TASK 2: Update sms_app_created_at using DB facade directly
        if (app()->environment('production')) {
          DB::table('student_id_info')
            ->where('student_id', $user->student_id)
            ->where('school_code', $user->school_code)
            ->update([
              'sms_app_created_at' => DB::raw("NOW()")
            ]);
        } else {
          DB::table('student_id_info')
            ->where('student_id', $user->student_id)
            ->where('school_code', $user->school_code)
            ->update([
              'sms_app_created_at' => Carbon::now('Asia/Manila')
            ]);
        }

        $studentInfo->refresh();
        Log::info("Updated sms_app_credentials to 'yes' for student: {$studentInfo->student_id}");
      }

      // ============================================================
      // TASK 14: Create student record in school-specific database
      // ============================================================
      if (!$existingSmsUser) {
        try {
          $this->syncStudentRecord($studentInfo, $validated);
        } catch (\Exception $e) {
          Log::error('TASK 14 FAILED (Student Record): ' . $e->getMessage());
        }
      } else {
        Log::info("Skipping student record creation because SMS user already exists.");
      }

      // ============================================================
      // TASK 15: Send email to parent/guardian
      // ============================================================
      try {
        $this->sendParentEmail($studentInfo, $validated);
      } catch (\Exception $e) {
        Log::error('TASK 15 FAILED (Email): ' . $e->getMessage());
      }

      $studentInfo->refresh();

      return new JsonResponse([
        'success' => true,
        'response' => 'Profile updated and approved successfully',
        'data' => [
          'id' => $studentInfo->id,
          'student_id' => $studentInfo->student_id,
          'school_code' => $studentInfo->school_code,
          'first_name' => $studentInfo->first_name,
          'middle_initial' => $studentInfo->middle_initial,
          'surname' => $studentInfo->surname,
          'suffix_name' => $studentInfo->suffix_name,
          'full_name' => $fullName,
          'email' => $user->school_email ?? null,
          'username' => $user->username ?? null,
          'nick_name' => $studentInfo->nick_name,
          'birth_date' => $studentInfo->birth_date,
          'gender' => $studentInfo->gender,
          'residential_address' => $studentInfo->residential_address,
          'emergency_contact_person' => $studentInfo->emergency_contact_person,
          'emergency_contact_number' => $studentInfo->emergency_contact_number,
          'level' => $studentInfo->level,
          'section_course' => $studentInfo->section_course,
          'lrn' => $studentInfo->lrn,
          'student_type' => $studentInfo->student_type,
          'id_info_status' => $studentInfo->id_info_status,
          'id_info_approval_date' => $studentInfo->id_info_approval_date,
          'class_details_status' => $studentInfo->class_details_status,
          'id_print_status' => $studentInfo->id_print_status,
          'id_reprint_count' => $studentInfo->id_reprint_count,
          'created_at' => $studentInfo->created_at,
          'parent_first_name' => $studentInfo->parent_first_name,
          'parent_surname' => $studentInfo->parent_surname,
          'parent_email' => $studentInfo->parent_email,
          'sms_app_credentials' => $studentInfo->sms_app_credentials,
          'sms_app_created_at' => $studentInfo->sms_app_created_at,
        ]
      ], 200);

    } catch (\Illuminate\Validation\ValidationException $e) {
      return new JsonResponse([
        'success' => false,
        'error' => 'Validation failed',
        'errors' => $e->errors()
      ], 422);
    } catch (\Throwable $th) {
      Log::error('Failed to update profile: ' . $th->getMessage());
      Log::error('File: ' . $th->getFile() . ' Line: ' . $th->getLine());

      return new JsonResponse([
        'success' => false,
        'error' => 'Failed to update profile: ' . $th->getMessage()
      ], 500);
    }
  }

  /**
   * TASK 13: Sync user to SMS users database
   * Check existing before creating - UPDATE if exists
   */
  private function syncSmsUser($studentInfo, $validated): void
  {
    try {
      $schoolCode = strtoupper($studentInfo->school_code);

      $userId = $studentInfo->emergency_contact_number;
      $username = $studentInfo->emergency_contact_number;
      $email = $studentInfo->parent_email;

      if (empty($userId)) {
        Log::warning("No emergency contact number for student: {$studentInfo->student_id}");
        return;
      }

      if (empty($email)) {
        Log::warning("No parent email for student: {$studentInfo->student_id}");
        return;
      }

      // Format: Last Name, First Name
      $parentLastName = $studentInfo->parent_surname ?? '';
      $parentFirstName = $studentInfo->parent_first_name ?? '';
      $fullname = $parentLastName;
      if ($parentFirstName) {
        $fullname = $parentLastName . ', ' . $parentFirstName;
      }
      $fullname = trim($fullname, ', ');

      // If fullname is empty, use a fallback
      if (empty($fullname)) {
        $fullname = $studentInfo->first_name . ' ' . $studentInfo->surname;
      }

      // Get assigned admin email from school_id table
      $assignedAdminEmail = SchoolId::getEmailByCode($schoolCode);

      // CHECK IF USER ALREADY EXISTS by user_id, username, OR email
      $existingUser = DB::connection('sms_users')
        ->table('users')
        ->where('user_id', $userId)
        ->orWhere('username', $username)
        ->orWhere('email', $email)
        ->first();

      // Only get password if provided
      $newPassword = $validated['password'] ?? null;
      $hashedPassword = $newPassword ? Hash::make($newPassword) : null;

      // ✅ Get current timestamp based on environment
      if (app()->environment('production')) {
        $currentTimestamp = DB::raw("NOW()");
      } else {
        $currentTimestamp = Carbon::now('Asia/Manila');
      }

      if (!$existingUser) {
        // Create new user - password is required
        $finalPassword = $newPassword ? $hashedPassword : Hash::make('Default@123');

        DB::connection('sms_users')->table('users')->insert([
          'user_id' => $userId,
          'username' => $username,
          'email' => $email,
          'password' => $finalPassword,
          'fullname' => $fullname,
          'school_code' => $schoolCode,
          'account_status' => 'active',
          'gs_access_status' => 'pending',
          'assigned_admin_email' => $assignedAdminEmail,
          'created_at' => $currentTimestamp,
          'updated_at' => $currentTimestamp,
        ]);

        Log::info("SMS User created: {$username} ({$userId}) with email: {$email}");
      } else {
        // UPDATE existing user - only update password if a new one was provided
        $updateData = [
          'fullname' => $fullname,
          'school_code' => $schoolCode,
          'assigned_admin_email' => $assignedAdminEmail,
          'updated_at' => $currentTimestamp,
        ];

        // Only update password if a new one was provided
        if ($hashedPassword) {
          $updateData['password'] = $hashedPassword;
          Log::info("SMS User password updated for: {$username} ({$userId})");
        } else {
          Log::info("SMS User updated (password unchanged) for: {$username} ({$userId})");
        }

        DB::connection('sms_users')->table('users')
          ->where('id', $existingUser->id)
          ->update($updateData);
      }
    } catch (\Exception $e) {
      Log::error('Failed to sync SMS user: ' . $e->getMessage());
      Log::error('Stack trace: ' . $e->getTraceAsString());
    }
  }

  /**
   * TASK 14: Sync student record to school-specific database
   * ONLY insert: user_id, fullname, nickname, school_name, created_at, updated_at
   */
  private function syncStudentRecord($studentInfo, $validated): void
  {
    try {
      $schoolCode = $studentInfo->school_code;
      $userId = $studentInfo->emergency_contact_number;

      if (empty($userId)) {
        Log::warning("No emergency contact number for student: {$studentInfo->student_id}");
        return;
      }

      $parentLastName = $studentInfo->parent_surname ?? '';
      $parentFirstName = $studentInfo->parent_first_name ?? '';

      if (empty($parentLastName) && empty($parentFirstName)) {
        Log::warning("No parent name for student: {$studentInfo->student_id}");
        return;
      }

      // Format: Last Name, First Name
      $fullname = $parentLastName;
      if ($parentFirstName) {
        $fullname = $parentLastName . ', ' . $parentFirstName;
      }
      $fullname = trim($fullname, ', ');

      // nickname is the first name of parent/guardian
      $nickname = $parentFirstName ?: 'Parent';

      // Get school name from school_id table
      $schoolName = SchoolId::getNameByCode($schoolCode) ?? $schoolCode;

      try {
        $databaseName = DatabaseManager::connectToSchoolDatabase($schoolCode);
      } catch (\Exception $e) {
        Log::error("Failed to connect to school database for {$schoolCode}: " . $e->getMessage());
        return;
      }

      // Check if record already exists
      $existingRecord = DB::connection($databaseName)
        ->table('student_records')
        ->where('user_id', $userId)
        ->first();

      // ✅ Get current timestamp based on environment
      if (app()->environment('production')) {
        $currentTimestamp = DB::raw("NOW()");
      } else {
        $currentTimestamp = Carbon::now('Asia/Manila');
      }

      if (!$existingRecord) {
        // ONLY insert the required fields
        DB::connection($databaseName)->table('student_records')->insert([
          'user_id' => $userId,
          'fullname' => $fullname,
          'nickname' => $nickname,
          'school_name' => $schoolName,
          'created_at' => $currentTimestamp,
          'updated_at' => $currentTimestamp,
        ]);

        Log::info("Student record created in {$databaseName} for user: {$userId}");
      } else {
        // ONLY update the required fields
        DB::connection($databaseName)->table('student_records')
          ->where('user_id', $userId)
          ->update([
            'fullname' => $fullname,
            'nickname' => $nickname,
            'school_name' => $schoolName,
            'updated_at' => $currentTimestamp,
          ]);

        Log::info("Student record updated in {$databaseName} for user: {$userId}");
      }
    } catch (\Exception $e) {
      Log::error('Failed to sync student record: ' . $e->getMessage());
    }
  }

  /**
   * TASK 15: Send email to parent/guardian
   */
  private function sendParentEmail($studentInfo, $validated): void
  {
    try {
      $parentEmail = $studentInfo->parent_email;

      if (!$parentEmail) {
        Log::warning("No parent email found for student: {$studentInfo->student_id}");
        return;
      }

      $parentFullName = trim(
        ($studentInfo->parent_first_name ?? '') . ' ' .
        ($studentInfo->parent_surname ?? '')
      );

      $username = $studentInfo->emergency_contact_number;
      $password = $validated['password'] ?? 'Default@123';

      Log::info('Sending email with password for student: ' . $studentInfo->student_id);

      $emailData = [
        'name_to_appear_on_id' => $studentInfo->name_to_appear_on_id ?? $studentInfo->first_name . ' ' . $studentInfo->surname,
        'residential_address' => $studentInfo->residential_address ?? 'Not provided',
        'emergency_contact_person' => $studentInfo->emergency_contact_person ?? 'Not provided',
        'emergency_contact_number' => $studentInfo->emergency_contact_number ?? 'Not provided',
        'level' => $studentInfo->level ?? 'Not provided',
        'section_course' => $studentInfo->section_course ?? 'Not provided',
        'lrn' => $studentInfo->lrn ?? 'Not provided',
        'esc_number' => $studentInfo->esc_number ?? 'Not provided',
        'username' => $username,
        'password' => $password,
      ];

      Mail::send('emails.parent-credentials', $emailData, function ($message) use ($parentEmail, $parentFullName) {
        $message->to($parentEmail, $parentFullName ?: 'Parent/Guardian')
          ->subject('Welcome to SchoolMANAGER System')
          ->from(config('mail.from.address'), config('mail.from.name'));
      });

      Log::info("Parent email sent to: {$parentEmail} for student: {$studentInfo->student_id}");
    } catch (\Exception $e) {
      Log::error('Failed to send parent email: ' . $e->getMessage());
    }
  }
}