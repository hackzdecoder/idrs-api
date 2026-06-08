<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Resources\ProfileResource;
use App\Models\Profile;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Log;

class ProfileController extends Controller
{
  /**
   * Get profile for authenticated user (Admin/Super Admin)
   */
  public function show(Request $request): JsonResponse
  {
    try {
      $user = $request->user();

      if (!$user) {
        return new JsonResponse([
          'success' => false,
          'error' => 'Unauthorized - No user found'
        ], 401);
      }

      // Check if user role is Admin or Super Admin
      if ($user->user_role !== 'Admin' && $user->user_role !== 'Super Admin') {
        return new JsonResponse([
          'success' => false,
          'error' => 'Unauthorized - User is not an admin'
        ], 403);
      }

      // Get profile using the user's id (since profile id = user id for admins)
      $profile = Profile::with('user')
        ->where('id', $user->id)
        ->first();

      if (!$profile) {
        // Create profile if it doesn't exist
        $profile = Profile::create([
          'id' => $user->id,
          'role' => $user->user_role,
          'fullname' => $user->account_name ?? $user->username ?? '',
        ]);
        $profile->load('user');
      }

      return new JsonResponse([
        'success' => true,
        'data' => new ProfileResource($profile) // Cleanly uses the resource
      ], 200);

    } catch (\Throwable $th) {
      Log::error('Profile fetch error: ' . $th->getMessage());
      return new JsonResponse([
        'success' => false,
        'error' => 'Failed to fetch profile: ' . $th->getMessage()
      ], 500);
    }
  }

  /**
   * Update profile for authenticated user (Admin/Super Admin)
   */
  public function update(Request $request): JsonResponse
  {
    try {
      $user = $request->user();

      if (!$user) {
        return new JsonResponse([
          'success' => false,
          'error' => 'Unauthorized - No user found'
        ], 401);
      }

      // Check if user role is Admin or Super Admin
      if ($user->user_role !== 'Admin' && $user->user_role !== 'Super Admin') {
        return new JsonResponse([
          'success' => false,
          'error' => 'Unauthorized - User is not an admin'
        ], 403);
      }

      // Validation updated to use 'school_email' to match your Resource and Frontend
      $validated = $request->validate([
        'fullname' => 'required|string|max:255',
        'username' => 'required|string|max:255|unique:users,username,' . $user->id,
        'school_email' => 'required|email|max:255|unique:users,school_email,' . $user->id,
        'mobile_number' => 'nullable|string|max:20',
      ]);

      // Update user information
      $user->update([
        'username' => $validated['username'],
        'school_email' => $validated['school_email'],
        'mobile_number' => $validated['mobile_number'] ?? null,
        'account_name' => $validated['fullname'],
      ]);

      // Update or create profile
      $profile = Profile::updateOrCreate(
        ['id' => $user->id],
        [
          'role' => $user->user_role,
          'fullname' => $validated['fullname'],
        ]
      );

      $profile->load('user');

      return new JsonResponse([
        'success' => true,
        'response' => 'Profile updated successfully',
        'data' => new ProfileResource($profile) // Cleanly uses the resource
      ], 200);

    } catch (\Throwable $th) {
      Log::error('Profile update error: ' . $th->getMessage());
      return new JsonResponse([
        'success' => false,
        'error' => 'Failed to update profile: ' . $th->getMessage()
      ], 500);
    }
  }
}