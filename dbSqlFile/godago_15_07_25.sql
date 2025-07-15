/*
SQLyog Community v13.1.6 (64 bit)
MySQL - 10.4.32-MariaDB : Database - godago
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`godago` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `godago`;

/*Table structure for table `admins` */

DROP TABLE IF EXISTS `admins`;

CREATE TABLE `admins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(255) DEFAULT 'admin',
  `status` enum('active','inactive') DEFAULT 'active',
  `last_login` datetime DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `admins` */

insert  into `admins`(`id`,`name`,`email`,`password`,`role`,`status`,`last_login`,`createdAt`,`updatedAt`,`deletedAt`) values 
(2,'Super Admin','admin@godago.com','$2a$10$3xG28fnVMM7MDeO9k08EKeW7yvcniO/GMqvUXUjG8cW/HtQphUEL6','admin','active',NULL,'2025-06-25 12:28:55','2025-06-25 12:28:55',NULL);

/*Table structure for table `document_types` */

DROP TABLE IF EXISTS `document_types`;

CREATE TABLE `document_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(50) NOT NULL,
  `status` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `document_types` */

insert  into `document_types`(`id`,`type_name`,`status`,`created_at`,`updated_at`,`deleted_at`) values 
(1,'Aadhar',1,'2025-07-07 19:47:22','2025-07-07 19:47:22',NULL),
(2,'Licence',1,'2025-07-07 19:47:22','2025-07-07 19:47:22',NULL),
(3,'Vehicle',1,'2025-07-07 19:47:22','2025-07-07 19:47:22',NULL),
(4,'RC Book',1,'2025-07-07 19:47:22','2025-07-07 19:47:22',NULL);

/*Table structure for table `documents` */

DROP TABLE IF EXISTS `documents`;

CREATE TABLE `documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ride_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `card_number` varchar(255) DEFAULT NULL,
  `expired_date` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp(),
  `deleted_at` datetime DEFAULT NULL,
  `document_type_id` int(11) DEFAULT NULL,
  `admin_approval_status` int(11) DEFAULT NULL,
  `front_side_file_path` varchar(255) DEFAULT NULL,
  `back_side_file_path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `documents` */

insert  into `documents`(`id`,`ride_id`,`name`,`card_number`,`expired_date`,`status`,`created_at`,`updated_at`,`deleted_at`,`document_type_id`,`admin_approval_status`,`front_side_file_path`,`back_side_file_path`) values 
(1,14,'license','JOK8907H','27-12-2040',NULL,'2025-04-22 15:19:06','2025-04-22 15:19:06',NULL,NULL,NULL,NULL,NULL),
(2,15,'aadharNo','890987654566',NULL,NULL,'2025-04-22 15:19:47','2025-04-22 15:19:47',NULL,NULL,NULL,NULL,NULL),
(4,20,'license','3456789','12-12-2000',NULL,'2025-04-29 14:49:34','2025-04-29 14:49:34',NULL,NULL,NULL,NULL,NULL),
(5,21,'license','12222','3-12-2000',NULL,'2025-05-01 10:05:05','2025-05-01 10:05:05',NULL,NULL,NULL,NULL,NULL),
(6,23,'license','12222','3-12-2000',NULL,'2025-05-01 10:05:52','2025-05-01 10:05:52',NULL,NULL,NULL,NULL,NULL),
(7,17,'license','12222','3-12-2000',NULL,'2025-05-01 10:05:57','2025-05-01 10:05:57',NULL,NULL,NULL,NULL,NULL),
(8,11,'license','12222','3-12-2000',NULL,'2025-05-01 10:08:50','2025-05-01 10:08:50',NULL,NULL,NULL,NULL,NULL),
(9,19,'license','12222','3-12-2000',NULL,'2025-05-01 10:09:27','2025-05-01 10:09:27',NULL,NULL,NULL,NULL,NULL),
(10,18,'license','12222','3-12-2000',NULL,'2025-05-01 10:10:26','2025-05-01 10:10:26',NULL,NULL,NULL,NULL,NULL),
(11,16,'license','12222','3-12-2000',NULL,'2025-05-01 10:11:11','2025-05-01 10:11:11',NULL,NULL,NULL,NULL,NULL),
(12,12,'New update','8909','3-12-2000',NULL,'2025-05-01 10:13:15','2025-05-01 10:13:15',NULL,NULL,NULL,NULL,NULL),
(13,11,'New update','8909','3-12-2000',NULL,'2025-05-01 10:17:48','2025-05-01 10:17:48',NULL,NULL,NULL,NULL,NULL),
(14,10,'New update','8909','3-12-2000',NULL,'2025-05-01 10:18:32','2025-05-01 10:18:32',NULL,NULL,NULL,NULL,NULL),
(15,8,'New update','8909','3-12-2000',NULL,'2025-05-01 10:20:06','2025-05-01 10:20:06',NULL,NULL,NULL,NULL,NULL),
(16,8,'Images','908789','3-12-2000',NULL,'2025-05-01 17:08:14','2025-05-01 17:08:14',NULL,NULL,NULL,NULL,NULL),
(17,9,'New update','8909','3-12-2000',NULL,'2025-05-01 17:09:03','2025-05-01 17:09:03',NULL,NULL,NULL,NULL,NULL),
(18,8,'New update','8909','3-12-2000',NULL,'2025-05-01 17:09:09','2025-05-01 17:09:09',NULL,NULL,NULL,NULL,NULL),
(19,24,'Licences','890JKLTY','3-12-2000',NULL,'2025-06-25 13:35:46','2025-06-25 13:35:46',NULL,NULL,NULL,NULL,NULL),
(20,8,'Identification cards','1357875544','65/97/2355',NULL,'2025-06-25 18:39:53','2025-06-25 18:39:53',NULL,NULL,NULL,NULL,NULL),
(21,31,'Identification cards','38373819737','04/07/2025',NULL,'2025-07-04 09:39:55','2025-07-04 09:39:55',NULL,NULL,NULL,NULL,NULL),
(22,24,'Licences','890JKLTY','3-12-2000',NULL,'2025-07-07 14:44:58','2025-07-07 14:44:58',NULL,1,NULL,'upload/documents/1751899498364.jpg','upload/documents/1751899498367.jpg'),
(23,8,'Aadhar','23467907357','18/07/2025',NULL,'2025-07-08 06:33:38','2025-07-08 06:33:38',NULL,1,NULL,'upload/documents/1751956418504.jpg','upload/documents/1751956418505.jpg'),
(24,8,'Licence','135790685858686','08/07/2025',NULL,'2025-07-08 06:37:47','2025-07-08 06:37:47',NULL,2,NULL,'upload/documents/1751956667805.jpg','upload/documents/1751956667805.jpg'),
(25,8,'RC Book','1242868268580','08/07/2025',NULL,'2025-07-08 06:38:10','2025-07-08 06:38:10',NULL,4,NULL,'upload/documents/1751956690333.jpg','upload/documents/1751956690333.jpg'),
(26,8,'Vehicle','5732575888','08/07/2025',NULL,'2025-07-08 06:38:49','2025-07-08 06:38:49',NULL,3,NULL,'upload/documents/1751956729598.jpg','upload/documents/1751956729598.jpg'),
(27,31,'Aadhar','123456789','10/07/2025',NULL,'2025-07-10 06:32:37','2025-07-10 06:32:37',NULL,1,NULL,'upload/documents/1752129157803.jpg','upload/documents/1752129157809.jpg'),
(28,31,'Licence','123456789523','10/07/2025',NULL,'2025-07-10 06:32:51','2025-07-10 06:32:51',NULL,2,NULL,'upload/documents/1752129171581.jpg','upload/documents/1752129171582.jpg'),
(29,31,'Vehicle','1234567890522','10/07/2025',NULL,'2025-07-10 06:33:06','2025-07-10 06:33:06',NULL,3,NULL,'upload/documents/1752129186420.jpg','upload/documents/1752129186420.jpg'),
(30,31,'RC Book','123456789052','10/07/2025',NULL,'2025-07-10 06:33:21','2025-07-10 06:33:21',NULL,4,NULL,'upload/documents/1752129201672.jpg','upload/documents/1752129201672.jpg');

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

/*Table structure for table `insurances` */

DROP TABLE IF EXISTS `insurances`;

CREATE TABLE `insurances` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(225) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `term_condition_url` text DEFAULT NULL,
  `deleted_flag` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp(),
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `insurances` */

insert  into `insurances`(`id`,`title`,`description`,`term_condition_url`,`deleted_flag`,`created_at`,`updated_at`,`deleted_at`) values 
(1,'Insurances','Active','https://www.axismaxlife.com/term-insurance-plans/premium-calculator?utmCode=1311262&utm_theme=1Crore&utm_source=bing&utm_medium=cpc&utm_campaign=Bing_Core_Exact_19032025&utm_content=Term_Plan&utm_term=what%20is%20term%20plan%20in%20insurance',NULL,'2025-05-12 09:43:52','2025-05-12 09:43:52',NULL),
(2,'Life Insurance','Life Insurance','demo',NULL,'2025-04-22 14:53:42','2025-04-22 14:53:42',NULL),
(3,'two wheeler Isurance','two wheeler Isurance','https://www.tataaig.com/knowledge-center/two-wheeler-insurance/renew-expired-bike-insurance?msclkid=036356dc92ac19bfb2443e9ae7b2da35&utm_source=bing&utm_medium=cpc&utm_campaign={4W_Generic_TN_Top_Sales_Loc_BPE_FY25}-compare%20car%20insurance-663473478-1256743140189341-kwd-78546828610783:loc-1674&utm_content=&msclkid=036356dc92ac19bfb2443e9ae7b2da35',NULL,'2025-04-30 10:45:14','2025-04-30 10:45:14',NULL);

/*Table structure for table `notifications` */

DROP TABLE IF EXISTS `notifications`;

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  `description` text DEFAULT NULL,
  `user_otp` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `notifications` */

