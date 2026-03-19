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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-19 14:00:59
