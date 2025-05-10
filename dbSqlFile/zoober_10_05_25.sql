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

/*Table structure for table `order_bookings` */

DROP TABLE IF EXISTS `order_bookings`;

CREATE TABLE `order_bookings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `user_uid` varchar(255) DEFAULT NULL,
  `pickup_type_id` int(11) DEFAULT NULL,
  `user_ride_type_id` int(11) DEFAULT NULL,
  `pickup_latitude` varchar(255) DEFAULT NULL,
  `pickup_longitude` varchar(255) DEFAULT NULL,
  `pickup_location` varchar(255) DEFAULT NULL,
  `pickup_start_datetime` datetime DEFAULT NULL,
  `otp` int(11) DEFAULT NULL,
  `otp_status` int(11) DEFAULT NULL,
  `distance` varchar(255) DEFAULT NULL,
  `amount` varchar(255) DEFAULT NULL,
  `duration` varchar(255) DEFAULT NULL,
  `drop_latitude` varchar(255) DEFAULT NULL,
  `drop_longitude` varchar(255) DEFAULT NULL,
  `drop_location` varchar(255) DEFAULT NULL,
  `suggestion_id` int(11) DEFAULT NULL,
  `order_status` varchar(255) DEFAULT NULL,
  `deleted_flag` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp(),
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `order_bookings` */

insert  into `order_bookings`(`id`,`user_id`,`user_uid`,`pickup_type_id`,`user_ride_type_id`,`pickup_latitude`,`pickup_longitude`,`pickup_location`,`pickup_start_datetime`,`otp`,`otp_status`,`distance`,`amount`,`duration`,`drop_latitude`,`drop_longitude`,`drop_location`,`suggestion_id`,`order_status`,`deleted_flag`,`created_at`,`updated_at`,`deleted_at`) values 
(12,22,NULL,NULL,NULL,'37.7749','-122.4194','San Francisco, CA',NULL,16057,2,'382','477.5','6 hours 10 minutes','34.0522','-118.2437','Los Angeles, CA',NULL,'In Progress',NULL,'2025-05-05 20:50:42','2025-05-06 14:56:44',NULL),
(13,22,NULL,NULL,NULL,'37.7749','-122.4194','San Francisco, CA',NULL,NULL,NULL,'382','477.5','6 hours 10 minutes','34.0522','-118.2437','Los Angeles, CA',NULL,'In Progress',NULL,'2025-05-06 16:58:51','2025-05-06 16:58:51',NULL),
(14,22,NULL,NULL,NULL,'37.7749','-122.4194','San Francisco, CA',NULL,NULL,NULL,'382','477.5','6 hours 10 minutes','34.0522','-118.2437','Los Angeles, CA',NULL,NULL,NULL,'2025-05-09 13:12:25','2025-05-09 13:12:25',NULL),
(15,22,NULL,NULL,NULL,'37.7749','-122.4194','San Francisco, CA',NULL,NULL,NULL,'382','477.5','6 hours 10 minutes','34.0522','-118.2437','Los Angeles, CA',NULL,NULL,NULL,'2025-05-09 13:14:23','2025-05-09 13:14:23',NULL),
(16,22,NULL,NULL,NULL,'37.7749','-122.4194','San Francisco, CA',NULL,NULL,NULL,'382',NULL,'6 hours 10 minutes','34.0522','-118.2437','Los Angeles, CA',NULL,NULL,NULL,'2025-05-09 13:21:05','2025-05-09 13:21:05',NULL),
(17,23,NULL,NULL,NULL,'10.7851008','78.7019398','Current Location',NULL,NULL,NULL,'126 km',NULL,'2 hours 1 min','9.9252007','78.1197754','Madurai, Tamil Nadu, India',NULL,NULL,NULL,'2025-05-09 13:24:08','2025-05-09 13:24:08',NULL),
(18,23,NULL,NULL,NULL,'10.7851008','78.7019398','Current Location',NULL,NULL,NULL,'126 km',NULL,'2 hours 1 min','9.9252007','78.1197754','Madurai, Tamil Nadu, India',NULL,NULL,NULL,'2025-05-09 13:24:08','2025-05-09 13:24:08',NULL),
(19,22,NULL,NULL,NULL,'37.7749','-122.4194','San Francisco, CA',NULL,NULL,NULL,'382',NULL,'6 hours 10 minutes','34.0522','-118.2437','Los Angeles, CA',NULL,NULL,NULL,'2025-05-09 13:28:02','2025-05-09 13:28:02',NULL),
(20,22,NULL,NULL,NULL,'37.7749','-122.4194','San Francisco, CA',NULL,NULL,NULL,'382',NULL,'6 hours 10 minutes','34.0522','-118.2437','Los Angeles, CA',NULL,NULL,NULL,'2025-05-09 13:29:24','2025-05-09 13:29:24',NULL),
(21,23,NULL,NULL,NULL,'10.7851008','78.7019398','Current Location',NULL,NULL,NULL,'126 km',NULL,'2 hours 1 min','9.9252007','78.1197754','Madurai, Tamil Nadu, India',NULL,NULL,NULL,'2025-05-09 13:36:00','2025-05-09 13:36:00',NULL),
(22,22,NULL,NULL,NULL,'37.7749','-122.4194','San Francisco, CA',NULL,NULL,NULL,'382',NULL,'6 hours 10 minutes','34.0522','-118.2437','Los Angeles, CA',NULL,NULL,NULL,'2025-05-09 13:45:17','2025-05-09 13:45:17',NULL),
(23,22,NULL,NULL,NULL,'37.7749','-122.4194','San Francisco, CA',NULL,NULL,NULL,'382',NULL,'6 hours 10 minutes','34.0522','-118.2437','Los Angeles, CA',NULL,NULL,NULL,'2025-05-09 13:47:05','2025-05-09 13:47:05',NULL),
(24,22,NULL,NULL,NULL,'37.7749','-122.4194','San Francisco, CA',NULL,NULL,NULL,'10',NULL,'6 hours 10 minutes','34.0522','-118.2437','Los Angeles, CA',NULL,NULL,NULL,'2025-05-09 13:47:19','2025-05-09 13:47:19',NULL),
(25,22,NULL,NULL,NULL,'37.7749','-122.4194','San Francisco, CA',NULL,NULL,NULL,'10',NULL,'6 hours 10 minutes','34.0522','-118.2437','Los Angeles, CA',NULL,NULL,NULL,'2025-05-09 13:47:43','2025-05-09 13:47:43',NULL),
(26,22,NULL,NULL,NULL,'37.7749','-122.4194','San Francisco, CA',NULL,NULL,NULL,'10',NULL,'6 hours 10 minutes','34.0522','-118.2437','Los Angeles, CA',NULL,NULL,NULL,'2025-05-09 13:48:05','2025-05-09 13:48:05',NULL),
(27,22,NULL,NULL,NULL,'37.7749','-122.4194','San Francisco, CA',NULL,NULL,NULL,'10','550','30','34.0522','-118.2437','Los Angeles, CA',2,NULL,NULL,'2025-05-09 13:48:12','2025-05-09 13:48:12',NULL),
(28,23,NULL,NULL,NULL,'10.7851008','78.7019398','Current Location',NULL,NULL,NULL,'126 km',NULL,'2 hours 1 min','9.9252007','78.1197754','Madurai, Tamil Nadu, India',NULL,NULL,NULL,'2025-05-09 13:49:39','2025-05-09 13:49:39',NULL),
(29,23,NULL,NULL,NULL,'10.7851008','78.7019398','Current Location',NULL,NULL,NULL,'126 km',NULL,'2 hours 1 min','9.9252007','78.1197754','Madurai, Tamil Nadu, India',NULL,NULL,NULL,'2025-05-09 13:53:12','2025-05-09 13:53:12',NULL),
(30,22,NULL,NULL,NULL,'37.7749','-122.4194','San Francisco, CA',NULL,NULL,NULL,'10',NULL,NULL,'34.0522','-118.2437','Los Angeles, CA',NULL,NULL,NULL,'2025-05-09 14:04:19','2025-05-09 14:04:19',NULL),
(31,22,NULL,NULL,NULL,'37.7749','-122.4194','San Francisco, CA',NULL,NULL,NULL,'10',NULL,NULL,'34.0522','-118.2437','Los Angeles, CA',NULL,NULL,NULL,'2025-05-09 14:04:37','2025-05-09 14:04:37',NULL),
(32,23,NULL,NULL,NULL,'10.7851008','78.7019398','Current Location',NULL,NULL,NULL,'126 km',NULL,NULL,'9.9252007','78.1197754','Madurai, Tamil Nadu, India',NULL,NULL,NULL,'2025-05-09 14:18:56','2025-05-09 14:18:56',NULL),
(33,23,NULL,NULL,NULL,'10.7851008','78.7019398','Current Location',NULL,NULL,NULL,'126 km',NULL,NULL,'9.9252007','78.1197754','Madurai, Tamil Nadu, India',NULL,NULL,NULL,'2025-05-09 14:20:30','2025-05-09 14:20:30',NULL),
(34,23,NULL,NULL,NULL,'10.7851078','78.7019423','Current Location',NULL,NULL,NULL,'332 km',NULL,NULL,'13.0843007','80.2704622','Chennai, Tamil Nadu, India',NULL,NULL,NULL,'2025-05-09 14:22:33','2025-05-09 14:22:33',NULL),
(35,23,NULL,NULL,NULL,'10.7851078','78.7019423','Current Location',NULL,NULL,NULL,'332 km',NULL,NULL,'13.0843007','80.2704622','Chennai, Tamil Nadu, India',NULL,NULL,NULL,'2025-05-09 14:26:14','2025-05-09 14:26:14',NULL),
(36,22,NULL,NULL,NULL,'37.7749','-122.4194','San Francisco, CA',NULL,NULL,NULL,'10',NULL,NULL,'34.0522','-118.2437','Los Angeles, CA',NULL,NULL,NULL,'2025-05-09 14:39:16','2025-05-09 14:39:16',NULL),
(37,23,NULL,NULL,NULL,'10.7851078','78.7019423','Current Location',NULL,NULL,NULL,'332 km',NULL,NULL,'13.0843007','80.2704622','Chennai, Tamil Nadu, India',NULL,NULL,NULL,'2025-05-09 14:44:13','2025-05-09 14:44:13',NULL),
(38,23,NULL,NULL,NULL,'10.7851193','78.7019437','Current Location',NULL,NULL,NULL,'332 km',NULL,NULL,'13.0843007','80.2704622','Chennai, Tamil Nadu, India',NULL,NULL,NULL,'2025-05-09 14:45:25','2025-05-09 14:45:25',NULL),
(39,23,NULL,NULL,NULL,'10.7851193','78.7019437','Current Location',NULL,NULL,NULL,'332 km',NULL,NULL,'13.0843007','80.2704622','Chennai, Tamil Nadu, India',NULL,NULL,NULL,'2025-05-09 14:46:38','2025-05-09 14:46:38',NULL),
(40,23,NULL,NULL,NULL,'10.7851193','78.7019437','Current Location',NULL,NULL,NULL,'332 km',NULL,NULL,'13.0843007','80.2704622','Chennai, Tamil Nadu, India',NULL,NULL,NULL,'2025-05-09 14:50:29','2025-05-09 14:50:29',NULL),
(41,23,NULL,NULL,NULL,'10.7851193','78.7019437','Current Location',NULL,NULL,NULL,'332 km',NULL,NULL,'13.0843007','80.2704622','Chennai, Tamil Nadu, India',NULL,NULL,NULL,'2025-05-09 14:52:59','2025-05-09 14:52:59',NULL),
(42,23,NULL,NULL,NULL,'10.7851193','78.7019437','Current Location',NULL,NULL,NULL,'332','415','22:8','13.0843007','80.2704622','Chennai, Tamil Nadu, India',1,NULL,NULL,'2025-05-09 14:55:22','2025-05-09 14:55:22',NULL),
(43,23,NULL,NULL,NULL,'10.7851193','78.7019437','Current Location',NULL,NULL,NULL,'332','415','22:8','13.0843007','80.2704622','Chennai, Tamil Nadu, India',1,NULL,NULL,'2025-05-09 14:57:41','2025-05-09 14:57:41',NULL),
(44,23,NULL,NULL,NULL,'10.7851193','78.7019437','Current Location',NULL,NULL,NULL,'332 km',NULL,NULL,'13.0843007','80.2704622','Chennai, Tamil Nadu, India',NULL,NULL,NULL,'2025-05-09 14:58:59','2025-05-09 14:58:59',NULL),
(45,23,NULL,NULL,NULL,'10.7851193','78.7019437','Current Location',NULL,NULL,NULL,'332 km',NULL,NULL,'13.0843007','80.2704622','Chennai, Tamil Nadu, India',NULL,NULL,NULL,'2025-05-09 14:59:40','2025-05-09 14:59:40',NULL),
(46,23,NULL,NULL,NULL,'10.7773133','78.6951816','Current Location',NULL,NULL,NULL,'333 km',NULL,NULL,'13.0843007','80.2704622','Chennai, Tamil Nadu, India',NULL,NULL,NULL,'2025-05-10 04:27:41','2025-05-10 04:27:41',NULL),
(47,23,NULL,NULL,NULL,'10.7773133','78.6951816','Current Location',NULL,NULL,NULL,'333 km',NULL,NULL,'13.0843007','80.2704622','Chennai, Tamil Nadu, India',NULL,NULL,NULL,'2025-05-10 05:08:22','2025-05-10 05:08:22',NULL),
(48,23,NULL,NULL,NULL,'10.7772862','78.695183','Current Location',NULL,NULL,NULL,'2.0 km',NULL,NULL,'10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'2025-05-10 05:45:36','2025-05-10 05:45:36',NULL),
(49,23,NULL,NULL,NULL,'10.7772862','78.695183','Current Location',NULL,NULL,NULL,'2.0 km',NULL,NULL,'10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'2025-05-10 05:46:37','2025-05-10 05:46:37',NULL),
(50,23,NULL,NULL,NULL,'10.7772862','78.695183','Current Location',NULL,NULL,NULL,'2.0 km',NULL,NULL,'10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'2025-05-10 05:47:17','2025-05-10 05:47:17',NULL),
(51,23,NULL,NULL,NULL,'10.7772862','78.695183','Current Location',NULL,NULL,NULL,'2.0 km',NULL,NULL,'10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'2025-05-10 05:54:39','2025-05-10 05:54:39',NULL),
(52,23,NULL,NULL,NULL,'10.7772862','78.695183','Current Location',NULL,NULL,NULL,'2.0 km',NULL,NULL,'10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'2025-05-10 05:56:39','2025-05-10 05:56:39',NULL),
(53,23,NULL,NULL,NULL,'10.7772848','78.6951385','Current Location',NULL,NULL,NULL,'2',NULL,NULL,'10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'2025-05-10 06:03:35','2025-05-10 06:03:35',NULL),
(54,23,NULL,NULL,NULL,'10.7772848','78.6951385','Current Location',NULL,NULL,NULL,'2.0 km',NULL,NULL,'10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'2025-05-10 06:07:15','2025-05-10 06:07:15',NULL),
(55,23,NULL,NULL,NULL,'10.7772848','78.6951385','Current Location',NULL,NULL,NULL,'2.0',NULL,NULL,'10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'2025-05-10 06:08:26','2025-05-10 06:08:26',NULL),
(56,23,NULL,NULL,NULL,'10.7772848','78.6951385','Current Location',NULL,NULL,NULL,'2.0',NULL,NULL,'10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'2025-05-10 06:10:42','2025-05-10 06:10:42',NULL),
(57,23,NULL,NULL,NULL,'10.7773229','78.6951265','Current Location',NULL,NULL,NULL,'2.0',NULL,NULL,'10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'2025-05-10 06:14:29','2025-05-10 06:14:29',NULL),
(58,23,NULL,NULL,NULL,'10.7773384','78.6951016','Current Location',NULL,NULL,NULL,'333',NULL,NULL,'13.0843007','80.2704622','Chennai, Tamil Nadu, India',NULL,NULL,NULL,'2025-05-10 06:15:07','2025-05-10 06:15:07',NULL),
(59,23,NULL,NULL,NULL,'10.7773303','78.6951262','Current Location',NULL,NULL,NULL,'333',NULL,NULL,'13.0843007','80.2704622','Chennai, Tamil Nadu, India',NULL,NULL,NULL,'2025-05-10 06:16:05','2025-05-10 06:16:05',NULL),
(60,23,NULL,NULL,NULL,'10.7773347','78.695117','Current Location',NULL,NULL,NULL,'2.5',NULL,NULL,'10.7904833','78.7046725','Trichy, Tamil Nadu, India',NULL,NULL,NULL,'2025-05-10 06:17:10','2025-05-10 06:17:10',NULL),
(61,23,NULL,NULL,NULL,'10.7773347','78.695117','Current Location',NULL,NULL,NULL,'2.5',NULL,NULL,'10.7904833','78.7046725','Trichy, Tamil Nadu, India',NULL,NULL,NULL,'2025-05-10 06:17:25','2025-05-10 06:17:25',NULL),
(62,23,NULL,NULL,NULL,'10.7773076','78.6951409','chenn',NULL,NULL,NULL,'333',NULL,NULL,'13.0843007','80.2704622','Chennai, Tamil Nadu, India',NULL,NULL,NULL,'2025-05-10 06:45:46','2025-05-10 06:45:46',NULL),
(63,23,NULL,NULL,NULL,'10.7772863','78.6951318','Current Location',NULL,NULL,NULL,'2.0',NULL,NULL,'10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'2025-05-10 06:46:49','2025-05-10 06:46:49',NULL),
(64,23,NULL,NULL,NULL,'13.0843007','80.2704622','Chennai, Tamil Nadu, India',NULL,NULL,NULL,'332',NULL,NULL,'10.7904833','78.7046725','Trichy, Tamil Nadu, India',NULL,NULL,NULL,'2025-05-10 09:31:44','2025-05-10 09:31:44',NULL);

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
  `suggestion_id` int(11) DEFAULT NULL,
  `base_price` varchar(255) DEFAULT NULL,
  `price_per_km` varchar(255) DEFAULT NULL,
  `per_kilometer_time` varchar(255) DEFAULT NULL,
  `price_per_minute` varchar(255) DEFAULT NULL,
  `minimum_fare` varchar(255) DEFAULT NULL,
  `cancellation_fee` varchar(255) DEFAULT NULL,
  `platform_fee` varchar(255) DEFAULT NULL,
  `max_wait_time` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp(),
  `deleted_flag` int(11) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `pricing_rules` */

insert  into `pricing_rules`(`id`,`suggestion_id`,`base_price`,`price_per_km`,`per_kilometer_time`,`price_per_minute`,`minimum_fare`,`cancellation_fee`,`platform_fee`,`max_wait_time`,`created_at`,`updated_at`,`deleted_flag`,`deleted_at`) values 
(3,1,'2.50','1.25','4','0.35','5.00','3.00','1.50','5','2025-05-07 14:08:10','2025-05-07 14:08:10',NULL,NULL),
(4,2,NULL,'2.25','6',NULL,NULL,NULL,NULL,NULL,'2025-05-09 18:46:48','2025-05-09 18:46:48',NULL,NULL),
(5,3,NULL,'3.25','3',NULL,NULL,NULL,NULL,NULL,'2025-05-09 18:46:55','2025-05-09 18:46:55',NULL,NULL),
(6,4,NULL,'4.25','2',NULL,NULL,NULL,NULL,NULL,'2025-05-09 18:47:06','2025-05-09 18:47:06',NULL,NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `ride_details` */

insert  into `ride_details`(`id`,`ride_uid`,`total_ride`,`total_hours`,`total_kilometer`,`rating`,`earning`,`created_at`,`updated_at`,`deleted_at`,`deleted_flag`) values 
(1,'2664','1','10','100','5','100','2025-05-06 13:26:23','2025-05-06 13:26:23',NULL,NULL),
(2,'333','1','10','100','5','555','2025-05-06 13:33:54','2025-05-06 13:33:54',NULL,NULL);

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
  `latitude` varchar(255) DEFAULT NULL,
  `longitude` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `ride_status` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp(),
  `deleted_flag` int(11) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `rides` */

insert  into `rides`(`id`,`ride_uid`,`firstname`,`lastname`,`email`,`mobile`,`password`,`gender`,`dob`,`profile`,`status`,`latitude`,`longitude`,`location`,`ride_status`,`created_at`,`updated_at`,`deleted_flag`,`deleted_at`) values 
(8,'26887','guru','S','guru@gmail.com','9890987654','$2b$10$bTVRgAAuCkWxUFKBBGVwJeuUtYIbbavKRwCLU3qip3jqHluOYcTG2','male','12-12-2006',NULL,'online','10.9194° N','78.7409° E','samayapuram','Active','2025-05-06 13:12:59','2025-05-06 13:12:59',NULL,NULL),
(9,'342','Ravi','M','ravi@gmail.com','9087654323','$2b$10$bTVRgAAuCkWxUFKBBGVwJeuUtYIbbavKRwCLU3qip3jqHluOYcTG2','male','12-12-2009',NULL,'online','10.9194° N','78.7409° E','samayapuram','Active','2025-05-08 19:14:01','2025-05-08 19:14:01',NULL,NULL),
(10,'345','santhosh','K','santhosh@gmail.com','7890678965','$2b$10$bTVRgAAuCkWxUFKBBGVwJeuUtYIbbavKRwCLU3qip3jqHluOYcTG2','male','11-12-2008',NULL,'online','10.9194° N','78.7409° E','samayapuram','Active','2025-05-08 19:16:02','2025-05-08 19:16:02',NULL,NULL),
(11,'346','arun','p','arun@gmail.com','9807654278','$2b$10$bTVRgAAuCkWxUFKBBGVwJeuUtYIbbavKRwCLU3qip3jqHluOYcTG2','male','07-12-2007',NULL,'online','10.9194° N','78.7409° E','samayapuram','Active','2025-05-08 19:18:01','2025-05-08 19:18:01',NULL,NULL),
(12,'342','naveen','S','Naveen@gmail.com','789065432','$2b$10$bTVRgAAuCkWxUFKBBGVwJeuUtYIbbavKRwCLU3qip3jqHluOYcTG2','male','09-12-2009',NULL,'online','10.9194° N','78.7409° E','samayapuram','Active','2025-05-08 19:18:02','2025-05-08 19:18:02',NULL,NULL);

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
(2,'Bike',NULL,NULL,'2025-04-24 11:10:20','2025-04-24 11:10:20',NULL),
(3,'cab',NULL,NULL,'2025-04-24 11:10:24','2025-04-24 11:10:24',NULL),
(4,'premium cab',NULL,NULL,'2025-04-24 11:10:39','2025-04-24 11:10:39',NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `supports` */

insert  into `supports`(`id`,`platform_name`,`support_email`,`support_phone`,`help_center_url`,`terms_conditions_url`,`privacy_policy_url`,`created_at`,`updated_at`,`deleted_flag`,`deleted_at`) values 
(1,'GODAGO','support@godago.com','+1 (800) 555-0123','https://help.godago.com','https://godago.com/terms','https://godago.com/privacy','2025-05-06 17:05:23','2025-05-06 17:05:23',NULL,NULL);

/*Table structure for table `user_details` */

DROP TABLE IF EXISTS `user_details`;

CREATE TABLE `user_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
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

