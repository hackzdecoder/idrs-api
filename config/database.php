<?php

use Illuminate\Support\Str;

return [

  'default' => env('DB_CONNECTION', 'sqlite'),

  'connections' => [
    'main_connection' => [
      'driver' => 'mysql',
      'url' => env('DB_URL'),
      'host' => env('DB_HOST', '127.0.0.1'),
      'port' => env('DB_PORT', '3306'),
      'database' => env('APP_ENV') === 'dev' ? env('DB_DATABASE_IDRS_DEV') : env('DB_DATABASE_IDRS_PROD'),
      'username' => env('APP_ENV') === 'dev' ? env('DB_USERNAME_IDRS_DEV') : env('DB_USERNAME_IDRS_PROD'),
      'password' => env('APP_ENV') === 'dev' ? env('DB_PASSWORD_IDRS_DEV') : env('DB_PASSWORD_IDRS_PROD'),
      'unix_socket' => env('DB_SOCKET', ''),
      'charset' => env('DB_CHARSET', 'utf8mb4'),
      'collation' => env('DB_COLLATION', 'utf8mb4_unicode_ci'),
      'prefix' => '',
      'prefix_indexes' => true,
      'strict' => true,
      'engine' => null,
      'timezone' => '+08:00',
      'options' => extension_loaded('pdo_mysql') ? array_filter([
        PDO::MYSQL_ATTR_SSL_CA => env('MYSQL_ATTR_SSL_CA'),
      ]) : [],
    ],

    // ====================================================
    // TRADEMARKS DATABASE CONNECTION
    // ====================================================
    'trademarks' => [
      'driver' => 'mysql',
      'url' => env('DB_URL'),
      'host' => env('DB_HOST', '127.0.0.1'),
      'port' => env('DB_PORT', '3306'),
      'database' => env('APP_ENV') === 'dev'
        ? env('DB_DATABASE_TRADEMARKS_DEV')
        : env('DB_DATABASE_TRADEMARKS_PROD'),
      'username' => env('APP_ENV') === 'dev'
        ? env('DB_USERNAME_TRADEMARKS_DEV')
        : env('DB_USERNAME_TRADEMARKS_PROD'),
      'password' => env('APP_ENV') === 'dev'
        ? env('DB_PASSWORD_TRADEMARKS_DEV')
        : env('DB_PASSWORD_TRADEMARKS_PROD'),
      'unix_socket' => env('DB_SOCKET', ''),
      'charset' => 'utf8mb4',
      'collation' => 'utf8mb4_unicode_ci',
      'prefix' => '',
      'prefix_indexes' => true,
      'strict' => true,
      'engine' => null,
      'timezone' => '+08:00',
      'options' => extension_loaded('pdo_mysql') ? array_filter([
        PDO::MYSQL_ATTR_SSL_CA => env('MYSQL_ATTR_SSL_CA'),
      ]) : [],
    ],

    // ====================================================
    // SMS USERS DATABASE CONNECTION
    // ====================================================
    'sms_users' => [
      'driver' => 'mysql',
      'host' => env('DB_HOST', '127.0.0.1'),
      'port' => env('DB_PORT', '3306'),
      'database' => env('APP_ENV') === 'dev'
        ? env('DB_DATABASE_SMS_USERS_DEV')
        : env('DB_DATABASE_SMS_USERS_PROD'),
      'username' => env('APP_ENV') === 'dev'
        ? env('DB_USERNAME_SMS_USERS_DEV')
        : env('DB_USERNAME_SMS_USERS_PROD'),
      'password' => env('APP_ENV') === 'dev'
        ? env('DB_PASSWORD_SMS_USERS_DEV')
        : env('DB_PASSWORD_SMS_USERS_PROD'),
      'charset' => 'utf8mb4',
      'collation' => 'utf8mb4_unicode_ci',
      'prefix' => '',
      'strict' => true,
      'engine' => null,
      'timezone' => '+08:00',
      'options' => extension_loaded('pdo_mysql') ? array_filter([
        PDO::MYSQL_ATTR_SSL_CA => env('MYSQL_ATTR_SSL_CA'),
      ]) : [],
    ],
  ],

  'migrations' => [
    'table' => 'migrations',
    'update_date_on_publish' => true,
  ],

  'redis' => [
    'client' => env('REDIS_CLIENT', 'phpredis'),

    'options' => [
      'cluster' => env('REDIS_CLUSTER', 'redis'),
      'prefix' => env('REDIS_PREFIX', Str::slug((string) env('APP_NAME', 'laravel')) . '-database-'),
      'persistent' => env('REDIS_PERSISTENT', false),
    ],

    'default' => [
      'url' => env('REDIS_URL'),
      'host' => env('REDIS_HOST', '127.0.0.1'),
      'username' => env('REDIS_USERNAME'),
      'password' => env('REDIS_PASSWORD'),
      'port' => env('REDIS_PORT', '6379'),
      'database' => env('REDIS_DB', '0'),
      'max_retries' => env('REDIS_MAX_RETRIES', 3),
      'backoff_algorithm' => env('REDIS_BACKOFF_ALGORITHM', 'decorrelated_jitter'),
      'backoff_base' => env('REDIS_BACKOFF_BASE', 100),
      'backoff_cap' => env('REDIS_BACKOFF_CAP', 1000),
    ],

    'cache' => [
      'url' => env('REDIS_URL'),
      'host' => env('REDIS_HOST', '127.0.0.1'),
      'username' => env('REDIS_USERNAME'),
      'password' => env('REDIS_PASSWORD'),
      'port' => env('REDIS_PORT', '6379'),
      'database' => env('REDIS_CACHE_DB', '1'),
      'max_retries' => env('REDIS_MAX_RETRIES', 3),
      'backoff_algorithm' => env('REDIS_BACKOFF_ALGORITHM', 'decorrelated_jitter'),
      'backoff_base' => env('REDIS_BACKOFF_BASE', 100),
      'backoff_cap' => env('REDIS_BACKOFF_CAP', 1000),
    ],
  ],
];