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
-- Table structure for table `prjm010017`
--

DROP TABLE IF EXISTS `prjm010017`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prjm010017` (
  `nobreak_id` int NOT NULL AUTO_INCREMENT,
  `person_id` int NOT NULL,
  `location_id` int NOT NULL,
  `local_id` int NOT NULL,
  `daydate` date NOT NULL,
  `dayhour` time NOT NULL,
  `name_person` varchar(100) DEFAULT NULL,
  `nobreakmodel` varchar(100) DEFAULT NULL,
  `resulttest` char(1) DEFAULT NULL,
  `observation` varchar(100) DEFAULT NULL,
  `serialnumber` varchar(50) DEFAULT NULL,
  `user_id_deleted` int DEFAULT NULL,
  `dt_deleted` timestamp NULL DEFAULT NULL,
  `situation` char(1) DEFAULT '0',
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`nobreak_id`),
  KEY `FK_prjm010017_PRJM010001_idx` (`person_id`),
  KEY `fk_prjm010017_PRJM010032_idx` (`location_id`),
  KEY `fk_prjm010017_PRJM010029_idx` (`local_id`),
  CONSTRAINT `fk_prjm010017_PRJM010001` FOREIGN KEY (`person_id`) REFERENCES `prjm010001` (`person_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_prjm010017_PRJM010029` FOREIGN KEY (`local_id`) REFERENCES `prjm010029` (`local_id`),
  CONSTRAINT `fk_prjm010017_PRJM010032` FOREIGN KEY (`location_id`) REFERENCES `prjm010032` (`location_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prjm010017`
--

LOCK TABLES `prjm010017` WRITE;
/*!40000 ALTER TABLE `prjm010017` DISABLE KEYS */;
INSERT INTO `prjm010017` VALUES (1,1,3,3,'2021-08-02','08:50:00','ADMINISTRADOR DO SISTEMA','BCF 13D F154','0','erew xzcxzczxcxz xzc xzcxzc','323443',1,'2021-08-02 12:14:47','1','2021-08-02 11:51:24');
/*!40000 ALTER TABLE `prjm010017` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-08-03  7:46:12
