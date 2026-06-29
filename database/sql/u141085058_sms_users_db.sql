-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jun 29, 2026 at 05:18 AM
-- Server version: 11.8.8-MariaDB-log
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u141085058_sms_users_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` varchar(20) NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(2, 'App\\Models\\User', '46', 'auth_token', 'df94f67bf0136e970c7745426badfaecf1baa7c75f1cbf5e35d1fdf070da9507', '[\"*\"]', '2026-06-24 15:06:01', NULL, '2026-06-24 15:05:28', '2026-06-24 15:06:01'),
(3, 'App\\Models\\User', '64', 'auth_token', 'd86076f5e4189dfce367bea5a360a484984d39135ff6e642af35e19484c2bb98', '[\"*\"]', '2026-06-24 17:21:50', NULL, '2026-06-24 17:21:32', '2026-06-24 17:21:50'),
(4, 'App\\Models\\User', '160', 'auth_token', 'e4e5ac260d53f90b4725345bc23dad987c19c3c77e60db425ec6bc0832b2ad20', '[\"*\"]', '2026-06-25 21:48:43', NULL, '2026-06-24 22:13:41', '2026-06-25 21:48:43'),
(6, 'App\\Models\\User', '238', 'auth_token', '07bcaf5fa17ca40f918214728aee1bc11a314663c836318b9c1dd843560c57af', '[\"*\"]', '2026-06-26 00:31:33', NULL, '2026-06-26 00:30:51', '2026-06-26 00:31:33'),
(7, 'App\\Models\\User', '240', 'auth_token', '5c05a9a8de90839527a7ecf1cd3f98dcced269903dd308d3f85a39c46f7cfabf', '[\"*\"]', '2026-06-26 02:21:36', NULL, '2026-06-26 02:20:02', '2026-06-26 02:21:36'),
(8, 'App\\Models\\User', '264', 'auth_token', '0fd746177983a8a4b6ea2986a0d09b3545aa2ce73e07aaef36895948e1985f4a', '[\"*\"]', '2026-06-29 11:40:36', NULL, '2026-06-26 21:37:37', '2026-06-29 11:40:36'),
(11, 'App\\Models\\User', '198', 'auth_token', '51c2454a28d13c8e68d4b0a6d757798282a731fe8aef16ea71be57716d111ec0', '[\"*\"]', '2026-06-29 10:19:58', NULL, '2026-06-27 09:51:49', '2026-06-29 10:19:58'),
(12, 'App\\Models\\User', '82', 'auth_token', '5d2770e3aa49049bcfb0cb3c10428a4a086505bf6fc5b212c30bae9287269f6a', '[\"*\"]', '2026-06-28 08:50:28', NULL, '2026-06-28 08:48:20', '2026-06-28 08:50:28');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) NOT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `email_verified_at` datetime DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `reset_password_token` varchar(255) DEFAULT NULL,
  `reset_token_expires_at` timestamp NULL DEFAULT NULL,
  `otp_code` varchar(255) DEFAULT NULL,
  `otp_code_expired_at` timestamp NULL DEFAULT NULL,
  `otp_verified_at` datetime DEFAULT NULL,
  `remember_token` varchar(255) DEFAULT NULL,
  `account_status` varchar(255) DEFAULT NULL,
  `last_successfull_login` datetime DEFAULT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `school_code` varchar(255) DEFAULT NULL,
  `gs_access_status` varchar(255) DEFAULT NULL,
  `password_update_by` varchar(255) DEFAULT NULL,
  `assigned_admin_email` varchar(255) DEFAULT NULL,
  `terms` varchar(255) DEFAULT NULL,
  `usage_policy` varchar(255) DEFAULT NULL,
  `privacy_policy` varchar(255) DEFAULT NULL,
  `terms_policy_date` varchar(255) DEFAULT NULL,
  `first_user_token` varchar(255) DEFAULT NULL,
  `first_user_token_expiry_at` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `user_id`, `username`, `email`, `email_verified_at`, `password`, `reset_password_token`, `reset_token_expires_at`, `otp_code`, `otp_code_expired_at`, `otp_verified_at`, `remember_token`, `account_status`, `last_successfull_login`, `fullname`, `school_code`, `gs_access_status`, `password_update_by`, `assigned_admin_email`, `terms`, `usage_policy`, `privacy_policy`, `terms_policy_date`, `first_user_token`, `first_user_token_expiry_at`, `created_at`, `updated_at`) VALUES
(1, '09171139756', '09171139756', 'tkjtapar@gmail.com', '2026-01-01 11:11:11', '$2y$10$B1R0.pHIbTx0ACYbXBzEg.tZDS04l8bib36HfhUwBcyFY8t4qrkyK', '', '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', 'active', '0000-00-00 00:00:00', 'TS_ATHENEUM', 'atheneum', 'pending', '', 'taparsoft@gmail.com', 'agreed', 'agreed', 'accepted', '2026-01-01 11:11:11', '', '', '2026-01-01 11:11:11', '2026-01-01 11:11:11'),
(2, '09171139756', '09171139756', 'tkjtapar@gmail.com', '2026-01-01 11:11:11', '$2y$10$B1R0.pHIbTx0ACYbXBzEg.tZDS04l8bib36HfhUwBcyFY8t4qrkyK', '', '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', 'active', '0000-00-00 00:00:00', 'TS_CSI', 'csi', 'pending', '', 'taparsoft@gmail.com', 'agreed', 'agreed', 'accepted', '2026-01-01 11:11:11', '', '', '2026-01-01 11:11:11', '2026-01-01 11:11:11'),
(3, '09171139756', '09171139756', 'tkjtapar@gmail.com', '2026-01-01 11:11:11', '$2y$10$B1R0.pHIbTx0ACYbXBzEg.tZDS04l8bib36HfhUwBcyFY8t4qrkyK', '', '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', 'active', '0000-00-00 00:00:00', 'TS_GVA', 'gva', 'pending', '', 'taparsoft@gmail.com', 'agreed', 'agreed', 'accepted', '2026-01-01 11:11:11', '', '', '2026-01-01 11:11:11', '2026-01-01 11:11:11'),
(4, '09171139756', '09171139756', 'tkjtapar@gmail.com', '2026-01-01 11:11:11', '$2y$10$B1R0.pHIbTx0ACYbXBzEg.tZDS04l8bib36HfhUwBcyFY8t4qrkyK', '', '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', 'active', '0000-00-00 00:00:00', 'TS_NSCI', 'nsci', 'pending', '', 'taparsoft@gmail.com', 'agreed', 'agreed', 'accepted', '2026-01-01 11:11:11', '', '', '2026-01-01 11:11:11', '2026-01-01 11:11:11'),
(5, '09171139756', '09171139756', 'tkjtapar@gmail.com', '2026-01-01 11:11:11', '$2y$10$B1R0.pHIbTx0ACYbXBzEg.tZDS04l8bib36HfhUwBcyFY8t4qrkyK', '', '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', 'active', '0000-00-00 00:00:00', 'TS_SCA', 'sca', 'pending', '', 'taparsoft@gmail.com', 'agreed', 'agreed', 'accepted', '2026-01-01 11:11:11', '', '', '2026-01-01 11:11:11', '2026-01-01 11:11:11'),
(6, '09171139756', '09171139756', 'tkjtapar@gmail.com', '2026-01-01 11:11:11', '$2y$10$B1R0.pHIbTx0ACYbXBzEg.tZDS04l8bib36HfhUwBcyFY8t4qrkyK', '', '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', 'active', '0000-00-00 00:00:00', 'TS_SVA', 'sva', 'pending', '', 'taparsoft@gmail.com', 'agreed', 'agreed', 'accepted', '2026-01-01 11:11:11', '', '', '2026-01-01 11:11:11', '2026-01-01 11:11:11'),
(7, '09171139756', '09171139756', 'tkjtapar@gmail.com', '2026-01-01 11:11:11', '$2y$10$B1R0.pHIbTx0ACYbXBzEg.tZDS04l8bib36HfhUwBcyFY8t4qrkyK', '', '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', 'active', '0000-00-00 00:00:00', 'TS_VISION', 'vision', 'pending', '', 'taparsoft@gmail.com', 'agreed', 'agreed', 'accepted', '2026-01-01 11:11:11', '', '', '2026-01-01 11:11:11', '2026-01-01 11:11:11'),
(8, '09171139756', '09171139756', 'tkjtapar@gmail.com', '2026-01-01 11:11:11', '$2y$10$B1R0.pHIbTx0ACYbXBzEg.tZDS04l8bib36HfhUwBcyFY8t4qrkyK', '', '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', 'active', '0000-00-00 00:00:00', 'TS_RESERVE01', 'trial', 'pending', '', 'taparsoft@gmail.com', 'agreed', 'agreed', 'accepted', '2026-01-01 11:11:11', '', '', '2026-01-01 11:11:11', '2026-01-01 11:11:11'),
(9, '09171139756', '09171139756', 'tkjtapar@gmail.com', '2026-01-01 11:11:11', '$2y$10$B1R0.pHIbTx0ACYbXBzEg.tZDS04l8bib36HfhUwBcyFY8t4qrkyK', '', '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', 'active', '0000-00-00 00:00:00', 'TS_RESERVE02', 'trial', 'pending', '', 'taparsoft@gmail.com', 'agreed', 'agreed', 'accepted', '2026-01-01 11:11:11', '', '', '2026-01-01 11:11:11', '2026-01-01 11:11:11'),
(10, '09171139756', '09171139756', 'tkjtapar@gmail.com', '2026-01-01 11:11:11', '$2y$10$B1R0.pHIbTx0ACYbXBzEg.tZDS04l8bib36HfhUwBcyFY8t4qrkyK', '', '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', 'active', '0000-00-00 00:00:00', 'TS_RESERVE03', 'trial', 'pending', '', 'taparsoft@gmail.com', 'agreed', 'agreed', 'accepted', '2026-01-01 11:11:11', '', '', '2026-01-01 11:11:11', '2026-01-01 11:11:11'),
(11, '09171139756', '09171139756', 'tkjtapar@gmail.com', '2026-01-01 11:11:11', '$2y$10$B1R0.pHIbTx0ACYbXBzEg.tZDS04l8bib36HfhUwBcyFY8t4qrkyK', '', '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', 'active', '0000-00-00 00:00:00', 'TS_RESERVE04', 'trial', 'pending', '', 'taparsoft@gmail.com', 'agreed', 'agreed', 'accepted', '2026-01-01 11:11:11', '', '', '2026-01-01 11:11:11', '2026-01-01 11:11:11'),
(12, '09171139756', '09171139756', 'tkjtapar@gmail.com', '2026-01-01 11:11:11', '$2y$10$B1R0.pHIbTx0ACYbXBzEg.tZDS04l8bib36HfhUwBcyFY8t4qrkyK', '', '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', 'active', '0000-00-00 00:00:00', 'TS_RESERVE05', 'trial', 'pending', '', 'taparsoft@gmail.com', 'agreed', 'agreed', 'accepted', '2026-01-01 11:11:11', '', '', '2026-01-01 11:11:11', '2026-01-01 11:11:11'),
(13, '09171139756', '09171139756', 'tkjtapar@gmail.com', '2026-01-01 11:11:11', '$2y$10$B1R0.pHIbTx0ACYbXBzEg.tZDS04l8bib36HfhUwBcyFY8t4qrkyK', '', '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', 'active', '0000-00-00 00:00:00', 'TS_RESERVE06', 'trial', 'pending', '', 'taparsoft@gmail.com', 'agreed', 'agreed', 'accepted', '2026-01-01 11:11:11', '', '', '2026-01-01 11:11:11', '2026-01-01 11:11:11'),
(14, '09171139756', '09171139756', 'tkjtapar@gmail.com', '2026-01-01 11:11:11', '$2y$10$B1R0.pHIbTx0ACYbXBzEg.tZDS04l8bib36HfhUwBcyFY8t4qrkyK', '', '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', 'active', '0000-00-00 00:00:00', 'TS_RESERVE07', 'trial', 'pending', '', 'taparsoft@gmail.com', 'agreed', 'agreed', 'accepted', '2026-01-01 11:11:11', '', '', '2026-01-01 11:11:11', '2026-01-01 11:11:11'),
(15, '09171139756', '09171139756', 'tkjtapar@gmail.com', '2026-01-01 11:11:11', '$2y$10$B1R0.pHIbTx0ACYbXBzEg.tZDS04l8bib36HfhUwBcyFY8t4qrkyK', '', '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', 'active', '0000-00-00 00:00:00', 'TS_RESERVE08', 'trial', 'pending', '', 'taparsoft@gmail.com', 'agreed', 'agreed', 'accepted', '2026-01-01 11:11:11', '', '', '2026-01-01 11:11:11', '2026-01-01 11:11:11'),
(16, '09171139756', '09171139756', 'tkjtapar@gmail.com', '2026-01-01 11:11:11', '$2y$10$B1R0.pHIbTx0ACYbXBzEg.tZDS04l8bib36HfhUwBcyFY8t4qrkyK', '', '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', 'active', '0000-00-00 00:00:00', 'TS_RESERVE09', 'trial', 'pending', '', 'taparsoft@gmail.com', 'agreed', 'agreed', 'accepted', '2026-01-01 11:11:11', '', '', '2026-01-01 11:11:11', '2026-01-01 11:11:11'),
(17, '09171139756', '09171139756', 'tkjtapar@gmail.com', '2026-01-01 11:11:11', '$2y$10$B1R0.pHIbTx0ACYbXBzEg.tZDS04l8bib36HfhUwBcyFY8t4qrkyK', '', '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', 'active', '0000-00-00 00:00:00', 'TS_RESERVE10', 'trial', 'pending', '', 'taparsoft@gmail.com', 'agreed', 'agreed', 'accepted', '2026-01-01 11:11:11', '', '', '2026-01-01 11:11:11', '2026-01-01 11:11:11'),
(18, '11111111111', '11111111111', 'tkjtapar@gmail.com', '2026-01-01 11:11:11', '$2y$10$B1R0.pHIbTx0ACYbXBzEg.tZDS04l8bib36HfhUwBcyFY8t4qrkyK', '', '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', 'active', '0000-00-00 00:00:00', 'TS_USER1', 'trial', 'pending', '', 'taparsoft@gmail.com', 'agreed', 'agreed', 'accepted', '2026-01-01 11:11:11', '', '', '2026-01-01 11:11:11', '2026-01-01 11:11:11'),
(19, '22222222222', '22222222222', 'tkjtapar@gmail.com', NULL, '$2y$10$B1R0.pHIbTx0ACYbXBzEg.tZDS04l8bib36HfhUwBcyFY8t4qrkyK', '', '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', 'active', '0000-00-00 00:00:00', 'TS_USER2', 'trial', 'pending', '', 'taparsoft@gmail.com', '', '', '', '', '', '', '2026-01-01 11:11:11', '2026-01-01 11:11:11'),
(20, '33333333333', '33333333333', 'tkjtapar@gmail.com', '2026-01-01 11:11:11', '$2y$10$B1R0.pHIbTx0ACYbXBzEg.tZDS04l8bib36HfhUwBcyFY8t4qrkyK', '', '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', 'active', '0000-00-00 00:00:00', 'TS_USER3', 'trial', 'pending', '', 'taparsoft@gmail.com', 'agreed', 'agreed', 'accepted', '2026-01-01 11:11:11', '', '', '2026-01-01 11:11:11', '2026-01-01 11:11:11'),
(21, '44444444444', '44444444444', 'tkjtapar@gmail.com', NULL, '$2y$10$B1R0.pHIbTx0ACYbXBzEg.tZDS04l8bib36HfhUwBcyFY8t4qrkyK', '', '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', 'active', '0000-00-00 00:00:00', 'TS_USER4', 'trial', 'pending', '', 'taparsoft@gmail.com', '', '', '', '', '', '', '2026-01-01 11:11:11', '2026-01-01 11:11:11'),
(22, '55555555555', '55555555555', 'tkjtapar@gmail.com', '2026-01-01 11:11:11', '$2y$10$B1R0.pHIbTx0ACYbXBzEg.tZDS04l8bib36HfhUwBcyFY8t4qrkyK', '', '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', 'active', '0000-00-00 00:00:00', 'TS_USER5', 'trial', 'pending', '', 'taparsoft@gmail.com', 'agreed', 'agreed', 'accepted', '2026-01-01 11:11:11', '', '', '2026-01-01 11:11:11', '2026-01-01 11:11:11'),
(23, '77777777777', '77777777777', 'tkjtapar@gmail.com', '2026-01-01 11:11:11', '$2y$10$B1R0.pHIbTx0ACYbXBzEg.tZDS04l8bib36HfhUwBcyFY8t4qrkyK', '', '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', 'active', '0000-00-00 00:00:00', 'TS_USER7', 'trial', 'pending', '', 'taparsoft@gmail.com', 'agreed', 'agreed', 'accepted', '2026-01-01 11:11:11', '', '', '2026-01-01 11:11:11', '2026-01-01 11:11:11'),
(24, '88888888888', '88888888888', 'tkjtapar@gmail.com', NULL, '$2y$10$B1R0.pHIbTx0ACYbXBzEg.tZDS04l8bib36HfhUwBcyFY8t4qrkyK', '', '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', 'active', '0000-00-00 00:00:00', 'TS_USER8', 'trial', 'pending', '', 'taparsoft@gmail.com', '', '', '', '', '', '', '2026-01-01 11:11:11', '2026-01-01 11:11:11'),
(25, '99999999999', '99999999999', 'tkjtapar@gmail.com', '2026-01-01 11:11:11', '$2y$10$B1R0.pHIbTx0ACYbXBzEg.tZDS04l8bib36HfhUwBcyFY8t4qrkyK', '', '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', 'active', '0000-00-00 00:00:00', 'TS_USER9', 'trial', 'pending', '', 'taparsoft@gmail.com', 'agreed', 'agreed', 'accepted', '2026-01-01 11:11:11', '', '', '2026-01-01 11:11:11', '2026-01-01 11:11:11'),
(26, '09175023039', '09175023039', 'atheneumamcan@gmail.com', NULL, '$2y$10$4cIep6p3aeVmz4f4BxrzleSh7E6XOXeJ6rTGQ0BVtwLbTd9B52a3C', '', '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', 'active', '0000-00-00 00:00:00', 'ATHENEUM SCHOOL', 'atheneum', 'pending', '', 'atheneumamcan@gmail.com', '', '', '', '', '', '', '2026-06-01 11:11:11', '2026-06-01 11:11:11'),
(27, '09763922884', '09763922884', 'goldenvalues_academy@yahoo.com', NULL, '$2y$10$M5OG/E3DLQVmxn/Llc8Xf.KX.BQ30auV4zl9PYumKiZ8lqKDV8Hai', '', '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', 'active', '0000-00-00 00:00:00', 'GOLDEN VALUES ACADEMY', 'gva', 'pending', '', 'goldenvalues_academy@yahoo.com', '', '', '', '', '', '', '2026-06-01 11:11:11', '2026-06-01 11:11:11'),
(28, '09177455049', '09177455049', 'nuestrainstitute@gmail.com', NULL, '$2y$10$/u5gnT64DptHq4lcbYJRb.auPbxR2rtXSTjPknpgq68l472temkgO', '', '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', 'active', '0000-00-00 00:00:00', 'NUESTRA SEÑORA DEL CARMEN INSTITUTE', 'nsci', 'pending', '', 'nuestrainstitute@gmail.com', '', '', '', '', '', '', '2026-06-01 11:11:11', '2026-06-01 11:11:11'),
(29, '09228463570', '09228463570', 'darwin_clemente@yahoo.com', NULL, '$2y$10$nCvgvWjLZa4qVsp5OEm0KuvUi5m4/8y/PWkw1MLjzv5XrfgwiKFTi', '', '0000-00-00 00:00:00', NULL, NULL, '0000-00-00 00:00:00', '', 'active', '0000-00-00 00:00:00', 'ST. CLEMENT ACADEMY', 'sca', 'pending', '', 'stclementacademyincorporated@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-01 11:11:11', '2026-06-01 11:11:11'),
(30, '09562112068', '09562112068', 'sva_1985@yahoo.com', NULL, '$2y$10$jX8K.o/pzcYd.gegdr8jY.Tn1JG97/u9YTx1WJDGiQgJsX/Y0XtGe', '', '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', 'active', '0000-00-00 00:00:00', 'ST. VINCENT\'S ACADEMY OF APALIT, PAMPANGA', 'sva', 'pending', '', 'sva_1985@yahoo.com', '', '', '', '', '', '', '2026-06-01 11:11:11', '2026-06-01 11:11:11'),
(31, '09171869598', '09171869598', 'visionacademyinc@gmail.com', NULL, '$2y$10$50EiWXXwxfvsT2LTbjca1.8YtOHW48akKSmlpTnEedW4ceqVGzO.6', '', '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', 'active', '0000-00-00 00:00:00', 'VISION ACADEMY', 'vision', 'pending', '', 'visionacademyinc@gmail.com', '', '', '', '', '', '', '2026-06-01 11:11:11', '2026-06-01 11:11:11'),
(34, '09175211118', '09175211118', 'dlasernacosejo@gmail.com', NULL, '$2y$12$lSjnzAPs7QtyQYW7IKB7qebHjhnWYPe5d/c8gXFEZPjnCSllW7TnC', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Laserna, Dianne', 'ATHENEUM', 'pending', NULL, 'atheneumamcan@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-11 16:18:06', '2026-06-11 16:24:08'),
(37, '09459759771', '09459759771', 'mitchoctavo@gmail.com', NULL, '$2y$12$dwNcZvVzOMZfhHv.5K44Pun8BzPYjDk/xJE.VhDyKvB/XXYNrMM4W', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Cipriaso, Mitch', 'ATHENEUM', 'pending', NULL, 'atheneumamcan@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-16 15:00:27', '2026-06-16 15:00:27'),
(38, '09165620305', '09165620305', 'shenvrra@gmail.com', NULL, '$2y$12$pEcCrEjovYEAx0mRuN9mBejGDFILWJndW6u3gJ06o/sobipF5V1Xa', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Navarra, Sheena', 'SCA', 'pending', NULL, 'stclementacademyincorporated@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-23 17:03:40', '2026-06-23 17:03:40'),
(39, '09533786679', '09533786679', 'roxanneanonuevo25@gmail.com', NULL, '$2y$12$cuvTmlZtEDLI1c2/DalU6.CrMIlVAuy/UugWsOGlh6/ECBTrm1h5S', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Villaruel, Roxanne', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 08:55:30', '2026-06-24 08:55:30'),
(40, '09292784580', '09292784580', 'maryruthjoy.reginalde902@gmail.com', NULL, '$2y$12$ZgUAaqxXzaIvRVJdRuBvHevTjV.5AHIbZ0NWzm66VhdRHnH5ajZDG', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Uy, Mary Ruth Joy', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 08:56:18', '2026-06-24 08:56:18'),
(41, '09484131577', '09484131577', 'dulayharveykianofficial@gmail.com', NULL, '$2y$12$NbGY7jSvWEWu8wV3/O5VPuEgMiGMSYU4Ha9XFeGtVoc/AKKpac2WC', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Dulay, Alma Villota', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 09:00:11', '2026-06-24 09:00:11'),
(42, '09953344438', '09953344438', 'armiahdlsnts@gmail.com', NULL, '$2y$12$ePruhVLNpFxwSBVukQbXROXb6Nod5rzg6l8xX6Bs9b66npCiuOaEe', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Delos Santos, Lilibeth', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 09:03:11', '2026-06-24 09:03:11'),
(43, '09067850846', '09067850846', '1984bonaventeaileen@gmail.com', NULL, '$2y$12$93xngnfvEX3ktqHXFVYtpuOWj1HdtMPlSgbVEXlYHmcv2Jop6Ol96', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Bonavente, Aileen', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 09:06:30', '2026-06-24 09:06:30'),
(44, '09052223875', '09052223875', 'delrosargiezzelle@gmail.com', NULL, '$2y$12$6fyrhNi18r38xEYDkX8c/.8iGfsLtwYt7XsdzDNbIZmaEljSQzF.q', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Del Rosario, Giezzelle C.Del Rosario', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 14:21:50', '2026-06-24 14:21:50'),
(45, '09973947883', '09973947883', 'ettolrach.santos.21@gmail.com', NULL, '$2y$12$i5xSCTMXVr3IzhWfkcCiiuv1So/lltZdc3x2q.Y5uyPerr/iGkx46', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Santos, Louie', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 14:53:12', '2026-06-24 14:53:12'),
(46, '09328815613', '09328815613', 'angel_abella28@yahoo.com', '2026-06-24 15:05:10', '$2y$12$DWAad2v.lv9roxm9LytFOe2gtLyINooBRZ.ytxhdfLynk0S6VloAm', NULL, NULL, NULL, NULL, '2026-06-24 15:05:05', NULL, 'active', '2026-06-24 15:05:28', 'ABELLA, ANGEL', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', 'Agreed', 'Agreed', 'Accepted', '2026-06-24 15:05:10', NULL, NULL, '2026-06-24 15:00:59', '2026-06-24 15:05:10'),
(47, '09853637447', '09853637447', 'akocaix@gmail.com', NULL, '$2y$12$l1VwCDc5CvZ8ASpHvEkeMeq4IKr1Rj0M8d52hE3eOYUQfrx8M/.2i', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Cabiles, Aiko Jane', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 15:27:03', '2026-06-24 15:27:03'),
(48, '09102798037', '09102798037', 'elain3fabonan20@gmail.com', NULL, '$2y$12$CEFRwIHrO/Ou.IIyZr.8D.aU6UsQD2XRpz2B3CVcbLXE.YqIJW2/6', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Fabonan, Elaine', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 15:28:48', '2026-06-25 14:14:47'),
(49, '09392295559', '09392295559', 'kheidgermar@gmail.com', NULL, '$2y$12$2c/23.Kon/JCTjjttEsykeV2o8Ek3/E5GHnhxiqYZ8jCKd6XF6br.', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Germar, Khecielen', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 15:30:48', '2026-06-25 18:14:37'),
(50, '09122150527', '09122150527', 'khrisallan08@gmail.com', NULL, '$2y$12$GiUfGgTvNe4U7L8tQgM7w.N1WNJ79PyaDGKWAJ47kwWDdaugqf7Sa', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Saguin, Khristine', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 15:33:15', '2026-06-24 15:33:15'),
(51, '09093325485', '09093325485', 'xmarie668@gmail.com', NULL, '$2y$12$DEzQ6DYnbBT2RHyBzpknSuNRVHh6EJZTalrGC09v.1vRyYc4yHCtC', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Achazo, Roxxane Marie', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 15:43:03', '2026-06-24 15:43:03'),
(52, '09217605902', '09217605902', 'nashika1221@gmail.com', NULL, '$2y$12$haIDo8KILW8s7Eq8G49Dy.hF7oME.UFSotx1A/6bB/t56RP8IfUK2', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Capuno, Kashina Pia', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 15:45:16', '2026-06-25 20:46:18'),
(53, '09561262653', '09561262653', 'friasdiane60@gmail.com', NULL, '$2y$12$yVbECU6EB5BsbyFr4R/SyumrszEYIKiATbS8pUWbQtzXBm4X4IVfi', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Frias, Ma.Cristina Luz', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 15:49:14', '2026-06-24 15:49:14'),
(54, '09079955974', '09079955974', 'dahliagulinao@gmail.com', NULL, '$2y$12$45Rcn6zReaLaEv5GhfQ54OyM8Kh.ewX9DzBUId28nbredBs8tEqIG', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Gulinao, Teresita', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 15:52:27', '2026-06-24 15:52:27'),
(55, '09952173195', '09952173195', 'nezhbperez@gmail.com', NULL, '$2y$12$2rQ7wnOGWmlw8Tz/kjFTUewe4V9r0UJMBeqz/dKus.k0gEdOug3v6', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Perez, Nezhrine', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 15:55:24', '2026-06-24 15:55:24'),
(56, '09915917364', '09915917364', 'jhenv9040@gmail.com', NULL, '$2y$12$0dmxalj/YLuUppxfytVuOewQl1io1gdt9/FikdwF49.wNHM89hpGu', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Viray, Jennifer', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 16:01:11', '2026-06-24 16:01:11'),
(57, '09244925992', '09244925992', 'gracedantes50@gmail.com', NULL, '$2y$12$Ak7kQ8K7i9AZH5LwxOFYeuGndzWY1zK0ebVHznpa9GITWpT88pFJS', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Diamante, Mary Grace', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 16:13:33', '2026-06-24 16:13:33'),
(58, '09431285650', '09431285650', 'melodybernardo66@gmail.com', NULL, '$2y$12$fmeH2vQrzO6SXLJQ3EkfAujEmSOIBqFLA/ovMv86.eakOOx5Zw3ym', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Pascual, Melody', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 16:23:39', '2026-06-24 16:23:39'),
(59, '09758048289', '09758048289', 'herliebuenaventura514@gmail.com', NULL, '$2y$12$Q0lnrzogRy5Vkm.tlS5iFOHaG0auHJvYJeHKhqBxW312VeManR1pK', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Germar, Herlie', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 16:30:49', '2026-06-24 19:37:50'),
(60, '09683262107', '09683262107', 'hazelanngrace05@yahoo.com', NULL, '$2y$12$ThtJazJG7gqjUuFDcFtoouWrz..dw4PApZzbsShFh6QM2Z0fnt2Vy', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Bacani, Hazel Ann Grace', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 16:32:52', '2026-06-24 16:32:52'),
(61, '09482581743', '09482581743', 'quintosraizel19@gmail.com', NULL, '$2y$12$UQaSoEb.gxyEwU1KRCfPLOkEomyONCauQGbKIRdzcFj2MDKxwLRIS', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Quintos, Quintos', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 16:37:39', '2026-06-24 16:37:39'),
(62, '09676407769', '09676407769', 'iyaquelidoro21@gmail.com', NULL, '$2y$12$TwjPh2oUKS/TFVSuAgOsHuM.tNUM1ybzSFN9kCImfKY2uq7xHOo8u', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Quelidoro, Maria eliza', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 16:40:36', '2026-06-25 20:41:27'),
(63, '09655213922', '09655213922', 'pastorajasmine30@gmail.com', NULL, '$2y$12$0kr3Sal32k.PbMR2SHRb8.Z2XBMYCt/w4f21gn4UyDbwTI7mRY2mK', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Cabrera, Jasmine', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 16:40:37', '2026-06-24 16:40:37'),
(64, '09669622887', '09669622887', 'jenniferpfausto@yahoo.com', '2026-06-24 17:21:32', '$2y$12$O7zArIOWo2wy1qYPs/.ttONJD2BI.2i7X0jffVsIKkBxJtO6kg22G', NULL, NULL, NULL, NULL, '2026-06-24 17:21:26', NULL, 'active', '2026-06-24 17:21:32', 'Fausto, Jennifer', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', 'Agreed', 'Agreed', 'Accepted', '2026-06-24 17:21:32', NULL, NULL, '2026-06-24 16:41:41', '2026-06-27 15:50:52'),
(65, '09568926933', '09568926933', 'milisaramos825@gmail.com', NULL, '$2y$12$SQ2kTiudYlH4Z46XizpOoOV8ayj277cffJamRhY96ps2xVLN8SYJm', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Ramos, Milisa', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 16:41:47', '2026-06-24 16:41:47'),
(66, '09089415064', '09089415064', 'francine111219@gmail.com', NULL, '$2y$12$2WjOLWtfcDX4kvhm0.Dz3ewY.hR7jcpJb/TS9nj91kLqXtwEgSnjS', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Dagondon, Jenelyn', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 16:42:15', '2026-06-24 16:42:15'),
(67, '09334476138', '09334476138', 'maryshelleuntalan@gmail.com', NULL, '$2y$12$dGafmascAIG5gnSI5AZ5B.MdaVE3deQhTEzUW1.sTOHdhk./yq.Ba', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Untalan, Mary Shelle', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 16:48:42', '2026-06-24 16:48:42'),
(68, '09611945846', '09611945846', 'joanalyncruz30@gmail.com', NULL, '$2y$12$R.bB7nL2ziqnLCi4yE7e/O7XsQ.kr2XCgl9e36MsucO7mRkXgJSUy', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Cruz, Joanalyn', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 16:49:53', '2026-06-24 19:32:07'),
(69, '09060083360', '09060083360', 'botemarkdave@gmail.com', NULL, '$2y$12$xM25vUrzLPDTdBzUWAcJYuooAudqRPOu2allYCt58T9Y0RSeX.Vte', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Bote, Jamaica Rose', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 16:50:39', '2026-06-24 16:50:39'),
(70, '09918292335', '09918292335', 'cristinadizon1975@gmail.com', NULL, '$2y$12$mMguEc9NF2lKZeMQ7vEzAuHlh1zsVc3EVeeAkCb8eHdUlbTa/.2Wq', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'DIZON, CRISTINA', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 16:50:45', '2026-06-28 12:35:40'),
(71, '09507030225', '09507030225', 'rezelista22@gmail.com', NULL, '$2y$12$S4N79tP.DT.jpdHm9d8GaukZnY9OzO5HZOfbe0hHIe3pOOP28EQZm', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'De Silva, Rezel May', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 16:53:53', '2026-06-24 16:53:53'),
(72, '09153954131', '09153954131', 'maryanncortez0670@gmail.com', NULL, '$2y$12$sPI7K8MfeP74s2h9QGcHYeE.SFNZaxJzglzIKE9dyV2kZgB4n1cS6', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Cortez, Maryann', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 16:57:29', '2026-06-24 16:57:29'),
(73, '09531322306', '09531322306', 'jezceldelrosario@gmail.com', NULL, '$2y$12$He.y5Nk48ukPd.WDNbImEOtUgR6Oq1MXZvDQSI2yDUb50mbmlLS0W', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Del Rosario, Jezcel Jane', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 16:58:36', '2026-06-24 16:58:36'),
(74, '09055214336', '09055214336', 'dhesvargas25@gmail.com', NULL, '$2y$12$vbLhfFGajFz7BAK7LNr/7em0.TkT8Vo.kmd14wAhre8aHLoha5MA6', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Sakata, Rudess', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 17:01:55', '2026-06-26 07:59:13'),
(75, '09068776002', '09068776002', 'Leahmanalaysay1210@gmail.com', NULL, '$2y$12$4xxIhXh6zNmPCWGO0/2li.JkYGACIIuilVfvdD9FtXTdSi7Wmlg.u', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Pozon, Leah', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 17:04:10', '2026-06-24 17:04:10'),
(76, '09816599405', '09816599405', 'sarmientochristia@gmail.com', NULL, '$2y$12$nXYxVVp2TY.39ZvwTyL9N.2VNur58n6cqLr86hCT8vnkXA9.9i9/m', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Sarmiento, Christia Anne', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 17:05:55', '2026-06-24 17:05:55'),
(77, '09569039297', '09569039297', 'jham052887@gmail.com', NULL, '$2y$12$NR2JSgAmNdJiHTZczmsCVOls0ALCbP9b1WkVqCX.29YNfTE95wspu', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Fernandez, Joanna marie', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 17:07:21', '2026-06-25 22:07:47'),
(78, '09753080737', '09753080737', 'mp_javinal17@rocketmail.com', NULL, '$2y$12$09oOBYVDdo9MjMmb/XPN5uBYK0sK3phTdO299w/15/ig/2JTGadTu', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Magpayo, Maria Pablita', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 17:19:51', '2026-06-24 17:19:51'),
(79, '09083962495', '09083962495', 'kathleen.parohinog0104@gmail.com', NULL, '$2y$12$RojUpfMYzt9UYmX/YWkXje1EMiEGfWgnjSg4mi0Khl2jqWFP82g26', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Parohinog, Kathleen', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 17:23:13', '2026-06-24 20:25:43'),
(80, '09994438043', '09994438043', 'vhancaacbay@gmail.com', NULL, '$2y$12$kojSgMFh.siHSUolwxQZquvoVjCRHx9gCdd86wzcHPzO8cKGkts66', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'FABABIER, REYNA VANESSA', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 18:00:28', '2026-06-24 19:49:04'),
(81, '09686769462', '09686769462', 'villonr25@gmail.com', NULL, '$2y$12$OeAVp0LFWW.u1ZvwsY0BnuRu.ccUmY4D/bZ6Q3TGjT4QS2jR5UsWa', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Villon, Rita', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 18:03:45', '2026-06-24 18:03:45'),
(82, '09647688298', '09647688298', 'dinabatayola@gmail.com', '2026-06-28 08:48:20', '$2y$12$Wb4v.zWPApACNMK6KinqrO0hTV1z.vbRm3eL1CuRO1gMLFUa9x/Xq', NULL, NULL, NULL, NULL, '2026-06-28 08:47:53', NULL, 'active', '2026-06-28 08:48:20', 'Batayola, Dina', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', 'Agreed', 'Agreed', 'Accepted', '2026-06-28 08:48:20', NULL, NULL, '2026-06-24 18:28:12', '2026-06-28 08:48:20'),
(83, '09239351338', '09239351338', 'alexandergalopejr@gmail.com', NULL, '$2y$12$rkXMcQ6VpeBQRxXik2Rr7eayBFYwpEhUNIDlahhgrk2avecai8tEW', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Galope Jr., Alexander', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 18:33:08', '2026-06-24 18:45:13'),
(84, '09668892338', '09668892338', 'bernadethserajose17@gmail.com', NULL, '$2y$12$kaLgvAXSUEjHjHlUDAytUOeH63bhbrVLah9OkspqZ0uRJVMS1J/xu', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Chuliao, Lovely', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 18:34:42', '2026-06-24 18:34:42'),
(85, '09275686865', '09275686865', 'jhenigordo@gmail.com', NULL, '$2y$12$4mCYnfbOwA1W1QItroxOuuszlhOcUEUf2N4KSDairi/WWoD360Xiu', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Gordo, Jennifer', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 18:39:50', '2026-06-24 18:39:50'),
(86, '09266504883', '09266504883', 'sarmientocandy@yahoo.com.ph', NULL, '$2y$12$jObFtQuL10nC1FOI8WvnfedRhRzKZ5Ajj.N2QceTDdi81A3kwqc5G', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Tumanan, Candy', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 18:42:45', '2026-06-24 18:42:45'),
(87, '09351358531', '09351358531', 'kyrishgmartinez@gmail.com', NULL, '$2y$12$bFq3LQ/TXJJlvoRGPp2SGeM/CZxP0gKpclm..I9/zIPFQZimWWrLm', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Martinez, Kyrish', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 18:44:16', '2026-06-24 18:47:29'),
(88, '09065104287', '09065104287', 'neroezekieldejesus@gmail.com', NULL, '$2y$12$X5Sb8UK/x3/njLDaiNg31eNnWPVWB/L/fAIDgU0JrtE4wTeRwiRRe', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'De Jesus, Ricalyn', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 18:46:22', '2026-06-24 18:46:22'),
(89, '09278030542', '09278030542', 'cathysese26@gmail.com', NULL, '$2y$12$QXWoOv1ojZLvAVrw27dn4elzqIQEi0zvCEc5xv/sZRtcvmVWS0rwm', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Basi, Cathyrene', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 18:49:56', '2026-06-24 18:49:56'),
(90, '09053631408', '09053631408', 'belmalana919@yahoo.com', NULL, '$2y$12$OK7sZIdGEeKzitT6W8.WJeouC7L5mWn2fbJcbgrdTiG8J.CQELFie', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Malana, Crisbel', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 18:51:45', '2026-06-24 18:51:45'),
(91, '09261997858', '09261997858', 'robertdelatorre278@gmail.com', NULL, '$2y$12$0xhUu4IkZR3UILu4Y0aPauRqlns3S5DCQHddphwFSULIukQfuQMAq', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Torre, Robert', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 18:53:13', '2026-06-24 18:53:13'),
(92, '09753641893', '09753641893', 'larabels3nidad@yahoo.com', NULL, '$2y$12$OCleCwx5eXiA/RnTZNs1ZOALian.UnvL4l.MNrNeDzyMMJl/wfc7W', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Trinidad, Cynthia Lara', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 18:54:18', '2026-06-24 18:54:18'),
(93, '09466996597', '09466996597', 'ocamporejalyn@gmail.com', NULL, '$2y$12$QcNB.ij1ZT777vdEUjoKvuIWDNF36lxGNqaibNe8LlgD1kVigc4aW', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Jerico L. Gumasing, Rejalyn M.Ocampo', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 18:55:54', '2026-06-24 18:55:54'),
(94, '09310103846', '09310103846', 'romelhen19@gmail.com', NULL, '$2y$12$v2akMMLHg5fecaXK16FkJOlSfxcCCdNZpgl9bcZQ7px2OuHH6iGVy', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Quijano, Romelyn', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 18:59:01', '2026-06-24 18:59:01'),
(95, '09543922310', '09543922310', 'jonzshoutan01@gmail.com', NULL, '$2y$12$.eH1pzeOc2jgUKMufHvdjerJgooP3NhZsJ6go8PIK9dnBH5qUPoQ6', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Simbahon, Irish', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 19:00:55', '2026-06-24 19:01:29'),
(96, '09690166802', '09690166802', 'mariapilarsarmiento.10251986@gmail.com', NULL, '$2y$12$bUOc4IB7sdj.j3ptxTis7eDyPXxAMMkbJgHo.ND5PLznzMl9w13t.', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Maria Pilar Sarmiento, Maria Pilar Sarmiento', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 19:09:36', '2026-06-24 19:09:36'),
(97, '09568324703', '09568324703', 'jamie021988@gmail.com', NULL, '$2y$12$Agh7iWgNNhHtE35ySdpStOGCmLi.OmL./e/BmuVxDivRChnQJdvx.', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Ignacio, Jamie', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 19:15:14', '2026-06-24 19:15:14'),
(98, '09352335737', '09352335737', 'carriemangiduyos@gmail.com', NULL, '$2y$12$uLRvEsSCvM1DP.Jyx9LnXOSTmwGu./t3h6ZSiMSOk9fa1q.KYnzei', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Mapacpac, Carrie', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 19:22:53', '2026-06-24 19:22:53'),
(99, '09659439293', '09659439293', 'gracia2791@icloud.com', NULL, '$2y$12$T5w63ySW9rF1Io9Oi5JGN.oEvGVOeQPmdZ3.6eoDGvClxr7DPYJNG', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Llagas, Mary Grace', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 19:25:56', '2026-06-24 19:25:56'),
(100, '09764175343', '09764175343', 'che08ante@gmail.com', NULL, '$2y$12$pvLLgqyb8fiU/EES.FkmhuaannwY1VacNk6STI0aTkjUQTN3k3Puy', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Belmonte, Michelle', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 19:27:18', '2026-06-24 19:27:18'),
(101, '09271471120', '09271471120', 'candyroseseno@gmail.com', NULL, '$2y$12$TfyjkP0X.Nj78.ES2LAWYOm8iMTKf0JBXFUqlEBGjnAOBVU/YeTV6', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Seño, Candy rose', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 19:28:51', '2026-06-24 19:33:12'),
(102, '09750031339', '09750031339', 'jbadilla042816@gmail.com', NULL, '$2y$12$DCAp9TjqurvXBOBylBIoYunIcM.M56.isvunvpJw7i4nifDX3ye/u', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Badilla, Joey', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 19:32:45', '2026-06-24 19:32:45'),
(103, '09983746426', '09983746426', 'whengwee@yahoo.com', NULL, '$2y$12$9dx5K6k5ES.swS1URX6Gs.sQJP86kPSRSeNLc1S.a1leej.FpqTB6', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Wee, Rowena', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 19:34:00', '2026-06-24 19:34:00'),
(104, '09352555941', '09352555941', 'reahalba@yahoo.com', NULL, '$2y$12$K8QYQABSfVRzT4ZRR.7Ol.e/l6i7m.SH/TG3ATx/nxlTTJf2jwOJO', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Arriesgado, Reah', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 19:34:43', '2026-06-24 19:34:43'),
(105, '09123628177', '09123628177', 'sethnashdelarosa@gmail.com', NULL, '$2y$12$gnTFNovFUzsjgdnPELZPgO4ycFrYAyzOaMNH/dwq7XYBxJmLh8HIK', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Rivera, Marie Jean', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 19:34:58', '2026-06-24 19:34:58'),
(106, '09050433574', '09050433574', 'gumasingjessamay.03@gmail.com', NULL, '$2y$12$tKU1hX8Hc2M/Zmp2tV7IZO7dXBBdF3rTXRMFcFFBLBO4vwJ1HBYNK', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Gumasing, Jessa May', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 19:35:23', '2026-06-24 19:35:23'),
(107, '09351127236', '09351127236', 'samanthaarcheses@gmail.com', NULL, '$2y$12$gXc7keX.QbrRvhXe9EHn/uu1iwDjFXJ11aGIsJUDxjuNpXL/wytlG', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Arches, Samantha Lou', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 19:37:13', '2026-06-24 19:45:40'),
(108, '09566172903', '09566172903', 'ianbalbarino5@gmail.com', NULL, '$2y$12$zkpDTFW9xsUzJHnXv8WCM.DcGH5nrAff/nevK60qF7QiIyEKoH4VK', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Balbarino, Ian', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 19:39:08', '2026-06-24 19:39:08'),
(109, '09178761220', '09178761220', 'geraldineglabrador21@gmail.com', NULL, '$2y$12$wGZ9jkUA0kctTM9TCptI2O83oav6TnHZgHnuu1OWlsXz2NztXeFCC', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Labrador, Geraldine', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 19:40:17', '2026-06-27 17:34:57'),
(110, '09666655475', '09666655475', 'imbzerna0518@gmail.com', NULL, '$2y$12$QDKJg6m8jfVHtpSh1n2X4eqVoIztRk1WtxczbMVj4yF8G9xlNT68S', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Zerna, Irene mae', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 19:44:32', '2026-06-24 19:44:32'),
(111, '09275773969', '09275773969', 'nonaganit@gmail.com', NULL, '$2y$12$phdVX16Y2HWKHxXMMYMoNOQBBh6jGWXAdTr88ldGQWNuULUO6H.Mi', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Ganit, Nona', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 19:46:12', '2026-06-24 19:46:12'),
(112, '09104695121', '09104695121', 'rogeromaricel21@gmail.com', NULL, '$2y$12$TLhJBJsaGZe9VCmHL1Rhfesl0PcVK7yA/B/W0fdp35ODF35HLTShm', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Rogero, Maricel', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 19:47:28', '2026-06-24 19:47:28'),
(113, '09922216208', '09922216208', 'emmiejane919@gmail.com', NULL, '$2y$12$q4F9D6by7cMZAsnlbNFTmOL2by6K9TMHVZOAmyExE4CyvdkFlUPJm', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Ahon, Emmie Jane', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 19:49:08', '2026-06-24 19:49:08'),
(114, '09311781071', '09311781071', 'imilizent@gmail.com', NULL, '$2y$12$VkbX80N0EgtOSTD/7/cWUOVgvyWDwWufmyjqKuRLftNLtRXP/jvWy', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Glorioso, Marilou', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 19:54:37', '2026-06-25 21:03:29'),
(115, '09627056246', '09627056246', 'renelainedumaguing22@gmail.com', NULL, '$2y$12$RRa105TWRpGWU9NqgBDBvuWlCrWVT3gvvgY4LiJiW9UoyQabMC2De', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Dumaguing, Renelaine', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 19:55:57', '2026-06-24 19:55:57'),
(116, '09339376687', '09339376687', 'gumasing.jc444444@gmail.com', NULL, '$2y$12$rWfhlX.Jmw1HqSrF9mLG2.9xS0Nb5Ne8gMh1f08ZY8Eg974Pk5uVK', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Gumasing, Emelita', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 19:58:26', '2026-06-24 19:58:26'),
(117, '09195810818', '09195810818', 'mabelvicerra080808@gmail.com', NULL, '$2y$12$LO6TJuhd2FtfZNGes/J/3OT/NxbuHjSTWryRjf2FmDJayzjvjQkrW', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Vicerra, Mabel', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 19:59:34', '2026-06-24 19:59:34'),
(118, '09323040369', '09323040369', 'vinmendoza275@gmail.com', NULL, '$2y$12$SuARCpMoHZe.pjOyPDFbgugBaJUzWF6W4wup9Xv8jNDxspzJWEngy', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Mendoza, Melvin', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 19:59:37', '2026-06-24 19:59:37'),
(119, '09858468802', '09858468802', 'juviecortez81@gmail.com', NULL, '$2y$12$Sw.HOmZyjWv/O/aKq700K.3LJvi39or1QDB1af2SfFwq6xylTzDpC', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Cortez, Juvie', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 20:00:25', '2026-06-24 20:00:25'),
(120, '09948811844', '09948811844', 'princessguillermo743@gmail.com', NULL, '$2y$12$7K1rJhIGhD.X4juS7qjRLO1E.PuLm3YQnT0gqHqaCdNAR3ADEmfY2', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Guillermo, Princess Apple F.', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 20:01:08', '2026-06-24 20:01:08'),
(121, '09708366714', '09708366714', 'teresadelacruz0430@gmail.com', NULL, '$2y$12$3dwAXY5wHPf6jbQ5nQbKHOzGPEbmk23IUAelrFtk.oYysP23/uKRu', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Dela Cruz, Teresa', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 20:02:03', '2026-06-24 20:02:03'),
(122, '09358824506', '09358824506', 'Leahmanalaysay1210@gmail.com', NULL, '$2y$12$2OqYVS2CvauHDV2xir7iReEfxf58Gwy07cMaKJxEMrdf1zC2YblH6', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Pozon, Leah', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 20:06:30', '2026-06-24 20:06:30'),
(123, '09651340421', '09651340421', 'carullolerina@gmail.com', NULL, '$2y$12$Ju7SRCzRyGNFGcZWF3JgxeSTeUTb8WDzIb2RMRV/NfTQqiXSny.ji', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Carullo, Lerina', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 20:07:51', '2026-06-24 20:07:51'),
(124, '09530578545', '09530578545', 'eugenia.d.ahmad76@gmail.com', NULL, '$2y$12$YXiZ96NAlyQRtWhN9.gpu.4x5xD04SymF8nrVO2ocN/7jV5V0gdsy', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Ahmad, Eugenia', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 20:08:15', '2026-06-24 20:08:15'),
(125, '09360418242', '09360418242', 'a91maglinte@gmail.com', NULL, '$2y$12$YzV/lGznZy3BC3P2s1Evf.Vg4Enul6n81hU3X/EVt9UXbN/W25w/y', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Maglinte, Angelica', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 20:09:41', '2026-06-24 20:09:41'),
(126, '09177301006', '09177301006', 'lanidestua@gmail.com', NULL, '$2y$12$bqfQvj9nTqDP5k3yoSZWpuWZqHMo/I2yhdCmaV9kPwmUjBQn2QwJy', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'JENNO L. DESTUA, LANI M. DESTUA', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 20:11:20', '2026-06-24 20:11:20'),
(127, '09177012004', '09177012004', 'roselynjosemuyot@gmail.com', NULL, '$2y$12$cgrlA00/scuHTTpArqQZfe/hqlqRDm1xKwI7ZLwvoTe5LKPozGrWG', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Muyot, Roselyn', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 20:11:30', '2026-06-24 20:14:56'),
(128, '09509632071', '09509632071', 'angelocastro218343@gmail.com', NULL, '$2y$12$KFQMAKA7yJQ6DAbOxaCYe.53xXcHfmsIJHnY8x4fNgQ4Xk5G9pqCq', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Angelo, Castro', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 20:13:31', '2026-06-24 20:13:31'),
(129, '09562566444', '09562566444', 'a91maglinte@gmail.com', NULL, '$2y$12$ipA641t4zIHdE0AZvfrOFO6X7RMANj.4qL/EaBN7D19fbJUkXNI9a', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Maglinte, Angelica', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 20:13:32', '2026-06-24 20:13:32'),
(130, '09774667903', '09774667903', 'reyesjackson810@gmail.com', NULL, '$2y$12$7Y2FECXAG5WeRVIzrglmouFNAGnUwbZoRRQv45Rzq9hxONOU9Rl3C', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'REYES, MYLA', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 20:14:09', '2026-06-24 20:14:09'),
(131, '09687150989', '09687150989', 'angellunod23@gmail.com', NULL, '$2y$12$B37FZ2f550Fh5wiE6URSnODfWIE6JLghDpCjh3mJyLJ2qnos0yrsy', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Lunod, Angelica', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 20:20:02', '2026-06-24 20:20:02'),
(132, '09982044308', '09982044308', 'gladyslanzon@yahoo.com', NULL, '$2y$12$nytqo28sRW57hvKrAW8gleQVPKUkGCXbeIlxBJ57q6RodwiBeDJhi', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Concepcion, Gladys', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 20:22:10', '2026-06-24 20:22:10'),
(133, '09498960550', '09498960550', 'riverabetana09@gmail.com', NULL, '$2y$12$08Hq3K96V3kBF26dykUcNejPYFmUqzYPgGKKOskyKqIyQqCCSUitK', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Rivera, Jovelyn', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 20:22:22', '2026-06-24 20:22:22'),
(134, '09236031790', '09236031790', 'mmariano.guballa2@gmail.com', NULL, '$2y$12$Fo60ebzc8gBIX3L2XQsCXOxFm9nguN968VDj4Vbn2HBgHDei8Pjvi', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Guballa, Minette', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 20:27:13', '2026-06-24 20:46:19'),
(135, '09952805997', '09952805997', 'jhayna.louisecorrea081917@gmail.com', NULL, '$2y$12$h3ianv4DbND1Eh1QlEjFaes5b007pIdgxbie78EcxzxdtyEzLHZY6', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Correa, Diana', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 20:28:26', '2026-06-24 20:28:26'),
(136, '09178348308', '09178348308', 'sisonsheena96@gmail.com', NULL, '$2y$12$Vz49cJwi9bMFyCnpOA1dreh/BqTCje0sCLVkYBTALtPraLfklUlOm', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Sison, Sheena', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 20:29:37', '2026-06-26 11:11:30'),
(137, '09514901877', '09514901877', 'bebevitho20@gmail.com', NULL, '$2y$12$3v/gK344A/8hKg/xNBhN4ey5X/tp8LYUdfSNDqApVSE/KYpOgUGhq', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Tañon, Bernadette', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 20:31:53', '2026-06-24 20:42:10'),
(138, '09957926390', '09957926390', 'villapandopatty@gmail.com', NULL, '$2y$12$YLXi4nCX77xaa5FRWwJ9suMrP9x1879jRIqKbvxa40w/dJ7ydBQce', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Villapando, Patty', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 20:35:15', '2026-06-25 20:56:20'),
(139, '09685403605', '09685403605', 'leihertz@gmail.com', NULL, '$2y$12$4RE0Ns5Yax1p6Lvman1qfOIbhWtMWM7dMQa2gE9RtYQA6qaNxhNo2', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Hertzendorf, Lea', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 20:38:17', '2026-06-24 20:42:00'),
(140, '09765741404', '09765741404', 'racquel.hernandez3009@gmail.com', NULL, '$2y$12$4O4ibqx5QAX0ETi6a0dC4OWvueXXGJ68hsIjzdJAKRQ2oEboVEsPq', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Hernandez, Racquel', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 20:42:30', '2026-06-24 20:42:30');
INSERT INTO `users` (`id`, `user_id`, `username`, `email`, `email_verified_at`, `password`, `reset_password_token`, `reset_token_expires_at`, `otp_code`, `otp_code_expired_at`, `otp_verified_at`, `remember_token`, `account_status`, `last_successfull_login`, `fullname`, `school_code`, `gs_access_status`, `password_update_by`, `assigned_admin_email`, `terms`, `usage_policy`, `privacy_policy`, `terms_policy_date`, `first_user_token`, `first_user_token_expiry_at`, `created_at`, `updated_at`) VALUES
(141, '09934282546', '09934282546', 'vilmasakata1970@gmail.com', NULL, '$2y$12$jirddWZGo2dd9e1dz7iHr.Tn3EPYOyzOoNovgCWht90sGZKez5PqW', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Sakata, Vilma', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 20:47:00', '2026-06-24 20:47:00'),
(142, '09983780490', '09983780490', 'maribel.sanjose12@gmail.com', NULL, '$2y$12$TOxc5J55EJRedrZDnV1HWupJvhTwc9baLNV0p5SMZ.hfKfHbKv8uq', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'San Jose, Maribel', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 20:47:03', '2026-06-24 20:52:17'),
(143, '09995468931', '09995468931', 'jpallones0@gmail.com', NULL, '$2y$12$WVKy2SX1iHI4vfYMNhE54OwWWzTPcY9I8RluiR46UcbLny/j8xKbm', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Pallones, Joyce', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 20:47:35', '2026-06-24 20:47:35'),
(144, '09322874112', '09322874112', 'sanjoserhomlhyn@gmail.com', NULL, '$2y$12$DY2FBA/CfQFWOrCgQEq7WeS0lqLrIMdfrLlsntlTlij8wsXlaI/eO', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Cabrera, Mc Kris', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 20:53:22', '2026-06-24 20:53:22'),
(145, '09511256386', '09511256386', 'EDWINEALCAZAR@yahoo.com', NULL, '$2y$12$m/k1sAmUUKl40F26bYzHf.E1myrKIb8v3QbB.IIsQm55A56jNbpQ.', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Alcazar, Edwin', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 20:53:48', '2026-06-25 07:37:52'),
(146, '09199019181', '09199019181', 'icheyg@gmail.com', NULL, '$2y$12$6oooQdKHCixVCiDQKBZDmO/Tt52/htoAOBB8p6FzH3Wr4qGwea1jO', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Germar, Cheryll', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 20:54:14', '2026-06-24 21:29:07'),
(147, '09263633806', '09263633806', 'nahumvraye02@gmail.com', NULL, '$2y$12$w8yAT2S5cAwU56v6ULIzW.my9SKfTwm6M9Qe6k7hvaXo.WC7OP32W', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Llanes, Delnie Fhaye', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 20:56:56', '2026-06-24 20:56:56'),
(148, '09519277508', '09519277508', 'kiakicalimlim@gmail.com', NULL, '$2y$12$YSEBvKTexwwzQuBuCp5NneOMgGS2i1Gi3pxBgcLEsNdbWS.PT9.eW', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Calimlim, Cristine', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 21:06:52', '2026-06-25 08:22:16'),
(149, '09427064011', '09427064011', 'paulhusmillio26@gmail.com', NULL, '$2y$12$uwnO15Mm5/YrawDrmoiN6OLyq1dbKzzcucDr8XTEFMa3X2b57dIo6', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Husmillo, Paul John', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 21:12:49', '2026-06-24 21:12:49'),
(150, '09089333761', '09089333761', 'edlynjoycereyes16@yahoo.com', NULL, '$2y$12$y3BRHZUwzPG7CU5Hjm3JAeJkYxEeKpXmIUZr5MoWzrT1DhjtDACBS', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'REYES, EDLYN JOYCE', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 21:14:52', '2026-06-24 21:14:52'),
(151, '09068587710', '09068587710', 'Junelynbasagan@gmail.com', NULL, '$2y$12$Wp8rnARha/n6/T.8BHSxReCIv4q66RTBpeyd49vabglfi.wu0UH5O', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Basagan, Junelyn', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 21:14:55', '2026-06-24 21:14:55'),
(152, '09175185001', '09175185001', 'amelia.serquina001@deped.gov.ph', NULL, '$2y$12$cDCDAYuyk6vmQKqN/iEJs.jZC/JNWDxsb.b8J5rk4wwWFPdgkBMM6', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Serquina, Amelia', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 21:24:37', '2026-06-24 21:24:37'),
(153, '09993524359', '09993524359', 'deguzmanprecy71@9gmail.com', NULL, '$2y$12$NMAF7DdIqP6Q0bXyHl5ygOzaiYn/x7OdkZlGyXkp1fesDKfWtczTC', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'De Guzman, Precy', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 21:27:01', '2026-06-24 21:27:01'),
(154, '09566682349', '09566682349', 'abigaildelacruz0837@gmail.com', NULL, '$2y$12$bLvZ/ZrRYzuvtfas7T3MneoDwe7U4vHZV7WVub5R8Fdy90C/ARAqS', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Dela Cruz, Abigail', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 21:33:44', '2026-06-24 21:38:01'),
(155, '09530582005', '09530582005', 'abigaildelacruz0837@gmail.com', NULL, '$2y$12$Hzr9klVcH/Gs2XZrTtD0luSRIL0H2pm0xbN0dr/0LCi5yNDacvqou', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Dela Cruz, Alvin', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 21:42:30', '2026-06-24 21:42:30'),
(156, '09701006753', '09701006753', 'rochellesain08@gmail.com', NULL, '$2y$12$gl1nihtcll180i6liypa8en//rSFS89jCjSUXx14qhHfTTdShm8wW', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Sain, Rochelle', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 21:43:13', '2026-06-24 21:43:13'),
(157, '09763021875', '09763021875', 'medinarossette@gmail.com', NULL, '$2y$12$E1Kw4WUKx7I/9qSS9eSafu8uzopX.BP/E5jk6pgQd6ZSyhsK6AMbK', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Tungol, Ronnie', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 21:51:28', '2026-06-24 21:51:28'),
(158, '09477241966', '09477241966', 'iamgracey001@gmail.com', NULL, '$2y$12$AvWFz01TXKXS3SOqbUNZlOsTq2679fFQjl5fSo9oqU7FY8ezmcLIK', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Yacat, Mary grace', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 22:01:52', '2026-06-24 22:01:52'),
(159, '09157998135', '09157998135', 'sheilajoydgmagcalas@gmail.com', NULL, '$2y$12$sY.JuI71wLs0GPyryt44uuAeiUd7h9.QtO2K9N4HvVk0wmE4kFs6S', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Magcalas, Sheila Joy', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 22:06:48', '2026-06-24 22:06:48'),
(160, '09095306338', '09095306338', 'lovelyn.santiago@gmail.com', '2026-06-24 22:13:41', '$2y$12$VGWRvGRs2iHwt85bodDYEe2quaVG3A0Ed86c8Ql.9Cd6mKMEdjJ7G', NULL, NULL, NULL, NULL, '2026-06-24 22:13:38', NULL, 'active', '2026-06-24 22:13:41', 'Santiago, Leovilyn', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', 'Agreed', 'Agreed', 'Accepted', '2026-06-24 22:13:41', NULL, NULL, '2026-06-24 22:10:39', '2026-06-24 22:13:41'),
(161, '09071352978', '09071352978', 'romelhen19@gmail.com', NULL, '$2y$12$FXQWr02t4FWgeRxYcr9rKOsYh9zy.k4dw4AffaeCG64mp/NHU7GCO', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Quijano, Emma', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 22:14:25', '2026-06-24 22:14:25'),
(162, '09637494089', '09637494089', 'ashbeeshyne23@gmail.com', NULL, '$2y$12$OyLnmnWqA8flXZ1kcabpyeLyDRrnofjA6MS6ylAvdHDH9yv7fxPfy', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Alingasa, Ashbee Shyne', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 22:38:35', '2026-06-24 22:38:35'),
(163, '09519054894', '09519054894', 'geronimomario@gmail.com', NULL, '$2y$12$Kr3570DJ.HR.HacRWuOWOOrQdLRj9fw0iI/J6D6N31JN6rK3ot8ZO', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Rowena Geronimo, Mario Geronimo', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-24 22:42:37', '2026-06-25 08:36:23'),
(164, '09088215833', '09088215833', 'gonzalesjia@gmail.com', NULL, '$2y$12$wQ0xz8/oZ98lv0ljKo3lce5dZWBxCMyM9PMC1zXuUUkd8RWmi6/.m', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Mendoza, Jia', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 00:06:54', '2026-06-25 00:06:54'),
(165, '09325716167', '09325716167', 'michell.pelovello@yahoo.com', NULL, '$2y$12$ZNiJj951E4VduVWVwj72kO4p.29VWsybLw0SuTzC53pQQvvpI0.8u', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Mercado, Michell', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 00:22:45', '2026-06-25 00:22:45'),
(166, '09626279918', '09626279918', 'russellbarres@yahoo.com', NULL, '$2y$12$H8k513tj9bk1zXOR8BkWS.gzxopDh8LtwNmDZsBC6TGEc8duVmYLC', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Barres, Russell', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 01:47:19', '2026-06-25 01:47:19'),
(167, '09983962151', '09983962151', 'dhonnabells06@gmail.com', NULL, '$2y$12$OPjiSe5PqbTri7y3ln//pOz.w.wqz079ALjQCVCBR5ZlpffOoIqGW', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Almuete, Donna Joy', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 02:58:08', '2026-06-25 02:58:08'),
(168, '09984070234', '09984070234', 'rupertopaguipo06@gmail.com', NULL, '$2y$12$KaKCnApi2LTPm5LjKT1Wp.A.Ft6Pg1Awhitwt.Vrd5GQMSLHVIQkq', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Paguipo, Ruperto', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 05:28:42', '2026-06-25 05:28:42'),
(169, '09058135646', '09058135646', 'eugeniocloudmarissan@gmail.com', NULL, '$2y$12$sQEyNDMRILJp7f3TV4VOoe8eeXvFXb/.gaeJaJhknlx.gzVcfFyoW', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Eugenio, Marissan', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 05:38:51', '2026-06-25 05:38:51'),
(170, '09260270799', '09260270799', 'zachcarl02@gmail.com', NULL, '$2y$12$Xs5hfdUNFt33qCs3piaa5u/RsKTRG/GJ7xdIGt6anrVQtFKnrTZhC', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Flores, Mac Dennis', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 05:56:32', '2026-06-25 06:11:47'),
(171, '09062930429', '09062930429', 'charmainemilovymata@yahoo.com', NULL, '$2y$12$O47/eFDFxfbbiTqBvZ25YONH6waU9tT1JbR.W348ItPBE8nk1lC8G', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Mata, Charmaine Milovy', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 06:12:28', '2026-06-25 06:12:28'),
(172, '09339170464', '09339170464', 'michell.pelovello@yahoo.com', NULL, '$2y$12$z0.RD397jogF1.iQi533SO4Y2ElmxWz48wLW2hTpM5RM7NqQDa/k6', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Mercado, Michell', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 07:19:48', '2026-06-25 07:19:48'),
(173, '09633142058', '09633142058', 'sarahgeronimo498@gmail.com', NULL, '$2y$12$ytruBJ7BUSQZuGX1yecL1OQr9M70qZwJN8KLoBy1DaSlBhwon0I7O', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Dagdag, Sales', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 07:33:40', '2026-06-25 07:33:40'),
(174, '09685788902', '09685788902', 'delacruzmiguelrobin22@gmail.com', NULL, '$2y$12$WVrmU3nz7W6QlBHYg0bzA.FpcQ308kN9pdEKWk7UKIo.lgN0II5wi', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Delacruz, Angielyn', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 08:03:46', '2026-06-25 08:03:46'),
(175, '09359560382', '09359560382', 'rheajanegaspar90@gmail.com', NULL, '$2y$12$PNPdlyNj8i6RmfcwFQmqk.7C5/PYhKA8yEHlHxIVZlY8SHZROvmt2', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Gaspar, Mavelyn Lapig', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 08:06:29', '2026-06-25 08:06:29'),
(176, '09071619191', '09071619191', 'goyenaroseann04@gmail.com', NULL, '$2y$12$jRbQGEXX/J0rOZT.muCpEOU4SMozD9GXQOgW7mJSplAL1RMWRRO.i', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Celestino, Rose ann', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 08:11:15', '2026-06-25 08:11:15'),
(177, '09077521198', '09077521198', 'ericharriesgado1@gmail.com', NULL, '$2y$12$QvUBN0pFjjqmGe0ROEe2gO4wQbXrBJqquPQmYPcnCmvMboInF.YK2', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Arriesgado, Analiza', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 08:15:48', '2026-06-25 08:15:48'),
(178, '09533844397', '09533844397', 'garrytolentino0707@gmail.com', NULL, '$2y$12$Cy4hM1xbOLoXiHFQCnunxOLiO1617uoRpUudc6BUEjIFTAEfwH1La', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Tolentino, Gary', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 08:18:36', '2026-06-25 08:18:36'),
(179, '09175558420', '09175558420', 'mariarioja08@gmail.com', NULL, '$2y$12$ptatjCth2ZJLsGeMjkSO7uXaWA2fdJX6cArB/YAnlxqfv01DoSYXe', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Rioja, Maria Jawelei', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 08:20:28', '2026-06-25 08:20:28'),
(180, '09551165152', '09551165152', 'genvillanueva85@gmail.com', NULL, '$2y$12$L/nTzUP7VdEmcNaoFzvmDe0QGRmX9ucSCysFV6NYVArnSR6P7c5Um', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Gorospe, Generose', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 08:22:25', '2026-06-25 08:22:25'),
(181, '09496563732', '09496563732', 'valmontemarilou@gmail.com', NULL, '$2y$12$k6joIgUhUJA4snfLfm3MGe9rFuFfPaNcVUppmXi2ZCHpwcKuMVfq2', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Valmonte, Marilou', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 08:25:12', '2026-06-25 08:25:12'),
(182, '09658126831', '09658126831', 'rosiejagmis0@gmail.com', NULL, '$2y$12$JMMqC8HzY9TIJK6YJYseBOTYUuFI2LFmTTyuVPxb4jt8UwkJxTKZK', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Jagmis, Rosie', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 08:39:50', '2026-06-25 08:39:50'),
(183, '09218942141', '09218942141', 'teresita.bermejo0971@gmail.com', NULL, '$2y$12$OjzsQkWY.gZbA9Ni3mp68esO.uYyJoQvIrU6yobH29Ly0//l3ZDZS', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Bermejo, Teresita', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 08:43:39', '2026-06-25 08:43:39'),
(184, '09156515698', '09156515698', 'ignaciovangie1227@gmail.com', NULL, '$2y$12$oRTGVoE82Ac87aSatL3x7uC7bOqEm6Nh7I9rQtyvzDXFsaetvWecy', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Melecio, Ignacio', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 08:44:19', '2026-06-25 08:44:19'),
(185, '09095896728', '09095896728', 'rheezasierra@gmail.com', NULL, '$2y$12$vFlMB62Pg130uArqbQF3hunOZezBwNjfuYYpxLZ5IjLXaAbKNfKv6', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'SIERRA, RHEEZA', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 08:48:38', '2026-06-25 08:48:38'),
(186, '09238653688', '09238653688', 'bernsaporteza@icloud.com', NULL, '$2y$12$gs7mYzOj1BIBLQR4Qd000udVKuneuh10A8GUj53q3vFfq2ylgpaoG', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Saporteza, Bern Jeriz', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 09:15:43', '2026-06-25 14:16:47'),
(187, '09531248409', '09531248409', 'gelynalcantara38@gmail.com', NULL, '$2y$12$PSOHMYMMAaM.drEFJfP0ROMhH5odGsFZwQJvnjcSQrtLyQRAmY5Y.', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Tulab, Domingo', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 09:33:27', '2026-06-25 09:33:27'),
(188, '09661339619', '09661339619', 'magrace.macaraig@gmail.com', NULL, '$2y$12$Gh5H5lps2K7IXcYmcOJ2MehQ/8Hr5Qt/J9JMUVmiI4hRd1GrOMTee', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Monsoy, Ma.Grace', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 09:38:44', '2026-06-28 19:52:46'),
(189, '09158720168', '09158720168', 'jacob070182@gmail.con', NULL, '$2y$12$Ws6fc7PzJVFxp9kQUIQBiuPYXqrACTvOf7T3UyCIJXawIXUphicDe', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Vicente, Maricel', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 09:39:10', '2026-06-25 09:39:10'),
(190, '09670730846', '09670730846', 'lunariabros@gmail.com', NULL, '$2y$12$iG8WXlk7CxyGbEhrKWNss.TqYBNHOTgvyjKDjAaf2Dg/dKK8pLzS2', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Pastrana, Roneth', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 11:12:45', '2026-06-25 11:17:12'),
(191, '09559113907', '09559113907', 'rosemariesnano@gmail.com', NULL, '$2y$12$TYeIN9L8PJVW8BEv5qllt.2EtW.bTN1Hn2n8WBIwCAbo0dMHWa4bO', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Nano, Rosemarie', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 12:32:56', '2026-06-25 12:32:56'),
(192, '09551402917', '09551402917', 'juleneairar@gmail.com', NULL, '$2y$12$9OqVS9NMOKKOUEnF..Me4uLeeod2K8NGCEHMCzYxsaWBKWwScLMcq', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Reyes, Julene Aira', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 12:52:48', '2026-06-25 12:52:48'),
(193, '09154416373', '09154416373', 'arowendj@gmail.com', NULL, '$2y$12$kAgei309IIVTowoooi2g0umE239E8T369l00knrZF63O/dl3GOqPS', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'De Leon, Rowena', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 13:52:28', '2026-06-25 20:23:01'),
(194, '09235397202', '09235397202', 'maryannmendoza.0121@gmail.com', NULL, '$2y$12$zenLaHA/myHCS3dYogLCgOAzx8tz/tBZhjG2ekHplB90KU7CijyRq', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Mendoza, Mary Ann', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 13:58:04', '2026-06-25 13:58:04'),
(195, '09922294056', '09922294056', 'kimbinamira022@gmail.com', NULL, '$2y$12$qTlBoga8D4sotPqGZwQobuqpIBfJA1dMZgzkcugf28.coNzfSUcOW', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Samson, Mike Jonathan', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 14:01:22', '2026-06-25 14:01:22'),
(196, '09456631828', '09456631828', 'navidad542@gmail.com', NULL, '$2y$12$foIpm.Byx7cmmNuoj9pS5ugQWwfAKHHiknVhHvKIXHO4LCMW6drue', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Llanes, Marry Rose', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 14:18:02', '2026-06-25 14:18:02'),
(197, '09234150901', '09234150901', 'jasminviennedizon011720@gmail.com', NULL, '$2y$12$QOmNkqrJX/OPEqZYnrcUjO0fEhTnrOBjUYF7aZaz0BG3Wi54pVpou', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Dizon, Vivian', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 14:30:25', '2026-06-25 14:30:25'),
(198, '09946520034', '09946520034', 'nina.bustalinio@gmail.com', '2026-06-25 17:23:39', '$2y$12$TjvFQ62g8qZs8wmnjGLk2eKjqWBONaPFlkcZEfuMto/lCdtUV0eOy', NULL, NULL, NULL, NULL, '2026-06-25 17:23:32', NULL, 'active', '2026-06-27 09:51:49', 'Bustalinio, Nina', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', 'Agreed', 'Agreed', 'Accepted', '2026-06-25 17:23:39', NULL, NULL, '2026-06-25 14:35:19', '2026-06-26 08:29:52'),
(199, '09071395431', '09071395431', 'jacquelinecapongcol@gmail.com', NULL, '$2y$12$ZPWx.hKBpBwD4VCjKp8sNONZl7kTICPCkI5ttGCrmEF1oOhEiz41i', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Gabriel, Jacqueline', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 14:36:13', '2026-06-25 14:36:13'),
(200, '09498959354', '09498959354', 'inquire.leajane@gmail.com', NULL, '$2y$12$El1OfrSjD24pcw9eZFvh9Ont16s2B8icafhgtHI98AGSyWbMvEuki', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Lumabi, Lea Jane', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 15:02:08', '2026-06-25 15:02:08'),
(201, '09675916805', '09675916805', 'cielofloradelzayne@gmail.com', NULL, '$2y$12$5PAYz5AUmVX6hAkd.P5Z.uKrc.5vlwuuy0lChz1HUcmxDQG2cYzRe', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Cielo, Floradel', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 15:07:40', '2026-06-25 15:07:40'),
(202, '09650422636', '09650422636', 'darwinaganon087@gmail.com', NULL, '$2y$12$XkFmZ3wi8Hi2RB3EW7eHx.aQvQRMzg83ytG5DRqyNSUFKc2O4oQXK', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Aganon, Darwin', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 15:12:27', '2026-06-25 15:12:27'),
(203, '09532072759', '09532072759', 'curiecolemanahan@gmail.com', NULL, '$2y$12$mrprXQx34IkKzRBLgBblsecjCDbPgGE7nMPc4OmKBbfPkgExthnBu', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Manahan, Carmen', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 15:36:07', '2026-06-25 15:36:07'),
(204, '09283214986', '09283214986', 'jemzen060211@gmail.con', NULL, '$2y$12$MZ9v1dk.4w0FOs5ZNWPUZOw3i8o.yj5VRVfgq02LGvPug.ah4aTwu', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Martin, Jonnazen', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 15:54:39', '2026-06-25 16:01:16'),
(205, '09275533956', '09275533956', 'jenm92323@gmail.com', NULL, '$2y$12$H9n/ipeqa2ZxoulKps5n1O438GTpHZgLuSCZBpJEKiqqnUDM.iF0O', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Martinez, Jen', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 16:07:04', '2026-06-25 16:07:04'),
(206, '09851801151', '09851801151', 'albaocyrellep@gmail.com', NULL, '$2y$12$5sVdueB2ttnLtFmZjKfDn.4BuLCRhSSre9wOTbJFTTSUDs6yKspam', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Albao, Cyrelle', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 16:12:07', '2026-06-25 16:12:07'),
(207, '09293406465', '09293406465', 'reche.lagurin@yahoo.com', NULL, '$2y$12$kbIaGLtsAWQVMZ5a89pScObGIF7EgA0/MERZzEF.2J0PhUxV2sniK', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Aguilar, Reche', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 16:22:07', '2026-06-25 16:22:07'),
(208, '09357365332', '09357365332', 'lailaniefrancisco@gmail.com', NULL, '$2y$12$jaDjkPY7Abxr0nvZVHSGEucbqadNDH4EUzCZF8shziyK28.4bGkO2', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Francisco, Lailanie', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 17:09:44', '2026-06-27 15:31:22'),
(209, '09309511253', '09309511253', 'taplerasangelyn5@gmail.com', NULL, '$2y$12$9SL3DKM6cIi8sf44Z9x98OEb7OvRN5px6gVGSrlMWVnt1.QU5TTMi', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Tapleras, Angelyn', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 17:36:58', '2026-06-25 17:36:58'),
(210, '09420344119', '09420344119', 'michelle.ayet313@gmail.com', NULL, '$2y$12$U/PMN1Or6CthZbsLHeEBL.Q0Yevp4DGuU3O5n9a.HC1ePfQFRLfXi', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Delobrino, Michelle Marie', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 17:39:47', '2026-06-25 17:39:47'),
(211, '09201785002', '09201785002', 'jocelyna201080@gmail.com', NULL, '$2y$12$6OyiZAIQUh9hAx5UgDJMY.LDYqYKyufO7HUgJEHPx8OADQZjqyft.', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Abaggue, Jocelyn', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 17:41:07', '2026-06-25 17:41:07'),
(212, '09554293108', '09554293108', 'Dreianna_1327@yahoo.com', NULL, '$2y$12$kNzf8dJ/MG3a20cNiMMbKu5VUhUntpc7QuaEN/RGSR4jXU8ynBVI6', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Almuete, Aiko', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 17:58:25', '2026-06-25 17:58:25'),
(213, '09466823848', '09466823848', 'remyrosepamelan@yahoo.com', NULL, '$2y$12$4bD5OhG4bbhymn0v6ZggyOt4WD7RUze69NICBAXDxLgN3wRBn43W6', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Ramos, Neneng', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 18:01:44', '2026-06-25 18:01:44'),
(214, '09668643917', '09668643917', 'oplecristina@gmail.com', NULL, '$2y$12$A4u9AQ3NrdKHotymdJMdKuxo99euJf9lODfbXDmtBiRxn5XeZ34Me', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Ople, Cristina', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 18:13:54', '2026-06-25 18:13:54'),
(215, '09322462185', '09322462185', 'marilen0323@gmail.com', NULL, '$2y$12$oiIoW7pZY3uq46ipapCCy.hNHyw6aYAUU1ANSJFjS1krocSISu0Si', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Memoracion, Marilen', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 18:27:06', '2026-06-25 18:27:06'),
(216, '09064870709', '09064870709', 'rhizamae.calangi@yahoo.com', NULL, '$2y$12$YG49mV9L7M3IZIaWCiSAE.VELeR8sxnlDWFAalf2smpNH.yaCBGNG', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Calangi, Rhiza Mae', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 18:32:34', '2026-06-25 18:36:26'),
(217, '09610821211', '09610821211', 'fredelinrxs@gmail.com', NULL, '$2y$12$lgys8hjgX5KAO00L9BmzKerx/sStZ7M7iiC27zMSivTTe6hu/EyFS', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Roxas, Fredelin', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 19:07:45', '2026-06-25 19:07:45'),
(218, '09051282343', '09051282343', 'jennyenaldo2790@gmail.com', NULL, '$2y$12$tUYNpU2DwlBDSKlp6yxk4OPHQdmCAdSKu8lsh/QAJguIfCJjLdOky', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Enaldo, Jennilyn', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 19:09:25', '2026-06-25 19:09:25'),
(219, '09541850444', '09541850444', 'godslove1316@gmail.com', NULL, '$2y$12$4ACSFV90HsB3Sw2kMduM2epMHVgImZu/0921lHiEC9x1HrdEspwL.', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Guadalupe, Eldie Mar', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 19:22:34', '2026-06-25 19:22:34'),
(220, '09534501466', '09534501466', 'noreendevilla07@gmail.com', NULL, '$2y$12$77p2ClPCuhtw9LbOYH0TB.mLxGeEvtBtTwUuhOigUtxeCuu5/HOxC', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'De Villa, Noreen Carmel', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 19:58:30', '2026-06-25 19:58:30'),
(221, '09159292600', '09159292600', 'noreendevilla07@gmail.com', NULL, '$2y$12$9ac6KSnGHngdJqCCL4weVepTZEAIzc.LxAsWomIFwyjC6yq0Y7hYG', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'De Villa, Noreen Carmel', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 20:10:19', '2026-06-25 20:10:19'),
(222, '09304668585', '09304668585', 'glence.cambare17@gmail.com', NULL, '$2y$12$Uckh1WmZ26Cuzcq9k1khc.Hoc.2i9DM3I89d2qAWGLqiLeQHA1lJa', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Cambare, Glence', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 20:23:22', '2026-06-25 20:23:22'),
(223, '09164179740', '09164179740', 'marygracegflores07@gmail.com', NULL, '$2y$12$AdSomG1ND.GmeQiM4lQ2G.Dk5C.JsKsaZhMNev03rDTqvXlMBDzXm', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Flores, Mary Grace', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 20:24:53', '2026-06-25 20:24:53'),
(224, '09674670347', '09674670347', 'elsie.torres003@deped.gov.ph', NULL, '$2y$12$F94nh48deI8tmBaFOD8itewOtnsKjwoHS1k9tQH66iSwIWUrHMAMi', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'TORRES, ELSIE', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 20:42:08', '2026-06-25 20:42:08'),
(225, '09176505746', '09176505746', 'jennyvive_dejesus@yahoo.com', NULL, '$2y$12$5HaFrzS6rIz//kXOlCPtLu/iyzemoYusjTTPbWbK/l72G5z5F.DkG', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'De Jesus-Marcos, Jennyvive', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 20:42:38', '2026-06-25 20:42:38'),
(226, '09664216917', '09664216917', 'vkfm1225@gmail.com', NULL, '$2y$12$ZQr.YtdkFYt9l5kHRfEtE.Zm6SjZfm329nA0vcY608Kw/xIezMvYC', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Mendoza, Quennie', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 20:46:34', '2026-06-25 21:01:32'),
(227, '09610957581', '09610957581', 'rowelresurreccion02@gmail.com', NULL, '$2y$12$Sm.nRfgZ.ETizV2ihgtddOnxotdqwyfnW8nbTLVWyizmQY6OmkE5O', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Resurreccion, Jai-mee', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 20:46:48', '2026-06-25 20:46:48'),
(228, '09107763207', '09107763207', 'precious6@gmail.com', NULL, '$2y$12$cPjC.cpgdGYK6tPJvZnwQedR6/6MbqIydrD25/rKJX5Q38bupalwm', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Inocencio, Precious', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 20:53:06', '2026-06-25 20:53:06'),
(229, '09270128290', '09270128290', 'layosaailene@gmail.com', NULL, '$2y$12$iCGQzcI0BclZ1kZhGs99LOrzBkH4UBP03dOnVatdtTSmiDO353aRG', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Ailene Layosa, Ailene A. Layosa', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 20:59:15', '2026-06-25 20:59:15'),
(230, '09435524879', '09435524879', 'vanch2675@gmail.com', NULL, '$2y$12$j0nhFb0xETarkBzN6cBRe.kvmoy4/AJylP8QqvmZudupf0krYJez.', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'De Guzman, Evangeline', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 21:05:31', '2026-06-25 21:05:31'),
(231, '09465543605', '09465543605', 'thalenzgole@gmail.com', NULL, '$2y$12$rICF.THIEgu4vhhr8agLJ.15s..yyEpCphmUShn0asIaT5kCZkTTS', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Gole, Leneth', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 21:16:22', '2026-06-25 21:16:22'),
(232, '09750642517', '09750642517', 'gavinkrizz@gmail.com', NULL, '$2y$12$9ex/Mv1PUmtxGl6j4Zm3x.UjCp08C8gp8dHQSOHKGjn7WLziuFtcS', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Villanueva, Genekris', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 21:24:42', '2026-06-25 21:24:42'),
(233, '09202591175', '09202591175', 'irene.d.i.lanuza@gmail.com', NULL, '$2y$12$3tVlqbxNu0lXHhjGCaLvhemfwKwVTzqkceq6BRaONI4JVos3DJudS', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Lanuza, Irene Divine', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 21:29:14', '2026-06-25 21:35:07'),
(234, '09278171481', '09278171481', 'jericarosedelrosario@gmail.com', NULL, '$2y$12$3bIA.M9EKhKGE/c.kgLCd.d9ZiHYViUvSHAk6A7CMgf5afgD7JGaS', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Del Rosario, Jerica Rose', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 21:35:26', '2026-06-25 21:35:26'),
(235, '09814405275', '09814405275', 'ailyn_genesis@yahoo.com', NULL, '$2y$12$TI2o10XoWk8OXOU5sYF5BOcn3ErzTLTiEavkenLrSZbTxYUf1uMlK', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Castañeda, Ailyn', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 21:50:18', '2026-06-25 21:50:18'),
(236, '09064019816', '09064019816', 'mabelvicerra080808@gmail.com', NULL, '$2y$12$KBt0ga8HzP9B4BhWBfkG1.DCdBtzrYYyAj6KbmKr6EZgZLSQRpRbS', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Vicerra, Mabel', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 22:12:30', '2026-06-25 22:12:30'),
(237, '09551908971', '09551908971', 'judithkokoy@gmail.com', NULL, '$2y$12$ihxCjiCZioHWdPKhMXYSJ.BGBYkSnLww.Cl/eCRUjsWqZncgXqHAq', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Andes, Fides', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-25 23:00:09', '2026-06-26 17:50:45'),
(238, '09234436051', '09234436051', 'gilbertgermar@gmail.com', '2026-06-26 00:30:51', '$2y$12$SBhZRhX5GSVaK5OQZ0Zy.OLBabOw9Yqpx.NlE75H3rJN/Pkhjyr/a', NULL, NULL, NULL, NULL, '2026-06-26 00:30:35', NULL, 'active', '2026-06-26 00:30:51', 'Germar, Gilbert', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', 'Agreed', 'Agreed', 'Accepted', '2026-06-26 00:30:51', NULL, NULL, '2026-06-26 00:20:25', '2026-06-26 00:30:51'),
(239, '09324085675', '09324085675', 'perezrhoss.shyralyn@gmail.com', NULL, '$2y$12$Fwqxk7btizptx9pAVc0fkOExKMI08T9V59ev0iCu.ZTzOQ4Q2h3KO', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Perez, Rhoss Shyralyn', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-26 01:57:35', '2026-06-26 01:57:35'),
(240, '09158020079', '09158020079', 'abbimanguan25@gmail.com', '2026-06-26 02:20:02', '$2y$12$N17HLsN5UBiSDI1//C0yq./xQurzQw/VcXllzPcrFVR5OfJVWoGtC', NULL, NULL, NULL, NULL, '2026-06-26 02:19:55', NULL, 'active', '2026-06-26 02:20:02', 'Manguan, Abbi', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', 'Agreed', 'Agreed', 'Accepted', '2026-06-26 02:20:02', NULL, NULL, '2026-06-26 02:16:11', '2026-06-26 02:20:02'),
(241, '09674177552', '09674177552', 'gvicente1217@gmail.com', NULL, '$2y$12$PxW51JwKTU/FD68YUeS6v.zziqrSrEiiBKuh3KTprV2UFlNNRDwN6', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Vicente, Guiselda', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-26 03:26:31', '2026-06-26 03:26:31'),
(242, '09544575231', '09544575231', 'junsoledad28@gmail.com', NULL, '$2y$12$X6Cr6HDFzu4DIBHLSg/kKuLXF.m0AyY92s7ax6sr2KFDT1oBAJ9OG', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Soledad, Cesar Jr', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-26 06:53:22', '2026-06-26 06:53:22'),
(243, '09102228346', '09102228346', 'balase642@gmail.com', NULL, '$2y$12$n0oq638P1LH5uQrIUYZG2.zsoz8bWt/a3yZ6io.PsOMjtqzBxUFzW', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Balase, Lea', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-26 07:01:40', '2026-06-26 07:01:40'),
(244, '09951668731', '09951668731', 'EstrellaMelody@gmail.com', NULL, '$2y$12$Ve0JQM2HBHVvM4OtRjmlAO6CoB6brV5Oh/QsF2CYVRAHQj3JP37Ue', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Estrella, Melody', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-26 07:10:43', '2026-06-26 07:10:43'),
(245, '09554371425', '09554371425', 'jenniferreloxvillarosa@gmail.com', NULL, '$2y$12$ZD0FmxvfiOyOXc7p1WDArePS8DejjbtK6V0ExAVziWDPB5ghoDMry', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Villarosa, Jennifer', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-26 07:12:05', '2026-06-27 21:54:26'),
(246, '09682352138', '09682352138', 'jethroroxas@rocketmail.com', NULL, '$2y$12$TFrL2hlNpajv3Dt2EkhawemrXJXZtcZn2UYxBjGi4P3Obdx8KlKSO', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Roxas, Teresita', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-26 07:14:17', '2026-06-26 07:14:17'),
(247, '09617144030', '09617144030', 'christophermorada@gmail.com', NULL, '$2y$12$J0paUbHjjKtSX0apht9mUuj9vu5H.8gQ2y6ppByoF2XSpYb2XF55y', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'MORADA, JUNE', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-26 07:18:38', '2026-06-26 07:18:38'),
(248, '09381000533', '09381000533', 'monalizamesina@gmail.com', NULL, '$2y$12$/tBjS.GOv9SkBEypFwD6geFbC71ewqdBhCWG8R0twLN6sDYfL4oYC', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Mesina, Monaliza', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-26 07:23:52', '2026-06-26 07:23:52'),
(249, '09363765598', '09363765598', 'clarencejuan0@gmail.com', NULL, '$2y$12$WLOR0qFvLtwUcq1tkTpIqu3Rz8ld4Ik7S/NIBdHhmG5aDV3zidf8K', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Juan, Aries', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-26 07:25:07', '2026-06-26 07:25:07'),
(250, '09269580717', '09269580717', 'rowenanagano@gmail.com', NULL, '$2y$12$gkxIG0WL9TePLTQRjWA3Z.FOI/HwuZVVSFcLKN2.sR5tmeIa7Lp2a', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Nagaño, Rowena', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-26 07:30:01', '2026-06-26 07:30:01'),
(251, '09755809227', '09755809227', 'danilodzapata04@gmail.com', NULL, '$2y$12$OK9ETAcI5d2DFzMVrrmNVebonIbX.FXdZvdJ6nD4SejZL8lsg4P/2', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Zapata, Danilo', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-26 08:23:06', '2026-06-26 08:23:06'),
(252, '09105850777', '09105850777', 'dhoquijano16@gmail.com', NULL, '$2y$12$G80I9.ImqnJd//Y1Ghnpf./JmIg6JRlj4CFpygY3MuxM7WYjFDVmG', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Quijano, Jocelyn', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-26 08:29:27', '2026-06-26 08:29:27'),
(253, '09266961491', '09266961491', 'mitchgoncero@gmail.com', NULL, '$2y$12$J3FfZ4ROe09EFk80qKWzM.huxhZfwwP73.CwAnwgzxIoqY9Zv82P.', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Goncero, Mischel', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-26 08:38:09', '2026-06-26 08:38:09'),
(254, '09619818694', '09619818694', '9.laniejulian@gmail.com', NULL, '$2y$12$0D.3pCApIxAoT6ZUODSygOOWODK7AbKAAogQMNUXnSQzbC5j2o2zy', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Julian, Melanie', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-26 10:01:32', '2026-06-26 10:01:32'),
(255, '09339868193', '09339868193', 'andreamicah.gutierrez@gmail.com', NULL, '$2y$12$.S1mw0AaoGuhZGzS69kJY.a.Thxv4UuYFwo8Rs4aCvnkCUSwQwG6y', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Salazar, Andrea Micah', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-26 10:40:49', '2026-06-26 10:40:49'),
(256, '09958252056', '09958252056', 'cherieorsal@gmail.com', NULL, '$2y$12$rGRYR00t21fO99NMl0ZF1OczySRBXQaxjjGQnjC9yqt.6LTyXo7My', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Cabique, Cheriegil', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-26 10:40:59', '2026-06-26 10:40:59'),
(257, '09958473141', '09958473141', 'rowelresurreccion02@gmail.com', NULL, '$2y$12$fpt5GyheJkNttNlMySSH5eYbzXIuBMaLwavZXq4UoPU/F8tl/PWVO', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Resurreccion, Rowel', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-26 11:12:39', '2026-06-26 11:12:39'),
(258, '09353102131', '09353102131', 'lhezlhie10@gmail.com', NULL, '$2y$12$oo20.LmdCoKvGInPWwSLyuqO45z5x9h/vqUEKABoNgdsxCEWHLvv.', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Alipante, Leslie', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-26 11:59:35', '2026-06-26 11:59:35'),
(259, '09773440527', '09773440527', 'rheagracecruz2019@gmail.com', NULL, '$2y$12$.SFaVZu5Zk53GJU03nncrepX1ErqxcAXpBkJGteL0M3P2nvhqV7.u', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Cruz, Rhea Grace', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-26 12:52:35', '2026-06-26 12:52:35'),
(260, '09216555723', '09216555723', 'joaquingerwin558@gmail.com', NULL, '$2y$12$jfzEcdi7VkrPWwESiWClceH5NyeSIL4klYzlkxYRpkiYAaUrVYieO', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Joaquin, Gerwin', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-26 14:20:57', '2026-06-26 14:20:57'),
(261, '09085894214', '09085894214', 'salanapmalou@gmail.com', NULL, '$2y$12$aMK0FGki4T3P/D2XZplsreN1Z0UGTh7OltQODCRjXPXYoks6VGTxi', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Salanap, Marilou', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-26 15:58:55', '2026-06-27 12:47:11'),
(262, '09272792136', '09272792136', 'reyginatermulo@gmail.com', NULL, '$2y$12$pJ8h0v8WHaxkngLaYlIiTesyu8tT4i2pmpqQjDLS9tzMxpXz8sdeq', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Buenaventura, Reygina Shiela', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-26 19:58:31', '2026-06-26 19:58:31'),
(263, '09393480506', '09393480506', 'merryyours@yahoo.com', NULL, '$2y$12$7WrrKJimabOvGcUskCQBSOE8WqIBEX0ztFErXGT6FnGv7aksAlscm', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Guzman, Merry Cline', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-26 20:51:35', '2026-06-26 20:51:35'),
(264, '09569617407', '09569617407', 'kennethtabalno99@gmail.com', '2026-06-26 21:37:37', '$2y$12$GkVJO6ailovPzodF9Ywl2u/7qFyW1Ms/zHEotrgSuCei6lPLLkswO', NULL, NULL, NULL, NULL, '2026-06-26 21:37:33', NULL, 'active', '2026-06-26 21:37:37', 'Tabalno, Rowena', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', 'Agreed', 'Agreed', 'Accepted', '2026-06-26 21:37:37', NULL, NULL, '2026-06-26 21:34:53', '2026-06-26 21:37:37'),
(265, '09171829788', '09171829788', 'spaghettirevisa@gmail.com', NULL, '$2y$12$9hcYamefEjh5MxLukCJ3lONWMxyvJPwz4lLuD8rDJ2aM7KO0ggeLu', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Revisa, Spaghetti', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-27 08:50:20', '2026-06-27 08:50:20'),
(266, '09686966045', '09686966045', 'sanjosereese128@gmail.com', NULL, '$2y$12$O2uYliV6mxTvQiPYBcVinOjhL67ZkznRi00ZuAdz2G/h2AVVsTogu', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'San Jose, Roderic', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-27 10:04:24', '2026-06-27 10:04:24'),
(267, '09082421614', '09082421614', 'paolapaulley2019@gmail.com', NULL, '$2y$12$8.i/okQgT5Jtb0ZfZ.SPYecWCiuc14D3bZZJU1/I9MFKzJPrN0Rse', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Valencia, Paola Maudenice', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-27 15:51:17', '2026-06-27 15:51:17'),
(268, '09650313919', '09650313919', 'okeihn62487@gmail.com', NULL, '$2y$12$zilG2BOTx6/Eq9CTBqkPRebt1G4ZHJl.pj7DAx30aWLWLwRz.lcKq', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Sarmiento, Joahna Marie', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-27 15:56:07', '2026-06-27 15:56:07'),
(269, '09955784320', '09955784320', 'bebetwinkle14@gmail.com', NULL, '$2y$12$mTbFaugunK.kctxo.sFJz.Ocl7VqXAIaOJcUA/RwXbOR2slwXyg7m', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Valdez, Bernadette', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-27 15:59:53', '2026-06-27 15:59:53'),
(270, '09550421046', '09550421046', 'ricmurann029@gmail.com', NULL, '$2y$12$JYi4JPmGvB2Meu8SQFmgJOctk/MO.JkJD3QSSHOaM1wFQxWlRawxG', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Ricafort, AnnaAngelica', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-27 16:02:25', '2026-06-27 16:02:25'),
(271, '09668836639', '09668836639', 'jo.jacinto.ramos@gmail.com', NULL, '$2y$12$8df/Ayx/484RP5Z4MUo/4OjchsDsy7N5HQburhSJ1YBwN7nZWLiTG', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Ramos, Joana', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-27 16:05:08', '2026-06-27 16:05:08'),
(272, '09942162414', '09942162414', 'tangpuzrommel4@gmail.com', NULL, '$2y$12$7wGof9dSDuGhPs/wjpD3juE0E9Ga8Xq06qfpXuRXwNDGUJ5xUrFyW', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Tangpuz, Rommel', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-27 17:18:26', '2026-06-27 17:18:26'),
(273, '09465695454', '09465695454', 'maricar16borces@gmail.com', NULL, '$2y$12$Pi2ctdgxZkj1CviZNzHolePVtnVfLBxu9/cElWl4ZDwyde5lmuy5O', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Borces, Maricar', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-27 17:59:34', '2026-06-27 18:01:48'),
(274, '09957706545', '09957706545', 'agnesbarcialcruz@gmail.com', NULL, '$2y$12$vMNlY5YfJU9eWADyPZfWkO9391qqITQeWbfD.xOoD2JrTAWx4w8Ta', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Cruz, Agnes', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-27 20:53:30', '2026-06-27 20:53:30'),
(275, '09357923763', '09357923763', 'kharenchrisramos@yahoo.com', NULL, '$2y$12$wWQ8BkU.wWR.GiT.igf1LOkAybxG7zNDoRoNUYhnIlATCHecsAV2e', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Corpuz, Karen Cris', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-28 00:15:59', '2026-06-28 00:15:59'),
(276, '09176907900', '09176907900', 'janilegumatay1@gmail.com', NULL, '$2y$12$k3MtCpdOIvEmc5BOqP0LxeaK2/UmmOKIyBgv/iyX6wL8f0gSXyfC2', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Gumatay, Janile', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-28 07:50:53', '2026-06-28 07:54:00'),
(277, '09175884731', '09175884731', 'janilegumatay1@gmail.com', NULL, '$2y$12$zr.6g0pQRcfL9URiQ8TrVe3w6uRDwXkHdwV9k.g.O5FM1bZwx6psK', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'GUMATAY, JANILE', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-28 08:12:50', '2026-06-28 08:12:50'),
(278, '09108220249', '09108220249', 'rcatherine2013@gmail.com', NULL, '$2y$12$XPct2g9/uSu7v/NT1Am4Mu74mFn9mUv1EGcM0UIjedoycqbQsA59m', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Rosales, Catherine', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-28 09:09:35', '2026-06-28 09:09:35'),
(279, '09481064396', '09481064396', 'rheas2791@gmail.com', NULL, '$2y$12$/ns/jskWdFcRTvv/Yk1dZOMzUwIAuFM5/O9aAWQVnRh9Dy2sdQruy', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Gaspar, Mavelyn', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-28 09:22:46', '2026-06-28 09:22:46'),
(280, '09484917379', '09484917379', 'blesslatorza04@gmail.com', NULL, '$2y$12$PsNfoX6kG4w3pMJCwunXQebpwxZFkkOyiowVDiTMpp8EQwLe9Ok1e', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Latursa, Blesila', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-28 09:32:26', '2026-06-28 09:32:26'),
(281, '09457751175', '09457751175', 'lanie151118@gmail.com', NULL, '$2y$12$/.iATOcpymBpKZmN.Uf9f.F5fKHB4/wodXuyyyTrq9.DrKau6miS2', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Culubong, Philippe', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-28 11:17:24', '2026-06-28 11:17:24');
INSERT INTO `users` (`id`, `user_id`, `username`, `email`, `email_verified_at`, `password`, `reset_password_token`, `reset_token_expires_at`, `otp_code`, `otp_code_expired_at`, `otp_verified_at`, `remember_token`, `account_status`, `last_successfull_login`, `fullname`, `school_code`, `gs_access_status`, `password_update_by`, `assigned_admin_email`, `terms`, `usage_policy`, `privacy_policy`, `terms_policy_date`, `first_user_token`, `first_user_token_expiry_at`, `created_at`, `updated_at`) VALUES
(282, '09750453181', '09750453181', 'rom.sanjose@icloud.com', NULL, '$2y$12$a8dysDz.mR3XoBKsZJpIYel.xjxrgFiT1XReK/IOEq.9l.eofp.6u', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'San Jose, Erlinda', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-28 11:33:26', '2026-06-28 11:33:26'),
(283, '09625352215', '09625352215', 'gecelacadano35@gmail.com', NULL, '$2y$12$LV8Beh15PPm4eXi.H0OGMus159jypaIkRkIDXKOLpQjlWhd2DjTvu', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Cardaño, Gecela', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-28 12:46:32', '2026-06-28 12:50:03'),
(284, '09104920448', '09104920448', 'day0323207@gmail.com', NULL, '$2y$12$nNEPcFn2fd07uKSRpraNgu5HyS1gyFqIlIV7Nqi4wo9UNRcif2VTq', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Pacheco, Maria roda', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-28 14:24:21', '2026-06-28 14:24:21'),
(285, '09453602339', '09453602339', 'ganicapascua35@gmail.com', NULL, '$2y$12$ryJShnpz5.h.MtleEckJQeTFdSiVwH83aJC9.Jag8lWXp5cH2KpAq', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Pascua, Ganica', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-28 14:26:21', '2026-06-28 14:26:21'),
(286, '09532252265', '09532252265', 'yhamprincipe@gmail.com', NULL, '$2y$12$HZAhO7LMngSNUotOWzBvaOa51l33waVnE6z0ri9FKZmzAYS8LANJa', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Erolin, Miami Gretchen', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-29 05:14:26', '2026-06-29 05:14:26'),
(287, '09088828091', '09088828091', 'martinez1988leandre@gmail.com', NULL, '$2y$12$8m/L6EM64KDrSsh4OAttxOi9Ac6m1vUZkprnw5Hy5EIpMHDPiHpnO', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Martinez, John leandre', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-29 05:49:29', '2026-06-29 05:49:29'),
(288, '09458892187', '09458892187', 'hernandezangelakris@gmail.com', NULL, '$2y$12$gBEZfr.PDv.z47Vc.irso.ovL09D10CgSJnGgXG9zCIueoY/fPV5m', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, 'Hernandez, Angela Kris', 'GVA', 'pending', NULL, 'goldenvalues_academy@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-29 11:23:07', '2026-06-29 11:23:07');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `username` (`username`),
  ADD KEY `email` (`email`),
  ADD KEY `password` (`password`),
  ADD KEY `fullname` (`fullname`),
  ADD KEY `school_code` (`school_code`),
  ADD KEY `assigned_admin_email` (`assigned_admin_email`),
  ADD KEY `account_status` (`account_status`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=289;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
