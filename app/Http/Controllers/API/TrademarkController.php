<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Trademark;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Log;

class TrademarkController extends Controller
{
  /**
   * GET /footer - For the footer component
   * Returns copyright notice only
   */
  public function footer(Request $request): JsonResponse
  {
    try {
      // Use the Trademark model
      $company = Trademark::orderBy('id', 'desc')->first();

      if (!$company) {
        // Return default copyright notice if no data found
        return new JsonResponse([
          'success' => true,
          'data' => [
            'copyright_notice' => '© ' . date('Y') . ' TaparSoft Enterprise. All rights reserved.',
          ],
        ], 200);
      }

      // Get the copyright text and company name from the record
      $copyrightText = $company->copyright;
      $companyName = $company->company_name;
      $currentYear = date('Y');

      // Dynamic copyright notice generation
      $copyrightNotice = '';

      if ($copyrightText) {
        // If copyright text exists, update the year dynamically
        // Replace any existing year (4 digits) with current year
        $copyrightNotice = preg_replace('/\b\d{4}\b/', $currentYear, $copyrightText);

        // If no year found, add the current year
        if (!preg_match('/\b\d{4}\b/', $copyrightNotice)) {
          if (!str_starts_with($copyrightNotice, '©')) {
            $copyrightNotice = '© ' . $currentYear . ' ' . $copyrightNotice;
          } else {
            $copyrightNotice = preg_replace('/^©/', '© ' . $currentYear, $copyrightNotice);
          }
        }
      } else {
        // If no copyright text, use company name
        $copyrightNotice = '© ' . $currentYear . ' ' . $companyName . '. All rights reserved.';
      }

      // Ensure proper formatting
      if (!str_ends_with($copyrightNotice, '.')) {
        $copyrightNotice .= '.';
      }

      return new JsonResponse([
        'success' => true,
        'data' => [
          'copyright_notice' => $copyrightNotice,
        ],
      ], 200);

    } catch (\Throwable $th) {
      Log::error('Failed to fetch footer data: ' . $th->getMessage());

      // Return default on error
      return new JsonResponse([
        'success' => true,
        'data' => [
          'copyright_notice' => '© ' . date('Y') . ' TaparSoft Enterprise. All rights reserved.',
        ],
      ], 200);
    }
  }

  /**
   * POST /trademarks - For Privacy Policy, Terms, and Acceptable Use Policy
   * Returns complete company information
   */
  public function getTrademarkInfo(Request $request): JsonResponse
  {
    try {
      $type = $request->input('type');

      if ($type === 'company') {
        $company = Trademark::orderBy('id', 'desc')->first();

        if (!$company) {
          return new JsonResponse([
            'success' => false,
            'message' => 'No company data found',
          ], 404);
        }

        return new JsonResponse([
          'success' => true,
          'type' => 'company',
          'data' => [
            'id' => $company->id,
            'copyright_name' => $company->copyright,
            'company_name' => $company->company_name,
            'publication_date' => $company->publication_date,
            'created_at' => $company->created_at,
            'updated_at' => $company->updated_at,
          ],
        ], 200);
      }

      return new JsonResponse([
        'success' => false,
        'message' => 'Invalid type parameter',
      ], 400);

    } catch (\Throwable $th) {
      Log::error('Failed to fetch trademark info: ' . $th->getMessage());

      return new JsonResponse([
        'success' => false,
        'message' => 'Failed to fetch company information',
      ], 500);
    }
  }
}