-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: property_db
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Table structure for table `amenities`
--

DROP TABLE IF EXISTS `amenities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `amenities` (
  `amenity_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`amenity_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amenities`
--

LOCK TABLES `amenities` WRITE;
/*!40000 ALTER TABLE `amenities` DISABLE KEYS */;
INSERT INTO `amenities` VALUES (1,'Pools','swiming pools'),(2,'gym','24hours'),(4,'hotel','16 rooms'),(5,'cancel','dsfdsv');
/*!40000 ALTER TABLE `amenities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `apartments`
--

DROP TABLE IF EXISTS `apartments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `apartments` (
  `apartment_id` int NOT NULL AUTO_INCREMENT,
  `building_id` int NOT NULL,
  `apartment_number` varchar(50) NOT NULL,
  `floor` int NOT NULL,
  `bhk` int NOT NULL,
  `carpet_area` decimal(8,2) NOT NULL,
  `built_area` decimal(8,2) DEFAULT NULL,
  `price` decimal(15,2) NOT NULL,
  `status` varchar(100) DEFAULT 'Available',
  `amenities` text,
  `image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`apartment_id`),
  KEY `building_id` (`building_id`),
  CONSTRAINT `apartments_ibfk_1` FOREIGN KEY (`building_id`) REFERENCES `buildings` (`building_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apartments`
--

LOCK TABLES `apartments` WRITE;
/*!40000 ALTER TABLE `apartments` DISABLE KEYS */;
INSERT INTO `apartments` VALUES (1,1,'101',3,2,450.00,NULL,23445678.00,'Sold','Balcony , road side view etc','1773742413151-Screenshot (4).png','2026-03-17 10:13:33');
/*!40000 ALTER TABLE `apartments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bhk_options`
--

DROP TABLE IF EXISTS `bhk_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bhk_options` (
  `bhk` int NOT NULL,
  PRIMARY KEY (`bhk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bhk_options`
--

LOCK TABLES `bhk_options` WRITE;
/*!40000 ALTER TABLE `bhk_options` DISABLE KEYS */;
INSERT INTO `bhk_options` VALUES (1),(2),(3),(4),(5),(6),(7),(10),(33),(333),(342);
/*!40000 ALTER TABLE `bhk_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bhk_types`
--

DROP TABLE IF EXISTS `bhk_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bhk_types` (
  `bhk_id` int NOT NULL AUTO_INCREMENT,
  `bhk_name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`bhk_id`),
  UNIQUE KEY `bhk_name` (`bhk_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bhk_types`
--

LOCK TABLES `bhk_types` WRITE;
/*!40000 ALTER TABLE `bhk_types` DISABLE KEYS */;
INSERT INTO `bhk_types` VALUES (1,'1BHK'),(2,'2BHK'),(3,'3BHK'),(4,'4BHK'),(5,'5BHK');
/*!40000 ALTER TABLE `bhk_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `buildings`
--

DROP TABLE IF EXISTS `buildings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buildings` (
  `building_id` int NOT NULL AUTO_INCREMENT,
  `project_id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `block` varchar(50) DEFAULT NULL,
  `floors` int DEFAULT NULL,
  `status` varchar(100) DEFAULT 'Under Construction',
  `image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`building_id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `buildings_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`project_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buildings`
--

LOCK TABLES `buildings` WRITE;
/*!40000 ALTER TABLE `buildings` DISABLE KEYS */;
INSERT INTO `buildings` VALUES (1,1,'sdvfv','A',2,'Planning','1773742328123-Screenshot (6).png','2026-03-17 10:12:08'),(2,2,'Infosys','B',20,'Planning','1773747564447-Screenshot (3).png','2026-03-17 11:39:24'),(3,3,'20','A',2,'Under Construction','1773751997768-Screenshot (1).png','2026-03-17 12:53:17');
/*!40000 ALTER TABLE `buildings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `construction_statuses`
--

DROP TABLE IF EXISTS `construction_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `construction_statuses` (
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `construction_statuses`
--

LOCK TABLES `construction_statuses` WRITE;
/*!40000 ALTER TABLE `construction_statuses` DISABLE KEYS */;
INSERT INTO `construction_statuses` VALUES ('Ready to Move'),('Residensal'),('Under Construction');
/*!40000 ALTER TABLE `construction_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `construction_types`
--

DROP TABLE IF EXISTS `construction_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `construction_types` (
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `construction_types`
--

LOCK TABLES `construction_types` WRITE;
/*!40000 ALTER TABLE `construction_types` DISABLE KEYS */;
INSERT INTO `construction_types` VALUES ('New'),('Resale'),('Residensal'),('Residensalfedgd'),('Residensalfedgddsg'),('wfdg');
/*!40000 ALTER TABLE `construction_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `images` (
  `image_id` int NOT NULL AUTO_INCREMENT,
  `filename` varchar(255) DEFAULT NULL,
  `uploaded_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`image_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
INSERT INTO `images` VALUES (1,'1773321043940-Screenshot (4).png','2026-03-12 13:10:43');
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `owners`
--

DROP TABLE IF EXISTS `owners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `owners` (
  `owner_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`owner_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `owners`
--

LOCK TABLES `owners` WRITE;
/*!40000 ALTER TABLE `owners` DISABLE KEYS */;
INSERT INTO `owners` VALUES (1,'Default Owner','owner@example.com','123-456-7890');
/*!40000 ALTER TABLE `owners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projects` (
  `project_id` int NOT NULL AUTO_INCREMENT,
  `township_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text,
  `phase` varchar(50) DEFAULT NULL,
  `status` varchar(100) DEFAULT 'Planning',
  `image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`project_id`),
  KEY `township_id` (`township_id`),
  CONSTRAINT `projects_ibfk_1` FOREIGN KEY (`township_id`) REFERENCES `townships` (`township_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES (1,1,'sndjde','1223e3','phase 1','Under Development','1773742242018-Screenshot (2).png','2026-03-17 10:10:42'),(2,9,'IT Sector','It Sector','phase 2','Planning','1773747528993-Screenshot (3).png','2026-03-17 11:38:49'),(3,10,'Village project','Under construction','2','Under Development','1773751952385-Screenshot (1).png','2026-03-17 12:52:32');
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `properties`
--

DROP TABLE IF EXISTS `properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `properties` (
  `property_id` int NOT NULL AUTO_INCREMENT,
  `township_id` int DEFAULT NULL,
  `project_id` int DEFAULT NULL,
  `building_id` int DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `latitude` decimal(10,7) DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL,
  `bhk` int DEFAULT NULL,
  `property_type` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `construction_type` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `construction_status` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` decimal(15,2) DEFAULT NULL,
  `area_sqft` int DEFAULT NULL,
  `verified` tinyint(1) DEFAULT '0',
  `owner_id` int DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`property_id`),
  KEY `fk_properties_township` (`township_id`),
  KEY `fk_properties_project` (`project_id`),
  KEY `fk_properties_building` (`building_id`),
  KEY `fk_properties_bhk` (`bhk`),
  KEY `fk_properties_property_type` (`property_type`),
  KEY `fk_properties_construction_type` (`construction_type`),
  KEY `fk_properties_construction_status` (`construction_status`),
  KEY `fk_properties_owner` (`owner_id`),
  CONSTRAINT `fk_properties_bhk` FOREIGN KEY (`bhk`) REFERENCES `bhk_options` (`bhk`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_properties_building` FOREIGN KEY (`building_id`) REFERENCES `buildings` (`building_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_properties_construction_status` FOREIGN KEY (`construction_status`) REFERENCES `construction_statuses` (`name`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_properties_construction_type` FOREIGN KEY (`construction_type`) REFERENCES `construction_types` (`name`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_properties_owner` FOREIGN KEY (`owner_id`) REFERENCES `owners` (`owner_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_properties_project` FOREIGN KEY (`project_id`) REFERENCES `projects` (`project_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_properties_property_type` FOREIGN KEY (`property_type`) REFERENCES `property_types` (`name`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_properties_township` FOREIGN KEY (`township_id`) REFERENCES `townships` (`township_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `properties`
--

LOCK TABLES `properties` WRITE;
/*!40000 ALTER TABLE `properties` DISABLE KEYS */;
INSERT INTO `properties` VALUES (6,NULL,NULL,NULL,'djnjc','dcjndjrn','Malviya nagar',26.0000000,72.0000000,6,'Apartment','New','Ready to Move',38365828.00,1234,1,1,'1773751321260-Screenshot (1).png','2026-03-17 12:42:01'),(7,NULL,NULL,NULL,'ddjfndj','ndcdnc d','sdndemcncdm',29.0000000,80.0000000,6,'Villa','Residensal','Residensal',9474898483.00,1234,1,1,'1773751532245-Screenshot (1).png','2026-03-17 12:45:32'),(8,NULL,NULL,NULL,'efrfrdfrferf','dffcdc','fdcddf',34.0000000,54.0000000,10,'prsfdg','Residensal','Ready to Move',987654321.00,123,1,1,'1773751693455-Screenshot (6).png','2026-03-17 12:48:13');
/*!40000 ALTER TABLE `properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `property_types`
--

DROP TABLE IF EXISTS `property_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `property_types` (
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `property_types`
--

LOCK TABLES `property_types` WRITE;
/*!40000 ALTER TABLE `property_types` DISABLE KEYS */;
INSERT INTO `property_types` VALUES ('${encodeURIComponent(property)}'),('Apartment'),('prsfdg'),('Villa');
/*!40000 ALTER TABLE `property_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `townships`
--

DROP TABLE IF EXISTS `townships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `townships` (
  `township_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `city` varchar(100) NOT NULL,
  `latitude` decimal(10,7) DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL,
  `description` text,
  `total_area_acres` decimal(10,2) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`township_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `townships`
--

LOCK TABLES `townships` WRITE;
/*!40000 ALTER TABLE `townships` DISABLE KEYS */;
INSERT INTO `townships` VALUES (1,'Green Valley Township','Hinjewadi Phase 2','Pune',18.5912000,73.7389000,'A premium township with modern amenities and vast open spaces.',45.50,'green_valley.jpg','2026-03-17 08:48:24'),(2,'Sunrise Smart City','Thane West','Mumbai',19.2183000,72.9781000,'A smart township with high-end apartments and IT parks.',60.00,'sunrise_city.jpg','2026-03-17 08:48:24'),(3,'Royal Heritage Township','Kondapur','Hyderabad',17.4562000,78.3639000,'Luxury township with villas, apartments, and club facilities.',55.75,'royal_heritage.jpg','2026-03-17 08:48:24'),(4,'Lake View Township','Whitefield','Bangalore',12.9698000,77.7500000,'Scenic township located beside a large lake.',40.00,'lake_view.jpg','2026-03-17 08:48:24'),(5,'qweefrf','jaipur','jaipur',25.0000000,75.0000000,'',1320.00,'1773742026808-Screenshot (2).png','2026-03-17 10:07:06'),(6,'Jawahar Nagar','Adarsh Nagar ','Jaipur',25.0000000,75.0000000,'good',25.00,'1773742993826-Screenshot (1).png','2026-03-17 10:23:13'),(7,'sdfged','Malviya nagar','Ajmer',25.0000000,75.0000000,'good',123.00,'1773743677939-Screenshot (1).png','2026-03-17 10:34:37'),(8,'Samrat Farm','Vardhman nagar','Jaipur',25.0000000,75.0000000,'Excellent',25.00,'1773744268733-Screenshot (2).png','2026-03-17 10:44:28'),(9,'Mahindra world city','Sitapura','Jaipur',40.0000000,85.0000000,'Industrical area',300.00,'1773747004938-Screenshot (3).png','2026-03-17 11:30:04'),(10,' Riyasat Krishnam Residency','Ajmer road','Ajmer',31.0000000,90.0000000,'place to visit',12.00,'1773751918559-Screenshot (1).png','2026-03-17 12:51:58');
/*!40000 ALTER TABLE `townships` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `role` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-17 19:24:22
