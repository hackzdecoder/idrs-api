-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jun 29, 2026 at 05:12 AM
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
-- Database: `u141085058_atheneum`
--

-- --------------------------------------------------------

--
-- Table structure for table `attendance_records`
--

CREATE TABLE `attendance_records` (
  `id` int(11) NOT NULL,
  `user_id` varchar(20) DEFAULT NULL,
  `school_code` varchar(20) NOT NULL,
  `date` date DEFAULT NULL,
  `time_in` time DEFAULT NULL,
  `kiosk_terminal_in` varchar(50) DEFAULT NULL,
  `time_out` time DEFAULT NULL,
  `kiosk_terminal_out` varchar(50) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `attendance_type` varchar(20) NOT NULL,
  `level` varchar(50) NOT NULL,
  `section_course` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `school_code` varchar(20) NOT NULL,
  `user_id` varchar(20) NOT NULL,
  `date` date NOT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

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
-- Table structure for table `student_records`
--

CREATE TABLE `student_records` (
  `id` int(11) NOT NULL,
  `school_code` varchar(20) NOT NULL,
  `user_id` varchar(20) DEFAULT NULL,
  `student_id` varchar(20) DEFAULT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `nickname` varchar(255) DEFAULT NULL,
  `foreign_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` enum('Male','Female','Other') DEFAULT NULL,
  `course` varchar(100) DEFAULT NULL,
  `level` varchar(50) DEFAULT NULL,
  `school_level` varchar(255) DEFAULT NULL,
  `section` varchar(50) DEFAULT NULL,
  `school_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobile_number` varchar(50) DEFAULT NULL,
  `lrn` varchar(20) DEFAULT NULL,
  `profile_img` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `student_records`
--

INSERT INTO `student_records` (`id`, `school_code`, `user_id`, `student_id`, `fullname`, `nickname`, `foreign_name`, `gender`, `course`, `level`, `school_level`, `section`, `school_name`, `email`, `mobile_number`, `lrn`, `profile_img`, `created_at`, `updated_at`) VALUES
(1, 'atheneum', '09175023039', NULL, 'Laserna, Adelaida', 'Dhel', NULL, NULL, NULL, NULL, NULL, NULL, 'ATHENEUM SCHOOL', NULL, '09175023039', NULL, NULL, '2026-06-01 11:11:11', '2026-06-01 11:11:11'),
(2, 'atheneum', '09175211118', NULL, 'Laserna, Dianne', 'Dianne', NULL, NULL, NULL, NULL, NULL, NULL, 'ATHENEUM SCHOOL', 'dlasernacosejo@gmail.com', '09175211118', NULL, NULL, '2026-06-11 16:18:07', '2026-06-11 16:18:07'),
(3, 'atheneum', '09459759771', '26050000080', 'Cipriaso, Mitch', 'Mitch', NULL, 'Female', 'Fleming', 'Grade 5', 'Grade 5', 'Fleming', 'ATHENEUM SCHOOL', 'mitchoctavo@gmail.com', '09459759771', '108081210016', NULL, '2026-06-16 15:00:28', '2026-06-16 15:00:28');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attendance_records`
--
ALTER TABLE `attendance_records`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `date` (`date`),
  ADD KEY `full_name` (`full_name`),
  ADD KEY `attendance_type` (`attendance_type`),
  ADD KEY `school_code` (`school_code`),
  ADD KEY `level` (`level`),
  ADD KEY `section_course` (`section_course`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `date` (`date`),
  ADD KEY `full_name` (`full_name`),
  ADD KEY `school_code` (`school_code`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `student_records`
--
ALTER TABLE `student_records`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `nickname` (`nickname`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attendance_records`
--
ALTER TABLE `attendance_records`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `student_records`
--
ALTER TABLE `student_records`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
