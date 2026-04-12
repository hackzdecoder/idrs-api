<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\DB;

class TrademarkController extends Controller
{
  public function footer(Request $request): JsonResponse
  {
    try {
      // Use the trademarks database connection directly
      $company = DB::connection('trademarks')
        ->table('companies')
        ->orderBy('id', 'desc')
        ->first();

      if (!$company) {
        // Return default copyright notice if no data found
        return new JsonResponse([
          'success' => true,
          'data' => [
            'copyright_notice' => '© ' . date('Y') . ' TaparSoft Enterprise. All rights reserved.',
          ],
        ], 200);
      }

      // Get the copyright text from the company record
      $copyrightText = $company->copyright ?? 'TaparSoft Enterprise';
      $year = date('Y');

      // Check if copyright already contains the full notice
      if (!str_starts_with($copyrightText, '©')) {
        $copyrightNotice = '© ' . $year . ' ' . $copyrightText . '. All rights reserved.';
      } else {
        $copyrightNotice = $copyrightText;
      }

      return new JsonResponse([
        'success' => true,
        'data' => [
          'copyright_notice' => $copyrightNotice,
        ],
      ], 200);

    } catch (\Throwable $th) {
      \Log::error('Failed to fetch footer data: ' . $th->getMessage());

      // Return default on error
      return new JsonResponse([
        'success' => true,
        'data' => [
          'copyright_notice' => '© ' . date('Y') . ' TaparSoft Enterprise. All rights reserved.',
        ],
      ], 200);
    }
  }
}