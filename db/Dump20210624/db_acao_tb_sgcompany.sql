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
-- Table structure for table `tb_sgcompany`
--

DROP TABLE IF EXISTS `tb_sgcompany`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_sgcompany` (
  `idsgcompany` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `idperson` int NOT NULL,
  PRIMARY KEY (`idsgcompany`),
  KEY `fk_sgcompsny_persons_idx_idx` (`idperson`),
  CONSTRAINT `fk_sgcompany_persons` FOREIGN KEY (`idperson`) REFERENCES `tb_persons` (`idperson`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_sgcompany`
--

LOCK TABLES `tb_sgcompany` WRITE;
/*!40000 ALTER TABLE `tb_sgcompany` DISABLE KEYS */;
INSERT INTO `tb_sgcompany` VALUES (1,'MGLU3',3),(2,'PETR3',4),(3,'ABEV3',2),(4,'SPRI3',5),(5,'KLBN11',6),(6,'ELET3',7),(7,'AZUL4',8),(8,'PETR4',5),(9,'EMBR3',9),(10,'SUZB3',10),(11,'SBSP3',11),(12,'JBSS3',12),(13,'COGN3',13),(14,'TPIS3',14),(15,'GOLL4',15),(16,'AMAR3',16),(17,'ETER3',17),(18,'LUPA3',18),(19,'VVAR3',19),(20,'TIET11',20),(21,'BBSE3',21),(22,'TAEE11',22),(23,'TAEE4',22),(24,'GUAR3',23),(25,'TOTS3',24),(26,'TAEE3',22),(27,'GOLL2',15),(28,'GOLLE240',15);
/*!40000 ALTER TABLE `tb_sgcompany` ENABLE KEYS */;
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
