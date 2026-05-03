<?php

use App\Http\Controllers\API\AuthenticationController;
use App\Http\Controllers\API\StudentController;
use App\Http\Controllers\API\ProfileController;
use App\Http\Controllers\API\TrademarkController;
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

// Footer Company
Route::get('/footer', [TrademarkController::class, 'footer']);

Route::get('/student-image', [StudentController::class, 'serveStudentImage']);

// Download route - forces download instead of opening in browser
Route::get('/download-app', function () {
  $filePath = public_path('downloads/schoolmanager-app.txt');

  // Check if APK exists first
  $apkPath = public_path('downloads/schoolmanager-app.apk');
  if (file_exists($apkPath)) {
    $filePath = $apkPath;
    $filename = 'SchoolMANAGER-App.apk';
    $mimeType = 'application/vnd.android.package-archive';
  } elseif (file_exists($filePath)) {
    $filename = 'SchoolMANAGER-App.txt';
    $mimeType = 'text/plain';
  } else {
    abort(404, 'File not found');
  }

  return response()->download($filePath, $filename, [
    'Content-Type' => $mimeType,
    'Content-Disposition' => 'attachment; filename="' . $filename . '"',
  ]);
})->name('download.app');

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
    Route::put('/students/{id}', [StudentController::class, 'updateSchoolInformation']);
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
    Route::get('/existing-parent-data', [StudentController::class, 'getExistingParentData']);
  });

  Route::post('/logout', [AuthenticationController::class, 'logout']);
});