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

/*Data for the table `rides` */

insert  into `rides`(`id`,`ride_uid`,`firstname`,`lastname`,`email`,`mobile`,`password`,`gender`,`dob`,`profile`,`status`,`working_hour`,`latitude`,`longitude`,`location`,`ride_status`,`created_at`,`updated_at`,`deleted_flag`,`deleted_at`) values 
(8,'26887','Dinesh','S','guru@gmail.com','9890987654','$2b$10$bTVRgAAuCkWxUFKBBGVwJeuUtYIbbavKRwCLU3qip3jqHluOYcTG2','male','12-12-2006',NULL,'offline','2025-05-13 11:21:42','10.384721068246657','78.80313267770497','Pudukkottai','online','2025-05-06 13:12:59','2025-05-06 13:12:59',NULL,NULL),
(9,'342','Hari','M','ravi@gmail.com','9087654323','$2b$10$bTVRgAAuCkWxUFKBBGVwJeuUtYIbbavKRwCLU3qip3jqHluOYcTG2','male','12-12-2009',NULL,'online',NULL,'10.774214101198494','78.69679407182183','Thanjavur','Active','2025-05-08 19:14:01','2025-05-08 19:14:01',NULL,NULL),
(10,'345','srini','K','santhosh@gmail.com','7890678965','$2b$10$bTVRgAAuCkWxUFKBBGVwJeuUtYIbbavKRwCLU3qip3jqHluOYcTG2','male','11-12-2008',NULL,'online',NULL,'10.774150862980616','78.6965473085961','Evr College','Active','2025-05-08 19:16:02','2025-05-08 19:16:02',NULL,NULL),
(11,'346','pandi','p','arun@gmail.com','9807654278','$2b$10$bTVRgAAuCkWxUFKBBGVwJeuUtYIbbavKRwCLU3qip3jqHluOYcTG2','male','07-12-2007',NULL,'online',NULL,'10.796922757325508','78.69984123687385','TVS Tollgate','Active','2025-05-08 19:18:01','2025-05-08 19:18:01',NULL,NULL),
(12,'342','edward','S','Naveen@gmail.com','789065432','$2b$10$bTVRgAAuCkWxUFKBBGVwJeuUtYIbbavKRwCLU3qip3jqHluOYcTG2','male','09-12-2009',NULL,'online',NULL,'10.920095736988246','78.73901350049438','samayapuram','Active','2025-05-08 19:18:02','2025-05-08 19:18:02',NULL,NULL),
(13,'52969','ragu','j','t@gmail.com','1234567890','$2b$10$BfLQZraQ5pnaCwBK2A93rO5gmpjkCW43g7IU6w93F9jlNQZg3dJr2','Male','1/1/2000',NULL,'online','2025-05-13 22:29:53','10.866907763748856','78.6779274451325','Srirangam','online','2025-05-13 05:10:47','2025-05-13 05:10:47',NULL,NULL),
(14,'63595','algu','j','t@gmail.com','1234567890','$2b$10$RcnaNTRihMNuerLaQ3QCeukk.betvuPAIEEsfb72npK4cUirekIrW','Male','1/1/2000',NULL,NULL,NULL,'10.83574903122012','78.66110603847578','Thillai Nagar','Pending Approval','2025-05-13 05:12:02','2025-05-13 05:12:02',NULL,NULL),
(15,'14031','muthu','j','t@gmail.com','1234567890','$2b$10$j6rEZXBXQBd68Rc8Xgs9tufhyHV8tU.inOJ2lpbXXjJW1LS8ACXWK','Male','1/1/2000',NULL,NULL,NULL,'10.746143881308914','78.64981134443299','Panjappur','Pending Approval','2025-05-13 05:12:30','2025-05-13 05:12:30',NULL,NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
