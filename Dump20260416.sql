CREATE DATABASE  IF NOT EXISTS `1304_schema` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `1304_schema`;
-- MySQL dump 10.13  Distrib 8.0.45, for macos15 (arm64)
--
-- Host: 127.0.0.1    Database: 1304_schema
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `booking_assignments`
--

DROP TABLE IF EXISTS `booking_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_assignments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `booking_id` int DEFAULT NULL,
  `driver_id` int DEFAULT NULL,
  `vehicle_id` int DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `booking_id` (`booking_id`),
  KEY `driver_id` (`driver_id`),
  KEY `vehicle_id` (`vehicle_id`),
  CONSTRAINT `booking_assignments_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`),
  CONSTRAINT `booking_assignments_ibfk_2` FOREIGN KEY (`driver_id`) REFERENCES `drivers` (`id`),
  CONSTRAINT `booking_assignments_ibfk_3` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_assignments`
--

LOCK TABLES `booking_assignments` WRITE;
/*!40000 ALTER TABLE `booking_assignments` DISABLE KEYS */;
INSERT INTO `booking_assignments` VALUES (1,1,1,1,NULL,NULL),(2,4,2,2,NULL,NULL);
/*!40000 ALTER TABLE `booking_assignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_status_history`
--

DROP TABLE IF EXISTS `booking_status_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_status_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `booking_id` int NOT NULL,
  `from_status` enum('DRAFT','PENDING_REVIEW','AWAITING_USER_APPROVAL','AWAITING_PAYMENT','CONFIRMED','CANCELLED','EXPIRED') DEFAULT NULL,
  `to_status` enum('DRAFT','PENDING_REVIEW','AWAITING_USER_APPROVAL','AWAITING_PAYMENT','CONFIRMED','CANCELLED','EXPIRED') NOT NULL,
  `triggered_by` enum('CUSTOMER','OPERATOR','SYSTEM') NOT NULL,
  `customer_id` int DEFAULT NULL,
  `operator_id` int DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_bsh_booking` (`booking_id`),
  KEY `idx_bsh_created` (`created_at`),
  KEY `fk_bsh_customer` (`customer_id`),
  KEY `fk_bsh_operator` (`operator_id`),
  CONSTRAINT `fk_bsh_booking` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`),
  CONSTRAINT `fk_bsh_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  CONSTRAINT `fk_bsh_operator` FOREIGN KEY (`operator_id`) REFERENCES `operators` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_status_history`
--

LOCK TABLES `booking_status_history` WRITE;
/*!40000 ALTER TABLE `booking_status_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `booking_status_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_timeline_events`
--

DROP TABLE IF EXISTS `booking_timeline_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_timeline_events` (
  `id` int NOT NULL AUTO_INCREMENT,
  `booking_id` int NOT NULL,
  `event_type` enum('BOOKING_CREATED','BOOKING_SUBMITTED','REVIEW_STARTED','QUOTE_APPROVED','QUOTE_MODIFIED','QUOTE_REJECTED','USER_ACCEPTED_QUOTE','USER_DECLINED_QUOTE','PAYMENT_REQUESTED','PAYMENT_RECEIVED','BOOKING_CONFIRMED','CHANGE_REQUEST_SUBMITTED','CHANGE_REQUEST_REVIEWED','CHANGE_REQUEST_COMPLETED','CHANGE_REQUEST_CANCELLED','BOOKING_CANCELLED','BOOKING_EXPIRED') NOT NULL,
  `change_request_id` int DEFAULT NULL,
  `actor_type` enum('CUSTOMER','OPERATOR','SYSTEM') NOT NULL,
  `customer_id` int DEFAULT NULL,
  `operator_id` int DEFAULT NULL,
  `display_text` varchar(255) DEFAULT NULL,
  `metadata` json DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_bte_booking` (`booking_id`),
  KEY `idx_bte_created` (`created_at`),
  KEY `fk_bte_change_request` (`change_request_id`),
  KEY `fk_bte_customer` (`customer_id`),
  KEY `fk_bte_operator` (`operator_id`),
  CONSTRAINT `fk_bte_booking` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`),
  CONSTRAINT `fk_bte_change_request` FOREIGN KEY (`change_request_id`) REFERENCES `change_requests` (`id`),
  CONSTRAINT `fk_bte_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  CONSTRAINT `fk_bte_operator` FOREIGN KEY (`operator_id`) REFERENCES `operators` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_timeline_events`
--

LOCK TABLES `booking_timeline_events` WRITE;
/*!40000 ALTER TABLE `booking_timeline_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `booking_timeline_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int DEFAULT NULL,
  `pickup_time` datetime DEFAULT NULL,
  `pickup_location` text,
  `dropoff_location` text,
  `passenger_count` int DEFAULT NULL,
  `vehicle_class` enum('SEDAN','SUV','VAN','BUS') DEFAULT NULL,
  `booking_status` enum('DRAFT','PENDING_REVIEW','AWAITING_USER_APPROVAL','AWAITING_PAYMENT','CONFIRMED','CANCELLED','EXPIRED') DEFAULT 'DRAFT',
  `review_outcome` enum('NOT_REVIEWED','APPROVED_AS_IS','MODIFIED','REJECTED') DEFAULT 'NOT_REVIEWED',
  `estimated_price` decimal(10,2) DEFAULT NULL,
  `reviewed_price` decimal(10,2) DEFAULT NULL,
  `final_price` decimal(10,2) DEFAULT NULL,
  `booking_reference` varchar(50) DEFAULT NULL,
  `active_change_request_id` int DEFAULT NULL,
  `submitted_at` datetime DEFAULT NULL,
  `reviewed_at` datetime DEFAULT NULL,
  `approved_at` datetime DEFAULT NULL,
  `payment_due_at` datetime DEFAULT NULL,
  `paid_at` datetime DEFAULT NULL,
  `revision_count` int NOT NULL DEFAULT '0',
  `cancellation_reason` enum('USER_DECLINED_QUOTE','USER_ABANDONED','OPERATOR_REJECTED','PAYMENT_TIMEOUT','SYSTEM') DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `customer_id` (`customer_id`),
  KEY `fk_active_change_request` (`active_change_request_id`),
  KEY `idx_booking_status` (`booking_status`),
  CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  CONSTRAINT `fk_active_change_request` FOREIGN KEY (`active_change_request_id`) REFERENCES `change_requests` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
INSERT INTO `bookings` VALUES (1,1,'2026-05-10 09:00:00','Tokyo','Hakone',2,'SEDAN','CONFIRMED','NOT_REVIEWED',25000.00,25000.00,25000.00,'BK001',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,'2026-04-13 07:28:57'),(2,2,'2026-05-12 10:00:00','Osaka','Kyoto',3,'VAN','PENDING_REVIEW','NOT_REVIEWED',30000.00,NULL,NULL,'BK002',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,'2026-04-13 07:28:57'),(3,1,'2026-05-15 08:00:00','Tokyo','Narita Airport',2,'SEDAN','AWAITING_PAYMENT','NOT_REVIEWED',18000.00,20000.00,20000.00,'BK003',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,'2026-04-13 07:28:57'),(4,2,'2026-05-20 14:00:00','Tokyo','Mt Fuji',2,'SEDAN','CONFIRMED','NOT_REVIEWED',40000.00,40000.00,40000.00,'BK004',1,NULL,NULL,NULL,NULL,NULL,0,NULL,'2026-04-13 07:28:57');
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `change_request_items`
--

DROP TABLE IF EXISTS `change_request_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `change_request_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `change_request_id` int DEFAULT NULL,
  `field_name` varchar(100) DEFAULT NULL,
  `old_value` text,
  `new_value` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `change_request_id` (`change_request_id`),
  CONSTRAINT `change_request_items_ibfk_1` FOREIGN KEY (`change_request_id`) REFERENCES `change_requests` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `change_request_items`
--

LOCK TABLES `change_request_items` WRITE;
/*!40000 ALTER TABLE `change_request_items` DISABLE KEYS */;
INSERT INTO `change_request_items` VALUES (1,1,'passenger_count','2','4','2026-04-13 07:28:57'),(2,1,'vehicle_class','SEDAN','VAN','2026-04-13 07:28:57'),(3,2,'vehicle_class','VAN','SEDAN','2026-04-13 07:28:57');
/*!40000 ALTER TABLE `change_request_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `change_requests`
--

DROP TABLE IF EXISTS `change_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `change_requests` (
  `id` int NOT NULL AUTO_INCREMENT,
  `booking_id` int DEFAULT NULL,
  `status` enum('INITIATED','PENDING_REVIEW','AWAITING_USER_APPROVAL','AWAITING_PAYMENT','AWAITING_REFUND','COMPLETED','REJECTED','CANCELLED','EXPIRED') DEFAULT NULL,
  `review_outcome` enum('NOT_REVIEWED','APPROVED_AS_IS','MODIFIED','REJECTED') DEFAULT 'NOT_REVIEWED',
  `operator_note` text,
  `reviewed_by` int DEFAULT NULL,
  `price_difference` decimal(10,2) DEFAULT NULL,
  `currency` varchar(10) DEFAULT NULL,
  `submitted_at` datetime DEFAULT NULL,
  `reviewed_at` datetime DEFAULT NULL,
  `resolved_at` datetime DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `booking_id` (`booking_id`),
  KEY `idx_change_request_status` (`status`),
  KEY `fk_cr_reviewed_by` (`reviewed_by`),
  CONSTRAINT `change_requests_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`),
  CONSTRAINT `fk_cr_reviewed_by` FOREIGN KEY (`reviewed_by`) REFERENCES `operators` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `change_requests`
--

LOCK TABLES `change_requests` WRITE;
/*!40000 ALTER TABLE `change_requests` DISABLE KEYS */;
INSERT INTO `change_requests` VALUES (1,4,'AWAITING_PAYMENT','MODIFIED',NULL,NULL,10000.00,'JPY','2026-04-13 16:28:57',NULL,NULL,NULL,'2026-04-13 07:28:57'),(2,1,'COMPLETED','MODIFIED',NULL,NULL,-5000.00,'JPY','2026-04-13 16:28:57',NULL,'2026-04-13 16:28:57',NULL,'2026-04-13 07:28:57');
/*!40000 ALTER TABLE `change_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `customer_booking_activity`
--

DROP TABLE IF EXISTS `customer_booking_activity`;
/*!50001 DROP VIEW IF EXISTS `customer_booking_activity`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `customer_booking_activity` AS SELECT 
 1 AS `event_id`,
 1 AS `booking_id`,
 1 AS `booking_reference`,
 1 AS `change_request_id`,
 1 AS `activity_label`,
 1 AS `event_type`,
 1 AS `actor_type`,
 1 AS `metadata`,
 1 AS `occurred_at`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `customer_notifications`
--

DROP TABLE IF EXISTS `customer_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_notifications` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `booking_id` int DEFAULT NULL,
  `change_request_id` int DEFAULT NULL,
  `channel` enum('EMAIL','SMS','PUSH') NOT NULL,
  `notification_type` enum('BOOKING_RECEIVED','QUOTE_READY','QUOTE_UPDATED','ACTION_REQUIRED','PAYMENT_DUE','PAYMENT_CONFIRMED','BOOKING_CONFIRMED','CHANGE_REQUEST_UPDATE','REFUND_ISSUED','BOOKING_CANCELLED','BOOKING_EXPIRED','REMINDER_PAYMENT','REMINDER_TRIP') NOT NULL,
  `status` enum('QUEUED','SENT','FAILED') NOT NULL DEFAULT 'QUEUED',
  `sent_at` datetime DEFAULT NULL,
  `failed_reason` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_cn_customer` (`customer_id`),
  KEY `idx_cn_booking` (`booking_id`),
  KEY `idx_cn_status` (`status`),
  KEY `fk_cn_change_request` (`change_request_id`),
  CONSTRAINT `fk_cn_booking` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`),
  CONSTRAINT `fk_cn_change_request` FOREIGN KEY (`change_request_id`) REFERENCES `change_requests` (`id`),
  CONSTRAINT `fk_cn_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_notifications`
--

LOCK TABLES `customer_notifications` WRITE;
/*!40000 ALTER TABLE `customer_notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `account_status` enum('ACTIVE','INACTIVE','SUSPENDED') DEFAULT 'ACTIVE',
  `last_login` datetime DEFAULT NULL,
  `created_account_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'John','Doe','john@example.com','1234567890','hash1','ACTIVE',NULL,'2026-04-13 07:28:57'),(2,'Jane','Smith','jane@example.com','0987654321','hash2','ACTIVE',NULL,'2026-04-13 07:28:57');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drivers`
--

DROP TABLE IF EXISTS `drivers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `drivers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `license_number` varchar(100) DEFAULT NULL,
  `office_location` enum('Tokyo','Osaka','Nagoya','Sapporo') NOT NULL,
  `is_available` tinyint(1) DEFAULT '1',
  `office_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_driver_office` (`office_id`),
  CONSTRAINT `fk_driver_office` FOREIGN KEY (`office_id`) REFERENCES `offices` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drivers`
--

LOCK TABLES `drivers` WRITE;
/*!40000 ALTER TABLE `drivers` DISABLE KEYS */;
INSERT INTO `drivers` VALUES (1,'Taro Yamada','09011112222','LIC123','Tokyo',1,1),(2,'Ken Suzuki','09033334444','LIC456','Tokyo',1,1),(3,'S. Tanaka','090-1111-0001','LIC-T01','Tokyo',1,1),(4,'K. Sato','090-1111-0002','LIC-T02','Tokyo',1,1),(5,'I. Suzuki','090-1111-0003','LIC-T03','Tokyo',1,1),(6,'M. Takahashi','090-1111-0004','LIC-T04','Tokyo',1,1),(7,'Y. Watanabe','090-1111-0005','LIC-T05','Tokyo',1,1),(8,'H. Ito','090-1111-0006','LIC-T06','Tokyo',1,1),(9,'R. Yamamoto','090-1111-0007','LIC-T07','Tokyo',1,1),(10,'N. Nakamura','090-1111-0008','LIC-T08','Tokyo',1,1),(11,'T. Kobayashi','090-1111-0009','LIC-T09','Tokyo',1,1),(12,'A. Kato','090-1111-0010','LIC-T10','Tokyo',1,1);
/*!40000 ALTER TABLE `drivers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fleet_models`
--

DROP TABLE IF EXISTS `fleet_models`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fleet_models` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(100) DEFAULT NULL,
  `model_name` varchar(100) DEFAULT NULL,
  `vehicle_class` enum('SEDAN','SUV','VAN','BUS') DEFAULT NULL,
  `owner_type` enum('Self-Owned','Partner') DEFAULT NULL,
  `long_mileage_fee_jpy` int DEFAULT NULL,
  `overtime_fee_jpy` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fleet_models`
--

LOCK TABLES `fleet_models` WRITE;
/*!40000 ALTER TABLE `fleet_models` DISABLE KEYS */;
/*!40000 ALTER TABLE `fleet_models` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fleet_office_availability`
--

DROP TABLE IF EXISTS `fleet_office_availability`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fleet_office_availability` (
  `fleet_id` int NOT NULL,
  `office_location` enum('Tokyo','Osaka','Nagoya','Sapporo') NOT NULL,
  PRIMARY KEY (`fleet_id`,`office_location`),
  CONSTRAINT `fleet_office_availability_ibfk_1` FOREIGN KEY (`fleet_id`) REFERENCES `fleet_models` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fleet_office_availability`
--

LOCK TABLES `fleet_office_availability` WRITE;
/*!40000 ALTER TABLE `fleet_office_availability` DISABLE KEYS */;
/*!40000 ALTER TABLE `fleet_office_availability` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offices`
--

DROP TABLE IF EXISTS `offices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `offices` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `address` text,
  `max_radius` varchar(50) DEFAULT NULL,
  `radius_type` enum('kilometers','region') DEFAULT 'kilometers',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offices`
--

LOCK TABLES `offices` WRITE;
/*!40000 ALTER TABLE `offices` DISABLE KEYS */;
INSERT INTO `offices` VALUES (1,'Tokyo Office','1-1-1, Chuo-ku, Tokyo','400','kilometers'),(2,'Osaka Office','4 Chome-1-6 Senbachuo, Chuo Ward, Osaka, 541-0055','400','kilometers'),(3,'Nagoya Office','3 Chome-5-12, Sakae, Naka Ward, Nagoya, Aichi','400','kilometers'),(4,'Sapporo Office','Hokkaido, Sapporo, Shiroishi Ward, Kawashimo, 2651-3','Hokkaido','region');
/*!40000 ALTER TABLE `offices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operators`
--

DROP TABLE IF EXISTS `operators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `operators` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `role` enum('REVIEWER','ADMIN') NOT NULL DEFAULT 'REVIEWER',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_operator_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operators`
--

LOCK TABLES `operators` WRITE;
/*!40000 ALTER TABLE `operators` DISABLE KEYS */;
/*!40000 ALTER TABLE `operators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `booking_id` int DEFAULT NULL,
  `change_request_id` int DEFAULT NULL,
  `sales_order_id` int DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `currency` varchar(10) DEFAULT NULL,
  `type` enum('BOOKING_PAYMENT','CHANGE_ADDITIONAL_PAYMENT','REFUND') DEFAULT NULL,
  `status` enum('PENDING','SUCCEEDED','FAILED','REFUNDED') DEFAULT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `stripe_payment_intent_id` varchar(255) DEFAULT NULL,
  `stripe_refund_id` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `booking_id` (`booking_id`),
  KEY `change_request_id` (`change_request_id`),
  KEY `sales_order_id` (`sales_order_id`),
  KEY `idx_payment_status` (`status`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`),
  CONSTRAINT `payments_ibfk_2` FOREIGN KEY (`change_request_id`) REFERENCES `change_requests` (`id`),
  CONSTRAINT `payments_ibfk_3` FOREIGN KEY (`sales_order_id`) REFERENCES `sales_orders` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,1,NULL,1,25000.00,'JPY','BOOKING_PAYMENT','SUCCEEDED','CARD',NULL,NULL,'2026-04-13 07:28:57'),(2,3,NULL,2,20000.00,'JPY','BOOKING_PAYMENT','PENDING','CARD',NULL,NULL,'2026-04-13 07:28:57'),(3,4,NULL,3,40000.00,'JPY','BOOKING_PAYMENT','SUCCEEDED','CARD',NULL,NULL,'2026-04-13 07:28:57'),(4,NULL,1,NULL,10000.00,'JPY','CHANGE_ADDITIONAL_PAYMENT','PENDING','CARD',NULL,NULL,'2026-04-13 07:28:57'),(5,NULL,2,NULL,5000.00,'JPY','REFUND','SUCCEEDED','CARD',NULL,NULL,'2026-04-13 07:28:57');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_orders`
--

DROP TABLE IF EXISTS `sales_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales_orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `booking_id` int DEFAULT NULL,
  `change_request_id` int DEFAULT NULL,
  `order_number` varchar(50) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `currency` varchar(10) DEFAULT NULL,
  `state` enum('DRAFT','FINALIZED','CANCELLED') DEFAULT NULL,
  `status` enum('PENDING','PAID','FAILED') DEFAULT NULL,
  `quotation_sent_at` datetime DEFAULT NULL,
  `payment_due_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `booking_id` (`booking_id`),
  CONSTRAINT `sales_orders_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_orders`
--

LOCK TABLES `sales_orders` WRITE;
/*!40000 ALTER TABLE `sales_orders` DISABLE KEYS */;
INSERT INTO `sales_orders` VALUES (1,1,NULL,'SO001',25000.00,'JPY','FINALIZED','PAID',NULL,NULL,'2026-04-13 07:28:57'),(2,3,NULL,'SO002',20000.00,'JPY','FINALIZED','PENDING',NULL,NULL,'2026-04-13 07:28:57'),(3,4,NULL,'SO003',40000.00,'JPY','FINALIZED','PAID',NULL,NULL,'2026-04-13 07:28:57');
/*!40000 ALTER TABLE `sales_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trip_stops`
--

DROP TABLE IF EXISTS `trip_stops`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trip_stops` (
  `id` int NOT NULL AUTO_INCREMENT,
  `booking_id` int DEFAULT NULL,
  `stop_order` int DEFAULT NULL,
  `location` text,
  `arrival_time` datetime DEFAULT NULL,
  `stop_type` enum('PICKUP','DROPOFF','WAYPOINT') DEFAULT NULL,
  `stop_name` varchar(255) DEFAULT NULL,
  `duration_minutes` int DEFAULT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `booking_id` (`booking_id`),
  CONSTRAINT `trip_stops_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trip_stops`
--

LOCK TABLES `trip_stops` WRITE;
/*!40000 ALTER TABLE `trip_stops` DISABLE KEYS */;
INSERT INTO `trip_stops` VALUES (1,1,1,'Tokyo','2026-05-10 09:00:00','PICKUP',NULL,NULL,NULL,NULL),(2,1,2,'Hakone','2026-05-10 11:00:00','DROPOFF',NULL,NULL,NULL,NULL),(3,2,1,'Osaka','2026-05-12 10:00:00','PICKUP',NULL,NULL,NULL,NULL),(4,2,2,'Kyoto','2026-05-12 11:30:00','DROPOFF',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `trip_stops` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicles`
--

DROP TABLE IF EXISTS `vehicles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fleet_id` int NOT NULL,
  `plate_number` varchar(50) DEFAULT NULL,
  `vin` varchar(50) DEFAULT NULL,
  `odometer_reading` int DEFAULT NULL,
  `current_office` enum('Tokyo','Osaka','Nagoya','Sapporo') DEFAULT NULL,
  `office_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `vin` (`vin`),
  KEY `fk_vehicle_fleet` (`fleet_id`),
  KEY `fk_vehicle_office` (`office_id`),
  CONSTRAINT `fk_vehicle_fleet` FOREIGN KEY (`fleet_id`) REFERENCES `fleet_models` (`id`),
  CONSTRAINT `fk_vehicle_office` FOREIGN KEY (`office_id`) REFERENCES `offices` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicles`
--

LOCK TABLES `vehicles` WRITE;
/*!40000 ALTER TABLE `vehicles` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `customer_booking_activity`
--

/*!50001 DROP VIEW IF EXISTS `customer_booking_activity`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `customer_booking_activity` AS select `bte`.`id` AS `event_id`,`bte`.`booking_id` AS `booking_id`,`b`.`booking_reference` AS `booking_reference`,`bte`.`change_request_id` AS `change_request_id`,coalesce(`bte`.`display_text`,(case `bte`.`event_type` when 'BOOKING_CREATED' then 'Booking started' when 'BOOKING_SUBMITTED' then 'Request submitted' when 'QUOTE_APPROVED' then 'Quote confirmed — no changes' when 'QUOTE_MODIFIED' then 'Operator updated your quote' when 'QUOTE_REJECTED' then 'Request could not be fulfilled' when 'USER_ACCEPTED_QUOTE' then 'You accepted the updated quote' when 'USER_DECLINED_QUOTE' then 'You declined the updated quote' when 'PAYMENT_REQUESTED' then 'Payment requested' when 'PAYMENT_RECEIVED' then 'Payment received' when 'BOOKING_CONFIRMED' then 'Booking confirmed' when 'CHANGE_REQUEST_SUBMITTED' then 'Modification request submitted' when 'CHANGE_REQUEST_REVIEWED' then 'Modification reviewed' when 'CHANGE_REQUEST_COMPLETED' then 'Modification applied' when 'CHANGE_REQUEST_CANCELLED' then 'Modification cancelled' when 'BOOKING_CANCELLED' then 'Booking cancelled' when 'BOOKING_EXPIRED' then 'Booking expired' else `bte`.`event_type` end)) AS `activity_label`,`bte`.`event_type` AS `event_type`,`bte`.`actor_type` AS `actor_type`,`bte`.`metadata` AS `metadata`,`bte`.`created_at` AS `occurred_at` from (`booking_timeline_events` `bte` join `bookings` `b` on((`b`.`id` = `bte`.`booking_id`))) where ((`bte`.`event_type` <> 'REVIEW_STARTED') and ((`bte`.`actor_type` <> 'SYSTEM') or (`bte`.`event_type` in ('BOOKING_CONFIRMED','BOOKING_EXPIRED','PAYMENT_REQUESTED','CHANGE_REQUEST_COMPLETED')))) order by `bte`.`booking_id`,`bte`.`created_at` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-16 17:49:04
