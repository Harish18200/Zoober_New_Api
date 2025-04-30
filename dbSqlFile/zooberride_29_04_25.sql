-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 29, 2025 at 05:22 PM
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
-- Database: `zooberride`
--

-- --------------------------------------------------------

--
-- Table structure for table `documents`
--

CREATE TABLE `documents` (
  `id` int(11) NOT NULL,
  `ride_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `card_number` varchar(255) DEFAULT NULL,
  `expired_date` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `documents`
--

INSERT INTO `documents` (`id`, `ride_id`, `name`, `photo`, `card_number`, `expired_date`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 'license', NULL, 'JOK8907H', '27-12-2040', NULL, '2025-04-22 15:19:06', '2025-04-22 15:19:06', NULL),
(2, 1, 'aadharNo', NULL, '890987654566', NULL, NULL, '2025-04-22 15:19:47', '2025-04-22 15:19:47', NULL),
(4, 1, 'license', NULL, '3456789', '12-12-2000', NULL, '2025-04-29 14:49:34', '2025-04-29 14:49:34', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `favourites`
--

CREATE TABLE `favourites` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `favourites`
--

INSERT INTO `favourites` (`id`, `user_id`, `title`, `description`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 4, 'home', 'Welcome', NULL, NULL, NULL),
(2, 4, 'work', ' Welcome', NULL, NULL, NULL),
(4, 4, 'gym', 'Welcome', '2025-04-21 13:54:07', '2025-04-21 13:54:07', NULL),
(5, 5, 'college', 'Welcome', '2025-04-23 17:27:03', '2025-04-23 17:27:03', NULL),
(6, 5, 'hostel', 'Welcome', '2025-04-23 17:27:04', '2025-04-23 17:27:04', NULL),
(7, 4, 'New Home', 'New Testing', '2025-04-29 13:59:03', '2025-04-29 13:59:03', '2025-04-29 14:03:57');

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `pickup_type_id` int(11) DEFAULT NULL,
  `user_ride_type_id` int(11) DEFAULT NULL,
  `amount` varchar(255) DEFAULT NULL,
  `kilometer` varchar(255) DEFAULT NULL,
  `pickup_start_datetime` datetime DEFAULT NULL,
  `pickup_location` varchar(255) DEFAULT NULL,
  `drop_location` varchar(255) DEFAULT NULL,
  `suggestion_id` int(11) DEFAULT NULL,
  `deleted_flag` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_details`
--

INSERT INTO `order_details` (`id`, `user_id`, `pickup_type_id`, `user_ride_type_id`, `amount`, `kilometer`, `pickup_start_datetime`, `pickup_location`, `drop_location`, `suggestion_id`, `deleted_flag`, `created_at`, `updated_at`, `deleted_at`) VALUES
(7, 19, 1, 1, '250', '23', '2025-04-24 15:30:00', '123 Main Street, Cityname', '456 Market Road, Destination City', 2, NULL, '2025-04-24 10:07:12', '2025-04-24 10:07:12', NULL),
(8, 19, 1, 1, '100', '25', '0000-00-00 00:00:00', 'salem', 'chennai', 1, NULL, '2025-04-26 14:08:13', '2025-04-26 14:08:13', NULL),
(9, 21, 1, 1, '300', '15', '2000-12-11 18:30:00', 'Trichy', 'airport', 1, NULL, '2025-04-29 13:34:19', '2025-04-29 13:34:19', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pickup_types`
--

CREATE TABLE `pickup_types` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `deleted_flag` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pickup_types`
--

INSERT INTO `pickup_types` (`id`, `name`, `description`, `deleted_flag`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'pickup now', NULL, NULL, '2025-04-24 11:01:21', '2025-04-24 11:01:21', NULL),
(2, 'Later', NULL, NULL, '2025-04-24 11:01:41', '2025-04-24 11:01:41', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `rides`
--

CREATE TABLE `rides` (
  `id` int(11) NOT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `dob` varchar(255) DEFAULT NULL,
  `profile` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp(),
  `deleted_flag` int(11) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rides`
--

INSERT INTO `rides` (`id`, `firstname`, `lastname`, `email`, `mobile`, `password`, `gender`, `dob`, `profile`, `created_at`, `updated_at`, `deleted_flag`, `deleted_at`) VALUES
(1, 'Zoober', NULL, 'godagoapp@gmail.com', '9087678909', '$2b$10$lsVXxm8pLEeRKP/Gka8Dwuw5Os13jN1JdIJtoDKy4ukHXNGp8Rhiu', NULL, NULL, NULL, '2025-04-22 14:22:36', '2025-04-22 14:22:36', NULL, NULL),
(3, 'rider', NULL, 'ride@gmail.com', '9087678909', '$2b$10$AsbmklkXAmbPwE0loDqr4Ob6elOvZsRsLilXf1kg22zZBtGBe05Oa', NULL, NULL, NULL, '2025-04-26 11:34:43', '2025-04-26 11:34:43', NULL, NULL),
(4, 'dhana', 'raj', 'dhana@gmail.com', '9876543210', '$2b$10$hat/Yispp520EP5/aFUI0uu0IxLHh9hxyUC1swZSJVa/XCV9q8PEi', 'Male', '12-12-2000', NULL, '2025-04-29 14:19:49', '2025-04-29 14:19:49', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `suggestions`
--

CREATE TABLE `suggestions` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `deleted_flag` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `suggestions`
--

INSERT INTO `suggestions` (`id`, `name`, `description`, `deleted_flag`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Auto', NULL, NULL, '2025-04-24 11:10:16', '2025-04-24 11:10:16', NULL),
(2, 'Moto', NULL, NULL, '2025-04-24 11:10:20', '2025-04-24 11:10:20', NULL),
(3, 'Trip', NULL, NULL, '2025-04-24 11:10:24', '2025-04-24 11:10:24', NULL),
(4, 'Intercity', NULL, NULL, '2025-04-24 11:10:39', '2025-04-24 11:10:39', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `mobile_otp` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `profile` varchar(255) DEFAULT NULL,
  `dob` varchar(255) DEFAULT NULL,
  `deleted_flag` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `mobile`, `mobile_otp`, `password`, `gender`, `profile`, `dob`, `deleted_flag`, `created_at`, `updated_at`, `deleted_at`) VALUES
(19, 'zooberUser', 'S', 'godagoapp@gmail.com', '9087678909', NULL, '$2b$10$7DNVfzBdqGY9U.LZenFHY.wyjMFIqndaM9ejka/o8Vz2DQodIF.ZK', 'Male', NULL, '12-12-2002', NULL, '2025-04-26 07:08:26', '2025-04-24 06:56:41', NULL),
(20, 'arun', 'kumar', 'user@gmail.com', '1234567890', NULL, '$2b$10$cqb0S.Y8/LABmw.zUtHnDe1G6EQJgjtlDpzb1CC8nub5RjR1E5yq.', 'male', NULL, NULL, NULL, '2025-04-26 14:01:58', '2025-04-26 14:01:58', NULL),
(21, 'davi', 'kumar', 'davi@gmail.com', '9876543210', NULL, '$2b$10$7K2qH3N36XxPqyjbsrVUwe0u5oSX4AuMIZlPpY01FJvK.go.dXzha', 'Male', NULL, '12-12-2000', 1, '2025-04-29 13:40:47', '2025-04-29 13:26:32', '2025-04-29 13:40:47');

-- --------------------------------------------------------

--
-- Table structure for table `user_locations`
--

CREATE TABLE `user_locations` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `device_location` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_locations`
--

INSERT INTO `user_locations` (`id`, `user_id`, `device_location`, `created_at`, `updated_at`, `deleted_at`) VALUES
(2, 19, 'Trichy', '2025-04-24 07:19:41', '2025-04-24 07:19:41', NULL),
(3, 19, 'trichy', '2025-04-26 14:04:41', '2025-04-26 14:04:41', NULL),
(4, 21, 'Trichy', '2025-04-29 13:29:25', '2025-04-29 13:29:25', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_ride_types`
--

CREATE TABLE `user_ride_types` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `deleted_flag` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_ride_types`
--

INSERT INTO `user_ride_types` (`id`, `name`, `description`, `deleted_flag`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'For Me', NULL, NULL, '2025-04-24 11:05:39', '2025-04-24 11:05:39', NULL),
(2, 'A group', NULL, NULL, '2025-04-24 11:06:21', '2025-04-24 11:06:21', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `vehicles`
--

CREATE TABLE `vehicles` (
  `id` int(11) NOT NULL,
  `ride_id` int(11) DEFAULT NULL,
  `brand` varchar(255) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  `model_year` varchar(255) DEFAULT NULL,
  `license_plate` varchar(255) DEFAULT NULL,
  `color` varchar(255) DEFAULT NULL,
  `booking_type` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vehicles`
--

INSERT INTO `vehicles` (`id`, `ride_id`, `brand`, `model`, `model_year`, `license_plate`, `color`, `booking_type`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(2, 1, 'Duke', '200', '2018', 'Active', 'Blue', 'offline', NULL, '2025-04-22 14:53:42', '2025-04-22 14:53:42', NULL),
(3, 1, 'duke', 'Y1', '2020', 'active', 'red', 'offline', NULL, '2025-04-29 14:41:39', '2025-04-29 14:41:39', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `favourites`
--
ALTER TABLE `favourites`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pickup_types`
--
ALTER TABLE `pickup_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rides`
--
ALTER TABLE `rides`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `suggestions`
--
ALTER TABLE `suggestions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_locations`
--
ALTER TABLE `user_locations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_ride_types`
--
ALTER TABLE `user_ride_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `documents`
--
ALTER TABLE `documents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `favourites`
--
ALTER TABLE `favourites`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `pickup_types`
--
ALTER TABLE `pickup_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `rides`
--
ALTER TABLE `rides`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `suggestions`
--
ALTER TABLE `suggestions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `user_locations`
--
ALTER TABLE `user_locations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `user_ride_types`
--
ALTER TABLE `user_ride_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
