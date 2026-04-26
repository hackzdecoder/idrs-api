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
          'birth_date' => $studentInfo->birth_date ? date('Y-m-d', strtotime($studentInfo->birth_date)) : null,
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
   * ✅ NEW: Get existing parent data for a student with SMS credentials
   * This pre-fills the parent fields when a student already has SMS credentials
   */
  public function getExistingParentData(Request $request): JsonResponse
  {
    try {
      $user = $request->user();

      if (!$user || $user->user_role !== 'Student') {
        return new JsonResponse([
          'success' => false,
          'error' => 'Unauthorized'
        ], 401);
      }

      $emergencyContactNumber = $request->query('emergency_contact_number');
      $schoolCode = $request->query('school_code');

      if (empty($emergencyContactNumber) || empty($schoolCode)) {
        return new JsonResponse([
          'success' => false,
          'error' => 'Missing required parameters'
        ], 400);
      }

      // Find existing record with matching emergency_contact_number, school_code, and sms_app_credentials = 'yes'
      $studentInfo = StudentIdInfo::where('emergency_contact_number', $emergencyContactNumber)
        ->where('school_code', $schoolCode)
        ->where('sms_app_credentials', 'yes')
        ->first();

      if (!$studentInfo) {
        return new JsonResponse([
          'success' => false,
          'error' => 'No existing record found'
        ], 404);
      }

      return new JsonResponse([
        'success' => true,
        'data' => [
          'parent_first_name' => $studentInfo->parent_first_name ?? '',
          'parent_surname' => $studentInfo->parent_surname ?? '',
          'parent_email' => $studentInfo->parent_email ?? '',
        ]
      ], 200);

    } catch (\Throwable $th) {
      Log::error('Failed to fetch existing parent data: ' . $th->getMessage());
      return new JsonResponse([
        'success' => false,
        'error' => 'Failed to fetch existing parent data'
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
   * Update school information for a student (Admin/Super Admin only)
   * 
   * @param int $id The student_id_info record ID
   * @param Request $request
   * @return JsonResponse
   */
  public function updateSchoolInformation(Request $request, $id): JsonResponse
  {
    try {
      $user = $request->user();

      // Verify admin access
      if (!$user || !in_array($user->user_role, ['Admin', 'Super Admin'])) {
        return new JsonResponse([
          'success' => false,
          'error' => 'Unauthorized - Admin access required'
        ], 403);
      }

      // Find the student record by ID
      $studentInfo = StudentIdInfo::find($id);

      if (!$studentInfo) {
        return new JsonResponse([
          'success' => false,
          'error' => 'Student record not found'
        ], 404);
      }

      // For Admin users, verify they have access to this student's school
      if ($user->user_role === 'Admin' && $studentInfo->school_code !== $user->school_code) {
        return new JsonResponse([
          'success' => false,
          'error' => 'Unauthorized - You do not have access to this student'
        ], 403);
      }

      // Validate the request
      $validated = $request->validate([
        'level' => 'nullable|string|max:255',
        'section_course' => 'nullable|string|max:255',
        'lrn' => 'nullable|string|max:255',
        'esc_voucher_recipient' => 'nullable|boolean',
        'esc_number' => 'nullable|string|max:255',
        'class_details_status' => 'nullable|string|in:pending,approved',
      ]);

      // Prepare update data
      $updateData = [];

      if ($request->has('level')) {
        $updateData['level'] = $validated['level'];
      }
      if ($request->has('section_course')) {
        $updateData['section_course'] = $validated['section_course'];
      }
      if ($request->has('lrn')) {
        $updateData['lrn'] = $validated['lrn'];
      }
      if ($request->has('esc_voucher_recipient')) {
        $updateData['esc_voucher_recipient'] = filter_var($validated['esc_voucher_recipient'], FILTER_VALIDATE_BOOLEAN);
      }
      if ($request->has('esc_number')) {
        $updateData['esc_number'] = $validated['esc_number'];
      }

      // Handle class details status - automatically set approval date when approving
      if ($request->has('class_details_status')) {
        $updateData['class_details_status'] = $validated['class_details_status'];

        // If status is being set to 'approved' and it wasn't approved before, set approval date to Philippine time
        if ($validated['class_details_status'] === 'approved' && $studentInfo->class_details_status !== 'approved') {
          $updateData['class_details_approval_date'] = Carbon::now('Asia/Manila');
        }
      }

      // Update the record using ID
      $studentInfo->update($updateData);

      // Log the update
      \Log::info('Student school information updated', [
        'student_id' => $studentInfo->student_id,
        'school_code' => $studentInfo->school_code,
        'updated_by' => $user->id,
        'updated_fields' => array_keys($updateData)
      ]);

      // Fetch the updated record
      $studentInfo->refresh();

      // ✅ SYNC TO SCHOOL-SPECIFIC DATABASE
      $this->syncSchoolInformationToSchoolDatabase($studentInfo);

      // Return success response
      return new JsonResponse([
        'success' => true,
        'response' => 'School information updated successfully',
        'data' => [
          'id' => $studentInfo->id,
          'student_id' => $studentInfo->student_id,
          'school_code' => $studentInfo->school_code,
          'level' => $studentInfo->level,
          'section_course' => $studentInfo->section_course,
          'lrn' => $studentInfo->lrn,
          'esc_voucher_recipient' => (bool) $studentInfo->esc_voucher_recipient,
          'esc_number' => $studentInfo->esc_number,
          'class_details_status' => $studentInfo->class_details_status,
          'class_details_approval_date' => $studentInfo->class_details_approval_date,
        ]
      ], 200);

    } catch (\Illuminate\Validation\ValidationException $e) {
      return new JsonResponse([
        'success' => false,
        'error' => 'Validation failed',
        'errors' => $e->errors()
      ], 422);
    } catch (\Throwable $th) {
      \Log::error('Failed to update school information: ' . $th->getMessage());
      return new JsonResponse([
        'success' => false,
        'error' => 'Failed to update school information: ' . $th->getMessage()
      ], 500);
    }
  }

  /**
   * Sync school information to school-specific database
   * Updates the student_records table in the school's database
   */
  private function syncSchoolInformationToSchoolDatabase($studentInfo): void
  {
    try {
      $schoolCode = $studentInfo->school_code;
      $userId = $studentInfo->emergency_contact_number;

      if (empty($userId)) {
        \Log::warning("No emergency contact number for student: {$studentInfo->student_id}");
        return;
      }

      // Get school database connection
      try {
        $databaseName = DatabaseManager::connectToSchoolDatabase($schoolCode);
      } catch (\Exception $e) {
        \Log::error("Failed to connect to school database for {$schoolCode}: " . $e->getMessage());
        return;
      }

      // Format fullname: Last Name, First Name Middle Initial.
      $firstName = $studentInfo->first_name ?? '';
      $middleInitial = $studentInfo->middle_initial ?? '';
      $lastName = $studentInfo->surname ?? '';

      // Format middle initial with period if present
      $formattedMiddleInitial = '';
      if (!empty($middleInitial)) {
        // Remove existing period if any, then add one
        $cleanMiddle = rtrim($middleInitial, '.');
        $formattedMiddleInitial = $cleanMiddle . '.';
      }

      // Build fullname: Last Name, First Name MI.
      $fullname = $lastName;
      if ($firstName) {
        $fullname .= $fullname ? ', ' . $firstName : $firstName;
      }
      if ($formattedMiddleInitial) {
        $fullname .= ' ' . $formattedMiddleInitial;
      }

      // If fullname is empty, use parent name as fallback
      if (empty(trim($fullname))) {
        $parentLastName = $studentInfo->parent_surname ?? '';
        $parentFirstName = $studentInfo->parent_first_name ?? '';
        $fullname = trim($parentLastName . ', ' . $parentFirstName);
        $fullname = trim($fullname, ', ');
      }

      // Determine school_level based on level (e.g., Grade 7 -> Junior High School)
      $level = $studentInfo->level ?? '';
      $schoolLevel = '';
      if (preg_match('/Grade [7-9]/i', $level)) {
        $schoolLevel = 'Junior High School';
      } elseif (preg_match('/Grade 10/i', $level)) {
        $schoolLevel = 'Junior High School';
      } elseif (preg_match('/Grade 1[1-2]/i', $level)) {
        $schoolLevel = 'Senior High School';
      } elseif (preg_match('/Grade [1-6]/i', $level)) {
        $schoolLevel = 'Elementary';
      } else {
        $schoolLevel = $level; // Use as-is if no match
      }

      // Prepare update data for school database
      $updateData = [
        'student_id' => $studentInfo->student_id ?? '',
        'level' => $studentInfo->level ?? '',
        'section' => $studentInfo->section_course ?? '',
        'lrn' => $studentInfo->lrn ?? '',
        'gender' => $studentInfo->gender ?? '',
        'course' => $studentInfo->section_course ?? '', // Use section_course as course
        'school_level' => $schoolLevel,
        'fullname' => $fullname,
        'nickname' => $studentInfo->nick_name ?? '',
        'email' => $studentInfo->parent_email ?? '',
        'mobile_number' => $studentInfo->emergency_contact_number ?? '',
        'updated_at' => Carbon::now(),
      ];

      \Log::info("Syncing school information to school database: {$databaseName}", [
        'user_id' => $userId,
        'school_code' => $schoolCode,
        'update_data' => $updateData
      ]);

      // Check if record exists
      $existingRecord = DB::connection($databaseName)
        ->table('student_records')
        ->where('user_id', $userId)
        ->where('school_code', $schoolCode)
        ->first();

      if ($existingRecord) {
        // Update existing record
        DB::connection($databaseName)
          ->table('student_records')
          ->where('user_id', $userId)
          ->where('school_code', $schoolCode)
          ->update($updateData);

        \Log::info("Updated student record in {$databaseName} for user: {$userId}");
      } else {
        // Create new record if doesn't exist (should exist from registration)
        $insertData = array_merge($updateData, [
          'user_id' => $userId,
          'school_code' => $schoolCode,
          'created_at' => Carbon::now(),
        ]);

        DB::connection($databaseName)
          ->table('student_records')
          ->insert($insertData);

        \Log::info("Created new student record in {$databaseName} for user: {$userId}");
      }
    } catch (\Exception $e) {
      \Log::error('Failed to sync school information to school database: ' . $e->getMessage());
      \Log::error('Stack trace: ' . $e->getTraceAsString());
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
          // ✅ ADD THESE TWO LINES:
          'parent_first_name' => $student->parent_first_name,
          'parent_surname' => $student->parent_surname,
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

      // ✅ ABSOLUTE FIX: Store the original approval status BEFORE update
      $wasAlreadyApproved = !is_null($studentInfo->id_info_approval_date);

      $studentInfo->update($dataToUpdate);

      // Get current timestamp (working correctly)
      $currentTimestamp = Carbon::now();

      // Update id_info_approval_date
      DB::table('student_id_info')
        ->where('student_id', $user->student_id)
        ->where('school_code', $user->school_code)
        ->update([
          'id_info_approval_date' => $currentTimestamp
        ]);

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
      $firstName = $validated['first_name'] ?? $studentInfo->first_name;
      $middleInitial = ($validated['middle_initial'] ?? $studentInfo->middle_initial)
        ? rtrim(($validated['middle_initial'] ?? $studentInfo->middle_initial), '.') . '.'
        : '';
      $lastName = $validated['surname'] ?? $studentInfo->surname;

      $fullName = trim($lastName . ', ' . $firstName . ' ' . $middleInitial);
      $userUpdates['account_name'] = $fullName;

      if (!empty($userUpdates)) {
        $user->update($userUpdates);
      }

      // ============================================================
      // CHECK IF USER ALREADY EXISTS IN SMS DATABASE FOR THIS SCHOOL
      // ============================================================
      $userId = $studentInfo->emergency_contact_number;
      $email = $studentInfo->parent_email;
      $schoolCode = $studentInfo->school_code;
      $existingSmsUser = null;
      $smsUserCreated = false;

      if (!empty($userId)) {
        try {
          // Check by user_id AND school_code
          $existingSmsUser = DB::connection('sms_users')
            ->table('users')
            ->where('user_id', $userId)
            ->where('school_code', $schoolCode)
            ->first();

          if (!$existingSmsUser) {
            // Check by username AND school_code
            $existingSmsUser = DB::connection('sms_users')
              ->table('users')
              ->where('username', $userId)
              ->where('school_code', $schoolCode)
              ->first();
          }

          Log::info('SMS User check', [
            'user_id' => $userId,
            'email' => $email,
            'school_code' => $schoolCode,
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

        // Update sms_app_created_at with same timestamp
        DB::table('student_id_info')
          ->where('student_id', $user->student_id)
          ->where('school_code', $user->school_code)
          ->update([
            'sms_app_created_at' => $currentTimestamp
          ]);

        $studentInfo->refresh();
        Log::info("Updated sms_app_credentials to 'yes' for student: {$studentInfo->student_id}");
      }

      // ============================================================
      // TASK 14: Create student record in school-specific database
      // ============================================================
      try {
        $this->syncStudentRecord($studentInfo, $validated);
      } catch (\Exception $e) {
        Log::error('TASK 14 FAILED (Student Record): ' . $e->getMessage());
      }

      // ============================================================
      // TASK 15: Send email to parent/guardian
      // Pass the original approval status to determine email content
      // ============================================================
      try {
        $this->sendParentEmail($studentInfo, $validated, $wasAlreadyApproved);
      } catch (\Exception $e) {
        Log::error('TASK 15 FAILED (Email): ' . $e->getMessage());
      }

      $studentInfo->refresh();

      return new JsonResponse([
        'success' => true,
        'response' => 'ID Information was successfully submitted',
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
   * Creates new record for each unique (mobile_number + school_code) combination
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

      // ✅ Check if user exists for this specific school code (user_id + school_code)
      $existingUser = DB::connection('sms_users')
        ->table('users')
        ->where('user_id', $userId)
        ->where('school_code', $schoolCode)
        ->first();

      if (!$existingUser) {
        // ✅ Check by username AND school_code
        $existingUser = DB::connection('sms_users')
          ->table('users')
          ->where('username', $username)
          ->where('school_code', $schoolCode)
          ->first();
      }

      // Get current timestamp
      $currentTimestamp = Carbon::now();

      // Only get password if provided
      $newPassword = $validated['password'] ?? null;
      $hashedPassword = $newPassword ? Hash::make($newPassword) : null;

      if (!$existingUser) {
        // Create new user for this school
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

        Log::info("SMS User created for school {$schoolCode}: {$username} ({$userId})");
      } else {
        // Update existing user for this school
        $updateData = [
          'fullname' => $fullname,
          'email' => $email,
          'assigned_admin_email' => $assignedAdminEmail,
          'updated_at' => $currentTimestamp,
        ];

        if ($hashedPassword) {
          $updateData['password'] = $hashedPassword;
          Log::info("SMS User password updated for school {$schoolCode}: {$username} ({$userId})");
        } else {
          Log::info("SMS User exists for school {$schoolCode} (password unchanged): {$username} ({$userId})");
        }

        // ✅ FIXED: UPDATE must also include school_code in WHERE clause
        DB::connection('sms_users')->table('users')
          ->where('id', $existingUser->id)
          ->where('school_code', $schoolCode)  // ✅ ADD THIS LINE
          ->update($updateData);
      }
    } catch (\Exception $e) {
      Log::error('Failed to sync SMS user: ' . $e->getMessage());
      Log::error('Stack trace: ' . $e->getTraceAsString());
    }
  }

  /**
   * TASK 14: Sync student record to school-specific database
   * Creates new record for each school database
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

      $fullname = $parentLastName;
      if ($parentFirstName) {
        $fullname = $parentLastName . ', ' . $parentFirstName;
      }
      $fullname = trim($fullname, ', ');

      $nickname = $parentFirstName ?: 'Parent';
      $schoolName = SchoolId::getNameByCode($schoolCode) ?? $schoolCode;

      try {
        $databaseName = DatabaseManager::connectToSchoolDatabase($schoolCode);
      } catch (\Exception $e) {
        Log::error("Failed to connect to school database for {$schoolCode}: " . $e->getMessage());
        return;
      }

      // Check with BOTH user_id AND school_code
      $existingRecord = DB::connection($databaseName)
        ->table('student_records')
        ->where('user_id', $userId)
        ->where('school_code', $schoolCode)
        ->first();

      $currentTimestamp = Carbon::now();

      if (!$existingRecord) {
        // INSERT new record with all fields
        DB::connection($databaseName)->table('student_records')->insert([
          'user_id' => $userId,
          'student_id' => $studentInfo->student_id ?? '',
          'fullname' => $fullname,
          'nickname' => $nickname,
          'school_name' => $schoolName,
          'school_code' => $schoolCode,
          'level' => $studentInfo->level ?? '',
          'section' => $studentInfo->section_course ?? '',
          'lrn' => $studentInfo->lrn ?? '',
          'gender' => $studentInfo->gender ?? '',
          'course' => $studentInfo->section_course ?? '',
          'school_level' => $studentInfo->level ?? '',
          'email' => $studentInfo->parent_email ?? '',
          'mobile_number' => $studentInfo->emergency_contact_number ?? '',
          'created_at' => $currentTimestamp,
          'updated_at' => $currentTimestamp,
        ]);

        Log::info("Student record created in {$databaseName} for user: {$userId}");
      } else {
        // UPDATE existing record with all fields
        DB::connection($databaseName)->table('student_records')
          ->where('user_id', $userId)
          ->where('school_code', $schoolCode)
          ->update([
            'student_id' => $studentInfo->student_id ?? '',
            'fullname' => $fullname,
            'nickname' => $nickname,
            'school_name' => $schoolName,
            'level' => $studentInfo->level ?? '',
            'section' => $studentInfo->section_course ?? '',
            'lrn' => $studentInfo->lrn ?? '',
            'gender' => $studentInfo->gender ?? '',
            'course' => $studentInfo->section_course ?? '',
            'school_level' => $studentInfo->level ?? '',
            'email' => $studentInfo->parent_email ?? '',
            'mobile_number' => $studentInfo->emergency_contact_number ?? '',
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
   * 
   * Logic:
   * a. First time submission (wasAlreadyApproved = false) -> show actual unhashed password
   * b. 2nd or succeeding submission (wasAlreadyApproved = true) -> show "your 1st nominated password"
   * 
   * @param bool $wasAlreadyApproved Whether the record was already approved before this submission
   */
  private function sendParentEmail($studentInfo, $validated, $wasAlreadyApproved = false): void
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

      // ✅ Check if this is a resubmission (already approved before)
      if ($wasAlreadyApproved) {
        // Scenario b: 2nd or succeeding submission
        $password = 'your 1st nominated password';
        Log::info('Resubmission - showing placeholder: ' . $studentInfo->student_id);
      } else {
        // Scenario a: First time submission
        // Check if password was actually submitted
        if (!empty($validated['password'])) {
          $password = $validated['password'];
          Log::info('First time submission with password - showing actual password: ' . $studentInfo->student_id);
        } else {
          // This should not happen for first time, but as fallback
          $password = 'your nominated password';
          Log::warning('First time submission but no password provided: ' . $studentInfo->student_id);
        }
      }

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