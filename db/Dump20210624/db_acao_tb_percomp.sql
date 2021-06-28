CREATE DATABASE  IF NOT EXISTS `db_acao` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `db_acao`;
-- MySQL dump 10.13  Distrib 8.0.25, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: db_acao
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
-- Table structure for table `tb_percomp`
--

DROP TABLE IF EXISTS `tb_percomp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_percomp` (
  `idpercomp` int NOT NULL AUTO_INCREMENT,
  `idperson` int NOT NULL,
  `idsgcompany` int NOT NULL,
  PRIMARY KEY (`idpercomp`),
  KEY `FK_percomps_person_idx_idx` (`idperson`),
  KEY `FK_percomp_sgcompany_idx_idx` (`idsgcompany`),
  CONSTRAINT `FK_percomp_person_idx` FOREIGN KEY (`idperson`) REFERENCES `tb_persons` (`idperson`) ON DELETE CASCADE,
  CONSTRAINT `FK_percomp_sgcompany_idx` FOREIGN KEY (`idsgcompany`) REFERENCES `tb_sgcompany` (`idsgcompany`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_percomp`
--

LOCK TABLES `tb_percomp` WRITE;
/*!40000 ALTER TABLE `tb_percomp` DISABLE KEYS */;
INSERT INTO `tb_percomp` VALUES (1,3,1),(2,4,2),(3,2,3),(4,3,4),(5,6,5),(6,7,6),(7,8,7),(8,5,8),(9,9,9),(10,10,10),(11,11,11),(12,12,12),(13,13,13),(14,14,14),(15,15,15),(16,16,16),(17,17,17),(18,18,18),(19,19,19),(20,20,20),(21,21,21),(22,22,22),(23,22,23),(24,23,24),(25,24,25),(26,22,26),(27,15,27),(28,15,28);
/*!40000 ALTER TABLE `tb_percomp` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-06-24 17:48:46
