<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Trademark;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class TrademarkController extends Controller
{
  public function footer(Request $request): JsonResponse
  {
    try {
      $company = Trademark::orderBy('id', 'desc')->first();

      if (!$company) {
        return new JsonResponse([
          'success' => false,
          'error' => 'No company data found'
        ], 404);
      }

      // Check if copyright_name already contains the full notice
      $copyrightNotice = $company->copyright_name;

      // If it doesn't start with ©, format it properly
      if (!str_starts_with($copyrightNotice, '©')) {
        $year = $company->publication_date
          ? $company->publication_date->format('Y')
          : date('Y');
        $copyrightNotice = '© ' . $year . ' ' . $copyrightNotice . '. All rights reserved.';
      }

      return new JsonResponse([
        'success' => true,
        'data' => [
          'copyright_notice' => $copyrightNotice,
        ],
      ], 200);

    } catch (\Throwable $th) {
      return new JsonResponse([
        'success' => false,
        'error' => $th->getMessage()
      ], 500);
    }
  }
}