insert  into `user_details`(`id`,`user_id`,`user_uid`,`rating`,`wallet`,`created_at`,`updated_at`,`deleted_flag`,`deleted_at`) values 
(22,NULL,'b2b422f8-25ba-4f31-aef9-c91aa7650bc8','1','1010','2025-05-05 14:20:25','2025-05-05 14:20:25',NULL,NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `users` */

insert  into `users`(`id`,`user_uid`,`firstname`,`lastname`,`email`,`mobile`,`city`,`password`,`gender`,`profile`,`dob`,`user_status`,`deleted_flag`,`created_at`,`updated_at`,`deleted_at`) values 
(22,'b2b422f8-25ba-4f31-aef9-c91aa7650bc8','davi','kumar','davi@gmail.com','9876543210','chennai','$2b$10$t3760Isf/Oi9/7JW61j57O.9avOAhMzCNozsBeM6gAKkUAzaJBH9K','Male',NULL,'12-12-2000','Inactive',NULL,'2025-05-05 19:38:13','2025-05-05 13:51:47',NULL),
(23,'acf5aa49-57ec-48b0-80ca-7c396e435a92','tom','j','tom@gmail.com','1234567895',NULL,'$2b$10$8h0pilkFK1wMBR9cens3uu7t6UTy7ZK95ncQpI3ebbTJLs//nl7gS','Male',NULL,'1/1/2000','active',NULL,'2025-05-10 09:56:33','2025-05-10 04:26:33',NULL);

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
