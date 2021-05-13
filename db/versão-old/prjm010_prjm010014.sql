-- MariaDB dump 10.19  Distrib 10.4.18-MariaDB, for Win64 (AMD64)
--
-- Host: 127.0.0.1    Database: prjm010
-- ------------------------------------------------------
-- Server version	10.4.18-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `prjm010014`
--

DROP TABLE IF EXISTS `prjm010014`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prjm010014` (
  `visitant_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `daydate` date NOT NULL,
  `dayhour` time DEFAULT NULL,
  `company` varchar(100) DEFAULT NULL,
  `reason` varchar(100) DEFAULT NULL,
  `badge` char(3) NOT NULL,
  `auth` varchar(45) NOT NULL,
  `sign` varchar(100) NOT NULL,
  `dtregister` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`visitant_id`),
  KEY `FK_PRJM010014_PRJM010001_idx` (`person_id`),
  KEY `FK_PRJM010014_PRJM010013_idx` (`user_id`),
  CONSTRAINT `fk_PRJM010014_PRJM010001` FOREIGN KEY (`person_id`) REFERENCES `prjm010001` (`person_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRJM010014_PRJM010013` FOREIGN KEY (`user_id`) REFERENCES `prjm010013` (`user_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prjm010014`
--

LOCK TABLES `prjm010014` WRITE;
/*!40000 ALTER TABLE `prjm010014` DISABLE KEYS */;
INSERT INTO `prjm010014` VALUES (1,1,1,'2021-05-10','09:55:00','visitante','consulta','1','atendente','jorge','2021-05-10 17:45:39'),(2,2,1,'2021-05-12','09:07:00','VISITA','consulta','1','sim','gabriel','2021-05-12 14:33:58'),(3,3,1,'2021-05-12','09:07:00','VISITA','consulta','1','sim','gabriel','2021-05-12 14:40:28');
/*!40000 ALTER TABLE `prjm010014` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-05-13 15:25:44