insert  into `notifications`(`id`,`title`,`description`,`user_otp`,`created_at`,`updated_at`,`deleted_at`) values 
(1,'OrderBooked','Your order booked. finding the driver',NULL,'2025-05-12 15:13:52','2025-05-12 16:02:56',NULL),
(2,'OtpVerified','OTP verified successfully',NULL,'2025-05-12 15:13:52','2025-05-12 16:03:01',NULL),
(3,'DriverSendOTP','Driver sent OTP for your booking ',3009,'2025-05-12 15:13:52','2025-05-14 15:05:53',NULL),
(4,'OTPLogin','OTP Login Successfully',NULL,'2025-06-07 01:23:50','2025-06-07 01:23:50',NULL),
(5,'OTPSignUp','Signup MobileNo OTP Validate',NULL,'2025-05-12 15:13:52','2025-05-12 15:13:52',NULL),
(6,'RideCompleted','Rider Completed',NULL,'2025-05-12 15:13:52','2025-05-12 15:13:52',NULL);

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
  `ride_start_date` date DEFAULT NULL,
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
  `order_status_id` int(11) DEFAULT NULL,
  `deleted_flag` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp(),
  `deleted_at` datetime DEFAULT NULL,
  `cash_type_status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=189 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `order_bookings` */

insert  into `order_bookings`(`id`,`user_id`,`user_uid`,`pickup_type_id`,`user_ride_type_id`,`pickup_latitude`,`pickup_longitude`,`pickup_location`,`ride_start_date`,`otp`,`otp_status`,`distance`,`amount`,`duration`,`drop_latitude`,`drop_longitude`,`drop_location`,`suggestion_id`,`order_status`,`order_status_id`,`deleted_flag`,`created_at`,`updated_at`,`deleted_at`,`cash_type_status`) values 
(66,22,NULL,NULL,NULL,'37.7749','-122.4194','San Francisco, CA','2025-06-25',9479,2,'100','55','16:30','34.0522','-118.2437','Los Angeles, CA',2,'In Progress',4,NULL,'2025-05-12 05:47:08','2025-05-12 05:47:08',NULL,NULL),
(68,22,NULL,NULL,NULL,'37.7749','-122.4194','TVS','2025-06-25',NULL,NULL,'150','450',NULL,'34.0522','-118.2437','Madurai',2,NULL,5,NULL,'2025-05-12 18:42:27','2025-05-12 18:42:27',NULL,NULL),
(69,22,NULL,NULL,NULL,'37.7749','-122.4194','Kk Nagar',NULL,NULL,NULL,'250','350',NULL,'34.0522','-118.2437','Erode',NULL,NULL,5,NULL,'2025-05-12 18:43:58','2025-05-12 18:43:58',NULL,NULL),
(70,22,NULL,NULL,NULL,'37.7749','-122.4194','Airport','2025-05-20',1387,2,'15','230',NULL,'34.0522','-118.2437','junction',NULL,'In Progress',4,NULL,'2025-05-12 22:23:15','2025-05-12 22:23:15',NULL,NULL),
(72,25,NULL,2,NULL,'37.7749','-122.4194','PostOffice','2025-05-20',4110,1,'10','550','16:30','34.0522','-118.2437','Mathur',2,'Completed',5,NULL,'2025-05-13 05:52:34','2025-05-13 05:52:34',NULL,1),
(73,22,NULL,NULL,NULL,'10.798217299999999','78.679850099999996','Trichy Central Bus Stand Road, Cantonment, Tiruchirappalli, Tamil Nadu, India',NULL,2736,1,'2.8','6.3','17','10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',2,'OTP Processing',3,NULL,'2025-06-09 09:03:20','2025-06-09 09:03:20',NULL,NULL),
(74,224,NULL,NULL,NULL,'10.785123900000000','78.701934399999999','Current Location',NULL,6618,1,'1.5','1.88','6','10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',1,'OTP Processing',3,NULL,'2025-06-09 13:09:38','2025-06-09 13:09:38',NULL,NULL),
(75,224,NULL,NULL,NULL,'10.785119600000000','78.701933299999993','Current Location',NULL,4145,1,'9.4','39.95','19','10.7984681','78.7515008','Kattur, Tiruchirappalli, Tamil Nadu, India',4,'OTP Processing',3,NULL,'2025-06-09 13:10:34','2025-06-09 13:10:34',NULL,NULL),
(76,25,NULL,NULL,NULL,'10.833811000000001','78.656814900000001','Thillai Nagar, Tiruchirappalli, Tamil Nadu, India',NULL,5096,2,'8.0','10','32','10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',1,'expired',6,NULL,'2025-06-09 13:30:08','2025-06-09 13:30:08',NULL,NULL),
(77,229,NULL,NULL,NULL,'10.798217299999999','78.679850099999996','Trichy Central Bus Stand Road, Cantonment, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'14.2',NULL,NULL,'10.8741789','78.7078712','Tolgate, Maruthi Nagar, Tiruchirappalli, Tamil Nadu, India',NULL,'stage_1',1,NULL,'2025-06-10 10:46:16','2025-06-10 10:46:16',NULL,NULL),
(78,231,NULL,NULL,NULL,'10.7851119','78.7017753','Current Location',NULL,NULL,NULL,'1.5',NULL,NULL,'10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,'stage_1',1,NULL,'2025-06-10 11:51:41','2025-06-10 11:51:41',NULL,NULL),
(79,231,NULL,NULL,NULL,'10.7851119','78.7017753','Current Location',NULL,NULL,NULL,'1.5',NULL,NULL,'10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,'stage_1',1,NULL,'2025-06-10 11:51:41','2025-06-10 11:51:41',NULL,NULL),
(80,231,NULL,NULL,NULL,'10.7851119','78.7017753','Current Location',NULL,NULL,NULL,'1.5',NULL,NULL,'10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,'stage_1',1,NULL,'2025-06-10 11:51:41','2025-06-10 11:51:41',NULL,NULL),
(81,231,NULL,NULL,NULL,'10.7851119','78.7017753','Current Location',NULL,NULL,NULL,'1.5',NULL,NULL,'10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,'stage_1',1,NULL,'2025-06-10 11:51:41','2025-06-10 11:51:41',NULL,NULL),
(82,231,NULL,NULL,NULL,'10.7851119','78.7017753','Current Location',NULL,9168,1,'1.5','1.88','6','10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',1,'OTP Processing',3,NULL,'2025-06-10 11:51:41','2025-06-10 11:51:41',NULL,NULL),
(83,233,NULL,NULL,NULL,'10.7851932','78.701833','Current Locations',NULL,2785,2,'9.4','21.15','56','10.7984681','78.7515008','Kattur, Tiruchirappalli, Tamil Nadu, India',2,'In Progress',4,NULL,'2025-06-12 13:01:55','2025-06-12 13:01:55',NULL,NULL),
(84,230,NULL,NULL,NULL,'10.826939100000001','78.684368899999996','Current Location',NULL,NULL,NULL,'4.2',NULL,NULL,'10.7982173','78.6798501','Trichy Central Bus Stand Road, Cantonment, Tiruchirappalli, Tamil Nadu, India',NULL,'stage_1',1,NULL,'2025-06-12 14:19:09','2025-06-12 14:19:09',NULL,NULL),
(85,230,NULL,NULL,NULL,'10.8269391','78.6843689','Current Location',NULL,1269,2,'4.2','5.25','17','10.7982173','78.6798501','Trichy Central Bus Stand Road, Cantonment, Tiruchirappalli, Tamil Nadu, India',1,'In Progress',4,NULL,'2025-06-12 14:19:09','2025-06-12 14:19:09',NULL,NULL),
(86,24,NULL,NULL,NULL,'10.790745100000001','78.662283700000003','Current Location',NULL,8281,2,'8.3','18.68','50','10.8314346','78.6933267','Chatram Bus Stand, College Road, Melachinthamani, Tiruchirappalli, Tamil Nadu, India',2,'In Progress',4,NULL,'2025-06-12 15:17:51','2025-06-12 15:17:51',NULL,NULL),
(87,234,NULL,NULL,NULL,'10.794195900000000','78.758463000000006','Current Location',NULL,9085,2,'12.1','51.42','24','10.7944275','78.6858127','TRICHY JUNCTION AC EXECUTIVE LOUNGE & WAITING HALL, Junction, Bharathiyar Salai, Endry, Tiruchirappalli, Tamil Nadu, India',4,'In Progress',4,NULL,'2025-06-25 10:24:05','2025-06-25 10:24:05',NULL,NULL),
(88,234,NULL,NULL,NULL,'10.7941959','78.758463','Current Location',NULL,NULL,NULL,'12.1',NULL,NULL,'10.7944275','78.6858127','TRICHY JUNCTION AC EXECUTIVE LOUNGE & WAITING HALL, Junction, Bharathiyar Salai, Endry, Tiruchirappalli, Tamil Nadu, India',NULL,'stage_1',1,NULL,'2025-06-25 10:24:31','2025-06-25 10:24:31',NULL,NULL),
(89,234,NULL,NULL,NULL,'10.7941959','78.758463','Current Location',NULL,NULL,NULL,'12.1',NULL,NULL,'10.7944275','78.6858127','TRICHY JUNCTION AC EXECUTIVE LOUNGE & WAITING HALL, Junction, Bharathiyar Salai, Endry, Tiruchirappalli, Tamil Nadu, India',NULL,'stage_1',1,NULL,'2025-06-25 10:25:11','2025-06-25 10:25:11',NULL,NULL),
(90,234,NULL,NULL,NULL,'10.7942018','78.75847','Current Location',NULL,NULL,NULL,'11.9',NULL,NULL,'10.7949646','78.68567329999999','Trichy Railway Junction Paid Parking, Bharathiyar Salai, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,'stage_1',1,NULL,'2025-06-25 10:31:40','2025-06-25 10:31:40',NULL,NULL),
(91,235,NULL,NULL,NULL,'10.794201599999999','78.758460700000001','Current Location',NULL,NULL,NULL,'10.5','23.63','1:3','10.8314435','78.695698','CHATHIRAM BUS STAND, College Road, Tiruchirappalli, Tamil Nadu, India',2,'Completed',5,NULL,'2025-06-25 10:32:18','2025-06-25 10:32:18',NULL,1),
(92,234,NULL,NULL,NULL,'10.7942018','78.75847','Current Location',NULL,NULL,NULL,'11.9','100',NULL,'10.7949646','78.68567329999999','Trichy Railway Junction Paid Parking, Bharathiyar Salai, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,'Completed',4,NULL,'2025-06-25 10:35:49','2025-06-25 10:35:49',NULL,1),
(93,234,NULL,NULL,NULL,'10.794205900000000','78.758466999999996','Current Location',NULL,NULL,NULL,'12.4',NULL,NULL,'10.7982173','78.6798501','Trichy Central Bus Stand Road, Cantonment, Tiruchirappalli, Tamil Nadu, India',NULL,'stage_1',1,NULL,'2025-06-25 10:46:20','2025-06-25 10:46:20',NULL,NULL),
(94,234,NULL,NULL,NULL,'10.7942059','78.758467','Current Location',NULL,NULL,NULL,'12.4','27.9','1:14','10.7982173','78.6798501','Trichy Central Bus Stand Road, Cantonment, Tiruchirappalli, Tamil Nadu, India',2,'expired',6,NULL,'2025-06-25 10:46:20','2025-06-25 10:46:20',NULL,NULL),
(95,238,NULL,NULL,NULL,'10.794198600000000','78.758470200000005','Current Location',NULL,5407,2,'9.9','22.28','59','10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',2,'Completed',5,NULL,'2025-06-25 11:27:20','2025-06-25 11:27:20',NULL,1),
(96,238,NULL,NULL,NULL,'10.794200200000001','78.758468899999997','Current Location',NULL,9645,2,'9.9','22.28','59','10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',2,'In Progress',4,NULL,'2025-06-25 11:28:01','2025-06-25 11:28:01',NULL,NULL),
(97,238,NULL,NULL,NULL,'10.794200399999999','78.758468500000006','Current Location',NULL,NULL,NULL,'10.8',NULL,NULL,'10.8314346','78.6933267','Chatram Bus Stand, College Road, Melachinthamani, Tiruchirappalli, Tamil Nadu, India',NULL,'stage_1',1,NULL,'2025-06-25 11:28:41','2025-06-25 11:28:41',NULL,NULL),
(98,238,NULL,NULL,NULL,'10.7942004','78.7584685','Current Location',NULL,8961,1,'10.8','24.3','1:5','10.8314346','78.6933267','Chatram Bus Stand, College Road, Melachinthamani, Tiruchirappalli, Tamil Nadu, India',2,'OTP Processing',3,NULL,'2025-06-25 11:28:51','2025-06-25 11:28:51',NULL,NULL),
(99,230,NULL,NULL,NULL,'10.791367100000000','78.696760400000002','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,3587,2,'5.4','12.15','32','10.8330412','78.69250149999999','Chathiram Bus Stand, Nagapattinam - Coimbatore - Gundlupet Highway, Melachinthamani, Tiruchirappalli, Tamil Nadu, India',2,'In Progress',4,NULL,'2025-06-25 11:32:37','2025-06-25 11:32:37',NULL,NULL),
(100,230,NULL,NULL,NULL,'10.799011300000000','78.680764799999992','Central Bus Terminal, Royal Road, Cantonment, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'2.7','6.08','16','10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',2,'expired',6,NULL,'2025-07-01 13:03:30','2025-07-01 13:03:30',NULL,NULL),
(101,230,NULL,NULL,NULL,'10.794427499999999','78.685812700000000','TRICHY JUNCTION AC EXECUTIVE LOUNGE & WAITING HALL, Junction, Bharathiyar Salai, Endry, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'2.6','11.05','5','10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',4,'expired',6,NULL,'2025-07-01 13:33:12','2025-07-01 13:33:12',NULL,NULL),
(102,230,NULL,NULL,NULL,'10.791367100000000','78.696760400000002','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'8.0','10','32','10.833811','78.6568149','Thillai Nagar, Tiruchirappalli, Tamil Nadu, India',1,'expired',6,NULL,'2025-07-01 16:04:00','2025-07-01 16:04:00',NULL,NULL),
(103,230,NULL,NULL,NULL,'10.791367100000000','78.696760400000002','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'35.2',NULL,NULL,'11.0380975','78.8271336','Junction, Agaram, Tiruchirappalli, Tamil Nadu, India',NULL,'stage_1',1,NULL,'2025-07-01 16:06:55','2025-07-01 16:06:55',NULL,NULL),
(104,230,NULL,NULL,NULL,'10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'35.2','79.2','3:31','11.0380975','78.8271336','Junction, Agaram, Tiruchirappalli, Tamil Nadu, India',2,'expired',6,NULL,'2025-07-01 16:06:57','2025-07-01 16:06:57',NULL,NULL),
(105,230,NULL,NULL,NULL,'10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'35.2','44','2:21','11.0380975','78.8271336','Junction, Agaram, Tiruchirappalli, Tamil Nadu, India',1,'expired',6,NULL,'2025-07-01 16:11:32','2025-07-01 16:11:32',NULL,NULL),
(106,230,NULL,NULL,NULL,'10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'35.2','79.2','3:31','11.0380975','78.8271336','Junction, Agaram, Tiruchirappalli, Tamil Nadu, India',2,'expired',6,NULL,'2025-07-01 16:12:35','2025-07-01 16:12:35',NULL,NULL),
(107,230,NULL,NULL,NULL,'10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'35.2','79.2','3:31','11.0380975','78.8271336','Junction, Agaram, Tiruchirappalli, Tamil Nadu, India',2,'expired',6,NULL,'2025-07-01 16:13:28','2025-07-01 16:13:28',NULL,NULL),
(108,230,NULL,NULL,NULL,'10.791367100000000','78.696760400000002','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'17.6',NULL,NULL,'10.9193856','78.74090749999999','Samayapuram, Tiruchirappalli, Tamil Nadu, India',NULL,'stage_1',1,NULL,'2025-07-01 16:14:37','2025-07-01 16:14:37',NULL,NULL),
(109,230,NULL,NULL,NULL,'10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'17.6','39.6','1:46','10.9193856','78.74090749999999','Samayapuram, Tiruchirappalli, Tamil Nadu, India',2,'expired',6,NULL,'2025-07-01 16:14:38','2025-07-01 16:14:38',NULL,NULL),
(110,230,NULL,NULL,NULL,'10.798217299999999','78.679850099999996','Trichy Central Bus Stand Road, Cantonment, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'2.8','9.1','8','10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',3,'expired',6,NULL,'2025-07-01 16:15:05','2025-07-01 16:15:05',NULL,NULL),
(111,230,NULL,NULL,NULL,'10.7982173','78.6798501','Trichy Central Bus Stand Road, Cantonment, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'2.8','9.1','8','10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',3,'expired',6,NULL,'2025-07-01 16:20:02','2025-07-01 16:20:02',NULL,NULL),
(112,230,NULL,NULL,NULL,'10.919385600000000','78.740907499999992','Samayapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'20.0','45','2:0','10.7944275','78.6858127','TRICHY JUNCTION AC EXECUTIVE LOUNGE & WAITING HALL, Junction, Bharathiyar Salai, Endry, Tiruchirappalli, Tamil Nadu, India',2,'expired',6,NULL,'2025-07-03 05:33:01','2025-07-03 05:33:01',NULL,NULL),
(113,230,NULL,NULL,NULL,'10.919385600000000','78.740907499999992','Samayapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'20.4','86.7','41','10.7990113','78.68076479999999','Central Bus Terminal, Royal Road, Cantonment, Tiruchirappalli, Tamil Nadu, India',4,'expired',6,NULL,'2025-07-03 05:35:32','2025-07-03 05:35:32',NULL,NULL),
(114,230,NULL,NULL,NULL,'10.9193856','78.74090749999999','Samayapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'20.4','66.3','1:1','10.7990113','78.68076479999999','Central Bus Terminal, Royal Road, Cantonment, Tiruchirappalli, Tamil Nadu, India',3,'expired',6,NULL,'2025-07-03 05:37:44','2025-07-03 05:37:44',NULL,NULL),
(115,230,NULL,NULL,NULL,'10.798217299999999','78.679850099999996','Trichy Central Bus Stand Road, Cantonment, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'2.8','3.5','11','10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',1,'expired',6,NULL,'2025-07-03 06:34:07','2025-07-03 06:34:07',NULL,NULL),
(116,230,NULL,NULL,NULL,'10.7982173','78.6798501','Trichy Central Bus Stand Road, Cantonment, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'2.8','6.3','17','10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',2,'expired',6,NULL,'2025-07-03 06:40:38','2025-07-03 06:40:38',NULL,NULL),
(118,230,NULL,NULL,NULL,'10.7982173','78.6798501','Trichy Central Bus Stand Road, Cantonment, Tiruchirappalli, Tamil Nadu, India',NULL,2214,1,'2.8','11.9','6','10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',4,'OTP Processing',3,NULL,'2025-07-03 06:44:16','2025-07-03 06:44:16',NULL,NULL),
(119,230,NULL,NULL,NULL,'10.7982173','78.6798501','Trichy Central Bus Stand Road, Cantonment, Tiruchirappalli, Tamil Nadu, India',NULL,9907,1,'2.8','3.5','11','10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',1,'OTP Processing',3,NULL,'2025-07-03 06:44:50','2025-07-03 06:44:50',NULL,NULL),
(120,230,NULL,NULL,NULL,'10.7982173','78.6798501','Trichy Central Bus Stand Road, Cantonment, Tiruchirappalli, Tamil Nadu, India',NULL,2008,1,'2.8','11.9','6','10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',4,'OTP Processing',3,NULL,'2025-07-03 06:51:05','2025-07-03 06:51:05',NULL,NULL),
(121,230,NULL,NULL,NULL,'10.855817099999999','78.701643899999993','Thiruvanaikoil trichy, Trichy Chennai Trunk Road, Srirangam, Thiruvanaikoil, Tiruchirappalli, Tamil Nadu, India',NULL,1247,1,'13.4','30.15','1:20','10.7960403','78.6842959','Junction Bus Stop, Bharathiar Salai, Bharathiyar Salai, Cantonment, Tiruchirappalli, Tamil Nadu, India',2,'OTP Processing',3,NULL,'2025-07-03 06:52:30','2025-07-03 06:52:30',NULL,NULL),
(122,230,NULL,NULL,NULL,'10.794427499999999','78.685812700000000','TRICHY JUNCTION AC EXECUTIVE LOUNGE & WAITING HALL, Junction, Bharathiyar Salai, Endry, Tiruchirappalli, Tamil Nadu, India',NULL,3652,1,'13.3','29.93','1:20','10.8558171','78.7016439','Thiruvanaikoil trichy, Trichy Chennai Trunk Road, Srirangam, Thiruvanaikoil, Tiruchirappalli, Tamil Nadu, India',2,'OTP Processing',3,NULL,'2025-07-03 06:56:27','2025-07-03 06:56:27',NULL,NULL),
(123,230,NULL,NULL,NULL,'10.833811000000001','78.656814900000001','Thillai Nagar, Tiruchirappalli, Tamil Nadu, India',NULL,6260,1,'8.0','18','48','10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',2,'OTP Processing',3,NULL,'2025-07-03 07:27:30','2025-07-03 07:27:30',NULL,NULL),
(124,230,NULL,NULL,NULL,'10.833811','78.6568149','Thillai Nagar, Tiruchirappalli, Tamil Nadu, India',NULL,7547,1,'8.0','10','32','10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',1,'OTP Processing',3,NULL,'2025-07-03 07:27:56','2025-07-03 07:27:56',NULL,NULL),
(125,230,NULL,NULL,NULL,'10.796408100000001','78.709921100000003','Senthaneerpuram, Ariyamangalam Area, Tiruchirappalli, Tamil Nadu, India',NULL,2790,1,'1.5','3.38','9','10.8089062','78.71193210000001','Maruti Suzuki TRUE VALUE (Pillai & Sons, Tiruchirappalli, Palpannai), Chennai Bypass Rd, Tharanallur, Trichy, Tamil Nadu, India',2,'OTP Processing',3,NULL,'2025-07-03 07:31:41','2025-07-03 07:31:41',NULL,NULL),
(126,230,NULL,NULL,NULL,'10.7964081','78.7099211','Senthaneerpuram, Ariyamangalam Area, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'1.5','4.88','5','10.8089062','78.71193210000001','Maruti Suzuki TRUE VALUE (Pillai & Sons, Tiruchirappalli, Palpannai), Chennai Bypass Rd, Tharanallur, Trichy, Tamil Nadu, India',3,'expired',6,NULL,'2025-07-03 07:32:54','2025-07-03 07:32:54',NULL,NULL),
(127,230,NULL,NULL,NULL,'10.862576199999999','78.691125700000001','Srirangam Temple Elephant Shelter, East Uthrai Street, Sriramapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'13.2','29.7','1:19','10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',2,'expired',6,NULL,'2025-07-03 08:22:55','2025-07-03 08:22:55',NULL,NULL),
(128,230,NULL,NULL,NULL,'10.8625762','78.6911257','Srirangam Temple Elephant Shelter, East Uthrai Street, Sriramapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'13.2','29.7','1:19','10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',2,'expired',6,NULL,'2025-07-03 08:32:12','2025-07-03 08:32:12',NULL,NULL),
(129,230,NULL,NULL,NULL,'10.791367100000000','78.696760400000002','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'1.4',NULL,NULL,'10.8012395','78.6898276','Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,'stage_1',1,NULL,'2025-07-03 08:48:05','2025-07-03 08:48:05',NULL,NULL),
(130,230,NULL,NULL,NULL,'10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,7540,2,'1.4','3.15','8','10.8012395','78.6898276','Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',2,'In Progress',4,NULL,'2025-07-03 08:48:05','2025-07-03 08:48:05',NULL,NULL),
(131,230,NULL,NULL,NULL,'10.791367100000000','78.696760400000002','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'17.6',NULL,NULL,'10.9193856','78.74090749999999','Samayapuram, Tiruchirappalli, Tamil Nadu, India',NULL,'stage_1',1,NULL,'2025-07-03 10:12:43','2025-07-03 10:12:43',NULL,NULL),
(132,230,NULL,NULL,NULL,'10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'17.6','39.6','1:46','10.9193856','78.74090749999999','Samayapuram, Tiruchirappalli, Tamil Nadu, India',2,'expired',6,NULL,'2025-07-03 10:12:43','2025-07-03 10:12:43',NULL,NULL),
(133,230,NULL,NULL,NULL,'10.791367100000000','78.696760400000002','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'3.0','6.75','18','10.8119784','78.6956962','Trichy corporation zonal office 2, Malligaipuram Thottam, Palakarai, Palakkarai, Tiruchirappalli, Tamil Nadu, India',2,'expired',6,NULL,'2025-07-04 04:44:08','2025-07-04 04:44:08',NULL,NULL),
(134,230,NULL,NULL,NULL,'10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'3.0',NULL,NULL,'10.8119784','78.6956962','Trichy corporation zonal office 2, Malligaipuram Thottam, Palakarai, Palakkarai, Tiruchirappalli, Tamil Nadu, India',NULL,'stage_1',1,NULL,'2025-07-04 04:44:09','2025-07-04 04:44:09',NULL,NULL),
(135,243,NULL,NULL,NULL,'10.823086300000000','78.669659299999992','Ramalingam nagar, Ramlinga Nagar, Woraiyur, Tiruchirappalli, Tamil Nadu, India',NULL,5953,2,'5.3','11.92','32','10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',2,'Completed',5,NULL,'2025-07-04 05:14:49','2025-07-04 05:14:49',NULL,1),
(136,243,NULL,NULL,NULL,'10.791367100000000','78.696760400000002','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'2.8','6.3','17','10.7766538','78.6889164','Khajamalai Ladies Association, KLA TRUST, near Noor Mahal Road, Pitchaiammal Nagar, Kajamalai Colony, Tiruchirappalli, Tamil Nadu, India',2,'expired',6,NULL,'2025-07-04 05:27:17','2025-07-04 05:27:17',NULL,NULL),
(137,243,NULL,NULL,NULL,'10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'2.8','6.3','17','10.7766538','78.6889164','Khajamalai Ladies Association, KLA TRUST, near Noor Mahal Road, Pitchaiammal Nagar, Kajamalai Colony, Tiruchirappalli, Tamil Nadu, India',2,'expired',6,NULL,'2025-07-04 05:33:06','2025-07-04 05:33:06',NULL,NULL),
(138,243,NULL,NULL,NULL,'10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,3315,2,'2.8','6.3','17','10.7766538','78.6889164','Khajamalai Ladies Association, KLA TRUST, near Noor Mahal Road, Pitchaiammal Nagar, Kajamalai Colony, Tiruchirappalli, Tamil Nadu, India',2,'Completed',5,NULL,'2025-07-04 05:36:40','2025-07-04 05:36:40',NULL,1),
(139,243,NULL,NULL,NULL,'10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,3794,2,'2.8','6.3','17','10.7766538','78.6889164','Khajamalai Ladies Association, KLA TRUST, near Noor Mahal Road, Pitchaiammal Nagar, Kajamalai Colony, Tiruchirappalli, Tamil Nadu, India',2,'Completed',5,NULL,'2025-07-04 05:40:30','2025-07-04 05:40:30',NULL,1),
(140,243,NULL,NULL,NULL,'10.791367100000000','78.696760400000002','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,3627,2,'8.0','18','48','10.833811','78.6568149','Thillai Nagar, Tiruchirappalli, Tamil Nadu, India',2,'Completed',5,NULL,'2025-07-04 05:43:01','2025-07-04 05:43:01',NULL,1),
(141,243,NULL,NULL,NULL,'10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'11.7',NULL,NULL,'10.8786249','78.71126','Trichy - Chennai Highway, Maruthi Nagar, Tiruchirappalli, Tamil Nadu, India',NULL,'stage_1',1,NULL,'2025-07-04 05:44:50','2025-07-04 05:44:50',NULL,NULL),
(142,243,NULL,NULL,NULL,'10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,3928,2,'11.7','26.32','1:10','10.8786249','78.71126','Trichy - Chennai Highway, Maruthi Nagar, Tiruchirappalli, Tamil Nadu, India',2,'Completed',5,NULL,'2025-07-04 05:45:20','2025-07-04 05:45:20',NULL,1),
(143,243,NULL,NULL,NULL,'10.791367100000000','78.696760400000002','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,1474,2,'8.0','18','48','10.833811','78.6568149','Thillai Nagar, Tiruchirappalli, Tamil Nadu, India',2,'Completed',5,NULL,'2025-07-04 05:51:53','2025-07-04 05:51:53',NULL,1),
(144,243,NULL,NULL,NULL,'10.796408100000001','78.709921100000003','Senthaneerpuram, Ariyamangalam Area, Tiruchirappalli, Tamil Nadu, India',NULL,5767,2,'6.3','14.17','38','10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',2,'Completed',5,NULL,'2025-07-04 05:57:27','2025-07-04 05:57:27',NULL,1),
(145,243,NULL,NULL,NULL,'10.791367100000000','78.696760400000002','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,3686,2,'8.0','18','48','10.833811','78.6568149','Thillai Nagar, Tiruchirappalli, Tamil Nadu, India',2,'Completed',5,NULL,'2025-07-04 06:06:03','2025-07-04 06:06:03',NULL,1),
(146,243,NULL,NULL,NULL,'10.791367100000000','78.696760400000002','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,9926,2,'8.0','18','48','10.833811','78.6568149','Thillai Nagar, Tiruchirappalli, Tamil Nadu, India',2,'Completed',5,NULL,'2025-07-04 06:21:21','2025-07-04 06:21:21',NULL,1),
(147,243,NULL,NULL,NULL,'10.791367100000000','78.696760400000002','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,1952,2,'8.0','18','48','10.833811','78.6568149','Thillai Nagar, Tiruchirappalli, Tamil Nadu, India',2,'In Progress',4,NULL,'2025-07-04 06:27:09','2025-07-04 06:27:09',NULL,NULL),
(148,244,NULL,NULL,NULL,'10.791367100000000','78.696760400000002','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,9580,2,'6.1','13.72','37','10.8259483','78.6782621','Trichy Book House, Devar Colony, Thillai Nagar, Tiruchirappalli, Tamil Nadu, India',2,'Completed',5,NULL,'2025-07-04 06:49:05','2025-07-04 06:49:05',NULL,1),
(149,244,NULL,NULL,NULL,'10.791367100000000','78.696760400000002','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,4362,2,'5.3','11.92','32','10.8230986','78.6696576','Ramalinga Nagar, Woraiyur, Tiruchirappalli, Tamil Nadu, India',2,'In Progress',4,NULL,'2025-07-04 06:59:54','2025-07-04 06:59:54',NULL,NULL),
(150,246,NULL,NULL,NULL,'10.929133200000001','78.737021499999997','K RAMAKRISHNAN COLLEGE OF TECHNOLOGY (KRCT), Tiruchirappalli, Tamil Nadu, India',NULL,2470,2,'18.6','41.85','1:52','10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',2,'Completed',5,NULL,'2025-07-04 07:07:39','2025-07-04 07:07:39',NULL,1),
(151,246,NULL,NULL,NULL,'10.794427499999999','78.685812700000000','TRICHY JUNCTION AC EXECUTIVE LOUNGE & WAITING HALL, Junction, Bharathiyar Salai, Endry, Tiruchirappalli, Tamil Nadu, India',NULL,8776,2,'5.2','6.5','21','10.8330412','78.69250149999999','Chathiram Bus Stand, Nagapattinam - Coimbatore - Gundlupet Highway, Melachinthamani, Tiruchirappalli, Tamil Nadu, India',1,'Completed',5,NULL,'2025-07-04 07:10:13','2025-07-04 07:10:13',NULL,1),
(152,246,NULL,NULL,NULL,'10.791367100000000','78.696760400000002','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,6262,2,'1.4','3.15','8','10.7849842','78.7019421','Ackrock Technologies private limited, Paneer Selvam Street, Subramaniyapuram, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',2,'Completed',5,NULL,'2025-07-04 07:20:07','2025-07-04 07:20:07',NULL,1),
(153,246,NULL,NULL,NULL,'10.790104100000001','78.695650499999999','TVS Toll Gate Road, NMK Colony, Ramakrishna Nagar, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,3443,2,'1.5','3.38','9','10.8012395','78.6898276','Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',2,'Completed',5,NULL,'2025-07-04 07:37:53','2025-07-04 07:37:53',NULL,1),
(154,247,NULL,NULL,NULL,'10.794427499999999','78.685812700000000','TRICHY JUNCTION AC EXECUTIVE LOUNGE & WAITING HALL, Junction, Bharathiyar Salai, Endry, Tiruchirappalli, Tamil Nadu, India',NULL,3386,2,'5.5','17.88','17','10.8307782','78.6799037','Woraiyur, Tiruchirappalli, Tamil Nadu, India',3,'Completed',5,NULL,'2025-07-04 09:36:52','2025-07-04 09:36:52',NULL,1),
(155,247,NULL,NULL,NULL,'11.038097499999999','78.827133599999996','Junction, Agaram, Tiruchirappalli, Tamil Nadu, India',NULL,3513,1,'32.2','40.25','2:9','10.8330412','78.69250149999999','Chathiram Bus Stand, Nagapattinam - Coimbatore - Gundlupet Highway, Melachinthamani, Tiruchirappalli, Tamil Nadu, India',1,'OTP Processing',3,NULL,'2025-07-04 09:45:57','2025-07-04 09:45:57',NULL,NULL),
(156,236,NULL,NULL,NULL,'10.794193000000000','78.758475700000005','digiplus ',NULL,NULL,NULL,'11.9',NULL,NULL,'10.7952138','78.6840244','Railway Junction, Bharathiyar Salai, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,'stage_1',1,NULL,'2025-07-04 10:46:59','2025-07-04 10:46:59',NULL,NULL),
(157,236,NULL,NULL,NULL,'10.862576199999999','78.691125700000001','Srirangam Temple Elephant Shelter, East Uthrai Street, Sriramapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'15.2',NULL,NULL,'10.7952138','78.6840244','Railway Junction, Bharathiyar Salai, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,'stage_1',1,NULL,'2025-07-04 10:48:28','2025-07-04 10:48:28',NULL,NULL),
(158,236,NULL,NULL,NULL,'10.8625762','78.6911257','Srirangam Temple Elephant Shelter, East Uthrai Street, Sriramapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'15.2','64.6','30','10.7952138','78.6840244','Railway Junction, Bharathiyar Salai, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',4,'expired',6,NULL,'2025-07-04 10:48:42','2025-07-04 10:48:42',NULL,NULL),
(159,236,NULL,NULL,NULL,'10.8625762','78.6911257','Srirangam Temple Elephant Shelter, East Uthrai Street, Sriramapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'15.2',NULL,NULL,'10.7952138','78.6840244','Railway Junction, Bharathiyar Salai, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,'stage_1',1,NULL,'2025-07-04 10:50:10','2025-07-04 10:50:10',NULL,NULL),
(160,249,NULL,NULL,NULL,'10.794202000000000','78.758510099999995','Current Location',NULL,NULL,NULL,'10.8','13.5','43','10.8314346','78.6933267','Chatram Bus Stand, College Road, Melachinthamani, Tiruchirappalli, Tamil Nadu, India',1,'expired',6,NULL,'2025-07-05 17:03:20','2025-07-05 17:03:20',NULL,NULL),
(161,246,NULL,NULL,NULL,'10.855417800000000','78.699572200000006','TV Kovil, Sriramapuram, Tiruchirappalli, Tamil Nadu, India',NULL,8269,2,'11.5','25.88','1:9','10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',2,'Completed',5,NULL,'2025-07-07 05:24:10','2025-07-07 05:24:10',NULL,1),
(162,246,NULL,NULL,NULL,'10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'35.2',NULL,NULL,'10.7944275','78.6858127','TRICHY JUNCTION AC EXECUTIVE LOUNGE & WAITING HALL, Junction, Bharathiyar Salai, Endry, Tiruchirappalli, Tamil Nadu, India',NULL,'stage_1',1,NULL,'2025-07-07 05:44:23','2025-07-07 05:44:23',NULL,NULL),
(163,246,NULL,NULL,NULL,'10.791367100000000','78.696760400000002','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'2.5',NULL,NULL,'10.7944275','78.6858127','TRICHY JUNCTION AC EXECUTIVE LOUNGE & WAITING HALL, Junction, Bharathiyar Salai, Endry, Tiruchirappalli, Tamil Nadu, India',NULL,'stage_1',1,NULL,'2025-07-07 05:44:23','2025-07-07 05:44:23',NULL,NULL),
(164,246,NULL,NULL,NULL,'10.791367100000000','78.696760400000002','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,9565,2,'35.2','79.2','3:31','10.7944275','78.6858127','TRICHY JUNCTION AC EXECUTIVE LOUNGE & WAITING HALL, Junction, Bharathiyar Salai, Endry, Tiruchirappalli, Tamil Nadu, India',2,'Completed',5,NULL,'2025-07-07 05:44:24','2025-07-07 05:44:24',NULL,1),
(165,246,NULL,NULL,NULL,'10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,1364,2,'2.5','5.63','15','10.7944275','78.6858127','TRICHY JUNCTION AC EXECUTIVE LOUNGE & WAITING HALL, Junction, Bharathiyar Salai, Endry, Tiruchirappalli, Tamil Nadu, India',2,'Completed',5,NULL,'2025-07-07 05:46:25','2025-07-07 05:46:25',NULL,1),
(166,246,NULL,NULL,NULL,'10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'29.9',NULL,NULL,'11.0139624','78.7943616','M.A.M. College of Education, Trichy - Chennai Trunk Road, Siruganur, Tiruchirappalli, Tamil Nadu, India',NULL,'stage_1',1,NULL,'2025-07-07 06:53:35','2025-07-07 06:53:35',NULL,NULL),
(167,246,NULL,NULL,NULL,'10.791367100000000','78.696760400000002','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'29.9',NULL,NULL,'11.0139624','78.7943616','M.A.M. College of Education, Trichy - Chennai Trunk Road, Siruganur, Tiruchirappalli, Tamil Nadu, India',NULL,'stage_1',1,NULL,'2025-07-07 06:53:36','2025-07-07 06:53:36',NULL,NULL),
(168,246,NULL,NULL,NULL,'10.791367100000000','78.696760400000002','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'29.9',NULL,NULL,'11.0139624','78.7943616','M.A.M. College of Education, Trichy - Chennai Trunk Road, Siruganur, Tiruchirappalli, Tamil Nadu, India',NULL,'stage_1',1,NULL,'2025-07-07 06:53:37','2025-07-07 06:53:37',NULL,NULL),
(169,246,NULL,NULL,NULL,'10.791367100000000','78.696760400000002','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'29.9',NULL,NULL,'11.0139624','78.7943616','M.A.M. College of Education, Trichy - Chennai Trunk Road, Siruganur, Tiruchirappalli, Tamil Nadu, India',NULL,'stage_1',1,NULL,'2025-07-07 06:53:37','2025-07-07 06:53:37',NULL,NULL),
(170,246,NULL,NULL,NULL,'10.791367100000000','78.696760400000002','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,6826,2,'29.9','67.27','2:59','11.0139624','78.7943616','M.A.M. College of Education, Trichy - Chennai Trunk Road, Siruganur, Tiruchirappalli, Tamil Nadu, India',2,'Completed',5,NULL,'2025-07-07 06:53:52','2025-07-07 06:53:52',NULL,1),
(171,246,NULL,NULL,NULL,'10.791367100000000','78.696760400000002','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,4542,2,'21.9','49.27','2:11','10.9302246','78.7464908','DHANALAKSHMI SRINIVASAN UNIVERSITY, Trichy Chennai Trunk Road, Samayapuram, Tiruchirappalli, Tamil Nadu, India',2,'Completed',5,NULL,'2025-07-07 06:59:13','2025-07-07 06:59:13',NULL,1),
(172,246,NULL,NULL,NULL,'10.791367100000000','78.696760400000002','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'35.2',NULL,NULL,'11.0380975','78.8271336','Junction, Agaram, Tiruchirappalli, Tamil Nadu, India',NULL,'stage_1',1,NULL,'2025-07-07 07:04:18','2025-07-07 07:04:18',NULL,NULL),
(173,246,NULL,NULL,NULL,'10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'2.5',NULL,NULL,'10.7944275','78.6858127','TRICHY JUNCTION AC EXECUTIVE LOUNGE & WAITING HALL, Junction, Bharathiyar Salai, Endry, Tiruchirappalli, Tamil Nadu, India',NULL,'stage_1',1,NULL,'2025-07-07 07:06:45','2025-07-07 07:06:45',NULL,NULL),
(174,246,NULL,NULL,NULL,'10.791367100000000','78.696760400000002','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'2.5',NULL,NULL,'10.7944275','78.6858127','TRICHY JUNCTION AC EXECUTIVE LOUNGE & WAITING HALL, Junction, Bharathiyar Salai, Endry, Tiruchirappalli, Tamil Nadu, India',NULL,'stage_1',1,NULL,'2025-07-07 07:06:45','2025-07-07 07:06:45',NULL,NULL),
(175,246,NULL,NULL,NULL,'10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'2.5',NULL,NULL,'10.7944275','78.6858127','TRICHY JUNCTION AC EXECUTIVE LOUNGE & WAITING HALL, Junction, Bharathiyar Salai, Endry, Tiruchirappalli, Tamil Nadu, India',NULL,'stage_1',1,NULL,'2025-07-07 07:06:45','2025-07-07 07:06:45',NULL,NULL),
(176,246,NULL,NULL,NULL,'10.791367100000000','78.696760400000002','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,6595,2,'2.5','5.63','15','10.7944275','78.6858127','TRICHY JUNCTION AC EXECUTIVE LOUNGE & WAITING HALL, Junction, Bharathiyar Salai, Endry, Tiruchirappalli, Tamil Nadu, India',2,'Completed',5,NULL,'2025-07-07 07:06:46','2025-07-07 07:06:46',NULL,1),
(177,246,NULL,NULL,NULL,'10.791367100000000','78.696760400000002','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,3787,2,'2.5','5.63','15','10.7944275','78.6858127','TRICHY JUNCTION AC EXECUTIVE LOUNGE & WAITING HALL, Junction, Bharathiyar Salai, Endry, Tiruchirappalli, Tamil Nadu, India',2,'Completed',5,NULL,'2025-07-07 07:46:24','2025-07-07 07:46:24',NULL,1),
(178,246,NULL,NULL,NULL,'10.798217299999999','78.679850099999996','Trichy Central Bus Stand Road, Cantonment, Tiruchirappalli, Tamil Nadu, India',NULL,5074,2,'2.8','6.3','17','10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',2,'Completed',5,NULL,'2025-07-07 10:08:41','2025-07-07 10:08:41',NULL,1),
(179,246,NULL,NULL,NULL,'10.673801200000000','78.544101699999999','Inamkulathur Road, Kalkudi, Tiruchirappalli, Tamil Nadu, India',NULL,3944,2,'28.5','64.13','2:51','10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',2,'Completed',5,NULL,'2025-07-08 06:58:36','2025-07-08 06:58:36',NULL,1),
(180,246,NULL,NULL,NULL,'10.791367100000000','78.696760400000002','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,1546,1,'35.2','79.2','3:31','11.0380975','78.8271336','Junction, Agaram, Tiruchirappalli, Tamil Nadu, India',2,'OTP Processing',3,NULL,'2025-07-11 05:44:54','2025-07-11 05:44:54',NULL,NULL),
(181,246,NULL,NULL,NULL,'10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,8486,2,'35.2','79.2','3:31','11.0380975','78.8271336','Junction, Agaram, Tiruchirappalli, Tamil Nadu, India',2,'Completed',5,NULL,'2025-07-11 05:45:41','2025-07-11 05:45:41',NULL,1),
(182,246,NULL,NULL,NULL,'10.791367100000000','78.696760400000002','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,NULL,NULL,'8.0',NULL,NULL,'10.833811','78.6568149','Thillai Nagar, Tiruchirappalli, Tamil Nadu, India',NULL,'stage_1',1,NULL,'2025-07-11 05:57:23','2025-07-11 05:57:23',NULL,NULL),
(183,246,NULL,NULL,NULL,'10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,5360,2,'8.0','18','48','10.833811','78.6568149','Thillai Nagar, Tiruchirappalli, Tamil Nadu, India',2,'Completed',5,NULL,'2025-07-11 05:57:23','2025-07-11 05:57:23',NULL,1),
(184,246,NULL,NULL,NULL,'10.791367100000000','78.696760400000002','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,3295,2,'8.0','18','48','10.833811','78.6568149','Thillai Nagar, Tiruchirappalli, Tamil Nadu, India',2,'Completed',5,NULL,'2025-07-11 06:00:31','2025-07-11 06:00:31',NULL,1),
(185,246,NULL,NULL,NULL,'10.776653800000000','78.688916399999997','Khajamalai Ladies Association, KLA TRUST, near Noor Mahal Road, Pitchaiammal Nagar, Kajamalai Colony, Tiruchirappalli, Tamil Nadu, India',NULL,1051,2,'37.2','83.7','3:43','11.0380975','78.8271336','Junction, Agaram, Tiruchirappalli, Tamil Nadu, India',2,'Completed',5,NULL,'2025-07-11 06:08:31','2025-07-11 06:08:31',NULL,1),
(186,246,NULL,NULL,NULL,'10.791367100000000','78.696760400000002','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,4059,2,'1.4','3.15','8','10.8012395','78.6898276','Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',2,'In Progress',4,NULL,'2025-07-11 06:15:26','2025-07-11 06:15:26',NULL,NULL),
(187,246,NULL,NULL,NULL,'10.791367100000000','78.696760400000002','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',NULL,2858,2,'24.8','55.8','2:29','10.8711566','78.8197036','Lalgudi, Tiruchirappalli, Tamil Nadu, India',2,'Completed',5,NULL,'2025-07-11 06:19:21','2025-07-11 06:19:21',NULL,1),
(188,246,NULL,NULL,NULL,'10.833811000000001','78.656814900000001','Thillai Nagar, Tiruchirappalli, Tamil Nadu, India',NULL,4432,2,'8.0','18','48','10.7913671','78.6967604','TVS Tolgate, Hanifa Colony, Sangillyandapuram, Tiruchirappalli, Tamil Nadu, India',2,'Completed',5,NULL,'2025-07-11 11:59:16','2025-07-11 11:59:16',NULL,1);

/*Table structure for table `order_histories` */

DROP TABLE IF EXISTS `order_histories`;

CREATE TABLE `order_histories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `ride_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp(),
  `deleted_at` datetime DEFAULT NULL,
  `started_date` date DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  `reviews` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `order_histories` */

insert  into `order_histories`(`id`,`user_id`,`order_id`,`ride_id`,`created_at`,`updated_at`,`deleted_at`,`started_date`,`rating`,`reviews`) values 
(4,22,66,8,'2025-05-12 08:53:04','2025-05-12 08:53:04',NULL,'2025-06-08',1,'Good'),
(5,22,66,8,'2025-05-12 08:53:34','2025-05-12 08:53:34',NULL,NULL,1,'Good'),
(6,22,73,8,'2025-05-12 14:28:53','2025-05-12 14:28:53',NULL,NULL,1,'Good'),
(7,22,66,NULL,'2025-05-12 14:59:56','2025-05-12 14:59:56',NULL,NULL,NULL,NULL),
(8,22,66,NULL,'2025-05-12 15:00:19','2025-05-12 15:00:19',NULL,NULL,NULL,NULL),
(9,22,66,NULL,'2025-05-12 17:01:00','2025-05-12 17:01:00',NULL,NULL,NULL,NULL),
(10,22,66,NULL,'2025-05-12 17:02:54','2025-05-12 17:02:54',NULL,NULL,NULL,NULL),
(11,22,66,NULL,'2025-05-12 17:03:28','2025-05-12 17:03:28',NULL,NULL,NULL,NULL),
(12,22,66,8,'2025-05-12 17:08:10','2025-05-12 17:08:10',NULL,NULL,1,'Good'),
(13,22,66,NULL,'2025-05-12 17:22:03','2025-05-12 17:22:03',NULL,NULL,NULL,NULL),
(14,22,66,NULL,'2025-05-12 17:22:12','2025-05-12 17:22:12',NULL,NULL,NULL,NULL),
(15,22,66,NULL,'2025-05-12 17:22:25','2025-05-12 17:22:25',NULL,NULL,NULL,NULL),
(16,22,66,NULL,'2025-05-12 17:22:32','2025-05-12 17:22:32',NULL,NULL,NULL,NULL),
(17,22,66,NULL,'2025-05-12 17:22:59','2025-05-12 17:22:59',NULL,NULL,NULL,NULL),
(18,22,66,NULL,'2025-05-12 17:23:59','2025-05-12 17:23:59',NULL,NULL,NULL,NULL),
(19,22,66,NULL,'2025-05-12 17:25:14','2025-05-12 17:25:14',NULL,NULL,NULL,NULL),
(20,22,66,NULL,'2025-05-12 17:25:58','2025-05-12 17:25:58',NULL,NULL,NULL,NULL),
(21,22,66,NULL,'2025-05-12 17:26:05','2025-05-12 17:26:05',NULL,NULL,NULL,NULL),
(22,22,66,NULL,'2025-05-12 17:27:37','2025-05-12 17:27:37',NULL,NULL,NULL,NULL),
(23,22,66,NULL,'2025-05-12 17:32:18','2025-05-12 17:32:18',NULL,NULL,NULL,NULL),
(24,22,66,NULL,'2025-05-13 05:45:50','2025-05-13 05:45:50',NULL,NULL,NULL,NULL),
(25,25,71,8,'2025-05-13 05:51:50','2025-05-13 05:51:50',NULL,NULL,NULL,NULL),
(26,25,72,8,'2025-05-13 05:53:54','2025-05-13 05:53:54',NULL,NULL,NULL,NULL),
(27,233,83,NULL,'2025-06-12 13:02:23','2025-06-12 13:02:23',NULL,NULL,NULL,NULL),
(28,230,99,NULL,'2025-06-25 11:39:40','2025-06-25 11:39:40',NULL,NULL,NULL,NULL),
(29,22,70,NULL,'2025-06-30 13:43:37','2025-06-30 13:43:37',NULL,NULL,NULL,NULL),
(30,25,76,NULL,'2025-06-30 13:58:04','2025-06-30 13:58:04',NULL,NULL,NULL,NULL),
(31,25,76,NULL,'2025-06-30 14:04:12','2025-06-30 14:04:12',NULL,NULL,NULL,NULL),
(32,25,76,NULL,'2025-06-30 14:10:36','2025-06-30 14:10:36',NULL,NULL,NULL,NULL),
(33,25,76,NULL,'2025-06-30 14:12:43','2025-06-30 14:12:43',NULL,NULL,NULL,NULL),
(34,25,76,NULL,'2025-06-30 14:13:50','2025-06-30 14:13:50',NULL,NULL,NULL,NULL),
(35,25,76,NULL,'2025-06-30 14:14:16','2025-06-30 14:14:16',NULL,NULL,NULL,NULL),
(36,238,96,NULL,'2025-06-30 16:59:36','2025-06-30 16:59:36',NULL,NULL,NULL,NULL),
(37,230,85,NULL,'2025-06-30 17:09:49','2025-06-30 17:09:49',NULL,NULL,NULL,NULL),
(38,230,85,NULL,'2025-06-30 17:14:03','2025-06-30 17:14:03',NULL,NULL,NULL,NULL),
(39,230,85,NULL,'2025-06-30 17:14:30','2025-06-30 17:14:30',NULL,NULL,NULL,NULL),
(40,230,85,NULL,'2025-06-30 17:18:13','2025-06-30 17:18:13',NULL,NULL,NULL,NULL),
(41,24,86,NULL,'2025-06-30 17:22:41','2025-06-30 17:22:41',NULL,NULL,NULL,NULL),
(42,234,87,NULL,'2025-06-30 17:50:08','2025-06-30 17:50:08',NULL,NULL,NULL,NULL),
(43,238,95,NULL,'2025-06-30 17:52:12','2025-06-30 17:52:12',NULL,NULL,NULL,NULL),
(44,238,95,NULL,'2025-06-30 17:52:13','2025-06-30 17:52:13',NULL,NULL,NULL,NULL),
(45,238,95,NULL,'2025-06-30 17:59:06','2025-06-30 17:59:06',NULL,NULL,NULL,NULL),
(46,238,98,98,'2025-07-03 06:31:43','2025-07-03 06:31:43',NULL,NULL,NULL,NULL),
(47,230,119,119,'2025-07-03 06:45:41','2025-07-03 06:45:41',NULL,NULL,NULL,NULL),
(48,230,117,117,'2025-07-03 06:47:02','2025-07-03 06:47:02',NULL,NULL,NULL,NULL),
(49,230,117,8,'2025-07-03 06:50:06','2025-07-03 06:50:06',NULL,NULL,NULL,NULL),
(50,230,118,8,'2025-07-03 06:50:35','2025-07-03 06:50:35',NULL,NULL,NULL,NULL),
(51,230,120,8,'2025-07-03 06:51:32','2025-07-03 06:51:32',NULL,NULL,NULL,NULL),
(52,230,121,8,'2025-07-03 06:52:55','2025-07-03 06:52:55',NULL,NULL,NULL,NULL),
(53,230,122,8,'2025-07-03 06:56:42','2025-07-03 06:56:42',NULL,NULL,NULL,NULL),
(54,230,123,8,'2025-07-03 07:27:44','2025-07-03 07:27:44',NULL,NULL,NULL,NULL),
(55,230,125,8,'2025-07-03 07:32:37','2025-07-03 07:32:37',NULL,NULL,NULL,NULL),
(56,230,130,8,'2025-07-03 08:52:26','2025-07-03 08:52:26',NULL,NULL,NULL,NULL),
(57,230,130,NULL,'2025-07-03 08:52:36','2025-07-03 08:52:36',NULL,NULL,NULL,NULL),
(58,243,135,31,'2025-07-04 05:15:12','2025-07-04 05:15:12',NULL,NULL,NULL,NULL),
(59,243,135,NULL,'2025-07-04 05:34:37','2025-07-04 05:34:37',NULL,NULL,NULL,NULL),
(60,243,138,31,'2025-07-04 05:37:24','2025-07-04 05:37:24',NULL,NULL,NULL,NULL),
(61,243,138,NULL,'2025-07-04 05:38:23','2025-07-04 05:38:23',NULL,NULL,NULL,NULL),
(62,243,139,31,'2025-07-04 05:40:55','2025-07-04 05:40:55',NULL,NULL,NULL,NULL),
(63,243,139,NULL,'2025-07-04 05:41:11','2025-07-04 05:41:11',NULL,NULL,NULL,NULL),
(64,243,140,31,'2025-07-04 05:43:12','2025-07-04 05:43:12',NULL,NULL,NULL,NULL),
(65,243,140,NULL,'2025-07-04 05:43:34','2025-07-04 05:43:34',NULL,NULL,NULL,NULL),
(66,243,142,31,'2025-07-04 05:45:48','2025-07-04 05:45:48',NULL,NULL,NULL,NULL),
(67,243,142,NULL,'2025-07-04 05:46:35','2025-07-04 05:46:35',NULL,NULL,NULL,NULL),
(68,243,143,31,'2025-07-04 05:52:28','2025-07-04 05:52:28',NULL,NULL,NULL,NULL),
(69,243,143,NULL,'2025-07-04 05:52:40','2025-07-04 05:52:40',NULL,NULL,NULL,NULL),
(70,243,144,31,'2025-07-04 05:57:38','2025-07-04 05:57:38',NULL,NULL,NULL,NULL),
(71,243,144,NULL,'2025-07-04 05:57:49','2025-07-04 05:57:49',NULL,NULL,NULL,NULL),
(72,243,145,31,'2025-07-04 06:06:15','2025-07-04 06:06:15',NULL,NULL,NULL,NULL),
(73,243,145,NULL,'2025-07-04 06:06:30','2025-07-04 06:06:30',NULL,NULL,NULL,NULL),
(74,243,146,31,'2025-07-04 06:21:36','2025-07-04 06:21:36',NULL,NULL,NULL,NULL),
(75,243,146,NULL,'2025-07-04 06:21:54','2025-07-04 06:21:54',NULL,NULL,NULL,NULL),
(76,243,147,31,'2025-07-04 06:27:40','2025-07-04 06:27:40',NULL,NULL,NULL,NULL),
(77,243,147,NULL,'2025-07-04 06:29:09','2025-07-04 06:29:09',NULL,NULL,NULL,NULL),
(78,244,148,31,'2025-07-04 06:49:29','2025-07-04 06:49:29',NULL,NULL,NULL,NULL),
(79,244,148,NULL,'2025-07-04 06:49:49','2025-07-04 06:49:49',NULL,NULL,NULL,NULL),
(80,244,149,31,'2025-07-04 07:00:07','2025-07-04 07:00:07',NULL,NULL,4,'good'),
(81,244,149,NULL,'2025-07-04 07:00:21','2025-07-04 07:00:21',NULL,NULL,NULL,NULL),
(82,246,150,31,'2025-07-04 07:08:05','2025-07-04 07:08:05',NULL,NULL,4,'good'),
(83,246,150,NULL,'2025-07-04 07:08:18','2025-07-04 07:08:18',NULL,NULL,NULL,NULL),
(84,246,151,31,'2025-07-04 07:10:36','2025-07-04 07:10:36',NULL,NULL,5,'hhbshs'),
(85,246,151,NULL,'2025-07-04 07:10:56','2025-07-04 07:10:56',NULL,NULL,NULL,NULL),
(86,246,152,31,'2025-07-04 07:20:21','2025-07-04 07:20:21',NULL,NULL,4,'work done '),
(87,246,152,NULL,'2025-07-04 07:20:38','2025-07-04 07:20:38',NULL,NULL,NULL,NULL),
(88,246,153,31,'2025-07-04 07:38:19','2025-07-04 07:38:19',NULL,NULL,3,'good'),
(89,246,153,31,'2025-07-04 07:38:19','2025-07-04 07:38:19',NULL,NULL,3,'good'),
(90,246,153,NULL,'2025-07-04 07:38:47','2025-07-04 07:38:47',NULL,NULL,NULL,NULL),
(91,247,154,31,'2025-07-04 09:37:00','2025-07-04 09:37:00',NULL,NULL,5,'testing '),
(92,247,154,NULL,'2025-07-04 09:37:12','2025-07-04 09:37:12',NULL,NULL,NULL,NULL),
(93,247,155,31,'2025-07-04 09:47:04','2025-07-04 09:47:04',NULL,NULL,NULL,NULL),
(94,247,155,31,'2025-07-04 09:47:47','2025-07-04 09:47:47',NULL,NULL,NULL,NULL),
(95,247,155,31,'2025-07-04 09:49:38','2025-07-04 09:49:38',NULL,NULL,NULL,NULL),
(96,230,124,32,'2025-07-04 10:49:08','2025-07-04 10:49:08',NULL,NULL,NULL,NULL),
(97,246,161,31,'2025-07-07 05:25:09','2025-07-07 05:25:09',NULL,NULL,4,'gdih'),
(98,246,161,NULL,'2025-07-07 05:25:38','2025-07-07 05:25:38',NULL,NULL,NULL,NULL),
(99,246,164,31,'2025-07-07 05:44:37','2025-07-07 05:44:37',NULL,NULL,NULL,NULL),
(100,246,164,31,'2025-07-07 05:44:37','2025-07-07 05:44:37',NULL,NULL,NULL,NULL),
(101,246,164,NULL,'2025-07-07 05:44:49','2025-07-07 05:44:49',NULL,NULL,NULL,NULL),
(102,246,165,31,'2025-07-07 05:46:37','2025-07-07 05:46:37',NULL,NULL,NULL,NULL),
(103,246,165,NULL,'2025-07-07 05:47:07','2025-07-07 05:47:07',NULL,NULL,NULL,NULL),
(104,246,170,31,'2025-07-07 06:54:27','2025-07-07 06:54:27',NULL,NULL,3,'Good \n'),
(105,246,170,31,'2025-07-07 06:54:30','2025-07-07 06:54:30',NULL,NULL,3,'Good \n'),
(106,246,170,NULL,'2025-07-07 06:55:40','2025-07-07 06:55:40',NULL,NULL,NULL,NULL),
(107,246,171,31,'2025-07-07 06:59:32','2025-07-07 06:59:32',NULL,NULL,NULL,NULL),
(108,246,171,NULL,'2025-07-07 06:59:47','2025-07-07 06:59:47',NULL,NULL,NULL,NULL),
(109,246,176,13,'2025-07-07 07:06:56','2025-07-07 07:06:56',NULL,NULL,4,'good '),
(110,246,176,NULL,'2025-07-07 07:07:06','2025-07-07 07:07:06',NULL,NULL,NULL,NULL),
(111,246,177,13,'2025-07-07 07:46:36','2025-07-07 07:46:36',NULL,NULL,NULL,NULL),
(112,246,177,NULL,'2025-07-07 07:46:46','2025-07-07 07:46:46',NULL,NULL,NULL,NULL),
(113,246,178,31,'2025-07-07 10:09:13','2025-07-07 10:09:13',NULL,NULL,NULL,NULL),
(114,246,178,NULL,'2025-07-07 10:09:22','2025-07-07 10:09:22',NULL,NULL,NULL,NULL),
(115,246,179,31,'2025-07-08 06:58:55','2025-07-08 06:58:55',NULL,NULL,NULL,NULL),
(116,246,179,NULL,'2025-07-08 06:59:05','2025-07-08 06:59:05',NULL,NULL,NULL,NULL),
(117,246,181,31,'2025-07-11 05:47:01','2025-07-11 05:47:01',NULL,NULL,NULL,NULL),
(118,246,181,NULL,'2025-07-11 05:47:16','2025-07-11 05:47:16',NULL,NULL,NULL,NULL),
(119,246,183,31,'2025-07-11 05:57:33','2025-07-11 05:57:33',NULL,NULL,4,'cjhcjvhv'),
(120,246,183,NULL,'2025-07-11 05:58:20','2025-07-11 05:58:20',NULL,NULL,NULL,NULL),
(121,246,184,31,'2025-07-11 06:00:41','2025-07-11 06:00:41',NULL,NULL,3,'hog'),
(122,246,184,NULL,'2025-07-11 06:00:52','2025-07-11 06:00:52',NULL,NULL,NULL,NULL),
(123,246,185,31,'2025-07-11 06:08:49','2025-07-11 06:08:49',NULL,NULL,4,'hkhi'),
(124,246,185,NULL,'2025-07-11 06:09:04','2025-07-11 06:09:04',NULL,NULL,NULL,NULL),
(125,246,186,31,'2025-07-11 06:15:36','2025-07-11 06:15:36',NULL,NULL,NULL,NULL),
(126,246,186,NULL,'2025-07-11 06:15:51','2025-07-11 06:15:51',NULL,NULL,NULL,NULL),
(127,246,187,31,'2025-07-11 06:19:30','2025-07-11 06:19:30',NULL,NULL,5,'ibiiyh'),
(128,246,187,NULL,'2025-07-11 06:19:42','2025-07-11 06:19:42',NULL,NULL,NULL,NULL),
(129,246,188,31,'2025-07-11 11:59:29','2025-07-11 11:59:29',NULL,NULL,NULL,NULL),
(130,246,188,NULL,'2025-07-11 11:59:44','2025-07-11 11:59:44',NULL,NULL,NULL,NULL),
(131,246,180,31,'2025-07-11 12:15:57','2025-07-11 12:15:57',NULL,NULL,NULL,NULL),
(132,246,180,31,'2025-07-11 12:18:37','2025-07-11 12:18:37',NULL,NULL,NULL,NULL);

/*Table structure for table `order_reviews` */

DROP TABLE IF EXISTS `order_reviews`;

CREATE TABLE `order_reviews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `ride_id` int(11) DEFAULT NULL,
  `review_type_status` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `order_reviews` */

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `pricing_rules` */

