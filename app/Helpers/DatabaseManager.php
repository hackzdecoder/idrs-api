<?php

namespace App\Helpers;

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Config;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Cache;

class DatabaseManager
{
  const ENV_DEVELOPMENT = 'dev';
  const ENV_PRODUCTION = 'production';
  const CONNECTION_CACHE_KEY = 'school_database_connections';
  const CONNECTION_CACHE_TTL = 3600;

  /**
   * Connect to a school database based on school code
   */
  public static function connectToSchoolDatabase(string $schoolCode): string
  {
    $databaseName = self::generateSchoolDatabaseName($schoolCode);

    // Check if connection already exists and is valid
    if (self::isValidConnection($databaseName)) {
      return $databaseName;
    }

    // Get credentials and create connection
    $credentials = self::getSchoolDatabaseCredentials($schoolCode, $databaseName);
    self::createConnection($databaseName, $credentials);

    // Test connection
    if (!self::testConnection($databaseName)) {
      throw new \Exception("Could not connect to school database: {$databaseName}");
    }

    // Cache the connection
    self::addToCache($databaseName);

    return $databaseName;
  }

  /**
   * Generate school database name from school code
   */
  public static function generateSchoolDatabaseName(string $schoolCode): string
  {
    $isDevelopment = app()->environment(self::ENV_DEVELOPMENT);
    $schoolCode = strtolower(trim($schoolCode));

    if ($isDevelopment) {
      return 'sm_' . $schoolCode . '_dev';
    }

    return 'u141085058_' . $schoolCode;
  }

  /**
   * Generate username for school database
   */
  public static function generateSchoolDatabaseUsername(string $schoolCode): string
  {
    $isDevelopment = app()->environment(self::ENV_DEVELOPMENT);
    $schoolCode = strtolower(trim($schoolCode));

    if ($isDevelopment) {
      return env('DB_SCHOOL_USERNAME_DEV', 'root');
    }

    return 'u141085058_sm_' . $schoolCode;
  }

  /**
   * Get credentials for school database connection
   */
  private static function getSchoolDatabaseCredentials(string $schoolCode, string $databaseName): array
  {
    $isDevelopment = app()->environment(self::ENV_DEVELOPMENT);

    if ($isDevelopment) {
      return [
        'driver' => 'mysql',
        'host' => env('DB_HOST', '127.0.0.1'),
        'port' => env('DB_PORT', '3306'),
        'database' => $databaseName,
        'username' => env('DB_SCHOOL_USERNAME_DEV', 'root'),
        'password' => env('DB_SCHOOL_PASSWORD_DEV', ''),
        'charset' => 'utf8mb4',
        'collation' => 'utf8mb4_unicode_ci',
        'prefix' => '',
        'strict' => true,
        'engine' => null,
        'timezone' => '+08:00',
        'options' => [
          \PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci',
        ],
      ];
    }

    return [
      'driver' => 'mysql',
      'host' => env('DB_HOST', '127.0.0.1'),
      'port' => env('DB_PORT', '3306'),
      'database' => $databaseName,
      'username' => 'u141085058_sm_' . $schoolCode,
      'password' => env('DB_SCHOOL_PASSWORD_PROD', 'M@trix103!'),
      'charset' => 'utf8mb4',
      'collation' => 'utf8mb4_unicode_ci',
      'prefix' => '',
      'strict' => true,
      'engine' => null,
      'timezone' => '+08:00',
      'options' => [
        \PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci',
      ],
    ];
  }

  /**
   * Get SMS users database credentials
   */
  public static function getSmsUsersDatabaseName(): string
  {
    $isDevelopment = app()->environment(self::ENV_DEVELOPMENT);

    if ($isDevelopment) {
      return env('DB_SMS_USERS_DATABASE_DEV', 'sm_users_dev');
    }

    return env('DB_SMS_USERS_DATABASE_PROD', 'u141085058_sms_users_db');
  }

  /**
   * Test if connection is valid
   */
  private static function isValidConnection(string $databaseName): bool
  {
    if (!Config::has("database.connections.{$databaseName}")) {
      return false;
    }

    try {
      $connection = DB::connection($databaseName);
      $connection->getPdo();
      $connection->select('SELECT 1');
      return true;
    } catch (\Exception $e) {
      return false;
    }
  }

  /**
   * Create database connection configuration
   */
  private static function createConnection(string $databaseName, array $config): void
  {
    Config::set("database.connections.{$databaseName}", $config);
  }

  /**
   * Test connection to database
   */
  public static function testConnection(string $databaseName): bool
  {
    try {
      DB::connection($databaseName)->getPdo();
      return true;
    } catch (\Exception $e) {
      Log::error("Failed to connect to database: {$databaseName}", ['error' => $e->getMessage()]);
      return false;
    }
  }

  /**
   * Add connection to cache
   */
  private static function addToCache(string $databaseName): void
  {
    $connections = Cache::get(self::CONNECTION_CACHE_KEY, []);
    $connections[$databaseName] = [
      'connected_at' => now()->toDateTimeString(),
    ];
    Cache::put(self::CONNECTION_CACHE_KEY, $connections, self::CONNECTION_CACHE_TTL);
  }

  /**
   * Remove connection from cache
   */
  public static function removeFromCache(string $databaseName): void
  {
    $connections = Cache::get(self::CONNECTION_CACHE_KEY, []);
    unset($connections[$databaseName]);
    Cache::put(self::CONNECTION_CACHE_KEY, $connections, self::CONNECTION_CACHE_TTL);
  }

  /**
   * Clear all cached connections
   */
  public static function clearCache(): void
  {
    Cache::forget(self::CONNECTION_CACHE_KEY);
  }

  /**
   * Disconnect from database
   */
  public static function disconnect(string $databaseName): void
  {
    if (Config::has("database.connections.{$databaseName}")) {
      try {
        DB::disconnect($databaseName);
      } catch (\Exception $e) {
        // Ignore disconnect errors
      }
      Config::set("database.connections.{$databaseName}", null);
    }

    self::removeFromCache($databaseName);
  }

  /**
   * Extract school code from database name
   */
  public static function extractSchoolCodeFromDatabaseName(string $databaseName): string
  {
    // Remove u141085058_ prefix
    $schoolCode = preg_replace('/^u141085058_/', '', $databaseName);

    // Remove sm_ prefix if exists (for development)
    $schoolCode = preg_replace('/^sm_/', '', $schoolCode);

    // Remove _dev suffix if exists
    $schoolCode = preg_replace('/_dev$/', '', $schoolCode);

    return $schoolCode ?: $databaseName;
  }

  /**
   * Get all active school database connections
   */
  public static function getActiveConnections(): array
  {
    return Cache::get(self::CONNECTION_CACHE_KEY, []);
  }

  /**
   * Check if school database exists
   */
  public static function schoolDatabaseExists(string $schoolCode): bool
  {
    try {
      $databaseName = self::generateSchoolDatabaseName($schoolCode);
      $connection = self::connectToSchoolDatabase($schoolCode);
      return self::testConnection($databaseName);
    } catch (\Exception $e) {
      return false;
    }
  }
}