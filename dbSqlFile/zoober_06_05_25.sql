/*
SQLyog Community v13.1.6 (64 bit)
MySQL - 10.4.32-MariaDB : Database - zooberride
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`zooberride` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `zooberride`;

/*Table structure for table `documents` */

DROP TABLE IF EXISTS `documents`;

CREATE TABLE `documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ride_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `card_number` varchar(255) DEFAULT NULL,
  `expired_date` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp(),
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `documents` */

insert  into `documents`(`id`,`ride_id`,`name`,`photo`,`card_number`,`expired_date`,`status`,`created_at`,`updated_at`,`deleted_at`) values 
(1,1,'license',NULL,'JOK8907H','27-12-2040',NULL,'2025-04-22 15:19:06','2025-04-22 15:19:06',NULL),
(2,1,'aadharNo',NULL,'890987654566',NULL,NULL,'2025-04-22 15:19:47','2025-04-22 15:19:47',NULL),
(4,1,'license',NULL,'3456789','12-12-2000',NULL,'2025-04-29 14:49:34','2025-04-29 14:49:34',NULL),
(5,5,'license',NULL,'12222','3-12-2000',NULL,'2025-05-01 10:05:05','2025-05-01 10:05:05',NULL),
(6,5,'license',NULL,'12222','3-12-2000',NULL,'2025-05-01 10:05:52','2025-05-01 10:05:52',NULL),
(7,5,'license',NULL,'12222','3-12-2000',NULL,'2025-05-01 10:05:57','2025-05-01 10:05:57',NULL),
(8,5,'license',NULL,'12222','3-12-2000',NULL,'2025-05-01 10:08:50','2025-05-01 10:08:50',NULL),
(9,5,'license',NULL,'12222','3-12-2000',NULL,'2025-05-01 10:09:27','2025-05-01 10:09:27',NULL),
(10,5,'license',NULL,'12222','3-12-2000',NULL,'2025-05-01 10:10:26','2025-05-01 10:10:26',NULL),
(11,5,'license',NULL,'12222','3-12-2000',NULL,'2025-05-01 10:11:11','2025-05-01 10:11:11',NULL),
(12,5,'New update',NULL,'8909','3-12-2000',NULL,'2025-05-01 10:13:15','2025-05-01 10:13:15',NULL),
(13,5,'New update',NULL,'8909','3-12-2000',NULL,'2025-05-01 10:17:48','2025-05-01 10:17:48',NULL),
(14,5,'New update',NULL,'8909','3-12-2000',NULL,'2025-05-01 10:18:32','2025-05-01 10:18:32',NULL),
(15,5,'New update',NULL,'8909','3-12-2000',NULL,'2025-05-01 10:20:06','2025-05-01 10:20:06',NULL),
(16,5,'New update','1746119294391.jpg','8909','3-12-2000',NULL,'2025-05-01 17:08:14','2025-05-01 17:08:14',NULL),
(17,5,'New update',NULL,'8909','3-12-2000',NULL,'2025-05-01 17:09:03','2025-05-01 17:09:03',NULL),
(18,5,'New update',NULL,'8909','3-12-2000',NULL,'2025-05-01 17:09:09','2025-05-01 17:09:09',NULL);

/*Table structure for table `favourites` */

DROP TABLE IF EXISTS `favourites`;

CREATE TABLE `favourites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp(),
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `favourites` */

insert  into `favourites`(`id`,`user_id`,`title`,`description`,`created_at`,`updated_at`,`deleted_at`) values 
(1,4,'home','Welcome',NULL,NULL,NULL),
(2,4,'work',' Welcome',NULL,NULL,NULL),
(4,4,'gym','Welcome','2025-04-21 13:54:07','2025-04-21 13:54:07',NULL),
(5,5,'college','Welcome','2025-04-23 17:27:03','2025-04-23 17:27:03',NULL),
(6,5,'hostel','Welcome','2025-04-23 17:27:04','2025-04-23 17:27:04',NULL),
(7,4,'New Home','New Testing','2025-04-29 13:59:03','2025-04-29 13:59:03','2025-04-29 14:03:57');

/*Table structure for table `order_details` */

DROP TABLE IF EXISTS `order_details`;

CREATE TABLE `order_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_uid` varchar(255) DEFAULT NULL,
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
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `order_details` */

