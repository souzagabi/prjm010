CREATE DATABASE  IF NOT EXISTS `prjm010` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `prjm010`;
-- MySQL dump 10.13  Distrib 8.0.25, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: prjm010
-- ------------------------------------------------------
-- Server version	8.0.25

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
-- Table structure for table `prjm010012`
--

DROP TABLE IF EXISTS `prjm010012`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prjm010012` (
  `seq_classp_id` int NOT NULL AUTO_INCREMENT,
  `classification_id` int NOT NULL,
  `person_id` int NOT NULL,
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`seq_classp_id`,`classification_id`,`person_id`),
  KEY `FK_PRJM010012_PRJM010001_idx` (`person_id`),
  KEY `FK_PRJM010012_PRJM010011_idx` (`classification_id`),
  CONSTRAINT `fk_PRJM010012_PRJM010001` FOREIGN KEY (`person_id`) REFERENCES `prjm010001` (`person_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_PRJM010012_PRJM010011` FOREIGN KEY (`classification_id`) REFERENCES `prjm010011` (`classification_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=181 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prjm010012`
--

LOCK TABLES `prjm010012` WRITE;
/*!40000 ALTER TABLE `prjm010012` DISABLE KEYS */;
INSERT INTO `prjm010012` VALUES (1,4,1,'2021-05-25 00:35:42'),(2,5,2,'2021-06-21 16:49:58'),(3,5,3,'2021-06-21 19:45:41'),(17,2,4,'2021-08-10 20:37:05'),(18,2,5,'2021-08-10 20:41:49'),(22,2,9,'2021-08-10 20:44:21'),(23,2,10,'2021-08-10 20:47:42'),(24,2,11,'2021-08-10 20:50:01'),(25,2,12,'2021-08-11 12:54:31'),(26,2,13,'2021-08-11 13:02:03'),(27,2,14,'2021-08-11 13:04:25'),(28,2,15,'2021-08-11 13:08:44'),(29,2,16,'2021-08-11 13:10:26'),(31,2,18,'2021-08-11 13:13:53'),(32,2,19,'2021-08-11 13:16:56'),(33,2,20,'2021-08-11 16:57:04'),(34,2,21,'2021-08-11 18:00:34'),(35,2,22,'2021-08-12 15:40:08'),(36,2,23,'2021-08-12 15:54:08'),(38,2,25,'2021-08-12 16:24:42'),(40,2,27,'2021-08-12 16:26:26'),(41,2,28,'2021-08-12 17:11:56'),(42,2,29,'2021-08-12 17:25:56'),(43,5,30,'2021-08-16 17:04:51'),(44,5,31,'2021-08-16 17:18:56'),(45,2,32,'2021-08-17 16:23:26'),(46,2,33,'2021-08-17 18:23:17'),(47,2,34,'2021-08-17 18:25:26'),(48,2,35,'2021-08-17 19:08:17'),(49,2,36,'2021-08-17 19:12:13'),(50,2,37,'2021-08-18 16:01:10'),(51,2,38,'2021-08-18 16:04:11'),(52,2,39,'2021-08-18 17:32:52'),(53,2,40,'2021-08-19 17:55:51'),(54,2,41,'2021-08-19 17:58:56'),(55,2,42,'2021-08-19 17:58:56'),(56,2,43,'2021-08-19 17:58:56'),(57,2,44,'2021-08-23 11:41:07'),(58,2,45,'2021-08-23 11:44:40'),(59,2,46,'2021-08-23 18:59:50'),(60,2,47,'2021-08-24 17:12:48'),(61,2,48,'2021-08-24 20:33:21'),(62,2,49,'2021-08-25 17:52:11'),(63,2,50,'2021-08-25 17:55:29'),(64,2,51,'2021-08-26 13:40:21'),(65,2,52,'2021-08-26 17:10:56'),(66,2,53,'2021-08-26 18:12:51'),(67,2,54,'2021-08-26 18:48:45'),(68,2,55,'2021-08-26 19:31:34'),(69,2,56,'2021-08-26 19:34:48'),(70,2,57,'2021-08-31 11:56:19'),(71,2,58,'2021-08-31 12:35:50'),(73,2,60,'2021-08-31 15:22:05'),(74,2,61,'2021-08-31 15:49:52'),(75,2,62,'2021-08-31 15:49:52'),(76,2,63,'2021-08-31 15:51:36'),(77,2,64,'2021-08-31 17:11:20'),(78,2,65,'2021-08-31 19:14:59'),(79,2,66,'2021-08-31 19:18:40'),(80,2,67,'2021-08-31 19:18:40'),(81,2,68,'2021-09-01 13:24:07'),(82,2,69,'2021-09-01 20:53:06'),(83,2,70,'2021-09-02 14:36:05'),(84,2,71,'2021-09-08 13:50:47'),(85,2,72,'2021-09-08 17:58:02'),(86,2,73,'2021-09-10 13:59:10'),(87,2,74,'2021-09-13 14:45:07'),(88,2,75,'2021-09-13 18:16:25'),(89,2,76,'2021-09-15 19:14:24'),(90,2,77,'2021-09-16 19:04:41'),(91,2,78,'2021-09-16 19:34:12'),(92,2,79,'2021-09-17 13:58:12'),(93,2,80,'2021-09-20 19:51:19'),(94,2,81,'2021-09-21 12:43:36'),(95,2,82,'2021-09-21 20:20:04'),(96,2,83,'2021-09-21 20:31:41'),(97,2,84,'2021-09-21 20:34:52'),(98,2,85,'2021-09-21 20:36:54'),(99,2,86,'2021-09-21 21:16:49'),(100,2,87,'2021-09-27 22:30:21'),(101,2,88,'2021-09-28 13:40:04'),(102,2,89,'2021-09-30 14:17:01'),(103,2,90,'2021-09-30 14:19:05'),(104,2,91,'2021-09-30 17:03:52'),(105,2,92,'2021-10-04 12:16:46'),(106,2,93,'2021-10-04 18:00:24'),(107,2,94,'2021-10-04 18:02:35'),(108,2,95,'2021-10-04 20:22:02'),(109,2,96,'2021-10-05 13:42:52'),(110,2,97,'2021-10-05 20:38:30'),(112,2,99,'2021-10-06 12:14:00'),(113,2,100,'2021-10-06 16:45:10'),(114,2,101,'2021-10-06 19:36:39'),(115,2,102,'2021-10-06 19:41:12'),(117,2,104,'2021-10-07 16:50:29'),(118,2,105,'2021-10-07 19:10:37'),(119,2,106,'2021-10-07 19:39:13'),(120,2,107,'2021-10-07 20:31:51'),(121,2,108,'2021-10-11 21:26:02'),(122,2,109,'2021-10-13 15:29:06'),(123,2,110,'2021-10-13 17:55:34'),(124,2,111,'2021-10-14 16:39:19'),(125,2,112,'2021-10-14 18:02:20'),(126,2,113,'2021-10-14 20:38:54'),(127,2,114,'2021-10-14 20:40:38'),(128,2,115,'2021-10-14 20:40:38'),(129,2,116,'2021-10-15 12:23:19'),(130,2,117,'2021-10-16 14:46:44'),(131,2,118,'2021-10-19 16:46:04'),(132,2,119,'2021-10-19 16:46:04'),(133,2,120,'2021-10-19 20:07:46'),(134,2,121,'2021-10-20 12:08:06'),(135,2,122,'2021-10-20 16:43:22'),(136,2,123,'2021-10-21 18:07:15'),(137,2,124,'2021-10-21 18:07:15'),(138,2,125,'2021-10-21 19:16:26'),(139,2,126,'2021-10-22 19:34:26'),(140,2,127,'2021-10-22 19:36:35'),(141,2,128,'2021-10-25 19:52:56'),(142,2,129,'2021-10-26 10:37:40'),(143,2,130,'2021-10-26 16:40:31'),(144,2,131,'2021-10-26 16:40:31'),(145,2,132,'2021-10-26 18:29:53'),(146,2,133,'2021-10-27 17:14:27'),(147,2,134,'2021-10-27 20:00:43'),(148,2,135,'2021-10-27 20:10:48'),(149,2,136,'2021-10-27 20:10:48'),(150,2,137,'2021-10-28 15:20:10'),(151,2,138,'2021-10-30 12:20:15'),(152,2,139,'2021-10-30 12:20:15'),(153,2,140,'2021-10-30 12:22:51'),(154,2,141,'2021-10-30 12:22:51'),(155,2,142,'2021-11-03 18:57:04'),(156,2,143,'2021-11-04 20:42:20'),(157,2,144,'2021-11-06 11:46:08'),(158,2,145,'2021-11-06 11:46:09'),(159,2,146,'2021-11-06 11:47:54'),(160,2,147,'2021-11-09 13:59:56'),(161,2,148,'2021-11-10 12:40:48'),(162,2,149,'2021-11-10 18:41:12'),(163,2,150,'2021-11-10 18:51:29'),(164,2,151,'2021-11-10 18:51:29'),(165,2,152,'2021-11-10 19:02:19'),(166,2,153,'2021-11-11 17:44:04'),(167,2,154,'2021-11-16 17:09:37'),(168,2,155,'2021-11-16 17:09:37'),(171,2,158,'2021-11-17 16:29:17'),(172,2,159,'2021-11-17 18:12:52'),(173,2,160,'2021-11-18 17:07:51'),(174,2,161,'2021-11-18 17:53:26'),(175,2,162,'2021-11-18 20:04:07'),(176,2,163,'2021-11-18 20:05:10'),(177,2,164,'2021-11-23 18:04:00'),(178,2,165,'2021-11-24 16:28:38'),(179,2,166,'2021-11-25 17:47:26'),(180,2,167,'2021-11-25 19:26:27');
/*!40000 ALTER TABLE `prjm010012` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-26  4:53:21
