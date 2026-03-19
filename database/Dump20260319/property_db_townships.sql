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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `townships`
--

LOCK TABLES `townships` WRITE;
/*!40000 ALTER TABLE `townships` DISABLE KEYS */;
INSERT INTO `townships` VALUES (1,'Green Valley Township','Hinjewadi Phase 2','Pune',18.5912000,73.7389000,'A premium township with modern amenities and vast open spaces.',45.50,'green_valley.jpg','2026-03-17 08:48:24'),(2,'Sunrise Smart City','Thane West','Mumbai',19.2183000,72.9781000,'A smart township with high-end apartments and IT parks.',60.00,'sunrise_city.jpg','2026-03-17 08:48:24'),(3,'Royal Heritage Township','Kondapur','Hyderabad',17.4562000,78.3639000,'Luxury township with villas, apartments, and club facilities.',55.75,'royal_heritage.jpg','2026-03-17 08:48:24'),(4,'Lake View Township','Whitefield','Bangalore',12.9698000,77.7500000,'Scenic township located beside a large lake.',40.00,'lake_view.jpg','2026-03-17 08:48:24'),(5,'qweefrf','jaipur','jaipur',25.0000000,75.0000000,'',1320.00,'1773742026808-Screenshot (2).png','2026-03-17 10:07:06'),(6,'Jawahar Nagar','Adarsh Nagar ','Jaipur',25.0000000,75.0000000,'good',25.00,'1773742993826-Screenshot (1).png','2026-03-17 10:23:13'),(7,'sdfged','Malviya nagar','Ajmer',25.0000000,75.0000000,'good',123.00,'1773743677939-Screenshot (1).png','2026-03-17 10:34:37'),(8,'Samrat Farm','Vardhman nagar','Jaipur',25.0000000,75.0000000,'Excellent',25.00,'1773744268733-Screenshot (2).png','2026-03-17 10:44:28'),(9,'Mahindra world city','Sitapura','Jaipur',40.0000000,85.0000000,'Industrical area',300.00,'1773747004938-Screenshot (3).png','2026-03-17 11:30:04'),(10,' Riyasat Krishnam Residency','Ajmer road','Ajmer',31.0000000,90.0000000,'place to visit',12.00,'1773751918559-Screenshot (1).png','2026-03-17 12:51:58'),(11,'Fatehpur sikri','southwest of agra','Agra',23.0000000,90.0000000,'Visiting place',123.00,'1773817544624-Screenshot (2).png','2026-03-18 07:05:44');
/*!40000 ALTER TABLE `townships` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-19 14:00:58
