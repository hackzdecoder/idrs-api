<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\StudentIdInfo;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Log;

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
          'account_status' => $studentInfo->account_status,
          'created_at' => $studentInfo->created_at,
        ]
      ], 200);

    } catch (\Throwable $th) {
      Log::error('Student profile fetch error: ' . $th->getMessage());
      return new JsonResponse([
        'success' => false,
        'error' => 'Failed to fetch student profile: ' . $th->getMessage()
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
        'account_status' => $student->account_status,
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
        'error' => 'Failed to fetch student information: ' . $th->getMessage()
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
        ->byIdInfoStatus($request->id_info_status)
        ->byClassDetailsStatus($request->class_details_status)
        ->byIdPrintStatus($request->id_print_status)
        ->byIdReprintStatus($request->id_reprint_status)
        ->byAccountStatus($request->account_status)
        ->byDateRange($request->date_from, $request->date_to)
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
          'email' => $student->user->school_email ?? $student->user->email ?? null,
          'username' => $student->user->username ?? null,
          'level' => $student->level,
          'section_course' => $student->section_course,
          'lrn' => $student->lrn,
          'student_type' => $student->student_type,
          'id_info_status' => $student->id_info_status,
          'class_details_status' => $student->class_details_status,
          'id_print_status' => $student->id_print_status,
          'id_reprint_status' => $student->id_reprint_status,
          'account_status' => $student->user->account_status ?? null,
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
        ];
      });

      return new JsonResponse([
        'success' => true,
        'data' => $studentData
      ], 200);

    } catch (\Throwable $th) {
      Log::error('Failed to fetch students: ' . $th->getMessage());
      Log::error('Stack trace: ' . $th->getTraceAsString());

      return new JsonResponse([
        'success' => false,
        'error' => 'Failed to fetch students: ' . $th->getMessage()
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
      $dataToUpdate['id_info_approval_date'] = now();

      $studentInfo->update($dataToUpdate);

      if (isset($validated['first_name']) || isset($validated['surname']) || isset($validated['middle_initial'])) {
        $fullName = ($validated['first_name'] ?? $studentInfo->first_name) . ' ' .
          (($validated['middle_initial'] ?? $studentInfo->middle_initial) ? ($validated['middle_initial'] ?? $studentInfo->middle_initial) . ' ' : '') .
          ($validated['surname'] ?? $studentInfo->surname);

        $user->update(['account_name' => $fullName]);
      }

      $studentInfo->refresh();

      $fullName = trim(
        $studentInfo->first_name . ' ' .
        ($studentInfo->middle_initial ? $studentInfo->middle_initial . ' ' : '') .
        $studentInfo->surname .
        ($studentInfo->suffix_name ? ' ' . $studentInfo->suffix_name : '')
      );

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
          'account_status' => $studentInfo->account_status,
          'created_at' => $studentInfo->created_at,
          'parent_first_name' => $studentInfo->parent_first_name,
          'parent_surname' => $studentInfo->parent_surname,
          'parent_email' => $studentInfo->parent_email,
        ]
      ], 200);

    } catch (\Throwable $th) {
      Log::error('Failed to update profile: ' . $th->getMessage());
      return new JsonResponse([
        'success' => false,
        'error' => 'Failed to update profile: ' . $th->getMessage()
      ], 500);
    }
  }
}