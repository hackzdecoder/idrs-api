<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Trademark;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class TrademarkController extends Controller
{
  /**
   * Get footer information (company details)
   */
  public function footer(Request $request): JsonResponse
  {
    try {
      // Get the latest company record
      $company = Trademark::latest()->first();

      if ($company) {
        return new JsonResponse([
          'success' => true,
          'data' => [
            'id' => $company->id,
            'copyright_name' => $company->copyright_name,
            'company_name' => $company->company_name,
            'publication_date' => $company->publication_date,
            'copyright_notice' => $company->copyright_notice,
            'display_name' => $company->display_name,
            'year' => now()->year,
            'rights_reserved' => 'All rights reserved.',
          ],
        ], 200);
      }

      // Fallback data if no company exists
      return new JsonResponse([
        'success' => true,
        'data' => [
          'copyright_name' => 'TaparSoft Enterprise',
          'company_name' => 'TaparSoft',
          'year' => now()->year,
          'rights_reserved' => 'All rights reserved.',
          'copyright_notice' => '© ' . now()->year . ' TaparSoft Enterprise. All rights reserved.',
          'display_name' => 'TaparSoft (TaparSoft Enterprise)',
        ],
      ], 200);

    } catch (\Throwable $th) {
      return new JsonResponse([
        'success' => false,
        'error' => 'Failed to fetch footer data: ' . $th->getMessage()
      ], 500);
    }
  }

  /**
   * Get all companies (for admin management)
   */
  public function index(Request $request): JsonResponse
  {
    try {
      $companies = Trademark::latest()->get();

      return new JsonResponse([
        'success' => true,
        'data' => $companies,
      ], 200);
    } catch (\Throwable $th) {
      return new JsonResponse([
        'success' => false,
        'error' => 'Failed to fetch companies: ' . $th->getMessage()
      ], 500);
    }
  }

  /**
   * Get single company
   */
  public function show($id): JsonResponse
  {
    try {
      $company = Trademark::findOrFail($id);

      return new JsonResponse([
        'success' => true,
        'data' => $company,
      ], 200);
    } catch (\Throwable $th) {
      return new JsonResponse([
        'success' => false,
        'error' => 'Company not found: ' . $th->getMessage()
      ], 404);
    }
  }
}