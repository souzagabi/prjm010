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
-- Table structure for table `prjm010016`
--

DROP TABLE IF EXISTS `prjm010016`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prjm010016` (
  `goods_id` int NOT NULL AUTO_INCREMENT,
  `person_id` int NOT NULL,
  `daydate` date NOT NULL,
  `dayhour` time NOT NULL,
  `goods` varchar(100) DEFAULT NULL,
  `qtde` decimal(10,2) DEFAULT NULL,
  `packing` char(1) DEFAULT NULL,
  `receiver` varchar(100) DEFAULT NULL,
  `deliveryman` varchar(100) DEFAULT NULL,
  `situation` char(1) DEFAULT '0',
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`goods_id`),
  KEY `FK_prjm010016_PRJM010001_idx` (`person_id`),
  CONSTRAINT `fk_prjm010016_PRJM010001` FOREIGN KEY (`person_id`) REFERENCES `prjm010001` (`person_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prjm010016`
--

LOCK TABLES `prjm010016` WRITE;
/*!40000 ALTER TABLE `prjm010016` DISABLE KEYS */;
INSERT INTO `prjm010016` VALUES (1,2,'2021-06-09','15:33:00','LENTES',1.00,'1','LEANDRO','CORREIO','0','2021-06-10 00:33:17'),(2,2,'2021-06-10','256:00:00','caixa de agua',1.00,'1','LEANDRO','LIANE','0','2021-06-10 20:46:47'),(3,2,'2021-06-16','14:50:00','diversos',3.00,'1','LEANDRO','CORREIO','0','2021-06-16 23:57:51'),(4,2,'2021-06-16','14:50:00','centro cirurgico',6.00,'0','LEANDRO','UBER','0','2021-06-16 23:58:31'),(5,2,'2021-06-18','10:52:00','centro cirurgico',2.00,'1','LEANDRO','GILMED','0','2021-06-18 19:53:11'),(6,2,'2021-06-18','10:30:00','lentes',1.00,'1','LEANDRO','CORREIO','0','2021-06-18 20:36:50'),(7,2,'2021-06-18','10:30:00','lentes',1.00,'1','LEANDRO','CORREIO','0','2021-06-18 20:36:50'),(8,2,'2021-06-30','11:56:00','elétrica',11.00,'1','LEANDRO','ELETROSUL','0','2021-06-30 17:57:25'),(9,3,'2021-07-02','13:42:00','lentes',1.00,'0','Marco','CORREIO','0','2021-07-02 19:44:29'),(11,3,'2021-07-02','13:45:00','particular',1.00,'0','Marco','CORREIO','0','2021-07-02 19:46:01'),(12,3,'2021-07-02','16:59:00','papelaria',2.00,'0','Marco','PAPELARIA PRUDENTINA','0','2021-07-02 23:00:25'),(13,2,'2021-07-05','11:32:00','oculos',9.00,'1','LEANDRO','CARRION','0','2021-07-05 17:33:06'),(14,2,'2021-07-05','12:40:00','particular',2.00,'1','LEANDRO','JAD LOG','0','2021-07-05 18:41:07'),(15,3,'2021-07-05','16:26:00','mangueiras',3.00,'0','Marco','ELETROSUL','0','2021-07-05 22:26:48'),(16,3,'2021-07-05','17:52:00','nota fiscal',1.00,'0','Marco','ECOCLEAN  LAVANDEIRIA ','0','2021-07-05 23:53:57'),(17,3,'2021-07-06','08:53:00','diversos',5.00,'0','Marco','PALACIO DAS TINTAS','0','2021-07-06 14:56:56'),(19,3,'2021-07-06','10:31:00','DOCUMENTOS',2.00,'0','Marco','UNIMED','0','2021-07-06 16:32:32'),(20,3,'2021-07-06','10:32:00','DOCUMENTOS',5.00,'0','Marco','CORREIO','0','2021-07-06 16:33:11'),(21,3,'2021-07-06','14:59:00','lentes',1.00,'0','Marco','CORREIOS','0','2021-07-06 20:59:42'),(22,3,'2021-07-06','15:23:00','diversos',3.00,'0','Marco','ELETROSUL','0','2021-07-06 21:23:59'),(23,3,'2021-07-07','09:32:00','DOCUMENTOS',1.00,'0','Marco','UNIMED','0','2021-07-07 15:33:35'),(24,3,'2021-07-07','14:48:00','lentes',1.00,'0','Marco','CORREIO','0','2021-07-07 20:48:27'),(25,3,'2021-07-08','10:11:00','lentes',1.00,'0','Marco','CORREIO','0','2021-07-08 16:11:23'),(26,3,'2021-07-12','13:10:00','lentes',2.00,'0','Marco','CORREIO','0','2021-07-12 19:10:39'),(27,3,'2021-07-12','14:55:00','medicamentos',1.00,'0','Marco','BRIX CARGO','0','2021-07-12 20:56:34'),(28,3,'2021-07-12','16:32:00','particular',1.00,'0','Marco','MERCADO LIVRE','0','2021-07-12 22:35:44'),(29,3,'2021-07-13','10:30:00','diversos',9.00,'0','Marco','CORREIO','0','2021-07-13 16:30:51'),(30,3,'2021-07-13','14:47:00','Produto de limpeza',3.00,'0','Marco','BIO USA','0','2021-07-13 20:49:33'),(31,3,'2021-07-22','13:05:00','medicamentos',1.00,'0','Marco','MAFRA','0','2021-07-22 19:15:58'),(32,3,'2021-07-22','13:26:00','lentes',2.00,'0','Marco','CORREIO','0','2021-07-22 19:27:12'),(33,3,'2021-07-22','13:27:00','diversos',1.00,'0','Marco','CORREIO','0','2021-07-22 19:27:35'),(34,3,'2021-07-22','15:35:00','diversos',2.00,'0','Marco','SANEPROL','0','2021-07-22 21:38:21'),(36,3,'2021-07-22','17:16:00','lentes',1.00,'0','LEANDRO','CORREIO','0','2021-07-22 23:16:33'),(37,3,'2021-07-23','10:21:00','DOCUMENTOS',4.00,'0','Marco','CORREIO','0','2021-07-23 16:21:49'),(38,3,'2021-07-23','13:56:00','DOCUMENTOS',5.00,'0','Marco','ENERGISA','0','2021-07-23 19:56:53'),(39,3,'2021-07-23','14:13:00','lentes',3.00,'0','Marco','CORREIO','0','2021-07-23 20:13:55'),(40,3,'2021-07-23','14:48:00','espanador',1.00,'0','Marco','SANEPROL','0','2021-07-23 20:49:01'),(41,3,'2021-07-23','16:58:00','medicamentos',1.00,'0','Marco','JAD LOG','0','2021-07-23 22:59:03'),(42,3,'2021-07-26','08:58:00','bobinas de papel',1.00,'0','Marco','PSP TRANSPORTADORA','0','2021-07-26 14:59:19'),(43,3,'2021-07-26','10:53:00','material  cirurgico ',1.00,'0','Marco','OXETIL ','0','2021-07-26 16:55:54'),(44,3,'2021-07-26','12:14:00','diversos',7.00,'0','Marco','MULFFATTO','0','2021-07-26 18:15:02'),(45,3,'2021-07-26','13:37:00','diversos',2.00,'0','Marco','CORREIO','0','2021-07-26 19:38:00'),(46,3,'2021-07-26','13:37:00','diversos',2.00,'0','Marco','CORREIO','0','2021-07-26 19:38:00'),(47,3,'2021-07-27','09:43:00','diversos',1.00,'0','Marco','FROTA FORTE TRASNSPORTE ','0','2021-07-27 15:46:40'),(49,3,'2021-07-27','10:07:00','boleto',1.00,'0','Marco','OXETIL ','0','2021-07-27 16:07:59'),(50,3,'2021-07-27','10:10:00','lentes',1.00,'0','Marco','CORREIO','0','2021-07-27 16:11:01'),(51,3,'2021-07-27','10:45:00','medicamentos',1.00,'0','Marco','T A TRANSPORTE ','0','2021-07-27 16:48:19'),(52,3,'2021-07-27','13:27:00','lentes',1.00,'0','Marco','CORREIO','0','2021-07-27 19:27:44'),(54,3,'2021-07-27','13:29:00','diversos',2.00,'0','Marco','CORREIO','0','2021-07-27 19:30:15'),(55,3,'2021-07-28','10:09:00','café',2.00,'0','Marco','CAFÉ CRUZEIRO DO SUL','0','2021-07-28 16:13:55'),(56,3,'2021-07-28','13:19:00','lentes',1.00,'0','Marco','CORREIO','0','2021-07-28 19:20:38'),(57,3,'2021-07-28','14:26:00','Produto de limpeza',2.00,'0','Marco','SANEPROL','0','2021-07-28 20:27:50'),(58,3,'2021-07-28','16:41:00','diversos',1.00,'0','Marco','RODONAVES','0','2021-07-28 22:43:08'),(59,3,'2021-07-29','13:35:00','lentes',2.00,'0','Marco','CORREIO','0','2021-07-29 19:36:01'),(60,3,'2021-07-29','13:36:00','lentes',1.00,'0','Marco','CORREIO','0','2021-07-29 19:36:17'),(61,3,'2021-07-29','16:14:00','medicamentos',5.00,'0','Marco','CANTINHO DO DIABETICO','0','2021-07-29 22:16:26'),(62,3,'2021-07-30','09:35:00','diversos',1.00,'0','Marco','MAQ CENTER','0','2021-07-30 15:36:17'),(63,3,'2021-08-02','09:08:00','DOCUMENTOS',2.00,'0','Marco','UNIMED','0','2021-08-02 15:08:46'),(64,3,'2021-08-02','10:14:00','DOCUMENTOS',3.00,'0','Marco','CORREIO','0','2021-08-02 16:15:21'),(65,2,'2021-08-02','12:23:00','centro cirurgico',4.00,'1','LEANDRO','SUPERMED','0','2021-08-02 18:24:09'),(66,3,'2021-08-02','13:13:00','DOCUMENTOS',1.00,'0','Marco','ENERGISA','0','2021-08-02 19:14:34'),(67,3,'2021-08-02','13:42:00','lentes',1.00,'0','Marco','CORREIO','0','2021-08-02 19:43:30'),(68,3,'2021-08-02','13:43:00','diversos',1.00,'0','Marco','CORREIO','0','2021-08-02 19:43:48'),(69,3,'2021-08-02','15:22:00','diversos',2.00,'0','Marco','PAPELARIA PRUDENTINA','0','2021-08-02 21:23:53'),(70,3,'2021-08-02','15:53:00','diversos',1.00,'0','Marco','ONE PLUS TRANSPORTE','0','2021-08-02 21:55:56'),(71,2,'2021-08-03','12:49:00','lentes',2.00,'1','LEANDRO','CORREIO','0','2021-08-03 18:49:15'),(72,3,'2021-08-03','13:33:00','diversos',1.00,'0','Marco','MERCADO LIVRE','0','2021-08-03 19:34:24'),(73,3,'2021-08-03','14:56:00','Produto de limpeza',60.00,'0','Marco','SCHINCARIOL','0','2021-08-03 20:58:31'),(75,3,'2021-08-03','15:32:00','medicamentos',6.00,'0','Marco','SUPERMED','0','2021-08-03 21:33:19'),(76,3,'2021-08-03','16:47:00','DOCUMENTOS',1.00,'0','Marco','CORREIO','0','2021-08-03 22:47:48'),(77,3,'2021-08-04','10:47:00','DOCUMENTOS',4.00,'0','Marco','CORREIO','0','2021-08-04 16:47:41'),(78,3,'2021-08-04','12:24:00','Produto de limpeza',3.00,'0','Marco','SCHINCARIOL','0','2021-08-04 18:25:13'),(80,3,'2021-08-04','13:17:00','lentes',2.00,'0','Marco','CORREIO','0','2021-08-04 19:17:44'),(81,3,'2021-08-04','13:18:00','lentes / medicamentos',3.00,'0','Marco','CORREIO','0','2021-08-04 19:19:50');
/*!40000 ALTER TABLE `prjm010016` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-08-06 17:44:52
