-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 06, 2026 at 01:05 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `idrs_school_db`
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

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_03_12_065717_create_personal_access_tokens_table', 1);

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
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
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
(134, 'App\\Models\\User', 22, 'access_token', '9dc036d6dec7ea0dbb71c49fe74670092bcc213903788351fb559a49da11f6d3', '[\"*\"]', '2026-03-17 07:23:17', '2026-03-17 15:23:13', '2026-03-17 07:23:13', '2026-03-17 07:23:17'),
(135, 'App\\Models\\User', 22, 'refresh_token', 'c2afc19f11d173f6c5348b077810968bc3bff175566c0660d8cc61702d89df2f', '[\"*\"]', NULL, '2026-03-31 07:23:13', '2026-03-17 07:23:13', '2026-03-17 07:23:13'),
(144, 'App\\Models\\User', 21, 'access_token', 'a4b4ab3a55732e238fbfb27f25bbf07300433f44a5fa7dc6e79cb8e948fb8ed7', '[\"*\"]', '2026-03-18 20:25:42', '2026-03-19 04:24:17', '2026-03-18 20:24:17', '2026-03-18 20:25:42'),
(145, 'App\\Models\\User', 21, 'refresh_token', 'df9e945cf22c08b5809ba05159c15c1f91f46c5d36de44a31ee0093748539f53', '[\"*\"]', NULL, '2026-04-01 20:24:17', '2026-03-18 20:24:17', '2026-03-18 20:24:17'),
(360, 'App\\Models\\User', 13, 'access_token', 'b7601934a150ce873b63c4cbc8b3ef89f8b08fa28c1af7ad807ddb40a12e8906', '[\"*\"]', '2026-04-03 14:46:41', '2026-04-03 15:02:56', '2026-04-03 07:02:56', '2026-04-03 14:46:41'),
(362, 'App\\Models\\User', 13, 'access_token', '5bbe9de347a35a927431a575f4c9cd1959e8c8db85b877cdfbcf71d60ad3459f', '[\"*\"]', '2026-04-03 15:23:49', '2026-04-03 23:23:44', '2026-04-03 15:23:45', '2026-04-03 15:23:49');

-- --------------------------------------------------------

--
-- Table structure for table `profiles`
--