insert  into `order_details`(`id`,`user_uid`,`pickup_type_id`,`user_ride_type_id`,`amount`,`kilometer`,`pickup_start_datetime`,`pickup_location`,`drop_location`,`suggestion_id`,`deleted_flag`,`created_at`,`updated_at`,`deleted_at`) values 
(7,'19',1,1,'250','23','2025-05-04 15:30:00','123 Main Street, Cityname','456 Market Road, Destination City',2,NULL,'2025-04-24 10:07:12','2025-04-24 10:07:12',NULL),
(8,'19',1,1,'100','25','2025-05-03 19:06:55','salem','chennai',1,NULL,'2025-04-26 14:08:13','2025-04-26 14:08:13',NULL),
(9,'21',1,1,'300','15','2000-12-11 18:30:00','Trichy','airport',1,NULL,'2025-04-29 13:34:19','2025-04-29 13:34:19',NULL);

/*Table structure for table `pickup_types` */

DROP TABLE IF EXISTS `pickup_types`;

CREATE TABLE `pickup_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `deleted_flag` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp(),
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `pickup_types` */

insert  into `pickup_types`(`id`,`name`,`description`,`deleted_flag`,`created_at`,`updated_at`,`deleted_at`) values 
(1,'pickup now',NULL,NULL,'2025-04-24 11:01:21','2025-04-24 11:01:21',NULL),
(2,'Later',NULL,NULL,'2025-04-24 11:01:41','2025-04-24 11:01:41',NULL);

/*Table structure for table `pricing_rules` */

DROP TABLE IF EXISTS `pricing_rules`;

CREATE TABLE `pricing_rules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `base_price` varchar(255) DEFAULT NULL,
  `price_per` varchar(255) DEFAULT NULL,
  `price_per_minute` varchar(255) DEFAULT NULL,
  `minimum_fare` varchar(255) DEFAULT NULL,
  `cancellation_fee` varchar(255) DEFAULT NULL,
  `platform` varchar(255) DEFAULT NULL,
  `platform_fee` varchar(255) DEFAULT NULL,
  `max_wait_time` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp(),
  `deleted_flag` int(11) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `pricing_rules` */

/*Table structure for table `ride_details` */

DROP TABLE IF EXISTS `ride_details`;

CREATE TABLE `ride_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ride_uid` varchar(255) DEFAULT NULL,
  `total_ride` varchar(255) DEFAULT NULL,
  `total_hours` varchar(255) DEFAULT NULL,
  `total_kilometer` varchar(255) DEFAULT NULL,
  `rating` varchar(255) DEFAULT NULL,
  `earning` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_flag` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `ride_details` */

/*Table structure for table `rides` */

DROP TABLE IF EXISTS `rides`;

CREATE TABLE `rides` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ride_uid` varchar(255) DEFAULT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `dob` varchar(255) DEFAULT NULL,
  `profile` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `ride_status` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp(),
  `deleted_flag` int(11) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `rides` */

/*Table structure for table `suggestions` */

DROP TABLE IF EXISTS `suggestions`;

CREATE TABLE `suggestions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `deleted_flag` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp(),
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `suggestions` */

insert  into `suggestions`(`id`,`name`,`description`,`deleted_flag`,`created_at`,`updated_at`,`deleted_at`) values 
(1,'Auto',NULL,NULL,'2025-04-24 11:10:16','2025-04-24 11:10:16',NULL),
(2,'Moto',NULL,NULL,'2025-04-24 11:10:20','2025-04-24 11:10:20',NULL),
(3,'Trip',NULL,NULL,'2025-04-24 11:10:24','2025-04-24 11:10:24',NULL),
(4,'Intercity',NULL,NULL,'2025-04-24 11:10:39','2025-04-24 11:10:39',NULL);

/*Table structure for table `supports` */

DROP TABLE IF EXISTS `supports`;

CREATE TABLE `supports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `platform_name` varchar(255) DEFAULT NULL,
  `support_email` varchar(255) DEFAULT NULL,
  `support_phone` varchar(255) DEFAULT NULL,
  `help_center_url` varchar(255) DEFAULT NULL,
  `terms_conditions_url` varchar(255) DEFAULT NULL,
  `privacy_policy_url` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp(),
  `deleted_flag` int(11) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `supports` */