insert  into `pricing_rules`(`id`,`suggestion_id`,`base_price`,`price_per_km`,`per_kilometer_time`,`price_per_minute`,`minimum_fare`,`cancellation_fee`,`platform_fee`,`max_wait_time`,`created_at`,`updated_at`,`deleted_flag`,`deleted_at`) values 
(3,1,'2.50','1.25','4','0.35','5.00','3.00','1.50','5','2025-05-07 14:08:10','2025-05-07 14:08:10',NULL,NULL),
(4,2,NULL,'2.25','6',NULL,NULL,NULL,NULL,NULL,'2025-05-09 18:46:48','2025-05-09 18:46:48',NULL,NULL),
(5,3,NULL,'3.25','3',NULL,NULL,NULL,NULL,NULL,'2025-05-09 18:46:55','2025-05-09 18:46:55',NULL,NULL),
(6,4,NULL,'4.25','2',NULL,NULL,NULL,NULL,NULL,'2025-05-09 18:47:06','2025-05-09 18:47:06',NULL,NULL);

/*Table structure for table `review_user_change_log` */

DROP TABLE IF EXISTS `review_user_change_log`;

CREATE TABLE `review_user_change_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `table_name` varchar(255) DEFAULT NULL,
  `action_type` enum('INSERT','UPDATE','DELETE') DEFAULT NULL,
  `record_id` int(11) DEFAULT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`payload`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `review_user_change_log` */

/*Table structure for table `ride_details` */

DROP TABLE IF EXISTS `ride_details`;

CREATE TABLE `ride_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ride_id` int(11) DEFAULT NULL,
  `ride_uid` varchar(255) DEFAULT NULL,
  `total_ride` varchar(255) DEFAULT NULL,
  `total_hours` varchar(255) DEFAULT '00:00',
  `total_kilometer` varchar(255) DEFAULT NULL,
  `rating` varchar(255) DEFAULT NULL,
  `earning` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_flag` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `ride_details` */

