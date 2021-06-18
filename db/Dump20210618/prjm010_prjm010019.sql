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
-- Table structure for table `prjm010019`
--

DROP TABLE IF EXISTS `prjm010019`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prjm010019` (
  `historic_id` int NOT NULL AUTO_INCREMENT,
  `fireexting_id` int NOT NULL,
  `daydate` date NOT NULL,
  `htrigger` char(1) DEFAULT NULL,
  `hose` char(1) DEFAULT NULL,
  `diffuser` char(1) DEFAULT NULL,
  `painting` char(1) DEFAULT NULL,
  `hydrostatic` char(1) DEFAULT NULL,
  `hothers` varchar(100) DEFAULT NULL,
  `user_id_deleted` int DEFAULT NULL,
  `dt_deleted` timestamp NULL DEFAULT NULL,
  `situation` char(1) DEFAULT '0',
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`historic_id`),
  KEY `FK_prjm010019_PRJM010018_idx` (`fireexting_id`),
  CONSTRAINT `fk_prjm010019_PRJM010018` FOREIGN KEY (`fireexting_id`) REFERENCES `prjm010018` (`fireexting_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prjm010019`
--

LOCK TABLES `prjm010019` WRITE;
/*!40000 ALTER TABLE `prjm010019` DISABLE KEYS */;
/*!40000 ALTER TABLE `prjm010019` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-06-18 17:02:12
