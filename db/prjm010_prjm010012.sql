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
-- Table structure for table `prjm010012`
--

DROP TABLE IF EXISTS `prjm010012`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prjm010012` (
  `seq_classp_id` int(11) NOT NULL AUTO_INCREMENT,
  `classification_id` int(11) NOT NULL,
  `person_id` int(11) NOT NULL,
  `dtregister` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`seq_classp_id`,`classification_id`,`person_id`),
  KEY `FK_PRJM010012_PRJM010001_idx` (`person_id`),
  KEY `FK_PRJM010012_PRJM010011_idx` (`classification_id`),
  CONSTRAINT `fk_PRJM010012_PRJM010001` FOREIGN KEY (`person_id`) REFERENCES `prjm010001` (`person_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRJM010012_PRJM010011` FOREIGN KEY (`classification_id`) REFERENCES `prjm010011` (`classification_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prjm010012`
--

LOCK TABLES `prjm010012` WRITE;
/*!40000 ALTER TABLE `prjm010012` DISABLE KEYS */;
INSERT INTO `prjm010012` VALUES (1,3,1,'2021-05-10 12:55:48'),(2,1,2,'2021-05-12 14:33:57'),(3,1,3,'2021-05-12 14:40:28'),(4,3,4,'2021-05-14 17:35:04'),(5,1,5,'2021-05-14 18:21:17'),(6,1,6,'2021-05-14 18:23:48'),(7,2,7,'2021-05-14 19:18:30'),(8,1,8,'2021-05-14 19:18:52'),(9,3,9,'2021-05-14 19:19:26'),(10,2,10,'2021-05-14 19:19:57'),(11,2,11,'2021-05-14 19:20:26'),(12,3,12,'2021-05-14 19:20:48');
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

-- Dump completed on 2021-05-14 16:52:28