insert  into `ride_details`(`id`,`ride_id`,`ride_uid`,`total_ride`,`total_hours`,`total_kilometer`,`rating`,`earning`,`created_at`,`updated_at`,`deleted_at`,`deleted_flag`) values 
(1,22,'2664','1','10','100','5','100','2025-05-06 13:26:23','2025-05-06 13:26:23',NULL,NULL),
(2,NULL,'333','1','10','100','5','555','2025-05-06 13:33:54','2025-05-06 13:33:54',NULL,NULL),
(4,8,NULL,'2','16:30','110',NULL,'605','2025-05-12 11:31:54','2025-05-12 11:31:54',NULL,NULL),
(5,13,NULL,NULL,'00:00',NULL,NULL,NULL,'2025-05-13 16:44:14','2025-05-13 16:44:14',NULL,NULL),
(6,31,NULL,'3','NaN:NaN','68',NULL,'153','2025-07-11 05:49:13','2025-07-11 05:49:13',NULL,NULL);

/*Table structure for table `rider_notifications` */

DROP TABLE IF EXISTS `rider_notifications`;

CREATE TABLE `rider_notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rider_id` int(11) NOT NULL,
  `notification_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL,
  `rider_otp` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `rider_notifications` */

insert  into `rider_notifications`(`id`,`rider_id`,`notification_id`,`created_at`,`updated_at`,`deleted_at`,`rider_otp`) values 
(1,8,4,'2025-06-09 15:39:31','2025-06-09 15:39:31',NULL,4105),
(2,8,4,'2025-06-10 03:53:55','2025-06-10 03:53:55',NULL,2609),
(3,8,4,'2025-06-10 03:54:45','2025-06-10 03:54:45',NULL,6487),
(4,8,4,'2025-06-10 04:13:27','2025-06-10 04:13:27',NULL,6535),
(5,8,4,'2025-06-10 04:14:40','2025-06-10 04:14:40',NULL,9705),
(6,8,4,'2025-06-10 04:17:54','2025-06-10 04:17:54',NULL,5865),
(7,8,4,'2025-06-10 04:19:13','2025-06-10 04:19:13',NULL,1718),
(8,8,4,'2025-06-10 05:36:27','2025-06-10 05:36:27',NULL,6611),
(9,8,4,'2025-06-10 05:38:58','2025-06-10 05:38:58',NULL,4002),
(10,8,4,'2025-06-10 05:40:58','2025-06-10 05:40:58',NULL,6373),
(11,8,4,'2025-06-10 05:41:07','2025-06-10 05:41:07',NULL,6010),
(12,8,4,'2025-06-10 05:42:01','2025-06-10 05:42:01',NULL,1246),
(13,8,4,'2025-06-10 05:43:13','2025-06-10 05:43:13',NULL,3810),
(14,8,4,'2025-06-10 05:44:17','2025-06-10 05:44:17',NULL,1303),
(15,8,4,'2025-06-10 05:45:57','2025-06-10 05:45:57',NULL,2084),
(16,8,4,'2025-06-10 05:47:21','2025-06-10 05:47:21',NULL,6802),
(17,8,4,'2025-06-10 06:03:21','2025-06-10 06:03:21',NULL,8943),
(18,8,4,'2025-06-10 06:03:21','2025-06-10 06:03:21',NULL,5210),
(19,23,4,'2025-06-25 10:20:52','2025-06-25 10:20:52',NULL,6097),
(20,23,4,'2025-06-25 10:26:08','2025-06-25 10:26:08',NULL,9692),
(21,23,4,'2025-06-25 10:41:58','2025-06-25 10:41:58',NULL,2882),
(22,19,4,'2025-06-25 11:09:49','2025-06-25 11:09:49',NULL,6041),
(23,15,6,'2025-06-30 15:12:12','2025-06-30 15:12:12',NULL,NULL),
(24,15,6,'2025-06-30 17:50:20','2025-06-30 17:50:20',NULL,NULL),
(25,13,6,'2025-06-30 17:59:17','2025-06-30 17:59:17',NULL,NULL),
(26,31,4,'2025-07-04 05:10:18','2025-07-04 05:10:18',NULL,5555),
(27,31,6,'2025-07-04 05:37:13','2025-07-04 05:37:13',NULL,NULL),
(28,31,6,'2025-07-04 05:40:45','2025-07-04 05:40:45',NULL,NULL),
(29,31,6,'2025-07-04 05:42:33','2025-07-04 05:42:33',NULL,NULL),
(30,31,6,'2025-07-04 05:44:57','2025-07-04 05:44:57',NULL,NULL),
(31,31,6,'2025-07-04 05:52:14','2025-07-04 05:52:14',NULL,NULL),
(32,31,6,'2025-07-04 05:56:31','2025-07-04 05:56:31',NULL,NULL),
(33,31,6,'2025-07-04 06:05:43','2025-07-04 06:05:43',NULL,NULL),
(34,31,6,'2025-07-04 06:21:26','2025-07-04 06:21:26',NULL,NULL),
(35,31,6,'2025-07-04 06:27:26','2025-07-04 06:27:26',NULL,NULL),
(36,31,6,'2025-07-04 06:50:17','2025-07-04 06:50:17',NULL,NULL),
(37,31,6,'2025-07-04 07:08:45','2025-07-04 07:08:45',NULL,NULL),
(38,31,6,'2025-07-04 07:11:36','2025-07-04 07:11:36',NULL,NULL),
(39,31,6,'2025-07-04 07:21:08','2025-07-04 07:21:08',NULL,NULL),
(40,31,6,'2025-07-04 07:40:14','2025-07-04 07:40:14',NULL,NULL),
(41,31,6,'2025-07-04 09:37:53','2025-07-04 09:37:53',NULL,NULL),
(42,32,4,'2025-07-04 10:45:29','2025-07-04 10:45:29',NULL,4568),
(43,31,6,'2025-07-07 05:26:18','2025-07-07 05:26:18',NULL,NULL),
(44,31,6,'2025-07-07 05:45:09','2025-07-07 05:45:09',NULL,NULL),
(45,31,6,'2025-07-07 05:47:29','2025-07-07 05:47:29',NULL,NULL),
(46,31,6,'2025-07-07 06:56:01','2025-07-07 06:56:01',NULL,NULL),
(47,31,6,'2025-07-07 07:02:57','2025-07-07 07:02:57',NULL,NULL),
(48,13,6,'2025-07-07 07:07:40','2025-07-07 07:07:40',NULL,NULL),
(49,13,6,'2025-07-07 07:47:02','2025-07-07 07:47:02',NULL,NULL),
(50,31,6,'2025-07-07 10:09:34','2025-07-07 10:09:34',NULL,NULL),
(51,31,6,'2025-07-08 06:59:33','2025-07-08 06:59:33',NULL,NULL),
(52,31,6,'2025-07-11 05:49:10','2025-07-11 05:49:10',NULL,NULL),
(53,31,6,'2025-07-11 05:58:37','2025-07-11 05:58:37',NULL,NULL),
(54,31,6,'2025-07-11 06:01:10','2025-07-11 06:01:10',NULL,NULL),
(55,31,6,'2025-07-11 06:09:15','2025-07-11 06:09:15',NULL,NULL),
(56,31,6,'2025-07-11 06:21:21','2025-07-11 06:21:21',NULL,NULL),
(57,31,6,'2025-07-11 11:59:59','2025-07-11 11:59:59',NULL,NULL),
(58,8,6,'2025-07-12 14:23:34','2025-07-12 14:23:34',NULL,NULL),
(59,8,6,'2025-07-12 14:30:05','2025-07-12 14:30:05',NULL,NULL),
(60,8,6,'2025-07-12 14:36:16','2025-07-12 14:36:16',NULL,NULL),
(61,8,6,'2025-07-12 14:39:39','2025-07-12 14:39:39',NULL,NULL),
(62,8,6,'2025-07-12 14:40:29','2025-07-12 14:40:29',NULL,NULL),
(63,8,6,'2025-07-12 14:42:34','2025-07-12 14:42:34',NULL,NULL);

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
  `working_hour` timestamp NULL DEFAULT NULL,
  `latitude` varchar(255) DEFAULT NULL,
  `longitude` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `ride_status` varchar(255) DEFAULT NULL,
  `ride_status_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp(),
  `deleted_flag` int(11) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `rides` */

