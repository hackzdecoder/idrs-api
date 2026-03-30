<?php

use App\Http\Controllers\API\AuthenticationController;
use App\Http\Controllers\API\StudentController;
use App\Http\Controllers\API\ProfileController;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Route;

// Public routes
Route::post('/refresh', [AuthenticationController::class, 'refresh']);

// Student verification (no authentication required)
Route::post('/verify-user-account', [AuthenticationController::class, 'verify_user_account']);

// Student login (separate endpoint)
Route::post('/student/login', [AuthenticationController::class, 'authenticate_student']);

// Admin/Super Admin login (separate endpoint)
Route::post('/admin/login', [AuthenticationController::class, 'authenticate_admin']);

Route::middleware(['auth:sanctum'])->group(function () {

  Route::get('/user-role', [AuthenticationController::class, 'user_role']);

  // ===== SUPER ADMIN ONLY =====
  Route::middleware(['role:Super Admin'])->prefix('super-admin')->group(function () {
    Route::get('/dashboard', function (Request $request) {
      return (new JsonResponse([
        'success' => true,
        'message' => 'Super Admin Dashboard',
      ], 200));
    });
  });

  // ===== ADMIN & SUPER ADMIN =====
  Route::middleware(['role:Super Admin,Admin'])->prefix('admin')->group(function () {
    Route::get('/dashboard', function (Request $request) {
      return (new JsonResponse([
        'success' => true,
        'message' => 'Admin Dashboard',
      ], 200));
    });
    Route::get('/students', [StudentController::class, 'index']);
  });

  // ===== PROFILE ROUTES (for Admin & Super Admin) =====
  Route::middleware(['role:Super Admin,Admin'])->prefix('profile')->group(function () {
    Route::get('/', [ProfileController::class, 'show']);
    Route::post('/update', [ProfileController::class, 'update']);
  });

  // ===== STUDENT ONLY =====
  Route::middleware(['role:Student'])->prefix('student')->group(function () {
    Route::get('/dashboard', function (Request $request) {
      return (new JsonResponse([
        'success' => true,
        'message' => 'Student Dashboard',
      ], 200));
    });

    // Update these to use StudentController
    Route::get('/profile', [StudentController::class, 'student_profile']);
    Route::get('/information/list', [StudentController::class, 'student_information_lists']);
    Route::post('/update/profile', [StudentController::class, 'student_profile_update']);
  });

  Route::post('/logout', [AuthenticationController::class, 'logout']);
});