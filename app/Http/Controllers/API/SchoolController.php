<?php
// api/app/Http/Controllers/API/SchoolController.php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\SchoolId;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\File;
use Illuminate\Validation\Rule;

class SchoolController extends Controller
{
  public function index(Request $request): JsonResponse
  {
    try {
      $query = SchoolId::query();

      if ($request->has('school_code') && !empty($request->school_code)) {
        $query->where('school_code', 'like', '%' . $request->school_code . '%');
      }

      if ($request->has('school_name') && !empty($request->school_name)) {
        $query->where('school_name', 'like', '%' . $request->school_name . '%');
      }

      $schools = $query->orderBy('school_name', 'asc')->get();

      // Add full URL for logo
      $schools->transform(function ($school) {
        if ($school->school_logo && !filter_var($school->school_logo, FILTER_VALIDATE_URL)) {
          $school->school_logo = asset('assets/school-logo/' . $school->school_logo);
        }
        return $school;
      });

      return new JsonResponse([
        'success' => true,
        'data' => $schools
      ], 200);

    } catch (\Throwable $th) {
      Log::error('Failed to fetch schools: ' . $th->getMessage());
      return new JsonResponse([
        'success' => false,
        'error' => 'Failed to fetch schools: ' . $th->getMessage()
      ], 500);
    }
  }

  public function store(Request $request): JsonResponse
  {
    try {
      $validated = $request->validate([
        'school_code' => 'required|string|max:50|unique:school_id,school_code',
        'school_name' => 'required|string|max:255',
        'school_email' => 'required|email|max:255|unique:school_id,school_email',
        'school_logo' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
      ]);

      $logoFileName = null;
      if ($request->hasFile('school_logo')) {
        $file = $request->file('school_logo');
        $extension = $file->getClientOriginalExtension();
        $logoFileName = strtolower($validated['school_code']) . '.' . $extension;

        // Define the path
        $destinationPath = public_path('assets/school-logo');

        // Create directory if it doesn't exist
        if (!File::exists($destinationPath)) {
          File::makeDirectory($destinationPath, 0755, true);
        }

        // Move the file
        $file->move($destinationPath, $logoFileName);
      }

      $school = SchoolId::create([
        'school_code' => $validated['school_code'],
        'school_name' => $validated['school_name'],
        'school_email' => $validated['school_email'],
        'school_logo' => $logoFileName,
      ]);

      if ($school->school_logo) {
        $school->school_logo = asset('assets/school-logo/' . $school->school_logo);
      }

      return new JsonResponse([
        'success' => true,
        'data' => $school,
        'message' => 'School created successfully'
      ], 201);

    } catch (\Illuminate\Validation\ValidationException $e) {
      return new JsonResponse([
        'success' => false,
        'error' => 'Validation failed',
        'errors' => $e->errors()
      ], 422);
    } catch (\Exception $e) {
      Log::error('Failed to create school: ' . $e->getMessage());
      return new JsonResponse([
        'success' => false,
        'error' => 'Failed to create school: ' . $e->getMessage()
      ], 500);
    }
  }

  public function show($id): JsonResponse
  {
    try {
      $school = SchoolId::find($id);

      if (!$school) {
        return new JsonResponse([
          'success' => false,
          'error' => 'School not found'
        ], 404);
      }

      if ($school->school_logo && !filter_var($school->school_logo, FILTER_VALIDATE_URL)) {
        $school->school_logo = asset('assets/school-logo/' . $school->school_logo);
      }

      return new JsonResponse([
        'success' => true,
        'data' => $school
      ], 200);

    } catch (\Throwable $th) {
      Log::error('Failed to fetch school: ' . $th->getMessage());
      return new JsonResponse([
        'success' => false,
        'error' => 'Failed to fetch school'
      ], 500);
    }
  }

  public function update(Request $request, $id): JsonResponse
  {
    try {
      $school = SchoolId::find($id);

      if (!$school) {
        return new JsonResponse([
          'success' => false,
          'error' => 'School not found'
        ], 404);
      }

      $validated = $request->validate([
        'school_code' => [
          'required',
          'string',
          'max:50',
          Rule::unique('school_id', 'school_code')->ignore($id)
        ],
        'school_name' => 'required|string|max:255',
        'school_email' => [
          'required',
          'email',
          'max:255',
          Rule::unique('school_id', 'school_email')->ignore($id)
        ],
        'school_logo' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
      ]);

      $logoFileName = $school->school_logo;

      if ($request->hasFile('school_logo')) {
        // Delete old logo if exists
        if ($school->school_logo) {
          $oldLogoPath = public_path('assets/school-logo/' . $school->school_logo);
          if (File::exists($oldLogoPath)) {
            File::delete($oldLogoPath);
          }
        }

        $file = $request->file('school_logo');
        $extension = $file->getClientOriginalExtension();
        $logoFileName = strtolower($validated['school_code']) . '.' . $extension;

        // Define the path
        $destinationPath = public_path('assets/school-logo');

        // Create directory if it doesn't exist
        if (!File::exists($destinationPath)) {
          File::makeDirectory($destinationPath, 0755, true);
        }

        // Move the file
        $file->move($destinationPath, $logoFileName);
      }

      $school->update([
        'school_code' => $validated['school_code'],
        'school_name' => $validated['school_name'],
        'school_email' => $validated['school_email'],
        'school_logo' => $logoFileName,
      ]);

      if ($school->school_logo) {
        $school->school_logo = asset('assets/school-logo/' . $school->school_logo);
      }

      return new JsonResponse([
        'success' => true,
        'data' => $school,
        'message' => 'School updated successfully'
      ], 200);

    } catch (\Illuminate\Validation\ValidationException $e) {
      return new JsonResponse([
        'success' => false,
        'error' => 'Validation failed',
        'errors' => $e->errors()
      ], 422);
    } catch (\Exception $e) {
      Log::error('Failed to update school: ' . $e->getMessage());
      return new JsonResponse([
        'success' => false,
        'error' => 'Failed to update school: ' . $e->getMessage()
      ], 500);
    }
  }

  public function destroy($id): JsonResponse
  {
    try {
      $school = SchoolId::find($id);

      if (!$school) {
        return new JsonResponse([
          'success' => false,
          'error' => 'School not found'
        ], 404);
      }

      // Delete logo file if exists
      if ($school->school_logo) {
        $logoPath = public_path('assets/school-logo/' . $school->school_logo);
        if (File::exists($logoPath)) {
          File::delete($logoPath);
        }
      }

      $school->delete();

      return new JsonResponse([
        'success' => true,
        'message' => 'School deleted successfully'
      ], 200);

    } catch (\Throwable $th) {
      Log::error('Failed to delete school: ' . $th->getMessage());
      return new JsonResponse([
        'success' => false,
        'error' => 'Failed to delete school: ' . $th->getMessage()
      ], 500);
    }
  }
}