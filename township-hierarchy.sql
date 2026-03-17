-- Township Hierarchy Tables

-- Drop existing tables if they exist
DROP TABLE IF EXISTS `apartments`;
DROP TABLE IF EXISTS `buildings`;
DROP TABLE IF EXISTS `projects`;
DROP TABLE IF EXISTS `townships`;

-- Township Table
CREATE TABLE `townships` (
  `township_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL UNIQUE,
  `location` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `latitude` decimal(10,7) DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `total_area_acres` decimal(10,2) DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`township_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Project Table
CREATE TABLE `projects` (
  `project_id` int NOT NULL AUTO_INCREMENT,
  `township_id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `phase` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT 'Planning',
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`project_id`),
  KEY `fk_projects_township` (`township_id`),
  CONSTRAINT `fk_projects_township` FOREIGN KEY (`township_id`) REFERENCES `townships` (`township_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Building Table
CREATE TABLE `buildings` (
  `building_id` int NOT NULL AUTO_INCREMENT,
  `project_id` int NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `block` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `floors` int DEFAULT NULL,
  `status` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT 'Under Construction',
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`building_id`),
  KEY `fk_buildings_project` (`project_id`),
  CONSTRAINT `fk_buildings_project` FOREIGN KEY (`project_id`) REFERENCES `projects` (`project_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Apartment Table
CREATE TABLE `apartments` (
  `apartment_id` int NOT NULL AUTO_INCREMENT,
  `building_id` int NOT NULL,
  `apartment_number` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `floor` int NOT NULL,
  `bhk` int NOT NULL,
  `carpet_area` decimal(8,2) NOT NULL,
  `built_area` decimal(8,2) DEFAULT NULL,
  `price` decimal(15,2) NOT NULL,
  `status` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT 'Available',
  `amenities` text COLLATE utf8mb4_unicode_ci,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`apartment_id`),
  KEY `fk_apartments_building` (`building_id`),
  CONSTRAINT `fk_apartments_building` FOREIGN KEY (`building_id`) REFERENCES `buildings` (`building_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
