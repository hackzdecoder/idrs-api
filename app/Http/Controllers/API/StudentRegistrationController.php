<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\StudentRegistration;
use App\Http\Resources\StudentProfileResource;
use App\Http\Resources\StudentInformationListResource;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class StudentRegistrationController extends Controller
{
  /**
   * Get student profile data for the authenticated user
   */
  public function student_profile(Request $request): JsonResponse
  {
    try {
      $user = $request->user();

      if (!$user) {
        return new JsonResponse([
          'success' => false,
          'error' => 'Unauthenticated'
        ], 401);
      }

      if (!$user->isStudent()) {
        return new JsonResponse([
          'success' => false,
          'error' => 'User is not a student'
        ], 403);
      }

      $studentProfile = StudentRegistration::where('user_id', $user->user_id)->first();

      if (!$studentProfile) {
        return new JsonResponse([
          'success' => false,
          'error' => 'Student profile not found'
        ], 404);
      }

      return new JsonResponse([
        'success' => true,
        'data' => new StudentProfileResource($studentProfile)
      ], 200);

    } catch (\Throwable $th) {
      return new JsonResponse([
        'success' => false,
        'error' => 'Failed to get student profile: ' . $th->getMessage()
      ], 500);
    }
  }

  /**
   * Update student profile for the authenticated user
   */
  public function student_profile_update(Request $request): JsonResponse
  {
    try {
      $user = $request->user();

      if (!$user) {
        return new JsonResponse([
          'success' => false,
          'error' => 'Unauthenticated'
        ], 401);
      }

      if (!$user->isStudent()) {
        return new JsonResponse([
          'success' => false,
          'error' => 'User is not a student'
        ], 403);
      }

      $studentProfile = StudentRegistration::where('user_id', $user->user_id)->first();

      if (!$studentProfile) {
        return new JsonResponse([
          'success' => false,
          'error' => 'Student profile not found'
        ], 404);
      }

      $validated = $request->validate([
        'first_name' => 'sometimes|string|max:255',
        'middle_name' => 'nullable|string|max:255',
        'last_name' => 'sometimes|string|max:255',
        'suffix' => 'nullable|string|max:50',
        'nickname' => 'nullable|string|max:255',
        'present_address' => 'nullable|string',
        'permanent_address' => 'nullable|string',
        'profile_img' => 'nullable|string|max:255',
        'lrn' => 'nullable|string|max:50',
      ]);

      $studentProfile->update($validated);

      return new JsonResponse([
        'success' => true,
        'response' => 'Student profile updated successfully',
        'data' => new StudentProfileResource($studentProfile)
      ], 200);

    } catch (\Throwable $th) {
      return new JsonResponse([
        'success' => false,
        'error' => 'Failed to update student profile: ' . $th->getMessage()
      ], 500);
    }
  }

  /**
   * Get student information list with user data
   */
  public function student_information_lists(Request $request): JsonResponse
  {
    try {
      $user = $request->user();

      if (!$user) {
        return new JsonResponse([
          'success' => false,
          'error' => 'Unauthenticated'
        ], 401);
      }

      if (!$user->isStudent()) {
        return new JsonResponse([
          'success' => false,
          'error' => 'User is not a student'
        ], 403);
      }

      $studentProfile = StudentRegistration::where('user_id', $user->user_id)
        ->with('user')
        ->first();

      if (!$studentProfile) {
        return new JsonResponse([
          'success' => false,
          'error' => 'Student profile not found'
        ], 404);
      }

      return new JsonResponse([
        'success' => true,
        'data' => new StudentInformationListResource($studentProfile)
      ], 200);

    } catch (\Throwable $th) {
      return new JsonResponse([
        'success' => false,
        'error' => 'Failed to fetch student information: ' . $th->getMessage()
      ], 500);
    }
  }
}