insert  into `rides`(`id`,`ride_uid`,`firstname`,`lastname`,`email`,`mobile`,`password`,`gender`,`dob`,`profile`,`status`,`working_hour`,`latitude`,`longitude`,`location`,`ride_status`,`ride_status_id`,`created_at`,`updated_at`,`deleted_flag`,`deleted_at`) values 
(8,'26887','Dinesh','S','guru@gmail.com','8838721805','$2b$10$bTVRgAAuCkWxUFKBBGVwJeuUtYIbbavKRwCLU3qip3jqHluOYcTG2','male','12-12-2006',NULL,'online','2025-07-08 20:23:00','22233','565656','trichy','online',2,'2025-05-06 13:12:59','2025-05-06 13:12:59',NULL,NULL),
(9,'342','Hari','M','ravi@gmail.com','9087654323','$2b$10$bTVRgAAuCkWxUFKBBGVwJeuUtYIbbavKRwCLU3qip3jqHluOYcTG2','male','12-12-2009',NULL,'online',NULL,'10.789250191944086','79.14539811912229','Thanjavur','Active',1,'2025-05-08 19:14:01','2025-05-08 19:14:01',NULL,NULL),
(10,'345','srini','K','santhosh@gmail.com','7890678965','$2b$10$bTVRgAAuCkWxUFKBBGVwJeuUtYIbbavKRwCLU3qip3jqHluOYcTG2','male','11-12-2008',NULL,'online',NULL,'10.774150862980616','78.6965473085961','Evr College','Active',NULL,'2025-05-08 19:16:02','2025-05-08 19:16:02',NULL,NULL),
(11,'346','pandi','p','arun@gmail.com','9807654278','$2b$10$bTVRgAAuCkWxUFKBBGVwJeuUtYIbbavKRwCLU3qip3jqHluOYcTG2','male','07-12-2007',NULL,'online',NULL,'10.796922757325508','78.69984123687385','TVS Tollgate','Active',1,'2025-05-08 19:18:01','2025-05-08 19:18:01',NULL,NULL),
(12,'342','edward','S','Naveen@gmail.com','789065432','$2b$10$bTVRgAAuCkWxUFKBBGVwJeuUtYIbbavKRwCLU3qip3jqHluOYcTG2','male','09-12-2009',NULL,'online',NULL,'10.920095736988246','78.73901350049438','samayapuram','Active',NULL,'2025-05-08 19:18:02','2025-05-08 19:18:02',NULL,NULL),
(13,'52969','ragu','j','t@gmail.com','1234567890','$2b$10$BfLQZraQ5pnaCwBK2A93rO5gmpjkCW43g7IU6w93F9jlNQZg3dJr2','Male','1/1/2000',NULL,'online','2025-07-07 15:22:36','10.785124','78.7019122','Tiruchirappalli, Tamil Nadu','online',NULL,'2025-05-13 05:10:47','2025-05-13 05:10:47',NULL,NULL),
(14,'63595','algu','j','t@gmail.com','1234567890','$2b$10$RcnaNTRihMNuerLaQ3QCeukk.betvuPAIEEsfb72npK4cUirekIrW','Male','1/1/2000',NULL,NULL,NULL,'10.83574903122012','78.66110603847578','Thillai Nagar','Banned',3,'2025-05-13 05:12:02','2025-05-13 05:12:02',NULL,NULL),
(15,'14031','muthu','j','t@gmail.com','1234567890','$2b$10$j6rEZXBXQBd68Rc8Xgs9tufhyHV8tU.inOJ2lpbXXjJW1LS8ACXWK','Male','1/1/2000',NULL,NULL,NULL,'10.746143881308914','78.64981134443299','Panjappur','Approval',2,'2025-05-13 05:12:30','2025-05-13 05:12:30',NULL,NULL),
(16,'41731','dinesh','K','dinesh@gmail.com','9698591806','$2b$10$IH0RoqKcFvPx/QNQN/bi1.lB1yO50.gTioNCpXnXglQN1SHLsret2','Male','14/1/2000',NULL,NULL,NULL,NULL,NULL,NULL,'Pending Approval',1,'2025-06-10 03:42:38','2025-06-10 03:42:38',NULL,NULL),
(17,'36038','dinesh','K','dinesh@gmail.com','9698591806','$2b$10$AlnHqxCA05t6u3BvxUS2hOXhSN6Aaa2VukVj.OyuNIb1OR8D0HEW2','Male','14/1/2000',NULL,NULL,NULL,NULL,NULL,NULL,'Pending Approval',1,'2025-06-10 03:42:44','2025-06-10 03:42:44',NULL,NULL),
(18,'23134','bharathi','K','bharathi@gmail.com','9698591807','$2b$10$n6I8PT2IwzwaxGqICsNDbuuqx7mzzTiqHEegt3nMPauwYsxhG9j6W','Male','14/1/2000',NULL,NULL,NULL,NULL,NULL,NULL,'Pending Approval',1,'2025-06-10 03:43:11','2025-06-10 03:43:11',NULL,NULL),
(19,'66532','tmo','j','tom55@gmail.com','8610162671','$2b$10$VLxMYA/tR4ciyw2AXAyN1uO/5f/tu08993Douq9Zzz50Fu9KR6N5.','Male','22/1/2000',NULL,NULL,NULL,NULL,NULL,NULL,'Pending Approval',1,'2025-06-11 04:57:01','2025-06-11 04:57:01',NULL,NULL),
(20,'58255','uugm','h&','edward@gmail.com','8610162671','$2b$10$4Scn6SLUNXv4ZrkMBRQlO.U/mqR4sGiPscdsCbzvxxVwFwRty4xJC','Male','1/1/2000',NULL,NULL,NULL,NULL,NULL,NULL,'Pending Approval',1,'2025-06-11 05:02:35','2025-06-11 05:02:35',NULL,NULL),
(21,'58478','gg','g','hh@gmail.com','1234567899','$2b$10$3rbbUB/Yde..rBijwfEvOe0WNbFClhnCoue/1IbnJbB7uQKOlxNz6','Male','1/1/2000',NULL,NULL,NULL,NULL,NULL,NULL,'Pending Approval',1,'2025-06-11 05:05:45','2025-06-11 05:05:45',NULL,NULL),
(22,'10183','karthi','Ravi','pavi@example.com','4545454545','$2b$10$GHUzpuUTk3YUELwhn69JiulueL5t/HCYOEiUL12Y8lOoCD6k6Z6Dy','Male','20/8/2003',NULL,'offline','2025-06-12 18:32:50',NULL,NULL,NULL,'Approval',2,'2025-06-12 12:57:05','2025-06-12 12:57:05',NULL,NULL),
(23,'71830','Vignesh','S','vickeyeie@gmail.com','7598432079','$2b$10$alx3Po4iy13h10Lu4sVCTuF66ehbNQ/mMKLI0Fm.tLxjZ0K9DtEHW','Male','4/2/1997',NULL,NULL,NULL,NULL,NULL,NULL,'Pending Approval',1,'2025-06-25 10:20:11','2025-06-25 10:20:11',NULL,NULL),
(24,'16852','john','m','john@gmail.com','8610162671','$2b$10$.1XdbfC5GYPEfR2O8UUiK.zYm0WDwFpe8EaW1sV3tofVPxZBnZUaS','Male','1/1/2000',NULL,NULL,NULL,NULL,NULL,NULL,'Pending Approval',1,'2025-06-25 11:09:19','2025-06-25 11:09:19',NULL,NULL),
(25,'70410','Bharath','M','Bharath.mv@gmail.com','8056977938','$2b$10$Gmc2qPVJDifeH/iVUgmj5.bAkdOc/Z4SgKwUMLCtFDDfWz9te4KjK','Male','7/11/1985',NULL,NULL,NULL,NULL,NULL,NULL,'Pending Approval',1,'2025-06-25 11:23:34','2025-06-25 11:23:34',NULL,NULL),
(26,'92872','bharath','m','bharath.mv@gmail.com','8056977938','$2b$10$5ohLEdX1e7iu.K6XlO0xI.Uoy5jZNXF/buezd0r6eH3fO3v9NFyFG','Male','1/1/2000',NULL,NULL,NULL,NULL,NULL,NULL,'Pending Approval',1,'2025-06-25 11:31:11','2025-06-25 11:31:11',NULL,NULL),
(27,'13232','guru','S','guru@gmail.com','9890987654','$2b$10$pkmpBXpGyGXuYh..DJhK9.GX.LWYcuicgPkoLmaFoNuTcll41GRKC','male','12-12-2006',NULL,'online',NULL,'10.9194° N','78.7409° E','samayapuram','Approval',2,'2025-06-25 14:10:42','2025-06-25 14:10:42',NULL,NULL),
(28,'77650','Suresh','Sru','Suresh@gmail.com','7890657890','$2b$10$6Z/.3AILkR7fwvgLvlXKOuC6xDrjphRuEHc79v/CL3wzUsUXycUL2','Male','6/1/2000',NULL,NULL,NULL,NULL,NULL,NULL,'Pending Approval',1,'2025-06-25 14:27:04','2025-06-25 14:27:04',NULL,NULL),
(29,'68745','tok','h','h@gmail.com','1245678907','$2b$10$5HdGwEg5JMidrGE7p7Zgu.Y3aaqD.qulTB5XWwDuGcAkme1C5uFji','Female','22/1/2000',NULL,NULL,NULL,NULL,NULL,NULL,'Pending Approval',1,'2025-06-25 18:16:47','2025-06-25 18:16:47',NULL,NULL),
(30,'84204','firstName','lastName','demo@gmail.com','1234567895','$2b$10$tGCf4AmO4Qq1JkZ459rxVeffAdzCHgHkf8ru6j4Kt6yMVN8huDRke','male','09/09/2002',NULL,NULL,NULL,NULL,NULL,NULL,'Pending Approval',1,'2025-07-04 05:04:56','2025-07-04 05:04:56',NULL,NULL),
(31,'68039','Naveen','k','g@gmail.com','1234567896','$2b$10$38x7lZW1OxMMiS5RRfoUpuGC9rnprW1pX39v65Tkj9xWwTqcF.W2O','Male','1/1/2000','1751605746168.jpg','online','2025-07-11 18:08:31','10.7851364','78.701902','Tiruchirappalli, Tamil Nadu','Approval',2,'2025-07-04 05:09:06','2025-07-04 05:09:06',NULL,NULL),
(32,'44016','ari','m','arihara@gmail.com','8668012568','$2b$10$rDDq3YcjRUTwzVuIBbj80O3ur.b6ShbgcPyKtH9xvLQy9JobnEidK','Male','23/11/1999','1751625895813.jpg','online','2025-07-04 16:20:09','10.7941928','78.7584682','Tiruchirappalli, Tamil Nadu','Pending Approval',1,'2025-07-04 10:44:55','2025-07-04 10:44:55',NULL,NULL),
(33,'33003','ari','m','arihara@gmail.com','8668012568','$2b$10$tKiOWb9Nc1vqCTo3gj8UOOeEzBleik5HjfDh6TeadjVKdCTOpJR4a','Male','23/11/1999','1751625896867.jpg',NULL,NULL,NULL,NULL,NULL,'Pending Approval',1,'2025-07-04 10:44:56','2025-07-04 10:44:56',NULL,NULL),
(34,'99567','ari','m','arihara@gmail.com','8668012568','$2b$10$8X.EsT6LYZA9ztfKZpwvueV78nE2fT5.0XxK5S9eP64dQW6Et9dlO','Male','23/11/1999','1751625897026.jpg',NULL,NULL,NULL,NULL,NULL,'Pending Approval',1,'2025-07-04 10:44:57','2025-07-04 10:44:57',NULL,NULL),
(35,'71134','ari','m','arihara@gmail.com','8668012568','$2b$10$of5Td/AuLH4u.ThBE9A/lu4YP7VdUaxCS3btsfqcYZM26zTph1l76','Male','23/11/1999','1751625897227.jpg',NULL,NULL,NULL,NULL,NULL,'Pending Approval',1,'2025-07-04 10:44:57','2025-07-04 10:44:57',NULL,NULL),
(36,'30979','ari','m','arihara@gmail.com','8668012568','$2b$10$hBWGl88fLxI22IpQw8vAP.UubBP1lYZ.Kg5d2JkVnP.FmqfXBKMbm','Male','23/11/1999','1751625897427.jpg',NULL,NULL,NULL,NULL,NULL,'Pending Approval',1,'2025-07-04 10:44:57','2025-07-04 10:44:57',NULL,NULL),
(37,'73337','ari','m','arihara@gmail.com','8668012568','$2b$10$4zQP4AkaxWyMj56/vVzg1u7OLzoHtPyX567yTsZt1oQnirI2VB.iG','Male','23/11/1999','1751625897567.jpg',NULL,NULL,NULL,NULL,NULL,'Pending Approval',1,'2025-07-04 10:44:57','2025-07-04 10:44:57',NULL,NULL),
(38,'34380','ari','m','arihara@gmail.com','8668012568','$2b$10$0EQHiPsnFWfUCDw80iiOaemtHYN3JkP2PPGf2OjWYmu07/d15WA5.','Male','23/11/1999','1751625897807.jpg',NULL,NULL,NULL,NULL,NULL,'Pending Approval',1,'2025-07-04 10:44:57','2025-07-04 10:44:57',NULL,NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

/*Table structure for table `user_notification_change_log` */

DROP TABLE IF EXISTS `user_notification_change_log`;

CREATE TABLE `user_notification_change_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `table_name` varchar(255) DEFAULT NULL,
  `action_type` enum('INSERT','UPDATE','DELETE') DEFAULT NULL,
  `record_id` int(11) DEFAULT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`payload`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `user_notification_change_log` */

insert  into `user_notification_change_log`(`id`,`table_name`,`action_type`,`record_id`,`payload`,`created_at`) values 
(1,'user_notifications','INSERT',257,'{\"notification_id\": 2, \"user_id\": 22, \"user_otp\": null}','2025-07-14 20:07:59');

/*Table structure for table `user_notifications` */

DROP TABLE IF EXISTS `user_notifications`;

CREATE TABLE `user_notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `notification_id` int(11) DEFAULT NULL,
  `user_otp` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=258 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `user_notifications` */

insert  into `user_notifications`(`id`,`user_id`,`notification_id`,`user_otp`,`created_at`,`updated_at`,`deleted_at`) values 
(98,228,5,7249,'2025-06-10 09:53:18','2025-06-10 09:53:18',NULL),
(99,229,5,8975,'2025-06-10 10:44:01','2025-06-10 10:44:01',NULL),
(100,230,5,3630,'2025-06-10 11:42:36','2025-06-10 11:42:36',NULL),
(101,230,4,3427,'2025-06-10 11:45:18','2025-06-10 11:45:18',NULL),
(102,231,5,7496,'2025-06-10 11:50:18','2025-06-10 11:50:18',NULL),
(103,224,3,6618,'2025-06-10 16:31:17','2025-06-10 16:31:17',NULL),
(104,231,3,9168,'2025-06-10 16:31:34','2025-06-10 16:31:34',NULL),
(105,22,3,9764,'2025-06-10 16:32:33','2025-06-10 16:32:33',NULL),
(106,22,3,4550,'2025-06-10 16:33:15','2025-06-10 16:33:15',NULL),
(107,22,3,2736,'2025-06-10 16:33:20','2025-06-10 16:33:20',NULL),
(108,232,5,3672,'2025-06-12 12:59:01','2025-06-12 12:59:01',NULL),
(109,233,5,9850,'2025-06-12 13:01:10','2025-06-12 13:01:10',NULL),
(110,233,3,2785,'2025-06-12 13:02:13','2025-06-12 13:02:13',NULL),
(111,233,2,NULL,'2025-06-12 13:02:23','2025-06-12 13:02:23',NULL),
(112,234,5,5445,'2025-06-25 10:22:57','2025-06-25 10:22:57',NULL),
(113,235,5,3060,'2025-06-25 10:31:13','2025-06-25 10:31:13',NULL),
(114,236,5,9970,'2025-06-25 11:03:53','2025-06-25 11:03:53',NULL),
(115,229,4,5487,'2025-06-25 11:23:26','2025-06-25 11:23:26',NULL),
(116,237,5,6848,'2025-06-25 11:25:10','2025-06-25 11:25:10',NULL),
(117,238,5,1931,'2025-06-25 11:26:09','2025-06-25 11:26:09',NULL),
(118,237,4,5226,'2025-06-25 11:27:12','2025-06-25 11:27:12',NULL),
(119,230,4,3917,'2025-06-25 11:29:51','2025-06-25 11:29:51',NULL),
(120,230,4,4906,'2025-06-25 11:30:51','2025-06-25 11:30:51',NULL),
(121,230,3,3587,'2025-06-25 11:34:34','2025-06-25 11:34:34',NULL),
(122,230,2,NULL,'2025-06-25 11:39:40','2025-06-25 11:39:40',NULL),
(123,239,5,5248,'2025-06-25 13:58:31','2025-06-25 13:58:31',NULL),
(124,240,5,2739,'2025-06-25 14:10:00','2025-06-25 14:10:00',NULL),
(125,241,5,8820,'2025-06-25 14:35:06','2025-06-25 14:35:06',NULL),
(126,22,3,1387,'2025-06-30 13:42:56','2025-06-30 13:42:56',NULL),
(127,22,2,NULL,'2025-06-30 13:43:37','2025-06-30 13:43:37',NULL),
(128,25,3,5096,'2025-06-30 13:57:57','2025-06-30 13:57:57',NULL),
(129,25,2,NULL,'2025-06-30 13:58:04','2025-06-30 13:58:04',NULL),
(130,25,2,NULL,'2025-06-30 14:04:12','2025-06-30 14:04:12',NULL),
(131,25,2,NULL,'2025-06-30 14:10:36','2025-06-30 14:10:36',NULL),
(132,25,2,NULL,'2025-06-30 14:12:43','2025-06-30 14:12:43',NULL),
(133,25,2,NULL,'2025-06-30 14:13:50','2025-06-30 14:13:50',NULL),
(134,25,2,NULL,'2025-06-30 14:14:16','2025-06-30 14:14:16',NULL),
(135,238,3,9645,'2025-06-30 16:59:18','2025-06-30 16:59:18',NULL),
(136,238,2,NULL,'2025-06-30 16:59:36','2025-06-30 16:59:36',NULL),
(137,230,3,1269,'2025-06-30 17:09:37','2025-06-30 17:09:37',NULL),
(138,230,2,NULL,'2025-06-30 17:09:49','2025-06-30 17:09:49',NULL),
(139,230,2,NULL,'2025-06-30 17:14:03','2025-06-30 17:14:03',NULL),
(140,230,2,NULL,'2025-06-30 17:14:30','2025-06-30 17:14:30',NULL),
(141,230,2,NULL,'2025-06-30 17:18:13','2025-06-30 17:18:13',NULL),
(142,24,3,9438,'2025-06-30 17:22:29','2025-06-30 17:22:29',NULL),
(143,24,3,8281,'2025-06-30 17:22:30','2025-06-30 17:22:30',NULL),
(144,24,2,NULL,'2025-06-30 17:22:41','2025-06-30 17:22:41',NULL),
(145,234,3,9085,'2025-06-30 17:49:53','2025-06-30 17:49:53',NULL),
(146,234,2,NULL,'2025-06-30 17:50:08','2025-06-30 17:50:08',NULL),
(147,238,3,5407,'2025-06-30 17:51:58','2025-06-30 17:51:58',NULL),
(148,238,2,NULL,'2025-06-30 17:52:12','2025-06-30 17:52:12',NULL),
(149,238,2,NULL,'2025-06-30 17:52:13','2025-06-30 17:52:13',NULL),
(150,238,2,NULL,'2025-06-30 17:59:06','2025-06-30 17:59:06',NULL),
(151,238,3,8961,'2025-07-03 06:31:43','2025-07-03 06:31:43',NULL),
(152,230,3,9907,'2025-07-03 06:45:41','2025-07-03 06:45:41',NULL),
(153,230,3,3104,'2025-07-03 06:47:02','2025-07-03 06:47:02',NULL),
(154,230,3,9037,'2025-07-03 06:50:06','2025-07-03 06:50:06',NULL),
(155,230,3,2214,'2025-07-03 06:50:35','2025-07-03 06:50:35',NULL),
(156,230,3,2008,'2025-07-03 06:51:32','2025-07-03 06:51:32',NULL),
(157,230,3,1247,'2025-07-03 06:52:55','2025-07-03 06:52:55',NULL),
(158,230,3,3652,'2025-07-03 06:56:42','2025-07-03 06:56:42',NULL),
(159,230,3,6260,'2025-07-03 07:27:44','2025-07-03 07:27:44',NULL),
(160,230,3,2790,'2025-07-03 07:32:38','2025-07-03 07:32:38',NULL),
(161,230,3,7540,'2025-07-03 08:52:26','2025-07-03 08:52:26',NULL),
(162,230,2,NULL,'2025-07-03 08:52:36','2025-07-03 08:52:36',NULL),
(163,242,5,2903,'2025-07-04 05:11:43','2025-07-04 05:11:43',NULL),
(164,243,5,3119,'2025-07-04 05:14:00','2025-07-04 05:14:00',NULL),
(165,243,3,5953,'2025-07-04 05:15:12','2025-07-04 05:15:12',NULL),
(166,243,2,NULL,'2025-07-04 05:34:37','2025-07-04 05:34:37',NULL),
(167,243,3,3315,'2025-07-04 05:37:24','2025-07-04 05:37:24',NULL),
(168,243,2,NULL,'2025-07-04 05:38:23','2025-07-04 05:38:23',NULL),
(169,243,3,3794,'2025-07-04 05:40:55','2025-07-04 05:40:55',NULL),
(170,243,2,NULL,'2025-07-04 05:41:11','2025-07-04 05:41:11',NULL),
(171,243,3,3627,'2025-07-04 05:43:12','2025-07-04 05:43:12',NULL),
(172,243,2,NULL,'2025-07-04 05:43:34','2025-07-04 05:43:34',NULL),
(173,243,3,3928,'2025-07-04 05:45:48','2025-07-04 05:45:48',NULL),
(174,243,2,NULL,'2025-07-04 05:46:35','2025-07-04 05:46:35',NULL),
(175,243,3,1474,'2025-07-04 05:52:28','2025-07-04 05:52:28',NULL),
(176,243,2,NULL,'2025-07-04 05:52:40','2025-07-04 05:52:40',NULL),
(177,243,3,5767,'2025-07-04 05:57:38','2025-07-04 05:57:38',NULL),
(178,243,2,NULL,'2025-07-04 05:57:49','2025-07-04 05:57:49',NULL),
(179,243,3,3686,'2025-07-04 06:06:15','2025-07-04 06:06:15',NULL),
(180,243,2,NULL,'2025-07-04 06:06:30','2025-07-04 06:06:30',NULL),
(181,243,3,9926,'2025-07-04 06:21:36','2025-07-04 06:21:36',NULL),
(182,243,2,NULL,'2025-07-04 06:21:53','2025-07-04 06:21:53',NULL),
(183,243,3,1952,'2025-07-04 06:27:40','2025-07-04 06:27:40',NULL),
(184,243,2,NULL,'2025-07-04 06:29:09','2025-07-04 06:29:09',NULL),
(185,244,5,5825,'2025-07-04 06:48:22','2025-07-04 06:48:22',NULL),
(186,244,3,9580,'2025-07-04 06:49:29','2025-07-04 06:49:29',NULL),
(187,244,2,NULL,'2025-07-04 06:49:49','2025-07-04 06:49:49',NULL),
(188,244,3,4362,'2025-07-04 07:00:07','2025-07-04 07:00:07',NULL),
(189,244,2,NULL,'2025-07-04 07:00:21','2025-07-04 07:00:21',NULL),
(190,245,5,6717,'2025-07-04 07:02:23','2025-07-04 07:02:23',NULL),
(191,246,5,9328,'2025-07-04 07:07:01','2025-07-04 07:07:01',NULL),
(192,246,3,2470,'2025-07-04 07:08:05','2025-07-04 07:08:05',NULL),
(193,246,2,NULL,'2025-07-04 07:08:18','2025-07-04 07:08:18',NULL),
(194,246,3,8776,'2025-07-04 07:10:36','2025-07-04 07:10:36',NULL),
(195,246,2,NULL,'2025-07-04 07:10:56','2025-07-04 07:10:56',NULL),
(196,246,3,6262,'2025-07-04 07:20:21','2025-07-04 07:20:21',NULL),
(197,246,2,NULL,'2025-07-04 07:20:38','2025-07-04 07:20:38',NULL),
(198,246,3,6847,'2025-07-04 07:38:19','2025-07-04 07:38:19',NULL),
(199,246,3,3443,'2025-07-04 07:38:19','2025-07-04 07:38:19',NULL),
(200,246,2,NULL,'2025-07-04 07:38:47','2025-07-04 07:38:47',NULL),
(201,247,5,5105,'2025-07-04 09:35:32','2025-07-04 09:35:32',NULL),
(202,247,3,3386,'2025-07-04 09:37:00','2025-07-04 09:37:00',NULL),
(203,247,2,NULL,'2025-07-04 09:37:12','2025-07-04 09:37:12',NULL),
(204,247,3,9562,'2025-07-04 09:47:04','2025-07-04 09:47:04',NULL),
(205,247,3,3837,'2025-07-04 09:47:47','2025-07-04 09:47:47',NULL),
(206,247,3,3513,'2025-07-04 09:49:38','2025-07-04 09:49:38',NULL),
(207,236,4,4892,'2025-07-04 10:44:12','2025-07-04 10:44:12',NULL),
(208,230,3,7547,'2025-07-04 10:49:08','2025-07-04 10:49:08',NULL),
(209,248,5,4045,'2025-07-04 11:19:17','2025-07-04 11:19:17',NULL),
(210,249,5,3424,'2025-07-05 17:02:29','2025-07-05 17:02:29',NULL),
(211,246,3,8269,'2025-07-07 05:25:09','2025-07-07 05:25:09',NULL),
(212,246,2,NULL,'2025-07-07 05:25:38','2025-07-07 05:25:38',NULL),
(213,246,3,7174,'2025-07-07 05:44:37','2025-07-07 05:44:37',NULL),
(214,246,3,9565,'2025-07-07 05:44:37','2025-07-07 05:44:37',NULL),
(215,246,2,NULL,'2025-07-07 05:44:49','2025-07-07 05:44:49',NULL),
(216,246,3,1364,'2025-07-07 05:46:37','2025-07-07 05:46:37',NULL),
(217,246,2,NULL,'2025-07-07 05:47:07','2025-07-07 05:47:07',NULL),
(218,246,3,4127,'2025-07-07 06:54:27','2025-07-07 06:54:27',NULL),
(219,246,3,6826,'2025-07-07 06:54:30','2025-07-07 06:54:30',NULL),
(220,246,2,NULL,'2025-07-07 06:55:40','2025-07-07 06:55:40',NULL),
(221,246,3,4542,'2025-07-07 06:59:32','2025-07-07 06:59:32',NULL),
(222,246,2,NULL,'2025-07-07 06:59:47','2025-07-07 06:59:47',NULL),
(223,246,3,6595,'2025-07-07 07:06:56','2025-07-07 07:06:56',NULL),
(224,246,2,NULL,'2025-07-07 07:07:06','2025-07-07 07:07:06',NULL),
(225,246,3,3787,'2025-07-07 07:46:36','2025-07-07 07:46:36',NULL),
(226,246,2,NULL,'2025-07-07 07:46:46','2025-07-07 07:46:46',NULL),
(227,229,4,4601,'2025-07-07 09:41:06','2025-07-07 09:41:06',NULL),
(228,229,4,6471,'2025-07-07 09:41:42','2025-07-07 09:41:42',NULL),
(229,229,4,8176,'2025-07-07 09:43:40','2025-07-07 09:43:40',NULL),
(230,229,4,8623,'2025-07-07 09:46:36','2025-07-07 09:46:36',NULL),
(231,250,5,5232,'2025-07-07 09:47:57','2025-07-07 09:47:57',NULL),
(232,246,3,5074,'2025-07-07 10:09:13','2025-07-07 10:09:13',NULL),
(233,246,2,NULL,'2025-07-07 10:09:22','2025-07-07 10:09:22',NULL),
(234,246,3,3944,'2025-07-08 06:58:55','2025-07-08 06:58:55',NULL),
(235,246,2,NULL,'2025-07-08 06:59:05','2025-07-08 06:59:05',NULL),
(236,246,3,8486,'2025-07-11 05:47:01','2025-07-11 05:47:01',NULL),
(237,246,2,NULL,'2025-07-11 05:47:16','2025-07-11 05:47:16',NULL),
(238,246,3,5360,'2025-07-11 05:57:33','2025-07-11 05:57:33',NULL),
(239,246,2,NULL,'2025-07-11 05:58:20','2025-07-11 05:58:20',NULL),
(240,246,3,3295,'2025-07-11 06:00:41','2025-07-11 06:00:41',NULL),
(241,246,2,NULL,'2025-07-11 06:00:52','2025-07-11 06:00:52',NULL),
(242,246,3,1051,'2025-07-11 06:08:49','2025-07-11 06:08:49',NULL),
(243,246,2,NULL,'2025-07-11 06:09:04','2025-07-11 06:09:04',NULL),
(244,246,3,4059,'2025-07-11 06:15:36','2025-07-11 06:15:36',NULL),
(245,246,2,NULL,'2025-07-11 06:15:51','2025-07-11 06:15:51',NULL),
(246,246,3,2858,'2025-07-11 06:19:30','2025-07-11 06:19:30',NULL),
(247,246,2,NULL,'2025-07-11 06:19:42','2025-07-11 06:19:42',NULL),
(248,246,3,4432,'2025-07-11 11:59:29','2025-07-11 11:59:29',NULL),
(249,246,2,NULL,'2025-07-11 11:59:44','2025-07-11 11:59:44',NULL),
(250,246,3,3709,'2025-07-11 12:15:57','2025-07-11 12:15:57',NULL),
(251,246,3,1546,'2025-07-11 12:18:37','2025-07-11 12:18:37',NULL),
(253,22,2,NULL,'2025-07-14 14:30:49','2025-07-14 14:30:49',NULL),
(257,22,2,NULL,'2025-07-14 14:37:59','2025-07-14 14:37:59',NULL);

/*Table structure for table `user_reviews` */

DROP TABLE IF EXISTS `user_reviews`;

CREATE TABLE `user_reviews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `review_type_status` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `rider_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `user_reviews` */

insert  into `user_reviews`(`id`,`user_id`,`order_id`,`review_type_status`,`created_at`,`updated_at`,`deleted_at`,`rider_id`) values 
(1,235,91,1,'2025-06-30 15:09:18','2025-06-30 15:09:18',NULL,15),
(2,235,91,1,'2025-06-30 15:12:12','2025-06-30 15:12:12',NULL,15),
(3,25,72,1,'2025-06-30 17:50:20','2025-06-30 17:50:20',NULL,15),
(4,238,95,1,'2025-06-30 17:59:17','2025-06-30 17:59:17',NULL,13),
(5,243,135,1,'2025-07-04 05:37:13','2025-07-04 05:37:13',NULL,31),
(6,243,138,1,'2025-07-04 05:40:45','2025-07-04 05:40:45',NULL,31),
(7,243,139,1,'2025-07-04 05:42:33','2025-07-04 05:42:33',NULL,31),
(8,243,140,1,'2025-07-04 05:44:57','2025-07-04 05:44:57',NULL,31),
(9,243,142,1,'2025-07-04 05:52:14','2025-07-04 05:52:14',NULL,31),
(10,243,143,1,'2025-07-04 05:56:31','2025-07-04 05:56:31',NULL,31),
(11,243,144,1,'2025-07-04 06:05:43','2025-07-04 06:05:43',NULL,31),
(12,243,145,1,'2025-07-04 06:21:26','2025-07-04 06:21:26',NULL,31),
(13,243,146,1,'2025-07-04 06:27:26','2025-07-04 06:27:26',NULL,31),
(14,244,148,1,'2025-07-04 06:50:17','2025-07-04 06:50:17',NULL,31),
(15,246,150,2,'2025-07-04 07:08:45','2025-07-04 07:08:45',NULL,31),
(16,246,151,2,'2025-07-04 07:11:35','2025-07-04 07:11:35',NULL,31),
(17,246,152,2,'2025-07-04 07:21:08','2025-07-04 07:21:08',NULL,31),
(18,246,153,2,'2025-07-04 07:40:14','2025-07-04 07:40:14',NULL,31),
(19,247,154,2,'2025-07-04 09:37:53','2025-07-04 09:37:53',NULL,31),
(20,246,161,2,'2025-07-07 05:26:18','2025-07-07 05:26:18',NULL,31),
(21,246,164,1,'2025-07-07 05:45:09','2025-07-07 05:45:09',NULL,31),
(22,246,165,1,'2025-07-07 05:47:29','2025-07-07 05:47:29',NULL,31),
(23,246,170,2,'2025-07-07 06:56:01','2025-07-07 06:56:01',NULL,31),
(24,246,171,1,'2025-07-07 07:02:57','2025-07-07 07:02:57',NULL,31),
(25,246,176,2,'2025-07-07 07:07:40','2025-07-07 07:07:40',NULL,13),
(26,246,177,1,'2025-07-07 07:47:02','2025-07-07 07:47:02',NULL,13),
(27,246,178,1,'2025-07-07 10:09:34','2025-07-07 10:09:34',NULL,31),
(28,246,179,1,'2025-07-08 06:59:33','2025-07-08 06:59:33',NULL,31),
(29,246,181,1,'2025-07-11 05:49:10','2025-07-11 05:49:10',NULL,31),
(30,246,183,2,'2025-07-11 05:58:37','2025-07-11 05:58:37',NULL,31),
(31,246,184,2,'2025-07-11 06:01:10','2025-07-11 06:01:10',NULL,31),
(32,246,185,2,'2025-07-11 06:09:15','2025-07-11 06:09:15',NULL,31),
(33,246,187,2,'2025-07-11 06:21:21','2025-07-11 06:21:21',NULL,31),
(34,246,188,1,'2025-07-11 11:59:59','2025-07-11 11:59:59',NULL,31),
(36,25,72,1,'2025-07-12 14:23:34','2025-07-12 14:23:34',NULL,8),
(37,25,72,1,'2025-07-12 14:30:05','2025-07-12 14:30:05',NULL,8),
(38,25,72,1,'2025-07-12 14:36:16','2025-07-12 14:36:16',NULL,8),
(39,25,72,1,'2025-07-12 14:39:39','2025-07-12 14:39:39',NULL,8),
(40,25,72,1,'2025-07-12 14:40:29','2025-07-12 14:40:29',NULL,8),
(41,25,72,1,'2025-07-12 14:42:34','2025-07-12 14:42:34',NULL,8);

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
  `user_status_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=251 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `users` */

insert  into `users`(`id`,`user_uid`,`firstname`,`lastname`,`email`,`mobile`,`city`,`password`,`gender`,`profile`,`dob`,`user_status`,`deleted_flag`,`created_at`,`updated_at`,`deleted_at`,`user_status_id`) values 
(229,'9c0262b4-091a-4b84-b26d-1ea41477ff99','jam','j','jam@gmail.com','8610162671',NULL,'$2b$10$wU/vHFmyb.PoiGZLk.GaqOkOpBK2ktFPGKq1CsT4gE1oZhVM1lwHK','Male','1749552325115.jpg','22/1/2000','Active',NULL,'2025-06-10 16:15:25','2025-06-10 10:44:01',NULL,2),
(230,'c8276bc7-19b2-40f7-a947-459d0ddbc497','Harish','Hairsh','harikuty@gmail.com','8838721805',NULL,'$2b$10$c7SXfC3iBODsk3orT42r5.Lnv4sxm/vCXF4ZzL8ATck95YeS.AXZ.','Female',NULL,'7/1/2000','Active',NULL,'2025-06-25 19:35:55','2025-06-10 11:42:36',NULL,2),
(231,'062e456d-72eb-4996-82dd-f41939c888d3','ramesh','suresh','sri123@gmail.com','8870892053',NULL,'$2b$10$AZO5BpxL8Gz///DCn74OVedlN8v5DSRGBevHohYfdN.XFZVvUlr22','Female',NULL,'1/1/2000','Active',NULL,'2025-06-10 17:20:28','2025-06-10 11:50:17',NULL,2),
(232,'2c34755d-98bc-41fd-8968-def619407c45','sri','sri','sri123456@gmail.com','9680043170',NULL,'$2b$10$3ocgMR5VImN6cCBAuk/GwuXHlHJAcqCqpHG2w.pQixQvYp8RYGfi.','Male',NULL,'1/1/2000','Approval Pending',NULL,'2025-06-12 18:29:01','2025-06-12 12:59:01',NULL,1),
(233,'f6c802e8-3fbd-4956-9914-16d44a2eb905','sri','sri','sri19venki@gmail.com','9629624424',NULL,'$2b$10$IvupjzC0IdzTrrWGzDk6Q.Ay2z0ggyZkICEOEDsRV5NPqaZ3ehYIm','Male',NULL,'1/1/2000','Active',NULL,'2025-06-12 18:31:22','2025-06-12 13:01:10',NULL,2),
(234,'4534b980-68f6-4b21-bcde-55f76c32ec34','Vicky','','vickieyeie@gmail.com','7598432',NULL,'$2b$10$rholtSqJwkr218IKc9eyl.2tn0/ZVunb9hBktt6TvrQgR9r6bBNSC','Male',NULL,'4/2/1997','Active',NULL,'2025-06-25 16:28:41','2025-06-25 10:22:57',NULL,2),
(235,'c11a4799-659f-442b-b7fd-6e1f11c84c59','Syed','Ibrahim','syedibrahim7252@gmail.com','9360331850',NULL,'$2b$10$8bf2hbcZJOWiTEURjAE6fu5qwg6gvvaqbBQEuq0DkDu1Rl8RNbOI6','Male',NULL,'25/4/2002','Active',NULL,'2025-06-25 16:01:29','2025-06-25 10:31:13',NULL,2),
(236,'7ca0ba8e-d21e-4d9b-9ee3-574a88a9bd59','Syed','I','1234@gmail.com','7598432079',NULL,'$2b$10$WP63Q/f5Yhe6gBrebaNgI.izCVFjaVVrCKYWkBrWLToZZAuGdywXi','Male',NULL,'1/1/2000','Active',NULL,'2025-06-25 16:34:03','2025-06-25 11:03:53',NULL,2),
(237,'2b4f6af1-201c-424a-82c6-b4a80b6fd689','dharmaraj','chingaravelu','annaidharma6@gmail.com','7200266667',NULL,'$2b$10$Z/F0HdAV1gJppe9L9kIOT.5IWxON3BGzqsDhpH4tT8LhNTLVjla/i','Male',NULL,'6/1/1986','Approval Pending',NULL,'2025-06-25 16:55:10','2025-06-25 11:25:10',NULL,1),
(238,'0a7f491b-218f-4ad1-8abd-60eec4783519','md','rifas','rifas99try@gmail.com','8668129658',NULL,'$2b$10$sGqYg/0hCWr6U9QacoNAiupBuJoxJmv8BlA..sWhLQ4iJ2u1ymYyi','Male',NULL,'1/1/2000','Active',NULL,'2025-06-25 16:56:30','2025-06-25 11:26:09',NULL,2),
(239,'b783e7ef-ce6f-4fa9-aaf5-e5eb73ceade3','krishna','Krish','krish@gmail.com','9807667543',NULL,'$2b$10$81T37.4.xtxvOuKuuDkBJeIv5et1m1m1aybA01ZLOuUkCqzBwGtXu','Male',NULL,'10/1/2000','Approval Pending',NULL,'2025-06-25 19:28:31','2025-06-25 13:58:31',NULL,1),
(240,'d31017fd-59a2-4f54-aa28-7788839bbf9d','bala','kumar','bala@gmail.com','8838721800','trichy','$2b$10$XyjiqAgaC45krdur6jpjnekHrkUl8VffYGmtGnwm06SBWtmC10bZi','Male',NULL,'12-12-2000','Approval Pending',NULL,'2025-06-25 19:40:00','2025-06-25 14:10:00',NULL,1),
(241,'3fa0cb8e-8a08-4b0d-87f7-59cd1dae732f','sethu','barath','sethu@gmail.com','8790654345',NULL,'$2b$10$CvJzjPZpDA9i17F98yM2D.4A0hvPrD51lrDUB.R.QIYbzJe0YIVoi','Male',NULL,'2/1/2000','Approval Pending',NULL,'2025-06-25 20:05:06','2025-06-25 14:35:06',NULL,1),
(242,'e604629a-438f-4bc4-9fee-20eca16ce383','Ram','M','ram@gmail.com','1234567890',NULL,'$2b$10$WD5oPtIIKj64dzbkE3I12emUs4HhkhQyckVGncFXrmBj/./Cxyqke','Male',NULL,'1/1/2000','Approval Pending',NULL,'2025-07-04 10:41:43','2025-07-04 05:11:43',NULL,1),
(243,'8f3c7cd0-c06c-418b-931d-39e6cd0300df','aravind','m','arac@gmail.com','9080347770',NULL,'$2b$10$h5p1e2pJhw517n3a/8LFSOqOYVJMiSBXuIzESwATlUvs5oGYsUyc2','Male',NULL,'1/1/2000','Active',1,'2025-07-04 12:12:31','2025-07-04 05:14:00','2025-07-04 06:42:31',2),
(244,'eb5ef7cb-fe4e-4b28-8106-a8b8944a749b','ram','k','ram2@gmail.com','9344676564',NULL,'$2b$10$zjNUxmmFQu4bCCxzghl7we2./5kqicPRtxZTtCz11FzN5MefBGQ6.','Male',NULL,'1/1/2000','Active',1,'2025-07-04 12:31:28','2025-07-04 06:48:22','2025-07-04 07:01:28',2),
(245,'9188b22b-abdd-449f-aa7c-61e1658c0255','maddy','mad','mad@gmail.com','1234567899',NULL,'$2b$10$G8RD0Dbu1xATFr0R7L3yH.jPgBAjcsE7ZJMhlLuFqmU.T/57APcGa','Male',NULL,'1/1/2000','Approval Pending',NULL,'2025-07-04 12:32:23','2025-07-04 07:02:23',NULL,1),
(246,'afe3262f-c383-496e-a6b0-2686d0b7b2a9','maddy','mad','mad2@gmail.com','1234567888',NULL,'$2b$10$VtpF0rd9Aw72ZO5s2pqEsetDoqB5I6/hEo.Igx0NSb8V/JyS5H0Si','Male',NULL,'22/1/2000','Active',NULL,'2025-07-04 12:37:10','2025-07-04 07:07:01',NULL,2),
(247,'c6ba716d-78aa-4534-aab5-871ce83d863b','test','user','testuser@gmail.com','8248401943',NULL,'$2b$10$/eM5q/7VWcndRnGzhlylY.p/LHvtsbQNEHjfAp125aRTgBiUtRcVm','Female',NULL,'20/3/1997','Active',NULL,'2025-07-04 15:06:12','2025-07-04 09:35:32',NULL,2),
(248,'cf05dc41-3080-4ca0-9e52-0818e1499163','Ariharasudhan','m','arihara@gmail.com','8668012568',NULL,'$2b$10$PobVoXrpw5vdIQ/huVCoOeFTdxme0EB55XHGGE/FQgqeDsab4.lRa','Male',NULL,'23/11/1999','Active',NULL,'2025-07-04 16:49:39','2025-07-04 11:19:17',NULL,2),
(249,'3ba94efc-727a-468f-9eeb-f98052a06671','bharath','m','bharath.mv@gmail.com','8056977938',NULL,'$2b$10$dt0S2bgEFyt.KXb.ZKtL0.7vx/5VBR/HYqLAeA25bejmm/zMypURK','Male',NULL,'1/1/1985','Active',NULL,'2025-07-05 22:32:51','2025-07-05 17:02:29',NULL,2),
(250,'682f1c5a-5f60-458d-8741-f90113125812','leo','k','leo@gmail.com','1234567896',NULL,'$2b$10$yDAvRq.lfGwkA6fuxcIVvuzrWgaDRaBy/16TTrBE6YiNmG9yX1kjy','Male',NULL,'1/1/2000','Approval Pending',NULL,'2025-07-07 15:17:57','2025-07-07 09:47:57',NULL,1);

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
  `suggestion_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `vehicles` */

insert  into `vehicles`(`id`,`ride_id`,`brand`,`model`,`model_year`,`license_plate`,`color`,`booking_type`,`status`,`created_at`,`updated_at`,`deleted_at`,`suggestion_id`) values 
(2,1,'Duke','200','2018','Active','Blue','offline',NULL,'2025-04-22 14:53:42','2025-04-22 14:53:42',NULL,NULL),
(3,1,'duke','Y1','2020','active','red','offline',NULL,'2025-04-29 14:41:39','2025-04-29 14:41:39',NULL,NULL),
(4,1,'duke','Y1','2020','active','red','offline',NULL,'2025-04-30 10:45:14','2025-04-30 10:45:14',NULL,NULL),
(5,1,'duke','Y1','2020','active','red','offline',NULL,'2025-04-30 13:54:17','2025-04-30 13:54:17',NULL,NULL),
(8,1,'duke','Y1','2020','active','red','offline',NULL,'2025-04-30 14:06:59','2025-04-30 14:06:59',NULL,NULL),
(9,1,'duke','Y1','2020','active','red','offline',1,'2025-04-30 14:07:18','2025-04-30 14:07:18',NULL,NULL),
(10,1,'duke','Y1','2020','active','red','offline',NULL,'2025-04-30 14:07:21','2025-04-30 14:07:21',NULL,NULL),
(11,8,'honda','m15','2015','TN60K8899','red','online',1,'2025-06-25 11:11:30','2025-06-25 11:11:30',NULL,NULL),
(12,31,'Yamaha ','MT 15','2013','TN66L3033','white ','Online ',NULL,'2025-07-04 09:39:28','2025-07-04 09:39:28',NULL,NULL),
(13,8,'duke','Y1','2020','active','red','offline',1,'2025-07-08 14:05:10','2025-07-08 14:05:10',NULL,1),
(14,31,'Bajaj ','Auto ','2015','TN77L3890','yellow','online',NULL,'2025-07-09 05:23:26','2025-07-09 05:23:26',NULL,1),
(15,31,'yamaha ','mt15','2020','TN45L3456','Black ','online ',1,'2025-07-09 05:42:04','2025-07-09 05:42:04',NULL,2),
(16,31,'Hyundai ','verna','2014','TN34L6754','White ','online ',NULL,'2025-07-09 05:49:39','2025-07-09 05:49:39',NULL,4);

/* Trigger structure for table `user_notifications` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `after_user_notification_insert` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `after_user_notification_insert` AFTER INSERT ON `user_notifications` FOR EACH ROW 
BEGIN
    INSERT INTO user_notification_change_log (
        table_name, action_type, record_id, payload
    )
    VALUES (
        'user_notifications',
        'INSERT',
        NEW.id,
        JSON_OBJECT(
            'notification_id', NEW.notification_id,
            'user_id', NEW.user_id,
            'user_otp', NEW.user_otp
        )
    );
END */$$


DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