/*Table structure for table `user_details` */

DROP TABLE IF EXISTS `user_details`;

CREATE TABLE `user_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_uid` varchar(255) DEFAULT NULL,
  `rating` varchar(255) DEFAULT NULL,
  `wallet` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `deleted_flag` int(11) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `user_details` */

insert  into `user_details`(`id`,`user_uid`,`rating`,`wallet`,`created_at`,`updated_at`,`deleted_flag`,`deleted_at`) values 
(22,'b2b422f8-25ba-4f31-aef9-c91aa7650bc8','1','1010','2025-05-05 14:20:25','2025-05-05 14:20:25',NULL,NULL);

/*Table structure for table `user_locations` */

DROP TABLE IF EXISTS `user_locations`;

CREATE TABLE `user_locations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `device_location` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp(),
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `user_locations` */

insert  into `user_locations`(`id`,`user_id`,`device_location`,`created_at`,`updated_at`,`deleted_at`) values 
(2,19,'Trichy','2025-04-24 07:19:41','2025-04-24 07:19:41',NULL),
(3,19,'trichy','2025-04-26 14:04:41','2025-04-26 14:04:41',NULL),
(4,21,'Trichy','2025-04-29 13:29:25','2025-04-29 13:29:25',NULL);

/*Table structure for table `user_ride_types` */

DROP TABLE IF EXISTS `user_ride_types`;

CREATE TABLE `user_ride_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `deleted_flag` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp(),
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `user_ride_types` */

insert  into `user_ride_types`(`id`,`name`,`description`,`deleted_flag`,`created_at`,`updated_at`,`deleted_at`) values 
(1,'For Me',NULL,NULL,'2025-04-24 11:05:39','2025-04-24 11:05:39',NULL),
(2,'A group',NULL,NULL,'2025-04-24 11:06:21','2025-04-24 11:06:21',NULL);

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_uid` varchar(255) DEFAULT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `profile` varchar(255) DEFAULT NULL,
  `dob` varchar(255) DEFAULT NULL,
  `user_status` varchar(255) DEFAULT NULL,
  `deleted_flag` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `users` */

insert  into `users`(`id`,`user_uid`,`firstname`,`lastname`,`email`,`mobile`,`city`,`password`,`gender`,`profile`,`dob`,`user_status`,`deleted_flag`,`created_at`,`updated_at`,`deleted_at`) values 
(22,'b2b422f8-25ba-4f31-aef9-c91aa7650bc8','davi','kumar','davi@gmail.com','9876543210','chennai','$2b$10$t3760Isf/Oi9/7JW61j57O.9avOAhMzCNozsBeM6gAKkUAzaJBH9K','Male',NULL,'12-12-2000','Inactive',NULL,'2025-05-05 19:38:13','2025-05-05 13:51:47',NULL);

/*Table structure for table `vehicles` */

DROP TABLE IF EXISTS `vehicles`;

CREATE TABLE `vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
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
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `vehicles` */

insert  into `vehicles`(`id`,`ride_id`,`brand`,`model`,`model_year`,`license_plate`,`color`,`booking_type`,`status`,`created_at`,`updated_at`,`deleted_at`) values 
(2,1,'Duke','200','2018','Active','Blue','offline',NULL,'2025-04-22 14:53:42','2025-04-22 14:53:42',NULL),
(3,1,'duke','Y1','2020','active','red','offline',NULL,'2025-04-29 14:41:39','2025-04-29 14:41:39',NULL),
(4,1,'duke','Y1','2020','active','red','offline',NULL,'2025-04-30 10:45:14','2025-04-30 10:45:14',NULL),
(5,1,'duke','Y1','2020','active','red','offline',NULL,'2025-04-30 13:54:17','2025-04-30 13:54:17',NULL),
(8,1,'duke','Y1','2020','active','red','offline',NULL,'2025-04-30 14:06:59','2025-04-30 14:06:59',NULL),
(9,1,'duke','Y1','2020','active','red','offline',1,'2025-04-30 14:07:18','2025-04-30 14:07:18',NULL),
(10,1,'duke','Y1','2020','active','red','offline',NULL,'2025-04-30 14:07:21','2025-04-30 14:07:21',NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
