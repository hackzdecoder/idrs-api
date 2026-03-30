<?php

namespace App\Helpers;

use Laravel\Sanctum\PersonalAccessToken;

class Tokens
{
  /**
   * Refresh access token using a valid refresh token
   * 
   * @param string|null $refreshToken
   * @return string|null Returns new access token or null
   */
  public static function refreshToken($refreshToken)
  {
    if (!$refreshToken) {
      return null;
    }

    $tokenModel = PersonalAccessToken::findToken($refreshToken);

    if (!$tokenModel) {
      return null;
    }

    $user = $tokenModel->tokenable;

    // Check if user exists AND is active
    // Note: Sanctum doesn't have expires_at by default
    if (!$user || strtolower($user->account_status) !== 'active') {
      return null;
    }

    // Delete the used refresh token (ONE-TIME USE)
    $tokenModel->delete();

    // Create new access token
    return self::createAccessToken($user);
  }

  /**
   * Create access token for user
   * 
   * @param \App\Models\User $user
   * @return string
   */
  public static function createAccessToken($user)
  {
    return $user->createToken('access_token', ['*'], now()->addHours(8))->plainTextToken;
  }

  /**
   * Create refresh token for user
   * 
   * @param \App\Models\User $user
   * @return string
   */
  public static function createRefreshToken($user)
  {
    return $user->createToken('refresh_token', ['*'], now()->addDays(14))->plainTextToken;
  }

  /**
   * Delete all tokens for a user
   * 
   * @param \App\Models\User $user
   * @return void
   */
  public static function deleteAllUserTokens($user)
  {
    $user->tokens()->delete();
  }
}