CREATE TABLE `profiles` (
  `id` int(150) NOT NULL,
  `role` varchar(255) DEFAULT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `profiles`
--

INSERT INTO `profiles` (`id`, `role`, `fullname`, `created_at`, `updated_at`) VALUES
(1, '10000000021', 'Super Admin System', '2026-03-12 17:18:45', '2026-03-12 17:18:45'),
(2, '10000000021', 'Admin One User', '2026-03-12 17:18:45', '2026-03-12 17:18:45'),
(14, 'Super Admin', 'System Super Administrator', '2026-03-29 06:20:38', '2026-03-29 14:29:38');

-- --------------------------------------------------------

--
-- Table structure for table `school_id`
--

CREATE TABLE `school_id` (
  `id` bigint(20) NOT NULL,
  `school_code` varchar(20) NOT NULL,
  `school_name` varchar(255) NOT NULL,
  `school_logo` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
-- Table structure for table `student_id_info`
--

CREATE TABLE `student_id_info` (
  `id` bigint(20) NOT NULL,
  `school_code` varchar(20) NOT NULL,
  `student_id` varchar(20) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `middle_initial` varchar(255) DEFAULT NULL,
  `surname` varchar(255) DEFAULT NULL,
  `suffix_name` varchar(50) DEFAULT NULL,
  `name_to_appear_on_id` varchar(255) NOT NULL,
  `nick_name` varchar(255) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `residential_address` text DEFAULT NULL,
  `emergency_contact_person` varchar(255) DEFAULT NULL,
  `emergency_contact_number` varchar(20) DEFAULT NULL,
  `student_picture` varchar(255) NOT NULL,
  `level` varchar(100) NOT NULL,
  `section_course` varchar(100) NOT NULL,
  `lrn` varchar(20) DEFAULT NULL,
  `student_type` enum('old','new') NOT NULL,
  `esc_voucher_recipient` enum('yes','no') NOT NULL,
  `esc_number` varchar(20) DEFAULT NULL,
  `parent_first_name` varchar(255) DEFAULT NULL,
  `parent_surname` varchar(255) DEFAULT NULL,
  `parent_email` varchar(255) DEFAULT NULL,
  `id_info_status` enum('pending','approved') NOT NULL DEFAULT 'pending',
  `id_info_approval_date` timestamp NULL DEFAULT NULL,
  `class_details_status` enum('pending','approved') NOT NULL DEFAULT 'pending',
  `class_details_approval_date` timestamp NULL DEFAULT NULL,
  `id_print_status` enum('pending','printed') NOT NULL DEFAULT 'pending',
  `id_print_date` timestamp NULL DEFAULT NULL,
  `id_reprint_status` enum('yes','no') NOT NULL DEFAULT 'no',
  `id_reprint_date` timestamp NULL DEFAULT NULL,
  `id_reprint_count` varchar(3) NOT NULL,
  `sms_app_credentials` enum('yes','no') NOT NULL DEFAULT 'no',
  `sms_app_created_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `student_id_info`
--

INSERT INTO `student_id_info` (`id`, `school_code`, `student_id`, `first_name`, `middle_initial`, `surname`, `suffix_name`, `name_to_appear_on_id`, `nick_name`, `birth_date`, `gender`, `residential_address`, `emergency_contact_person`, `emergency_contact_number`, `student_picture`, `level`, `section_course`, `lrn`, `student_type`, `esc_voucher_recipient`, `esc_number`, `parent_first_name`, `parent_surname`, `parent_email`, `id_info_status`, `id_info_approval_date`, `class_details_status`, `class_details_approval_date`, `id_print_status`, `id_print_date`, `id_reprint_status`, `id_reprint_date`, `id_reprint_count`, `sms_app_credentials`, `sms_app_created_at`, `created_at`) VALUES
(1, 'SCH001', '26010000001', 'John', 'M', 'Smith', NULL, 'John M. Smith', 'Johnny', '2005-04-21', 'Male', '123 Main St, City', 'Mary Smith', '09123456789', '', 'Grade 10', 'Section A', '123456789012', '', 'no', '', 'Robert', 'Smith2', 'robert.smith@email.com', 'approved', '2024-01-15 02:30:00', 'pending', '2024-01-16 01:00:00', 'printed', '2024-01-17 06:30:00', '', NULL, '0', '', NULL, '2026-03-21 13:52:46'),
(2, 'SCH002', '26010000002', 'John', 'M', 'Smith', NULL, 'John M. Smith', 'Johnny', '2005-05-15', 'Male', '456 Oak Ave, City 2233', 'Mary Smith', '09374456755', '', 'Grade 10', 'Section B', '123456789013', '', 'no', '', 'Robert', 'Smith', 'robert.smith@email.com', 'approved', '2024-01-15 03:00:00', 'pending', '2024-01-16 02:00:00', 'printed', '2024-01-17 07:00:00', '', NULL, '0', '', NULL, '2026-03-21 13:52:46'),
(3, 'SCH001', '26010000003', 'Maria', 'A', 'Garcia', '', 'Maria A. Garcia', 'Maria', '2006-08-20', 'Female', '789 Pine St, City', 'Juan Garcia', '09234567890', '', 'Grade 9', 'Section A', '123456789014', '', 'yes', 'ESC12345', 'Carmen', 'Garcia', 'carmen.garcia@email.com', 'approved', '2024-01-16 01:00:00', 'pending', '2024-01-17 02:00:00', 'printed', '2024-01-18 03:00:00', '', NULL, '0', '', NULL, '2026-03-21 13:52:46'),
(4, 'SCH002', '26010000004', 'David', 'R', 'Johnson', 'Jr', 'David R. Johnson Jr', 'Dave', '2004-12-10', 'Male', '555 Elm St, City', 'Sarah Johnson', '09345678901', '', 'Grade 11', 'Section B', '123456789016', '', 'no', '', 'Michael', 'Johnson', 'michael.johnson@email.com', 'approved', '2024-01-17 02:00:00', 'pending', NULL, 'pending', NULL, '', NULL, '0', '', NULL, '2026-03-21 13:52:46'),
(5, 'SCH003', '26010000005', 'Sarah', 'L', 'Williams', '', 'Sarah L. Williams', 'Sally', '2007-03-25', 'Female', '999 Birch Rd, City', 'Thomas Williams', '09456789012', '', 'Grade 8', 'Section C', '123456789018', '', 'no', '', 'Elizabeth', 'Williams', 'elizabeth.williams@email.com', 'approved', '2024-01-18 01:00:00', 'pending', '2024-01-19 02:00:00', 'printed', '2024-01-20 06:00:00', '', NULL, '0', '', NULL, '2026-03-21 13:52:46'),
(6, 'SCH004', '26010000006', 'Emma', 'C', 'Rodriguez', NULL, 'Emma C. Rodriguez', 'Em', '2008-07-12', 'Female', '123 Sunshine Blvd, City 123', 'Carlos Rodriguez', '09678901234', '', 'Grade 7', 'Section A', '123456789022', '', 'yes', 'ESC12349', 'Maria', 'Rodriguez', 'maria.rodriguez@email.com', 'approved', '2024-02-01 01:00:00', 'pending', '2024-02-02 02:00:00', 'printed', '2024-02-03 03:00:00', '', NULL, '0', '', '2024-02-01 01:00:00', '2026-03-21 13:56:32'),
(7, 'SCH001', '26010000007', 'James', 'T', 'Wilson', 'III', 'James T. Wilson III', 'Jimmy', '2004-09-18', 'Male', '456 Park Ave, City', 'Linda Wilson', '09789012345', '', 'Grade 11', 'Section B', '123456789023', '', 'no', '', 'Thomas', 'Wilson', 'thomas.wilson@email.com', 'approved', '2024-02-03 06:00:00', 'pending', NULL, 'pending', NULL, '', NULL, '0', '', NULL, '2026-03-21 13:56:32'),
(8, 'SCH002', '26010000008', 'Sophia', 'M', 'Martinez', '', 'Sophia M. Martinez', 'Sophie', '2006-11-22', 'Female', '789 River Rd, City', 'Antonio Martinez', '09890123456', '', 'Grade 9', 'Section C', '123456789024', '', 'yes', 'ESC12350', 'Elena', 'Martinez', 'elena.martinez@email.com', 'approved', '2024-02-04 02:30:00', 'pending', '2024-02-05 03:30:00', 'printed', '2024-02-06 05:00:00', '', NULL, '0', '', NULL, '2026-03-21 13:56:32'),
(9, 'SCH003', '26010000009', 'Ethan', 'Madrid', 'Taylor', NULL, 'Ethan D. Taylor', 'E.T.', '2005-12-03', 'Male', '321 Mountain View, City', 'Jennifer Taylor', '09901234567', '', 'Grade 10', 'Section B', '123456789025', '', 'no', NULL, 'Robert', 'Taylor', 'robert.taylor@email.com', 'pending', NULL, 'pending', NULL, 'pending', NULL, '', NULL, '0', '', NULL, '2026-03-21 13:56:32'),
(10, 'SCH004', '26010000010', 'Olivia', 'K', 'Anderson', '', 'Olivia K. Anderson', 'Liv', '2007-02-28', 'Female', '654 Ocean Dr, City', 'David Anderson', '09112345678', '', 'Grade 8', 'Section A', '123456789026', '', 'yes', 'ESC12351', 'Susan', 'Anderson', 'susan.anderson@email.com', 'approved', '2024-02-07 00:00:00', 'pending', '2024-02-08 01:00:00', 'printed', '2024-02-09 02:00:00', '', '2024-02-10 03:00:00', '1', '', '2024-02-07 00:00:00', '2026-03-21 13:56:32'),
(11, 'SCH001', '26010000011', 'Benjamin', 'W', 'Lee', '', 'Benjamin W. Lee', 'Ben', '2005-04-08', 'Male', '123 Cherry Blossom Ln, City', 'Jennifer Lee', '09223344556', '', 'Grade 10', 'Section C', '123456789027', '', 'no', '', 'Steven', 'Lee', 'steven.lee@email.com', 'approved', '2024-02-15 01:30:00', 'pending', '2024-02-16 02:30:00', 'printed', '2024-02-17 06:00:00', '', NULL, '0', '', '2024-02-15 01:30:00', '2026-03-21 13:56:45'),
(12, 'SCH002', '26010000012', 'Isabella', 'R', 'Clark', '', 'Isabella R. Clark', 'Bella', '2006-09-14', 'Female', '456 Sunset Blvd, City', 'Mark Clark', '09334455667', '', 'Grade 9', 'Section A', '123456789028', '', 'yes', 'ESC12352', 'Amanda', 'Clark', 'amanda.clark@email.com', 'approved', '2024-02-18 03:00:00', 'pending', '2024-02-19 04:00:00', 'printed', '2024-02-20 01:00:00', '', '2024-02-25 06:30:00', '2', '', '2024-02-18 03:00:00', '2026-03-21 13:56:45'),
(13, 'SCH005', '26010000013', 'Alexander', 'J', 'Foster', 'II', 'Alexander J. Foster II', 'Alex', '2004-07-19', 'Male', '789 Highland Park, City', 'Patricia Foster', '09445566778', '', 'Grade 12', 'Section A', '123456789029', '', 'no', '', 'Richard', 'Foster', 'richard.foster@email.com', 'pending', NULL, 'pending', NULL, 'pending', NULL, '', NULL, '0', '', NULL, '2026-03-21 13:56:45');

-- --------------------------------------------------------

--
-- Table structure for table `student_registrations`
--

CREATE TABLE `student_registrations` (
  `id` bigint(20) NOT NULL,
  `school_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` varchar(200) NOT NULL,
  `student_id` varchar(200) DEFAULT NULL,
  `lrn` varchar(200) DEFAULT NULL,
  `first_name` varchar(200) DEFAULT NULL,
  `middle_name` varchar(200) DEFAULT NULL,
  `last_name` varchar(200) DEFAULT NULL,
  `suffix` varchar(200) DEFAULT NULL,
  `nickname` varchar(200) DEFAULT NULL,
  `present_address` varchar(255) DEFAULT NULL,
  `permanent_address` varchar(255) DEFAULT NULL,
  `profile_img` varchar(255) DEFAULT NULL,
  `registration_type` varchar(200) DEFAULT NULL,
  `registration_status` varchar(200) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `student_registrations`
--

INSERT INTO `student_registrations` (`id`, `school_code`, `user_id`, `student_id`, `lrn`, `first_name`, `middle_name`, `last_name`, `suffix`, `nickname`, `present_address`, `permanent_address`, `profile_img`, `registration_type`, `registration_status`, `created_at`, `updated_at`) VALUES
(1, '', '10000000001', 'S2024-001', '123456789001', 'Paul John', 'Mari', 'Sager', NULL, 'Sagara Kyosuke', '123 Rizal St, Manila', '456 Mabini St, Manila 255', NULL, 'OLD', 'Approved', '2026-03-12 17:23:51', '2026-03-18 19:51:44'),
(2, '', '10000000002', 'S2024-002', '123456789002', 'Maria', 'Reyes', 'Santos', NULL, 'Mar', '789 Bonifacio St, Quezon City', '101 Luna St, Quezon City', NULL, 'NEW', 'Approved', '2026-03-12 17:23:51', '2026-03-14 05:36:41'),
(3, '', '10000000003', 'S2024-003', '123456789003', 'Jose', 'Villanueva', 'Garcia', 'Jr', 'Pepe', '222 Aguinaldo St, Caloocan', '333 Jacinto St, Caloocan', NULL, 'OLD', 'Approved', '2026-03-12 17:23:51', '2026-03-14 05:36:41'),
(4, '', '10000000004', 'S2024-004', '123456789004', 'Ana', 'Fernandez', 'Lopez', NULL, 'Annie', '444 Mabuhay St, Pasig', '555 Sunrise St, Pasig', NULL, 'NEW', 'Declined', '2026-03-12 17:23:51', '2026-03-14 05:36:41'),
(5, '', '10000000005', 'S2024-005', '123456789005', 'Pedro', 'Gutierrez', 'Ramos', NULL, 'Pedring', '666 Sunset St, Mandaluyong', '777 Moonlight St, Mandaluyong', NULL, 'OLD', 'Approved', '2026-03-12 17:23:51', '2026-03-14 05:36:41'),
(6, '', '10000000006', 'S2024-006', '123456789006', 'Luisa', 'Mendoza', 'Torres', NULL, 'Louie', '888 Broadway St, Makati', '999 Park Ave, Makati', NULL, 'NEW', 'Approved', '2026-03-12 17:23:51', '2026-03-14 05:36:41'),
(7, '', '10000000007', 'S2024-007', '123456789007', 'Miguel', 'Castro', 'Rivera', 'II', 'Mike', '111 Lake St, Taguig', '222 River St, Taguig', NULL, 'OLD', 'Approved', '2026-03-12 17:23:51', '2026-03-14 05:36:41'),
(8, '', '10000000008', 'S2024-008', '123456789008', 'Carmen', 'Romualdez', 'Mercado', NULL, 'Menchie', '333 Hill St, Pasay', '444 Valley St, Pasay', NULL, 'NEW', 'Declined', '2026-03-12 17:23:51', '2026-03-14 05:36:41'),
(9, '', '10000000009', 'S2024-009', '123456789009', 'Antonio', 'Alvarez', 'Villanueva', NULL, 'Tony', '555 Beach St, Paranaque', '666 Shore St, Paranaque', NULL, 'OLD', 'Approved', '2026-03-12 17:23:51', '2026-03-14 05:36:41'),
(10, '', '10000000010', 'S2024-010', '123456789010', 'Isabel', 'Santos', 'Gonzales', NULL, 'Isay', '777 Garden St, Las Pinas', '888 Flower St, Las Pinas', NULL, 'NEW', 'Approved', '2026-03-12 17:23:51', '2026-03-14 05:36:41'),
(11, '', '10000000011', 'S2024-011', '123456789011', 'Ramon', 'Cruz', 'Fernandez', 'Sr', 'Mon-mon', '999 Tree St, Muntinlupa', '111 Forest St, Muntinlupa', NULL, 'OLD', 'Approved', '2026-03-12 17:23:51', '2026-03-14 05:36:41'),
(12, '', '10000000012', 'S2024-012', '123456789012', 'Teresa', 'Garcia', 'Luna', NULL, 'Terry', '222 Cloud St, Valenzuela', '333 Sky St, Valenzuela', NULL, 'NEW', 'Approved', '2026-03-12 17:23:51', '2026-03-14 05:36:41'),
(13, '', '10000000013', 'S2024-013', '123456789013', 'Emilio', 'Aquino', 'Jacinto', NULL, 'Emil', '444 Pearl St, Marikina', '555 Diamond St, Marikina', NULL, 'OLD', 'Declined', '2026-03-12 17:23:51', '2026-03-14 05:36:41'),
(14, '', '10000000014', 'S2024-014', '123456789014', 'Josefina', 'Laurel', 'Romero', NULL, 'Pining', '666 Ruby St, San Juan', '777 Emerald St, San Juan', NULL, 'NEW', 'Approved', '2026-03-12 17:23:51', '2026-03-14 05:36:41'),
(15, '', '10000000015', 'S2024-015', '123456789015', 'Fernando', 'Pascual', 'Dizon', 'III', 'Nando', '888 Sapphire St, Navotas', '999 Topaz St, Navotas', NULL, 'OLD', 'Approved', '2026-03-12 17:23:51', '2026-03-14 05:36:41'),
(16, '', '10000000016', 'S2024-016', '123456789016', 'Luzviminda', 'Magsaysay', 'Bautista', NULL, 'Luz', '111 Bronze St, Malabon', '222 Copper St, Malabon', NULL, 'NEW', 'Approved', '2026-03-12 17:23:51', '2026-03-14 05:36:41'),
(17, '', '10000000017', 'S2024-017', '123456789017', 'Roberto', 'Marcos', 'Tolentino', NULL, 'Bob', '333 Silver St, Pateros', '444 Gold St, Pateros', NULL, 'OLD', 'Approved', '2026-03-12 17:23:51', '2026-03-14 05:36:41'),
(18, '', '10000000018', 'S2024-018', '123456789018', 'Gloria', 'Macapagal', 'Ocampo', NULL, 'Glow', '555 Iron St, Mandaluyong', '666 Steel St, Mandaluyong', NULL, 'NEW', 'Declined', '2026-03-12 17:23:51', '2026-03-14 05:36:41'),
(19, '', '10000000019', 'S2024-019', '123456789019', 'Benigno', 'Noynoy', 'Simpson', NULL, 'Noy', '777 Cement St, Pasig', '888 Concrete St, Pasig', NULL, 'OLD', 'Approved', '2026-03-12 17:23:51', '2026-03-14 05:36:41'),
(20, '', '10000000020', 'S2024-020', '123456789020', 'Corazon', 'Cojuangco', 'Roxas', NULL, 'Cory', '999 Brick St, Manila', '111 Stone St, Manila', NULL, 'NEW', 'Approved', '2026-03-12 17:23:51', '2026-03-14 05:36:41');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `school_code` varchar(20) NOT NULL,
  `school_email` varchar(100) NOT NULL,
  `student_id` varchar(20) NOT NULL,
  `mobile_number` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `account_name` varchar(255) NOT NULL,
  `user_role` varchar(50) NOT NULL,
  `account_status` enum('inactive','active') NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `last_successful_login` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `school_code`, `school_email`, `student_id`, `mobile_number`, `username`, `password`, `account_name`, `user_role`, `account_status`, `remember_token`, `created_at`, `last_successful_login`) VALUES
(1, 'SCH001', 'john.smith@school001.edu.ph', '26010000001', '09123456789', 'john.smith', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'John M. Smith', 'Student', 'active', NULL, '2026-03-21 14:02:02', '2026-03-21 00:30:00'),
(2, 'SCH002', 'john.smith@school002.edu.ph', '26010000002', '09123456789', 'john.smith.sch002', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'John M. Smith', 'Student', 'active', NULL, '2026-03-21 14:02:02', '2026-03-20 07:45:00'),
(3, 'SCH001', 'maria.garcia@school001.edu.ph', '26010000003', '09234567890', 'maria.garcia', '2768b29fde9e02f48891ec8f8fe55745361f4fd08e57d8a29a4e4a5cc961b988', 'Maria Garcia', 'Student', 'active', NULL, '2026-03-21 14:02:02', '2026-03-21 01:15:00'),
(4, 'SCH002', 'david.johnson@school002.edu.ph', '26010000004', '09345678901', 'david.johnson', '0f14089313b20c1723ec1d660b0aaa4f473cf5b321cd370f2d48b7bcf9a7b234', 'David Johnson', 'Student', 'active', NULL, '2026-03-21 14:02:02', '2026-03-19 06:20:00'),
(5, 'SCH003', 'sarah.williams@school003.edu.ph', '26010000005', '09456789012', 'sarah.williams', '090298997498b2889041cff6d6a731a484a944289baa2cbd3870e9cec5ff5304', 'Sarah Williams', 'Student', 'active', NULL, '2026-03-21 14:02:02', '2026-03-18 03:00:00'),
(6, 'SCH004', 'emma.rodriguez@school004.edu.ph', '26010000006', '09678901234', 'emma.rodriguez', '52293754fdbea92ab6c69cd64e644deed1552f40ccd3c1cef9d4d63c754d13e3', 'Emma C. Rodriguez', 'Student', 'active', 'rem_token_001', '2026-03-21 14:02:02', '2026-03-21 02:30:00'),
(7, 'SCH001', 'james.wilson@school001.edu.ph', '26010000007', '09789012345', 'james.wilson', '22c009886333707393dedaf7232b929f1a921a150e860411a1d3053e6d2fc7f9', 'James Wilson', 'Student', 'active', NULL, '2026-03-21 14:02:02', '2026-03-17 05:45:00'),
(8, 'SCH002', 'sophia.martinez@school002.edu.ph', '26010000008', '09890123456', 'sophia.martinez', '2993dd514d3adc941f7ea41b49834d23d8af6b9e201a9a570bedc3f9aa40ac36', 'Sophia Martinez', 'Student', 'active', NULL, '2026-03-21 14:02:02', '2026-03-20 08:30:00'),
(9, 'SCH003', 'ethan.taylor@school003.edu.ph', '26010000009', '09901234567', 'ethan.taylor', '6922377617c1843bcea9199560dfb37869e1fd8f9cda34564ede1531481e6909', 'Ethan Madrid Taylor', 'Student', 'active', NULL, '2026-03-21 14:02:02', '2026-03-15 01:00:00'),
(10, 'SCH004', 'olivia.anderson@school004.edu.ph', '26010000010', '09112345678', 'olivia.anderson', 'e969b2a1eb7bc1450b441402ef2226e6c421d4c65fe0cb3a79e6b1815ab625fc', 'Olivia Anderson', 'Student', 'active', 'rem_token_002', '2026-03-21 14:02:02', '2026-03-21 00:45:00'),
(11, 'SCH001', 'benjamin.lee@school001.edu.ph', '26010000011', '09223344556', 'benjamin.lee', '00b35411c1d0be029af8d4d125db3be3d976e7eb2dd75a4577acaff3451d2263', 'Benjamin Lee', 'Student', 'active', NULL, '2026-03-21 14:02:02', '2026-03-20 23:30:00'),
(12, 'SCH002', 'isabella.clark@school002.edu.ph', '26010000012', '09334455667', 'isabella.clark', '6a919b7e74ca6b2ba6f1cd4ee64ae2086d069393c005a7bcfe17a2c50e758b6f', 'Isabella Clark', 'Student', 'active', 'rem_token_003', '2026-03-21 14:02:02', '2026-03-20 11:15:00'),
(13, 'SCH005', 'alexander.foster@school005.edu.ph', '26010000013', '09445566778', 'alexander.foster', 'dbacc600687ce8dc484ad4ced9450fbf8931d3d91d514efcac01343c480562f1', 'Alexander Foster', 'Student', 'active', NULL, '2026-03-21 14:02:02', NULL),
(14, '', 'super.admin@education.gov.ph', '', '09991234567', 'superadmin', '$2y$10$KRhPE/Rge/9XeYev.dUhJe7Wj4ZHfdjrOV566EohHMONe.jLQRX7O', 'System Super Administrator', 'Super Admin', 'active', 'super_admin_token_001', '2026-03-21 14:09:55', '2026-03-21 00:00:00'),
(15, 'SCH001', 'admin.division@school001.edu.ph', '26010000014', '09881234567', 'divisionadmin', '', 'School Division Administrator', 'Student', 'active', 'admin_token_001', '2026-03-21 14:09:55', '2026-03-20 23:30:00');

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
-- Indexes for table `profiles`
--
ALTER TABLE `profiles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `school_id`
--
ALTER TABLE `school_id`
  ADD PRIMARY KEY (`id`),
  ADD KEY `school_code` (`school_code`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `student_id_info`
--
ALTER TABLE `student_id_info`
  ADD PRIMARY KEY (`id`),
  ADD KEY `school_code` (`school_code`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `emergency_contact_number` (`emergency_contact_number`),
  ADD KEY `name_to_appear_on_id` (`name_to_appear_on_id`),
  ADD KEY `level` (`level`),
  ADD KEY `section_course` (`section_course`),
  ADD KEY `id_info_status` (`id_info_status`),
  ADD KEY `class_details_status` (`class_details_status`),
  ADD KEY `id_print_status` (`id_print_status`),
  ADD KEY `student_type` (`student_type`),
  ADD KEY `esc_voucher_recipient` (`esc_voucher_recipient`),
  ADD KEY `sms_app_credentials` (`sms_app_credentials`);

--
-- Indexes for table `student_registrations`
--
ALTER TABLE `student_registrations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id_2` (`user_id`),
  ADD UNIQUE KEY `id` (`id`,`user_id`,`student_id`,`lrn`,`first_name`,`middle_name`,`last_name`,`suffix`,`nickname`,`present_address`,`permanent_address`,`registration_type`,`registration_status`,`created_at`,`updated_at`),
  ADD KEY `id_2` (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `school_code` (`school_code`),
  ADD KEY `user_id_3` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mobile_number` (`mobile_number`),
  ADD KEY `school_code` (`school_code`),
  ADD KEY `student_id` (`student_id`);

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=374;

--
-- AUTO_INCREMENT for table `profiles`
--
ALTER TABLE `profiles`
  MODIFY `id` int(150) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `school_id`
--
ALTER TABLE `school_id`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `student_id_info`
--
ALTER TABLE `student_id_info`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `student_registrations`
--
ALTER TABLE `student_registrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
