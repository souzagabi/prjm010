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
-- Dumping events for database 'prjm010'
--

--
-- Dumping routines for database 'prjm010'
--
/*!50003 DROP PROCEDURE IF EXISTS `prc_airconditioning_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_airconditioning_delete`(
	par_airconditioning_id int(11),
    par_user_id int(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    UPDATE PRJM010026  
	SET 
		situation = 1,
		user_id_deleted = par_user_id,
		dt_deleted = now()
	WHERE airconditioning_id = par_airconditioning_id;
	
	IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao excluir registro na tabela de Ar Condicionado";
	ELSE
		SET MESSAGE = "SUCCESS: Registro excluído Extintor com sucesso!!" ;
	END IF;
    
	UPDATE PRJM010027  
	SET 
		situation = 1,
		user_id_deleted = par_user_id,
		dt_deleted = now()
	WHERE airconditioning_id = par_airconditioning_id;
	
	IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao excluir registro na tabela de Histórico";
	ELSE
		SET MESSAGE = "SUCCESS: Registro excluído Histórico com sucesso!!" ;
	END IF;
	
	IF EX = 1 THEN
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Registro excluído com sucesso!!" ;
        SELECT MESSAGE;
		COMMIT;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_airconditioning_save` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_airconditioning_save`(
	par_person_id int(11),
	par_location varchar(100)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    INSERT INTO PRJM010026
		(person_id,location)
		VALUES(par_person_id,par_location);
    
    IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao gravar registro na tabela PRJM010026";
	END IF;
   
   IF EX = 1 THEN
		SELECT MESSAGE;
        ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Dados salvos com sucesso!!";
        SELECT MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_airconditioning_sel` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_airconditioning_sel`(
	par_daydate varchar(10),
    par_date_fim varchar(10),
    par_start INT(10),
    par_limit INT(10)
)
BEGIN
	
    DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    SET @sql = CONCAT('SELECT *, (SELECT count(airconditioning_id) FROM PRJM010026) / ', par_limit, ' AS pgs');
	SET @sql = CONCAT(@sql, ' FROM PRJM010026 PRJM026  ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM026.situation = 0 ');
	
	IF par_daydate IS NOT NULL AND par_daydate != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM026.daydate >= "', par_daydate, '"');
	END IF;
	
	IF par_date_fim IS NOT NULL AND par_date_fim != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM026.daydate <= "',par_date_fim, '"');
	END IF;
	SET @sql = CONCAT(@sql, ' LIMIT ', par_start, ', ', par_limit);
	
	#SELECT @sql;
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	
	IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao filtrar registro na tabela PRJM010026";
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Dados salvo com sucesso!!" ;
		SELECT MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_airconditioning_sel_byid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_airconditioning_sel_byid`(
	par_airconditioning_id INT(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    SET @sql = CONCAT('SELECT * ');
	SET @sql = CONCAT(@sql, ' FROM PRJM010026 PRJM026 ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010010 PRJM010 USING(person_id) ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM026.airconditioning_id = "', par_airconditioning_id, '"');
    
    PREPARE STMT FROM @sql;
    EXECUTE STMT;
    
    IF EX = 1 THEN
		SELECT MESSAGE = "ERROR: Erro ao filtrar registro na tabela de Ar Condicionado";
		ROLLBACK;
	ELSE
		SELECT "SUCCESS: Dados filtrado com sucesso!!" MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_airconditioning_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_airconditioning_update`(
	par_airconditioning_id int(11),
    par_person_id int(11),
	par_location varchar(100)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
	UPDATE PRJM010026
	SET
		person_id       = par_person_id,
		location        = par_location
	WHERE airconditioning_id = par_airconditioning_id;
	
	IF EX = 1 THEN
		SET MESSAGE = CONCAT("ERROR: Erro ao atualizar registro na tabela de Ar Condicionado ");
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = CONCAT("SUCCESS: Dados atualizados com sucesso!! ") ;
        SELECT MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_anualplan_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_anualplan_delete`(
	par_anualplan_id int(11),
    par_user_id int(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERRO: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    UPDATE PRJM010030 
    SET
		situation = 1,
		user_id_deleted = par_user_id,
		dt_deleted = now()
        
	WHERE anualplan_id = par_anualplan_id;
    
    IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao filtrar registro na tabela PRJM010030";
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Dados excluído com sucesso!!" ;
		SELECT MESSAGE;
		COMMIT;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_anualplan_save` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_anualplan_save`(
	par_yyear int(11),
	par_equipament_id int(11),
	par_location_id int(11),
	par_person_id int(11),
	par_frequency varchar(50),
	par_amonth varchar(20),
	par_dtprevision date,
	par_rstatus int(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    INSERT INTO PRJM010030 (yyear,equipament_id,location_id,person_id,frequency,amonth,dtprevision,rstatus) 
		VALUES (par_yyear,par_equipament_id,par_location_id,par_person_id,par_frequency,par_amonth,par_dtprevision,par_rstatus);
    
    IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao filtrar registro na tabela PRJM010030";
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Dados filtrado com sucesso!!" ;
		SELECT MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_anualplan_sel` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_anualplan_sel`(
	par_start INT(10),
    par_limit INT(10)
)
BEGIN
	
    DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    SET @sql = CONCAT('SELECT PRJM010.name_person as responsable, PRJM030.*,PRJM029.*,PRJM028.*, (SELECT count(anualplan_id) FROM PRJM010030) / ', par_limit, ' AS pgs');
	SET @sql = CONCAT(@sql, ' FROM PRJM010030 PRJM030  ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010010 PRJM010 ON PRJM010.person_id = PRJM030.person_id ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010029 PRJM029 ON PRJM029.location_id = PRJM030.location_id  ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010028 PRJM028 ON PRJM028.equipament_id = PRJM030.equipament_id  ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM030.situation = 0 ');
	
	IF par_daydate IS NOT NULL AND par_daydate != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM030.daydate >= "', par_daydate, '"');
	END IF;
	
	SET @sql = CONCAT(@sql, ' LIMIT ', par_start, ', ', par_limit);
	
	#SELECT @sql;
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	
	IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao filtrar registro na tabela PRJM010030";
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Dados filtrado com sucesso!!" ;
		SELECT MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_anualplan_sel_byid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_anualplan_sel_byid`(
	par_anualplan_id int(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    
    SET @sql = CONCAT('SELECT * ');
	SET @sql = CONCAT(@sql, ' FROM PRJM010030 PRJM030 ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010010 PRJM010 ON PRJM010.person_id = PRJM030.person_id ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010028 PRJM028 ON PRJM028.equipament_id = PRJM030.equipament_id ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010029 PRJM029 ON PRJM029.location_id = PRJM030.location_id ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM030.anualplan_id = "', par_anualplan_id, '"');
    
    #SELECT @sql;
    PREPARE STMT FROM @sql;
    EXECUTE STMT;
    
    IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao filtrar registro na tabela PRJM010030";
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Dados filtrado com sucesso!!" ;
		SELECT MESSAGE;
		COMMIT;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_anualplan_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_anualplan_update`(
	par_anualplan_id int(11),
    par_yyear int(11),
	par_equipament_id int(11),
	par_location_id int(11),
	par_person_id int(11),
	par_frequency varchar(50),
	par_amonth varchar(20),
	par_dtprevision date,
	par_rstatus int(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    UPDATE PRJM010030 
	SET
			yyear          = par_yyear,
            equipament_id  = par_equipament_id,
            location_id    = par_location_id,
            person_id      = par_person_id,
            frequency      = par_frequency,
            amonth         = par_amonth,
            dtprevision    = par_dtprevision,
            rstatus        = par_rstatus
            
	WHERE anualplan_id = par_anualplan_id;
    
    IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao filtrar registro na tabela PRJM010030";
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Dados filtrado com sucesso!!" ;
		SELECT MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_classification_sel` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_classification_sel`()
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
	SELECT * FROM PRJM010011 ORDER BY PRJM010011.description;
    
    IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao filtrar tabela PRJM010011!!";
		SELECT MESSAGE;
        ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Dados salvos com sucesso!!";
        SELECT MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_clothing_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_clothing_delete`(
	par_clothing_id int(11),
    par_user_id int(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    	       
	SET @sql = CONCAT('UPDATE PRJM010022  ');
	SET @sql = CONCAT(@sql,' SET situation = 1,');
	SET @sql = CONCAT(@sql,' user_id_deleted = ',par_user_id,',');
	SET @sql = CONCAT(@sql,' dt_deleted = ','"',now(),'"');
	SET @sql = CONCAT(@sql,' WHERE clothing_id = ',par_clothing_id,';');
	
	#SELECT @sql;
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao excluir registro na tabela de roupas";
	END IF;
	
    IF EX = 1 THEN
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Registro excluído com sucesso!!" ;
        SELECT MESSAGE;
		COMMIT;
	END IF;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_clothing_save` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_clothing_save`(
	par_person_id int(11),
	par_dateout varchar(10),
	par_qtdeout int(11),
	par_signout varchar(50),
	par_datein varchar(10),
	par_qtdein int(11),
	par_signin varchar(50)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    set @sql = concat('INSERT INTO PRJM010022 ');
	set @sql = concat(@sql, ' (person_id,dateout,qtdeout,signout');
	
    IF par_datein IS NOT NULL AND par_datein != '' THEN
		set @sql = concat(@sql, ',datein,qtdein,signin');
 	END IF;
    
    set @sql = concat(@sql, ' )');
    set @sql = concat(@sql, ' VALUES (',par_person_id,',"',par_dateout,'",',par_qtdeout,',"',par_signout,'"');
    
    IF par_datein IS NOT NULL AND par_datein != '' THEN
		set @sql = concat(@sql,',"', par_datein,'",',par_qtdein,',"',par_signin,'"');
    END IF;
    
    set @sql = concat(@sql, ');');
    
	IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao gravar registro na tabela PRJM010022";
	END IF;
   
    #select @sql;
    PREPARE STMT FROM @sql;
    EXECUTE STMT;
    
	IF EX = 1 THEN
		SELECT MESSAGE;
        ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Dados salvos com sucesso!!";
        SELECT MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_clothing_sel` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_clothing_sel`(
	par_daydate varchar(10),
    par_date_fim varchar(10),
    par_start INT(10),
    par_limit INT(10)
)
BEGIN
	
    DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
	SET @sql = CONCAT('SELECT *, (SELECT count(clothing_id) FROM PRJM010022) / ', par_limit, ' AS pgs');
	SET @sql = CONCAT(@sql, ' FROM PRJM010022 PRJM022 ');
	SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010010 PRJM010 USING(person_id) ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM022.situation = 0 ');
	
	IF par_daydate IS NOT NULL AND par_daydate != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM022.dateout >= "', par_dateout, '"');
	END IF;
	
	IF par_date_fim IS NOT NULL AND par_date_fim != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM022.datein <= "',par_datein, '"');
	END IF;
		SET @sql = CONCAT(@sql, ' LIMIT ', par_start, ', ', par_limit);
	#SELECT @sql;
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	
	IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao filtrar registro na tabela PRJM010022";
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Dados salvo com sucesso!!" ;
		SELECT MESSAGE;
		COMMIT;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_clothing_sel_byid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_clothing_sel_byid`(
	par_clothing_id INT(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    SET @sql = CONCAT('SELECT * ');
	SET @sql = CONCAT(@sql, ' FROM PRJM010022 PRJM022 ');
    #SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010010 PRJM010 USING(person_id) ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM022.clothing_id = "', par_clothing_id, '"');
    
    PREPARE STMT FROM @sql;
    EXECUTE STMT;
    
    IF EX = 1 THEN
		SELECT MESSAGE = "ERROR: Erro ao filtrar registro na tabela de roupas";
		ROLLBACK;
	ELSE
		SELECT "SUCCESS: Dados filtrado com sucesso!!" MESSAGE;
		COMMIT;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_clothing_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_clothing_update`(
	par_clothing_id int(11),
	par_person_id int(11),
	par_dateout varchar(10),
	par_qtdeout int(11),
	par_signout varchar(50),
	par_datein varchar(10),
	par_qtdein int(11),
	par_signin varchar(50)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
	UPDATE PRJM010022
	SET
		person_id      = par_person_id,
		dateout        = par_dateout,
		qtdeout        = par_qtdeout,
		signout        = par_signout,
		datein         = par_datein,
		qtdein         = par_qtdein,
		signin         = par_signin
	WHERE clothing_id 	= par_clothing_id;
	
	IF EX = 1 THEN
		SET MESSAGE = CONCAT("ERROR: Erro ao atualizar registro na tabela de roupas ");
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = CONCAT("SUCCESS: Dados atualizados com sucesso!! ") ;
        SELECT MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_equipament_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_equipament_delete`(
	par_equipament_id int(11),
    par_user_id int(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    UPDATE PRJM010028 
    SET
		situation = 1,
		user_id_deleted = par_user_id,
		dt_deleted = now()
	WHERE equipament_id = par_equipament_id;
    
    UPDATE PRJM010030
    SET
		situation = 1,
		user_id_deleted = par_user_id,
		dt_deleted = now()
	WHERE equipament_id = par_equipament_id;
        
    IF EX = 1 THEN
		SELECT MESSAGE = "ERROR: Erro ao excluir registro na tabela PRJM010028";
	END IF;
    
    IF EX = 1 THEN
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SELECT "SUCCESS: Registro excluído com sucesso!!" MESSAGE;
		COMMIT;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_equipament_save` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_equipament_save`(
	par_desequipament varchar(64)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    INSERT INTO PRJM010028 (desequipament) VALUES (par_desequipament);
        
    IF EX = 1 THEN
		SELECT MESSAGE = "ERROR: Erro ao gravar registro na tabela PRJM010029";
	END IF;
	
    IF EX = 1 THEN
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SELECT "SUCCESS: Dados salvos com sucesso!!" MESSAGE;
		COMMIT;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_equipament_sel` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_equipament_sel`(
	par_start INT(10),
    par_limit INT(10)
)
BEGIN
	
    DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    SET @sql = CONCAT('SELECT *, (SELECT count(equipament_id) FROM PRJM010028) / ', par_limit, ' AS pgs');
	SET @sql = CONCAT(@sql, ' FROM PRJM010028 PRJM028  ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM028.situation = 0 ');
	
	SET @sql = CONCAT(@sql, ' LIMIT ', par_start, ', ', par_limit);
	
	#SELECT @sql;
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	
	IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao filtrar registro na tabela PRJM010028";
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Dados filtrado com sucesso!!" ;
		SELECT MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_equipament_sel_byid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_equipament_sel_byid`(
	par_equipament_id INT(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    SET @sql = CONCAT('SELECT * ');
	SET @sql = CONCAT(@sql, ' FROM PRJM010028 PRJM028 ');
    #SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010010 PRJM010 USING(person_id) ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM028.equipament_id = "', par_equipament_id, '"');
    
    PREPARE STMT FROM @sql;
    EXECUTE STMT;
    
    IF EX = 1 THEN
		SELECT MESSAGE = "ERROR: Erro ao filtrar registro na tabela de equipamento";
		ROLLBACK;
	ELSE
		SELECT "SUCCESS: Dados filtrado com sucesso!!" MESSAGE;
		COMMIT;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_equipament_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_equipament_update`(
	par_equipament_id int(11),
    par_desequipament varchar(64)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    UPDATE PRJM010028 SET desequipament = par_desequipament WHERE equipament_id = par_equipament_id;
        
    IF EX = 1 THEN
		SELECT MESSAGE = "ERROR: Erro ao atualizar registro na tabela PRJM010028";
	END IF;
	
    IF EX = 1 THEN
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SELECT "SUCCESS: Registro atualizados com sucesso!!" MESSAGE;
		COMMIT;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_fireexting_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_fireexting_delete`(
	par_fireexting_id int(11),
    par_user_id int(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    UPDATE PRJM010018  
	SET 
		situation = 1,
		user_id_deleted = par_user_id,
		dt_deleted = now()
	WHERE fireexting_id = par_fireexting_id;
	
	IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao excluir registro na tabela de Extintor";
	ELSE
		SET MESSAGE = "SUCCESS: Registro excluído Extintor com sucesso!!" ;
	END IF;
    
	UPDATE PRJM010019  
	SET 
		situation = 1,
		user_id_deleted = par_user_id,
		dt_deleted = now()
	WHERE fireexting_id = par_fireexting_id;
	
	IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao excluir registro na tabela de Histórico";
	ELSE
		SET MESSAGE = "SUCCESS: Registro excluído Histórico com sucesso!!" ;
	END IF;
	
	IF EX = 1 THEN
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Registro excluído com sucesso!!" ;
        SELECT MESSAGE;
		COMMIT;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_fireexting_save` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_fireexting_save`(
	par_person_id int(11),
	par_daydate date,
	par_dayhour time,
	par_location varchar(100),
	par_tipe varchar(20),
	par_weight varchar(10),
	par_capacity varchar(10),
	par_rechargedate date
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    INSERT INTO PRJM010018
		(person_id,daydate,dayhour,location,tipe,weight,capacity,rechargedate)
		VALUES(par_person_id,par_daydate,par_dayhour,par_location,par_tipe,par_weight,par_capacity,par_rechargedate);
    
    IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao gravar registro na tabela PRJM010018";
	END IF;
   
   IF EX = 1 THEN
		SELECT MESSAGE;
        ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Dados salvos com sucesso!!";
        SELECT MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_fireexting_sel` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_fireexting_sel`(
	par_daydate varchar(10),
    par_date_fim varchar(10),
    par_start INT(10),
    par_limit INT(10)
)
BEGIN
	
    DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    SET @sql = CONCAT('SELECT *, (SELECT count(fireexting_id) FROM PRJM010018) / ', par_limit, ' AS pgs');
	SET @sql = CONCAT(@sql, ' FROM PRJM010018 PRJM018  ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM018.situation = 0 ');
	
	IF par_daydate IS NOT NULL AND par_daydate != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM018.daydate >= "', par_daydate, '"');
	END IF;
	
	IF par_date_fim IS NOT NULL AND par_date_fim != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM018.daydate <= "',par_date_fim, '"');
	END IF;
	SET @sql = CONCAT(@sql, ' LIMIT ', par_start, ', ', par_limit);
	
	#SELECT @sql;
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	
	IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao filtrar registro na tabela PRJM010018";
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Dados salvo com sucesso!!" ;
		SELECT MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_fireexting_sel_byid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_fireexting_sel_byid`(
	par_fireexting_id INT(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    SET @sql = CONCAT('SELECT * ');
	SET @sql = CONCAT(@sql, ' FROM PRJM010018 PRJM018 ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010010 PRJM010 USING(person_id) ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM018.fireexting_id = "', par_fireexting_id, '"');
    
    PREPARE STMT FROM @sql;
    EXECUTE STMT;
    
    IF EX = 1 THEN
		SELECT MESSAGE = "ERROR: Erro ao filtrar registro na tabela de Extintor";
		ROLLBACK;
	ELSE
		SELECT "SUCCESS: Dados filtrado com sucesso!!" MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_fireexting_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_fireexting_update`(
	par_fireexting_id int(11),
    par_person_id int(11),
	par_daydate date,
	par_dayhour time,
	par_location varchar(100),
	par_tipe varchar(20),
	par_weight varchar(10),
	par_capacity varchar(10),
	par_rechargedate date
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
	UPDATE PRJM010018
	SET
		person_id       = par_person_id,
		daydate         = par_daydate,
		dayhour         = par_dayhour,
		location        = par_location,
		tipe            = par_tipe,
		weight          = par_weight,
		capacity        = par_capacity,
		rechargedate    = par_rechargedate
	WHERE fireexting_id = par_fireexting_id;
	
	IF EX = 1 THEN
		SET MESSAGE = CONCAT("ERROR: Erro ao atualizar registro na tabela de Extintor ");
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = CONCAT("SUCCESS: Dados atualizados com sucesso!! ") ;
        SELECT MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_goods_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_goods_delete`(
	par_goods_id int(11),
    par_user_id int(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
	SET @sql = CONCAT('UPDATE PRJM010016  ');
	SET @sql = CONCAT(@sql,' SET situation = 1,');
	SET @sql = CONCAT(@sql,' user_id_deleted = ',par_user_id,',');
	SET @sql = CONCAT(@sql,' dt_deleted = ','"',now(),'"');
	SET @sql = CONCAT(@sql,' WHERE goods_id = ',par_goods_id,';');
	
	#SELECT @sql;
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao excluir registro na tabela de materiais";
	END IF;
	
    IF EX = 1 THEN
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Registro excluído com sucesso!!" ;
        SELECT MESSAGE;
		COMMIT;
	END IF;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_goods_save` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_goods_save`(
	par_person_id int,
	par_daydate date,
	par_dayhour time,
	par_goods varchar(100),
	par_qtde numeric(10,2),
    par_packing char(1),
    par_receiver varchar(100),
    par_deliveryman varchar(100)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    INSERT INTO PRJM010016
		(person_id,daydate,dayhour,goods,qtde,packing,receiver,deliveryman)
		VALUES(par_person_id,par_daydate,par_dayhour,par_goods,par_qtde,par_packing,par_receiver,par_deliveryman);
     
	IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao gravar registro na tabela PRJM010016";
	END IF;
   
   IF EX = 1 THEN
		SELECT MESSAGE;
        ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Dados salvos com sucesso!!";
        SELECT MESSAGE;
		COMMIT;
	END IF; 
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_goods_sel` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_goods_sel`(
	par_receiver varchar(200),
    par_daydate varchar(10),
    par_date_fim varchar(10),
    par_start INT(10),
    par_limit INT(10)
)
BEGIN
	
    DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
        
	SET @sql = CONCAT('SELECT *, (SELECT count(goods_id) FROM PRJM010016) / ', par_limit, ' AS pgs');
	SET @sql = CONCAT(@sql, ' FROM (SELECT * FROM PRJM010016 PRJM016 LIMIT ', par_start, ', ', par_limit, ' ) AS PRJM016 ');
	SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010010 PRJM010 USING(person_id) ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM016.situation = 0 ');
	
	IF par_daydate IS NOT NULL AND par_daydate != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM016.daydate >= "', par_daydate, '"');
	END IF;
	
	IF par_date_fim IS NOT NULL AND par_date_fim != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM016.daydate <= "',par_date_fim, '"');
	END IF;
	
	IF par_receiver IS NOT NULL AND par_receiver != '' THEN
	BEGIN
		SET @sql = CONCAT(@sql, ' AND PRJM016.receiver LIKE "%', par_receiver, '%"' );
	END;
	END IF;
	
	#SELECT @sql;
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	
	IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao filtrar registro na tabela PRJM010016";
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Dados salvo com sucesso!!" ;
		SELECT MESSAGE;
		COMMIT;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_goods_sel_byid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_goods_sel_byid`(
	par_goods_id INT(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    SET @sql = CONCAT('SELECT * ');
	SET @sql = CONCAT(@sql, ' FROM PRJM010016 PRJM016 ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010010 PRJM010 USING(person_id) ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM016.goods_id = "', par_goods_id, '"');
    
    PREPARE STMT FROM @sql;
    EXECUTE STMT;
    
    IF EX = 1 THEN
		SELECT MESSAGE = "ERROR: Erro ao filtrar registro na tabela de materiais";
		ROLLBACK;
	ELSE
		SELECT "SUCCESS: Dados filtrado com sucesso!!" MESSAGE;
		COMMIT;
	END IF; #Fim do if EX = 1 THEN

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_goods_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_goods_update`(
	par_goods_id int,
    par_person_id int,
	par_daydate date,
	par_dayhour time,
	par_goods varchar(100),
	par_qtde numeric(10,2),
    par_packing char(1),
    par_receiver varchar(100),
    par_deliveryman varchar(100),
    par_situation tinyint(1)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
	UPDATE PRJM010016
	SET
		daydate		= par_daydate,
		dayhour		= par_dayhour,
		goods		= par_goods,
		qtde		= par_qtde,
		packing		= par_packing,
		receiver	= par_receiver,
		deliveryman	= par_deliveryman,
		situation	= par_situation
	WHERE goods_id 	= par_goods_id;
	
	IF EX = 1 THEN
		SET MESSAGE = CONCAT("ERROR: Erro ao atualizar registro na tabela de goods ");
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = CONCAT("SUCCESS: Dados atualizados com sucesso!! ") ;
        SELECT MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_historicA_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_historicA_delete`(
	par_historic_id int(11), 
    par_user_id int(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
	DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    	
	SET @sql = CONCAT('UPDATE PRJM010027  ');
	SET @sql = CONCAT(@sql,' SET situation = 1,');
	SET @sql = CONCAT(@sql,' user_id_deleted = ',par_user_id,',');
	SET @sql = CONCAT(@sql,' dt_deleted = "',now(),'"');
	SET @sql = CONCAT(@sql,' WHERE historic_id = ',par_historic_id,';');
	
	#SELECT @sql;
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao excluir registro na tabela de Histódico de Ar Condicionado";
	END IF;
	   
    IF EX = 1 THEN
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Registro excluído com sucesso!!" ;
        SELECT MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_historicA_save` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_historicA_save`(
	par_airconditioning_id int(11),
	par_inmonth varchar(15),
	par_daydate date
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    INSERT INTO PRJM010027
		(airconditioning_id,inmonth,daydate)
		VALUES(par_airconditioning_id,par_inmonth,par_daydate);
    
    IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao gravar registro na tabela PRJM010027";
	END IF;
   
   IF EX = 1 THEN
		SELECT MESSAGE;
        ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Dados salvos com sucesso!!";
        SELECT MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_historicA_sel` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_historicA_sel`(
	par_airconditioning_id int(11),
    par_daydate varchar(10),
    par_start INT(10),
    par_limit INT(10)
)
BEGIN
	
    DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    SET @sql = CONCAT('SELECT *, (SELECT count(airconditioning_id) FROM PRJM010027) / ', par_limit, ' AS pgs');
	SET @sql = CONCAT(@sql, ' FROM PRJM010026 PRJM026  ');
    SET @sql = CONCAT(@sql, ' LEFT JOIN PRJM010027 PRJM027 USING(airconditioning_id) ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM027.situation = 0 AND PRJM026.airconditioning_id = ',par_airconditioning_id);
	
	IF par_daydate IS NOT NULL AND par_daydate != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM027.daydate >= "', par_daydate, '"');
	END IF;
	
	SET @sql = CONCAT(@sql, ' LIMIT ', par_start, ', ', par_limit);
	
	#SELECT @sql;
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	  
    IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao filtrar registro na tabela PRJM010027";
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Dados salvo com sucesso!!" ;
		SELECT MESSAGE;
		COMMIT;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_historicA_sel_byid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_historicA_sel_byid`(
	par_historic_id INT(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    SET @sql = CONCAT('SELECT PRJM027.*');
	SET @sql = CONCAT(@sql, ' FROM PRJM010027 PRJM027 ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010026 PRJM026 USING(airconditioning_id) ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM027.historic_id = ', par_historic_id);
    
    #SELECT @sql;
    PREPARE STMT FROM @sql;
    EXECUTE STMT;
    
    IF EX = 1 THEN
		SELECT MESSAGE = "ERROR: Erro ao filtrar registro na tabela de Histórico";
		ROLLBACK;
	ELSE
		SELECT "SUCCESS: Dados filtrado com sucesso!!" MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_historicA_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_historicA_update`(
	par_historic_id int(11),
	par_airconditioning_id int(11),
	par_inmonth varchar(15),
    par_daydate varchar(10)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
	UPDATE PRJM010027
	SET
		airconditioning_id 	= par_airconditioning_id,
        inmonth				= par_inmonth,
		daydate         	= par_daydate
	WHERE historic_id 	= par_historic_id;
	
	IF EX = 1 THEN
		SET MESSAGE = CONCAT("ERROR: Erro ao atualizar registro na tabela de Histórico do Ar Condicionado ");
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = CONCAT("SUCCESS: Dados atualizados com sucesso!! ") ;
        SELECT MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_historicE_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_historicE_delete`(
	par_historic_id int(11), 
    par_user_id int(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
	DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    	
	SET @sql = CONCAT('UPDATE PRJM010019  ');
	SET @sql = CONCAT(@sql,' SET situation = 1,');
	SET @sql = CONCAT(@sql,' user_id_deleted = ',par_user_id,',');
	SET @sql = CONCAT(@sql,' dt_deleted = "',now(),'"');
	SET @sql = CONCAT(@sql,' WHERE historic_id = ',par_historic_id,';');
	
	#SELECT @sql;
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao excluir registro na tabela de Histódico de Extintor";
	END IF;
	   
    IF EX = 1 THEN
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Registro excluído com sucesso!!" ;
        SELECT MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_historicE_save` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_historicE_save`(
	par_fireexting_id int(11),
	par_daydate date,
	par_htrigger char(1),
	par_hose char(1),
	par_diffuser char(1),
	par_painting char(1),
	par_hydrostatic char(1),
	par_hothers varchar(100)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    INSERT INTO PRJM010019
		(fireexting_id,daydate,htrigger,hose,diffuser,painting,hydrostatic,hothers)
		VALUES(par_fireexting_id,par_daydate,par_htrigger,par_hose,par_diffuser,par_painting,par_hydrostatic,par_hothers);
    
    IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao gravar registro na tabela PRJM010019";
	END IF;
   
   IF EX = 1 THEN
		SELECT MESSAGE;
        ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Dados salvos com sucesso!!";
        SELECT MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_historicE_sel` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_historicE_sel`(
	par_fireexting_id int(11),
    par_daydate varchar(10),
    par_date_fim varchar(10),
    par_start INT(10),
    par_limit INT(10)
)
BEGIN
	
    DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    SET @sql = CONCAT('SELECT *, (SELECT count(fireexting_id) FROM PRJM010019) / ', par_limit, ' AS pgs');
	SET @sql = CONCAT(@sql, ' FROM PRJM010018 PRJM018  ');
    SET @sql = CONCAT(@sql, ' LEFT JOIN PRJM010019 PRJM019 USING(fireexting_id) ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM019.situation = 0 AND PRJM018.fireexting_id = ',par_fireexting_id);
	
	IF par_daydate IS NOT NULL AND par_daydate != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM019.daydate >= "', par_daydate, '"');
	END IF;
	
	IF par_date_fim IS NOT NULL AND par_date_fim != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM019.daydate <= "',par_date_fim, '"');
	END IF;
	SET @sql = CONCAT(@sql, ' LIMIT ', par_start, ', ', par_limit);
	
	#SELECT @sql;
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	  
    IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao filtrar registro na tabela PRJM010019";
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Dados salvo com sucesso!!" ;
		SELECT MESSAGE;
		COMMIT;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_historicE_sel_byid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_historicE_sel_byid`(
	par_historic_id INT(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    SET @sql = CONCAT('SELECT PRJM019.*');
	SET @sql = CONCAT(@sql, ' FROM PRJM010019 PRJM019 ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010018 PRJM018 USING(fireexting_id) ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM019.historic_id = ', par_historic_id);
    
    #SELECT @sql;
    PREPARE STMT FROM @sql;
    EXECUTE STMT;
    
    IF EX = 1 THEN
		SELECT MESSAGE = "ERROR: Erro ao filtrar registro na tabela de Histórico";
		ROLLBACK;
	ELSE
		SELECT "SUCCESS: Dados filtrado com sucesso!!" MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_historicE_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_historicE_update`(
	par_historic_id int(11),
	par_fireexting_id int(11),
	par_daydate varchar(10),
	par_htrigger char(1),
	par_hose char(1),
	par_diffuser char(1),
	par_painting char(1),
	par_hydrostatic char(1),
	par_hothers varchar(100)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
	UPDATE PRJM010019
	SET
		daydate         = par_daydate,
		htrigger        = par_htrigger,
		hose            = par_hose,
		diffuser        = par_diffuser,
		painting        = par_painting,
		hydrostatic     = par_hydrostatic,
		hothers         = par_hothers
	WHERE historic_id 	= par_historic_id;
	
	IF EX = 1 THEN
		SET MESSAGE = CONCAT("ERROR: Erro ao atualizar registro na tabela de Histórico de Extintor ");
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = CONCAT("SUCCESS: Dados atualizados com sucesso!! ") ;
        SELECT MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_historicH_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_historicH_delete`(
	par_historic_id int(11), 
    par_user_id int(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
	DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    	
	SET @sql = CONCAT('UPDATE PRJM010025  ');
	SET @sql = CONCAT(@sql,' SET situation = 1,');
	SET @sql = CONCAT(@sql,' user_id_deleted = ',par_user_id,',');
	SET @sql = CONCAT(@sql,' dt_deleted = "',now(),'"');
	SET @sql = CONCAT(@sql,' WHERE historic_id = ',par_historic_id,';');
	
	#SELECT @sql;
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao excluir registro na tabela de Histódico de Hidrante";
	END IF;
	   
    IF EX = 1 THEN
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Registro excluído com sucesso!!" ;
        SELECT MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_historicH_save` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_historicH_save`(
	par_hydrant_id int(11),
	par_daydate date,
	par_idkey char(1),
	par_hose char(1),
	par_squirt char(1),
	par_painting char(1),
	par_alarmcentral char(1),
	par_glass char(1),
	par_inlock char(1),
	par_record char(1),
	par_signaling char(1),
	par_obstruction char(1),
	par_observation varchar(255)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    INSERT INTO PRJM010025
		(hydrant_id,daydate,idkey,hose,squirt,painting,alarmcentral,glass,inlock,record,signaling,obstruction,observation)
		VALUES(par_hydrant_id,par_daydate,par_idkey,par_hose,par_squirt,par_painting,par_alarmcentral,par_glass,par_inlock,par_record,par_signaling,par_obstruction,par_observation);
    
    IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao gravar registro na tabela PRJM010025";
	END IF;
   
   IF EX = 1 THEN
		SELECT MESSAGE;
        ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Dados salvos com sucesso!!";
        SELECT MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_historicH_sel` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_historicH_sel`(
	par_hydrant_id int(11),
    par_daydate varchar(10),
    par_date_fim varchar(10),
    par_start INT(10),
    par_limit INT(10)
)
BEGIN
	
    DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    SET @sql = CONCAT('SELECT *, (SELECT count(hydrant_id) FROM PRJM010025) / ', par_limit, ' AS pgs');
	SET @sql = CONCAT(@sql, ' FROM PRJM010024 PRJM024  ');
    SET @sql = CONCAT(@sql, ' LEFT JOIN PRJM010025 PRJM025 USING(hydrant_id) ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM025.situation = 0 AND PRJM024.hydrant_id = ',par_hydrant_id);
	
	IF par_daydate IS NOT NULL AND par_daydate != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM025.daydate >= "', par_daydate, '"');
	END IF;
	
	IF par_date_fim IS NOT NULL AND par_date_fim != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM025.daydate <= "',par_date_fim, '"');
	END IF;
	SET @sql = CONCAT(@sql, ' LIMIT ', par_start, ', ', par_limit);
	
	#SELECT @sql;
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	  
    IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao filtrar registro na tabela PRJM010025";
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Dados salvo com sucesso!!" ;
		SELECT MESSAGE;
		COMMIT;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_historicH_sel_byid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_historicH_sel_byid`(
	par_historic_id INT(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    SET @sql = CONCAT('SELECT PRJM025.*');
	SET @sql = CONCAT(@sql, ' FROM PRJM010025 PRJM025 ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010024 PRJM024 ON PRJM024.hydrant_id = PRJM025.hydrant_id ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM025.historic_id = ', par_historic_id);
    
    #SELECT @sql;
    PREPARE STMT FROM @sql;
    EXECUTE STMT;
    
    IF EX = 1 THEN
		SELECT MESSAGE = "ERROR: Erro ao filtrar registro na tabela de Histórico";
		ROLLBACK;
	ELSE
		SELECT "SUCCESS: Dados filtrado com sucesso!!" MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_historicH_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_historicH_update`(
	par_historic_id int(11),
	par_hydrant_id int(11),
	par_daydate date,
	par_idkey char(1),
	par_hose char(1),
	par_squirt char(1),
	par_painting char(1),
	par_alarmcentral char(1),
	par_glass char(1),
	par_inlock char(1),
	par_record char(1),
	par_signaling char(1),
	par_obstruction char(1),
	par_observation varchar(255)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
	UPDATE PRJM010025
	SET
		hydrant_id = par_hydrant_id,
		daydate = par_daydate,
		idkey = par_idkey,
		hose = par_hose,
		squirt = par_squirt,
		painting = par_painting,
		alarmcentral = par_alarmcentral,
		glass = par_glass,
		inlock = par_inlock,
		record = par_record,
		signaling = par_signaling,
		obstruction = par_obstruction,
		observation = par_observation
	WHERE historic_id 	= par_historic_id;
	
	IF EX = 1 THEN
		SET MESSAGE = CONCAT("ERROR: Erro ao atualizar registro na tabela de Histórico de Hidrante ");
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = CONCAT("SUCCESS: Dados atualizados com sucesso!! ") ;
        SELECT MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_historicP_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_historicP_delete`(
	par_historic_id int(11), 
    par_user_id int(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
	DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    	
	SET @sql = CONCAT('UPDATE PRJM010021  ');
	SET @sql = CONCAT(@sql,' SET situation = 1,');
	SET @sql = CONCAT(@sql,' user_id_deleted = ',par_user_id,',');
	SET @sql = CONCAT(@sql,' dt_deleted = "',now(),'"');
	SET @sql = CONCAT(@sql,' WHERE historic_id = ',par_historic_id,';');
	
	#SELECT @sql;
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao excluir registro na tabela de Histódico de Purificador";
	END IF;
	   
    IF EX = 1 THEN
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Registro excluído com sucesso!!" ;
        SELECT MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_historicP_save` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_historicP_save`(
	par_purifier_id int(11),
	par_daydate date,
	par_serialnumber varchar(50)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    INSERT INTO PRJM010021
		(purifier_id,daydate,serialnumber)
		VALUES(par_purifier_id,par_daydate,par_serialnumber);
    
    IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao gravar registro na tabela PRJM010021";
	END IF;
   
   IF EX = 1 THEN
		SELECT MESSAGE;
        ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Dados salvos com sucesso!!";
        SELECT MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_historicP_sel` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_historicP_sel`(
	par_purifier_id int(11),
    par_daydate varchar(10),
    par_date_fim varchar(10),
    par_start INT(10),
    par_limit INT(10)
)
BEGIN
	
    DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    SET @sql = CONCAT('SELECT *, (SELECT count(purifier_id) FROM PRJM010021) / ', par_limit, ' AS pgs');
	SET @sql = CONCAT(@sql, ' FROM PRJM010020 PRJM020  ');
    SET @sql = CONCAT(@sql, ' LEFT JOIN PRJM010021 PRJM021 USING(purifier_id) ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM021.situation = 0 AND PRJM021.purifier_id = ',par_purifier_id);
	
	IF par_daydate IS NOT NULL AND par_daydate != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM021.daydate >= "', par_daydate, '"');
	END IF;
	
	IF par_date_fim IS NOT NULL AND par_date_fim != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM021.daydate <= "',par_date_fim, '"');
	END IF;
	SET @sql = CONCAT(@sql, ' LIMIT ', par_start, ', ', par_limit);
	
	#SELECT @sql;
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	  
    IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao filtrar registro na tabela PRJM010021";
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		#SET MESSAGE = "SUCCESS: Dados salvo com sucesso!!" ;
		SELECT MESSAGE;
		COMMIT;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_historicP_sel_byid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_historicP_sel_byid`(
	par_historic_id INT(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    SET @sql = CONCAT('SELECT PRJM021.*');
	SET @sql = CONCAT(@sql, ' FROM PRJM010021 PRJM021 ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010020 PRJM020 USING(purifier_id) ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM021.historic_id = ', par_historic_id);
    
    #SELECT @sql;
    PREPARE STMT FROM @sql;
    EXECUTE STMT;
    
    IF EX = 1 THEN
		SELECT MESSAGE = "ERROR: Erro ao filtrar registro na tabela de Histórico";
		ROLLBACK;
	ELSE
		SELECT "SUCCESS: Dados filtrado com sucesso!!" MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_historicP_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_historicP_update`(
	par_historic_id int(11),
	par_purifier_id int(11),
	par_daydate date,
	par_serialnumber varchar(50)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
	UPDATE PRJM010021
	SET
		purifier_id  = par_purifier_id, 
		daydate      = par_daydate, 
		serialnumber = par_serialnumber
        
	WHERE historic_id  = par_historic_id;
	
	IF EX = 1 THEN
		SET MESSAGE = CONCAT("ERROR: Erro ao atualizar registro na tabela de Histórico de Purificador ");
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = CONCAT("SUCCESS: Dados atualizados com sucesso!! ") ;
        SELECT MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_hydrant_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_hydrant_delete`(
	par_hydrant_id int(11),
    par_user_id int(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    UPDATE PRJM010024 
	SET 
		situation = 1,
		user_id_deleted = par_user_id,
		dt_deleted = now()
	WHERE hydrant_id = par_hydrant_id;
	
	IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao excluir registro na tabela de Hidrante";
	ELSE
		SET MESSAGE = "SUCCESS: Registro excluído Extintor com sucesso!!" ;
	END IF;
    
	UPDATE PRJM010025  
	SET 
		situation = 1,
		user_id_deleted = par_user_id,
		dt_deleted = now()
	WHERE hydrant_id = par_hydrant_id;
	
	IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao excluir registro na tabela de Histórico";
	ELSE
		SET MESSAGE = "SUCCESS: Registro excluído Histórico com sucesso!!" ;
	END IF;
	
	IF EX = 1 THEN
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Registro excluído com sucesso!!" ;
        SELECT MESSAGE;
		COMMIT;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_hydrant_save` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_hydrant_save`(
	par_person_id int(11),
	par_location varchar(100),
	par_tipe varchar(20),
	par_idnumber varchar(20),
	par_observation varchar(255)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    INSERT INTO PRJM010024
		(person_id,location,tipe,idnumber,observation)
		VALUES(par_person_id,par_location,par_tipe,par_idnumber,par_observation);
    
    IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao gravar registro na tabela PRJM010024";
	END IF;
   
   IF EX = 1 THEN
		SELECT MESSAGE;
        ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Dados salvos com sucesso!!";
        SELECT MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_hydrant_sel` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_hydrant_sel`(
	par_start INT(10),
    par_limit INT(10)
)
BEGIN
	
    DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    SET @sql = CONCAT('SELECT *, (SELECT count(hydrant_id) FROM PRJM010024) / ', par_limit, ' AS pgs');
	SET @sql = CONCAT(@sql, ' FROM PRJM010024 PRJM024  ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM024.situation = 0 ');
	
	SET @sql = CONCAT(@sql, ' LIMIT ', par_start, ', ', par_limit);
	
	#SELECT @sql;
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	
	IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao filtrar registro na tabela PRJM010024";
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Dados salvo com sucesso!!" ;
		SELECT MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_hydrant_sel_byid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_hydrant_sel_byid`(
	par_hydrant_id INT(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    SET @sql = CONCAT('SELECT * ');
	SET @sql = CONCAT(@sql, ' FROM PRJM010024 PRJM024 ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010010 PRJM010 USING(person_id) ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM024.hydrant_id = "', par_hydrant_id, '"');
    
    PREPARE STMT FROM @sql;
    EXECUTE STMT;
    
    IF EX = 1 THEN
		SELECT MESSAGE = "ERROR: Erro ao filtrar registro na tabela de Hidrante";
		ROLLBACK;
	ELSE
		SELECT "SUCCESS: Dados filtrado com sucesso!!" MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_hydrant_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_hydrant_update`(
	par_hydrant_id int(11),
    par_person_id int(11),
	par_location varchar(100),
	par_tipe varchar(20),
	par_idnumber varchar(20),
	par_observation varchar(255)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
	UPDATE PRJM010024
	SET
		person_id       = par_person_id,
		location        = par_location,
		tipe            = par_tipe,
		idnumber        = par_idnumber,
		observation     = par_observation
	WHERE hydrant_id = par_hydrant_id;
	
	IF EX = 1 THEN
		SET MESSAGE = CONCAT("ERROR: Erro ao atualizar registro na tabela de Hidrante ");
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = CONCAT("SUCCESS: Dados atualizados com sucesso!! ") ;
        SELECT MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_location_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_location_delete`(
	par_location_id int(11),
    par_user_id int(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    UPDATE PRJM010029 
    SET
		situation = 1,
		user_id_deleted = par_user_id,
		dt_deleted = now()
        
    WHERE location_id = par_location_id;
    
    UPDATE PRJM010030
    SET
		situation = 1,
		user_id_deleted = par_user_id,
		dt_deleted = now()
	WHERE location_id = par_location_id;
    
    IF EX = 1 THEN
		SELECT MESSAGE = "ERROR: Erro ao excluir registro na tabela PRJM010029";
	END IF;
    
    IF EX = 1 THEN
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SELECT "SUCCESS: Registro excluído com sucesso!!" MESSAGE;
		COMMIT;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_location_save` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_location_save`(
	par_deslocation varchar(64)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    INSERT INTO PRJM010029 (deslocation) VALUES (par_deslocation);
        
    IF EX = 1 THEN
		SELECT MESSAGE = "ERROR: Erro ao gravar registro na tabela PRJM010029";
	END IF;
	
    IF EX = 1 THEN
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SELECT "SUCCESS: Dados salvos com sucesso!!" MESSAGE;
		COMMIT;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_location_sel` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_location_sel`(
	par_start INT(10),
    par_limit INT(10)
)
BEGIN
	
    DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    SET @sql = CONCAT('SELECT *, (SELECT count(location_id) FROM PRJM010029) / ', par_limit, ' AS pgs');
	SET @sql = CONCAT(@sql, ' FROM PRJM010029 PRJM029  ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM029.situation = 0 ');
	
	SET @sql = CONCAT(@sql, ' LIMIT ', par_start, ', ', par_limit);
	
	#SELECT @sql;
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	
	IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao filtrar registro na tabela PRJM010029";
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Dados filtrado com sucesso!!" ;
		SELECT MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_location_sel_byid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_location_sel_byid`(
	par_location_id INT(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    SET @sql = CONCAT('SELECT * ');
	SET @sql = CONCAT(@sql, ' FROM PRJM010029 PRJM029 ');
    #SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010010 PRJM010 USING(person_id) ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM029.location_id = "', par_location_id, '"');
    
    PREPARE STMT FROM @sql;
    EXECUTE STMT;
    
    IF EX = 1 THEN
		SELECT MESSAGE = "ERROR: Erro ao filtrar registro na tabela de localidade";
		ROLLBACK;
	ELSE
		SELECT "SUCCESS: Dados filtrado com sucesso!!" MESSAGE;
		COMMIT;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_location_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_location_update`(
	par_location_id int(11),
    par_deslocation varchar(64)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    UPDATE PRJM010029 SET deslocation = par_deslocation WHERE location_id = par_location_id;
        
    IF EX = 1 THEN
		SELECT MESSAGE = "ERROR: Erro ao atualizar registro na tabela PRJM010029";
	END IF;
	
    IF EX = 1 THEN
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SELECT "SUCCESS: Registro atualizados com sucesso!!" MESSAGE;
		COMMIT;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_material_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_material_delete`(
	par_material_id int(11),
    par_user_id int(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
  
	SET @sql = CONCAT('UPDATE PRJM010023  ');
	SET @sql = CONCAT(@sql,' SET situation = 1,');
	SET @sql = CONCAT(@sql,' user_id_deleted = ',par_user_id,',');
	SET @sql = CONCAT(@sql,' dt_deleted = ','"',now(),'"');
	SET @sql = CONCAT(@sql,' WHERE material_id = ',par_material_id,';');
	
	#SELECT @sql;
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao excluir registro na tabela de materiais";
	END IF;
	
    IF EX = 1 THEN
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Registro excluído com sucesso!!" ;
        SELECT MESSAGE;
		COMMIT;
	END IF;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_material_save` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_material_save`(
	par_person_id int,
	par_daydate date,
	par_dayhour time,
	par_material varchar(100),
	par_qtde numeric(10,2),
    par_receiver varchar(100),
    par_deliveryman varchar(100)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    INSERT INTO PRJM010023
		(person_id,daydate,dayhour,material,qtde,receiver,deliveryman)
		VALUES(par_person_id,par_daydate,par_dayhour,par_material,par_qtde,par_receiver,par_deliveryman);
     
	IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao gravar registro na tabela PRJM010023";
	END IF;
   
   IF EX = 1 THEN
		SELECT MESSAGE;
        ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Dados salvos com sucesso!!";
        SELECT MESSAGE;
		COMMIT;
	END IF; 
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_material_sel` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_material_sel`(
	par_receiver varchar(200),
    par_daydate varchar(10),
    par_date_fim varchar(10),
    par_start INT(10),
    par_limit INT(10)
)
BEGIN
	
    DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
  
	SET @sql = CONCAT('SELECT *, (SELECT count(material_id) FROM PRJM010023) / ', par_limit, ' AS pgs');
	SET @sql = CONCAT(@sql, ' FROM PRJM010023 PRJM023 ');
	SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010010 PRJM010 USING(person_id) ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM023.situation = 0 ');
	
	IF par_daydate IS NOT NULL AND par_daydate != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM023.daydate >= "', par_daydate, '"');
	END IF;
	
	IF par_date_fim IS NOT NULL AND par_date_fim != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM023.daydate <= "',par_date_fim, '"');
	END IF;
	
	IF par_receiver IS NOT NULL AND par_receiver != '' THEN
	BEGIN
		SET @sql = CONCAT(@sql, ' AND PRJM023.receiver LIKE "%', par_receiver, '%"' );
	END;
	END IF;
	
    SET @sql = CONCAT(@sql, ' LIMIT ', par_start, ', ', par_limit, ';');
	
    
	#SELECT @sql;
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	
	IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao filtrar registro na tabela PRJM010023";
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Dados salvo com sucesso!!" ;
		SELECT MESSAGE;
		COMMIT;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_material_sel_byid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_material_sel_byid`(
	par_material_id INT(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    SET @sql = CONCAT('SELECT * ');
	SET @sql = CONCAT(@sql, ' FROM PRJM010023 PRJM023 ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010010 PRJM010 USING(person_id) ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM023.material_id = "', par_material_id, '"');
    
    PREPARE STMT FROM @sql;
    EXECUTE STMT;
    
    IF EX = 1 THEN
		SELECT MESSAGE = "ERROR: Erro ao filtrar registro na tabela de materiais";
		ROLLBACK;
	ELSE
		SELECT "SUCCESS: Dados filtrado com sucesso!!" MESSAGE;
		COMMIT;
	END IF; #Fim do if EX = 1 THEN

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_material_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_material_update`(
	par_material_id int,
    par_person_id int,
	par_daydate date,
	par_dayhour time,
	par_material varchar(100),
	par_qtde numeric(10,2),
    par_receiver varchar(100),
    par_deliveryman varchar(100),
    par_situation tinyint(1)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
	UPDATE PRJM010023
	SET
		daydate		= par_daydate,
		dayhour		= par_dayhour,
		material	= par_material,
		qtde		= par_qtde,
		receiver	= par_receiver,
		deliveryman	= par_deliveryman,
		situation	= par_situation
	WHERE material_id 	= par_material_id;
	
	IF EX = 1 THEN
		SET MESSAGE = CONCAT("ERROR: Erro ao atualizar registro na tabela de material ");
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = CONCAT("SUCCESS: Dados atualizados com sucesso!! ") ;
        SELECT MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_nobreak_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_nobreak_delete`(
	par_nobreak_id int(11),
    par_user_id int(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
   
    SET @sql = CONCAT('UPDATE PRJM010017  ');
	SET @sql = CONCAT(@sql,' SET situation = 1,');
	SET @sql = CONCAT(@sql,' user_id_deleted = ',par_user_id,',');
	SET @sql = CONCAT(@sql,' dt_deleted = ','"',now(),'"');
	SET @sql = CONCAT(@sql,' WHERE nobreak_id = ',par_nobreak_id,';');
	
	#SELECT @sql;
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao excluir registro na tabela de Nobreak";
	END IF;

    IF EX = 1 THEN
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Registro excluído com sucesso!!" ;
        SELECT MESSAGE;
		COMMIT;
	END IF;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_nobreak_save` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_nobreak_save`(
	par_person_id int(11),
	par_name_person varchar(100),
	par_daydate date,
	par_dayhour time,
	par_location varchar(100),
	par_nobreakmodel varchar(100),
	par_resulttest char(1),
	par_observation varchar(100),
	par_serialnumber varchar(50)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    INSERT INTO PRJM010017 
		(person_id,name_person,daydate,dayhour,location,nobreakmodel,resulttest,observation,serialnumber)
		VALUES (par_person_id,par_name_person,par_daydate,par_dayhour,par_location,par_nobreakmodel,par_resulttest,par_observation,par_serialnumber);
     
	
	IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao gravar registro na tabela PRJM010017";
	END IF;
   
   IF EX = 1 THEN
		SELECT MESSAGE;
        ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Dados salvos com sucesso!!";
        SELECT MESSAGE;
		COMMIT;
	END IF; 
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_nobreak_sel` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_nobreak_sel`(
	par_name_person varchar(200),
    par_daydate varchar(10),
    par_date_fim varchar(10),
    par_start INT(10),
    par_limit INT(10)
)
BEGIN
	
    DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
	SET @sql = CONCAT('SELECT *, (SELECT count(nobreak_id) FROM PRJM010017) / ', par_limit, ' AS pgs');
	SET @sql = CONCAT(@sql, ' FROM PRJM010017 PRJM017 ');
	SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010010 PRJM010 USING(person_id) ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM017.situation = 0 ');
	
	IF par_daydate IS NOT NULL AND par_daydate != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM017.daydate >= "', par_daydate, '"');
	END IF;
	
	IF par_date_fim IS NOT NULL AND par_date_fim != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM017.daydate <= "',par_date_fim, '"');
	END IF;
	
	IF par_name_person IS NOT NULL AND par_name_person != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM010.name_person LIKE "%', par_name_person, '%"' );
	END IF;
	SET @sql = CONCAT(@sql, ' LIMIT ', par_start, ', ', par_limit, ';');
	
	#SELECT @sql;
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	
	IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao filtrar registro na tabela PRJM010017";
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Dados filtrado com sucesso!!" ;
		SELECT MESSAGE;
		COMMIT;
	END IF;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_nobreak_sel_byid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_nobreak_sel_byid`(
	par_nobreak_id INT(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    SET @sql = CONCAT('SELECT * ');
	SET @sql = CONCAT(@sql, ' FROM PRJM010017 PRJM017 ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010010 PRJM010 USING(person_id) ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM017.nobreak_id = "', par_nobreak_id, '"');
    
    PREPARE STMT FROM @sql;
    EXECUTE STMT;
    
    IF EX = 1 THEN
		SELECT MESSAGE = "ERROR: Erro ao filtrar registro na tabela de Nobreak";
		ROLLBACK;
	ELSE
		SELECT "SUCCESS: Dados filtrado com sucesso!!" MESSAGE;
		COMMIT;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_nobreak_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_nobreak_update`(
	par_nobreak_id int(11),
    par_person_id int(11),
	par_name_person varchar(100),
	par_daydate date,
	par_dayhour time,
	par_location varchar(100),
	par_nobreakmodel varchar(100),
	par_resulttest char(1),
	par_observation varchar(100),
	par_serialnumber varchar(50)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
	UPDATE PRJM010017
	SET
		person_id      = par_person_id,
		name_person    = par_name_person,
		daydate        = par_daydate,
		dayhour        = par_dayhour,
		location       = par_location,
		nobreakmodel   = par_nobreakmodel,  
		resulttest     = par_resulttest,
		observation    = par_observation,
		serialnumber   = par_serialnumber
		
	WHERE nobreak_id 	= par_nobreak_id;
	
	IF EX = 1 THEN
		SET MESSAGE = CONCAT("ERROR: Erro ao atualizar registro na tabela de Nobreak ");
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = CONCAT("SUCCESS: Dados atualizados com sucesso!! ") ;
        SELECT MESSAGE;
		COMMIT;
	END IF; #Fim do if EX = 1 THEN
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_persons_select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_persons_select`()
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    SET @sql = CONCAT(' SELECT  PRJM010.person_id,PRJM010.name_person AS responsable FROM PRJM010010 PRJM010 ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010012 PRJM012 ON PRJM012.person_id = PRJM010.person_id ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM012.classification_id = 5 ');
     
    #SELECT @sql;
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
    
	IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao filtrar registro na tabela PRJM010010";
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Dados filtrado com sucesso!!" ;
		SELECT MESSAGE;
		COMMIT;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_person_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_person_delete`(
	par_person_id int(11),
    par_user_id int(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    UPDATE PRJM010001 
    SET
		situation = 1,
		user_id_deleted = par_user_id,
		dt_deleted = now()
	WHERE person_id = par_person_id;
        
    IF EX = 1 THEN
		SELECT MESSAGE = "ERROR: Erro ao excluir registro na tabela PRJM010001";
	END IF;
    
    IF EX = 1 THEN
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SELECT "SUCCESS: Registro excluído com sucesso!!" MESSAGE;
		COMMIT;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_person_save` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_person_save`(
	par_name_person varchar(200),
    par_phonenumber varchar(11),
    par_photo blob,
    par_rg_person varchar(10),
    par_cpf_person varchar(11),
    par_classification_id tinyint(1),
    par_daydate date,
    par_situation tinyint(1),
    par_login varchar(64),
    par_password varchar(200),
    par_inadmin tinyint(1)

)
BEGIN
	DECLARE par_person_id int;
    DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    INSERT INTO PRJM010001 (dt_save, situation) VALUES (par_daydate, par_situation);
    SET par_person_id = LAST_INSERT_ID();
        
    IF EX = 1 THEN
		SELECT MESSAGE = "ERROR: Erro ao gravar registro na tabela PRJM010001";
	END IF;
        
	INSERT INTO PRJM010010 (person_id, name_person, phonenumber, photo, rg_person, cpf_person) 
		VALUES (par_person_id, par_name_person, par_phonenumber,par_photo, par_rg_person, par_cpf_person);
	 
    IF EX = 1 THEN
		SELECT  MESSAGE = "ERROR: Erro ao gravar registro na tabela PRJM010010";
	END IF;
    IF (par_login IS NOT NULL AND par_login != '') AND (par_password IS NOT NULL AND par_password != '') THEN
    BEGIN
		INSERT INTO PRJM010013 (person_id, login, pass, inadmin)
			VALUES(par_person_id, par_login, par_password, par_inadmin);
    END;
    END IF;
    
    IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao gravar registro na tabela PRJM010013";
	END IF;
    
    INSERT INTO PRJM010012 (classification_id, person_id) VALUES ( par_classification_id, par_person_id);
    
    IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao gravar registro na tabela PRJM010012";
	END IF;
    
    IF EX = 1 THEN
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SELECT "SUCCESS: Dados salvos com sucesso!!" MESSAGE;
		COMMIT;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_person_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_person_update`(
	par_seq_person_id int(11),
    par_seq_classp_id int(11),
    par_person_id int(11),
    par_name_person varchar(200),
    par_phonenumber varchar(11),
    par_photo blob,
    par_rg_person varchar(10),
    par_cpf_person varchar(11),
    par_classification_id tinyint(1),
    par_daydate date,
    par_situation tinyint(1),
    par_login varchar(64),
    par_password varchar(200),
    par_inadmin tinyint(1)
)
BEGIN
	DECLARE pID INT;
	DECLARE MESSAGE, MSG001, MSG010 varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    
    START TRANSACTION;
    #set MESSAGE = msg;
    
    UPDATE PRJM010010
		SET
			name_person      =  par_name_person,
			phonenumber      =  par_phonenumber,
            photo			 =  par_photo,
			rg_person        =  par_rg_person,
			cpf_person       =  par_cpf_person

	WHERE seq_person_id = par_seq_person_id;
    
    IF EX = 1 THEN
		SET  MESSAGE = "ERROR: Erro ao atualizar registro na tabela PRJM010010";
	END IF;
    
    IF (par_login IS NOT NULL AND par_login != '') AND (par_password IS NOT NULL AND par_password != '') THEN
    BEGIN
		SELECT person_id INTO pID FROM PRJM010013 WHERE person_id = par_person_id;
        
        IF pID IS NOT NULL THEN
			UPDATE PRJM01013
				SET 
					login 		= par_login, 
					pass	 	= par_password, 
					inadmin 	= par_inadmin
				WHERE person_id = pID;
        ELSE
			INSERT INTO PRJM010013 (person_id, login, pass, inadmin)
				VALUES(par_person_id, par_login, par_password, par_inadmin);
		END IF;
    END;
    END IF;
    
    IF par_seq_classp_id IS NOT NULL AND par_seq_classp_id != '' THEN
		UPDATE PRJM010012 
			SET classification_id = par_classification_id
		WHERE seq_classp_id = par_seq_classp_id;   
	END IF;
    
    IF EX = 1 THEN
		SET  MESSAGE = 'ERROR: Erro ao atualizar registro na tabela PRJM010012';
	END IF;
    
    IF EX = 1 THEN
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = CONCAT("SUCCESS: Dados atualizados com sucesso!!");
        SELECT MESSAGE;
		COMMIT;
	END IF; #Fim do if EX = 1 THEN
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_purifier_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_purifier_delete`(
	par_purifier_id int(11),
    par_user_id int(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    UPDATE PRJM010020  
	SET 
		situation = 1,
		user_id_deleted = par_user_id,
		dt_deleted = now()
	WHERE purifier_id = par_purifier_id;
	
	IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao excluir registro na tabela de Purificador";
	ELSE
		SET MESSAGE = "SUCCESS: Registro excluído Extintor com sucesso!!" ;
	END IF;
    
	UPDATE PRJM010021  
	SET 
		situation = 1,
		user_id_deleted = par_user_id,
		dt_deleted = now()
	WHERE purifier_id = par_purifier_id;
	
	IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao excluir registro na tabela de Histórico";
	ELSE
		SET MESSAGE = "SUCCESS: Registro excluído Histórico com sucesso!!" ;
	END IF;
	   
    IF EX = 1 THEN
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Registro excluído com sucesso!!" ;
        SELECT MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_purifier_save` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_purifier_save`(
	par_person_id int(11),
    par_daydate date,
    par_serialnumber varchar(50),
	par_location varchar(100),
	par_nextmanager date
    
)
BEGIN
	DECLARE MESSAGE, LOC varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    SELECT location INTO LOC FROM PRJM010020 WHERE location = par_location;
    
    IF LOC IS NULL THEN
		INSERT INTO PRJM010020
			( person_id, daydate,serialnumber , location, nextmanager)
			VALUES( par_person_id, par_daydate,par_serialnumber , par_location, par_nextmanager);
		
        IF EX = 1 THEN
			SET MESSAGE = "ERROR: Erro ao gravar registro na tabela PRJM010020";
		ELSE
			SET MESSAGE = "SUCCESS: Dados cadastrado com sucesso!!" ;
		END IF;
	ELSE
		SET MESSAGE = CONCAT('ERROR: Registro ',LOC,' já está cadastrado');
    END IF;
    IF EX = 1 THEN
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SELECT MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_purifier_sel` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_purifier_sel`(
	par_daydate varchar(10),
    par_date_fim varchar(10),
    par_start INT(10),
    par_limit INT(10)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    SET @sql = CONCAT('SELECT PRJM020.*, PRJM010.name_person AS responsable, (SELECT count(purifier_id) FROM PRJM010020) / ', par_limit, ' AS pgs');
	SET @sql = CONCAT(@sql, ' FROM PRJM010020 PRJM020  ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010010 PRJM010 ON PRJM010.person_id = PRJM020.person_id  ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM020.situation = 0 ');
	
	IF par_daydate IS NOT NULL AND par_daydate != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM020.daydate >= "', par_daydate, '"');
	END IF;
	
	IF par_date_fim IS NOT NULL AND par_date_fim != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM020.daydate <= "',par_date_fim, '"');
	END IF;
	SET @sql = CONCAT(@sql, ' LIMIT ', par_start, ', ', par_limit);
	
	#SELECT @sql;
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	
	IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao filtrar registro na tabela PRJM010020";
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Dados salvo com sucesso!!" ;
		SELECT MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_purifier_sel_byid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_purifier_sel_byid`(
	par_purifier_id INT(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    SET @sql = CONCAT('SELECT PRJM020.*, PRJM010.name_person AS responsable ');
	SET @sql = CONCAT(@sql, ' FROM PRJM010020 PRJM020 ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010010 PRJM010 USING(person_id) ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM020.purifier_id = "', par_purifier_id, '"');
    
    #SELECT @sql;
    PREPARE STMT FROM @sql;
    EXECUTE STMT;
    
    IF EX = 1 THEN
		SELECT MESSAGE = "ERROR: Erro ao filtrar registro na tabela de purificador";
		ROLLBACK;
	ELSE
		SELECT "SUCCESS: Dados filtrado com sucesso!!" MESSAGE;
		COMMIT;
	END IF; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_purifier_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_purifier_update`(
	par_purifier_id int(11),
	par_person_id int(11),
	par_daydate date,
    par_serialnumber varchar(50),
	par_location varchar(100),
	par_nextmanager date
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
	UPDATE PRJM010020
	SET
		person_id    = par_person_id,
		daydate      = par_daydate,
        serialnumber = par_serialnumber,
		location     = par_location,
		nextmanager  = par_nextmanager
			
	WHERE purifier_id  = par_purifier_id;
	
	IF EX = 1 THEN
		SET MESSAGE = CONCAT("ERROR: Erro ao atualizar registro na tabela de purificador ");
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = CONCAT("SUCCESS: Dados atualizados com sucesso!! ") ;
        SELECT MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_residual_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_residual_delete`(
	par_residual_id int(11),
    par_user_id int(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
	SET @sql = CONCAT('UPDATE PRJM010015  ');
	SET @sql = CONCAT(@sql,' SET situation = 1,');
	SET @sql = CONCAT(@sql,' user_id_deleted = ',par_user_id,',');
	SET @sql = CONCAT(@sql,' dt_deleted = ','"',now(),'"');
	SET @sql = CONCAT(@sql,' WHERE residual_id = ',par_residual_id,';');
	
	#SELECT @sql;
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao excluir registro na tabela de resíduos";
	END IF;
	
    IF EX = 1 THEN
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Registro excluído com sucesso!!" ;
        SELECT MESSAGE;
		COMMIT;
	END IF;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_residual_save` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_residual_save`(
	par_person_id int,
	par_daydate date,
	par_dayhour time,
	par_name_person varchar(100),
	par_material varchar(100),
	par_location varchar(100),
	par_warehouse varchar(100)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    INSERT INTO PRJM010015
		( person_id, daydate, dayhour, name_person, material, location, warehouse)
		VALUES( par_person_id, par_daydate, par_dayhour, par_name_person, par_material, par_location, par_warehouse);
     
	IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao gravar registro na tabela PRJM010015";
	END IF;
   
   IF EX = 1 THEN
		SELECT MESSAGE;
        ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Dados salvos com sucesso!!";
        SELECT MESSAGE;
		COMMIT;
	END IF; 
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_residual_sel` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_residual_sel`(
	par_name_person varchar(200),
    par_daydate varchar(10),
    par_date_fim varchar(10),
    par_start INT(10),
    par_limit INT(10)
)
BEGIN
	
    DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
	SET @sql = CONCAT('SELECT *, (SELECT count(residual_id) FROM PRJM010015) / ', par_limit, ' AS pgs');
	SET @sql = CONCAT(@sql, ' FROM (SELECT * FROM PRJM010015 PRJM015 LIMIT ', par_start, ', ', par_limit, ' ) AS PRJM015 ');
	SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010010 PRJM010 USING(person_id) ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM015.situation = 0 ');
	
	IF par_daydate IS NOT NULL AND par_daydate != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM015.daydate >= "', par_daydate, '"');
	END IF;
	
	IF par_date_fim IS NOT NULL AND par_date_fim != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM015.daydate <= "',par_date_fim, '"');
	END IF;
	
	IF par_name_person IS NOT NULL AND par_name_person != '' THEN
	BEGIN
		SET @sql = CONCAT(@sql, ' AND PRJM010.name_person LIKE "%', par_name_person, '%"' );
	END;
	END IF;
	
	#SELECT @sql;
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	
	IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao filtrar registro na tabela PRJM010015";
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Dados filtrado com sucesso!!" ;
		SELECT MESSAGE;
		COMMIT;
	END IF;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_residual_sel_byid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_residual_sel_byid`(
	par_residual_id INT(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    SET @sql = CONCAT('SELECT * ');
	SET @sql = CONCAT(@sql, ' FROM PRJM010015 PRJM015 ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010010 PRJM010 USING(person_id) ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM015.residual_id = "', par_residual_id, '"');
    
    PREPARE STMT FROM @sql;
    EXECUTE STMT;
    
    IF EX = 1 THEN
		SELECT MESSAGE = "ERROR: Erro ao filtrar registro na tabela de resíduos";
		ROLLBACK;
	ELSE
		SELECT "SUCCESS: Dados filtrado com sucesso!!" MESSAGE;
		COMMIT;
	END IF; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_residual_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_residual_update`(
	par_residual_id int,
    par_person_id int,
    par_daydate date,
	par_dayhour time,
	par_name_person varchar(100),
	par_material varchar(100),
    par_location varchar(100),
	par_warehouse varchar(100),
    par_situation tinyint(1)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
	UPDATE PRJM010015
	SET
		daydate		= par_daydate,
		dayhour		= par_dayhour,
		name_person	= par_name_person,
		material	= par_material,
		location	= par_location,
		warehouse	= par_warehouse,
		situation	= par_situation
	WHERE residual_id 	= par_residual_id;
	
	IF EX = 1 THEN
		SET MESSAGE = CONCAT("ERROR: Erro ao atualizar registro na tabela de resíduos ");
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = CONCAT("SUCCESS: Dados atualizados com sucesso!! ") ;
        SELECT MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_responsable_sel` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_responsable_sel`(
	par_start INT(10),
    par_limit INT(10)
)
BEGIN
	
    DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    SET @sql = CONCAT('SELECT PRJM010.name_person as responsable, PRJM010.*, (SELECT count(person_id) FROM PRJM010010 ) / ', par_limit, ' AS pgs');
	SET @sql = CONCAT(@sql, ' FROM PRJM010010 PRJM010  ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010001 PRJM001 ON PRJM001.person_id = PRJM010.person_id  ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010012 PRJM012 ON PRJM012.person_id = PRJM010.person_id ');
    SET @sql = CONCAT(@sql, ' WHERE PRJM001.situation = 0 AND PRJM012.classification_id = 5');
	
	SET @sql = CONCAT(@sql, ' LIMIT ', par_start, ', ', par_limit);
	
	#SELECT @sql;
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	
	IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao filtrar registro na tabela PRJM010010";
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Dados filtrado com sucesso!!" ;
		SELECT MESSAGE;
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_user_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_user_update`(
	par_user_id int(11),
    par_login varchar(64),
    par_password varchar(200),
    par_inadmin tinyint(1)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    UPDATE PRJM010013
	SET 
		login 		= par_login, 
		pass 		= par_password, 
		inadmin 	= par_inadmin
	WHERE user_id = par_user_id;
                
    IF EX = 1 THEN
		SET  MESSAGE = CONCAT("ERROR: Erro ao atualizar registro na tabela PRJM010013 "," - ",par_login," - ", par_password," - ",par_inadmin," - ", par_user_id);
	END IF;
    
    IF EX = 1 THEN
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = CONCAT("SUCCESS: Dados atualizados com sucesso!!");
        SELECT MESSAGE;
		COMMIT;
	END IF; #Fim do if EX = 1 THEN
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_visitant_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_visitant_delete`(
	par_visitant_id int(11),
    par_user_id int(11),
    par_person_id int(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
   	
    CALL prc_person_delete(par_person_id, par_user_id);
    
    IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao excluir registro na tabela PRJM010001";
	END IF;
    
	UPDATE PRJM010014
	SET 
		situation = 1,
		user_id_deleted = par_user_id,
		dt_deleted = now()
	WHERE visitant_id = par_visitant_id;
	
	IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao excluir registro na tabela PRJM010014";
	END IF;
	
   
    IF EX = 1 THEN
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Registro excluído com sucesso!!" ;
        SELECT MESSAGE;
		COMMIT;
	END IF;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_visitant_save` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_visitant_save`(
	par_name_person varchar(200),
	par_rg_person varchar(10),
    par_cpf_person varchar(11),
	par_phonenumber varchar(11),
    par_photo blob,
	par_company varchar(100),
	par_reason varchar(100),
	par_badge char(3),
	par_auth varchar(45), 
	par_sign varchar(100),
	par_daydate date,
	par_dayhour time,
	par_classification int
)
BEGIN
	DECLARE par_person_id int;
    DECLARE MESSAGE, MSG001, MSG010 varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    CALL prc_person_save(par_name_person,par_phonenumber,par_photo,par_rg_person,par_cpf_person,par_classification,par_daydate,'0','','',0);
    IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao gravar registro na tabela PRJM010010";
	END IF;
    
    SELECT LAST_INSERT_ID() INTO par_person_id FROM PRJM010001 ;
    
	INSERT INTO prjm010014
		(person_id,daydate,dayhour,company,reason,badge,auth,sign)
		VALUES( par_person_id,par_daydate,par_dayhour,par_company,par_reason,par_badge,par_auth,par_sign);
     
	IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao gravar registro na tabela PRJM010014";
	END IF;
    
	IF EX = 1 THEN
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SELECT "SUCCESS: Dados salvos com sucesso!!" MESSAGE;
		COMMIT;
	END IF; #Fim do if EX = 1 THEN
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_visitant_sel` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_visitant_sel`(
	par_name_person varchar(200),
    par_daydate varchar(10),
    par_date_fim varchar(10),
    par_start INT(10),
    par_limit INT(10)
)
BEGIN
	
    DECLARE MESSAGE, MSG001, MSG010 varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    IF par_daydate IS NULL THEN
		SELECT daydate into par_daydate FROM PRJM010014 LIMIT 1;
	END IF;
    IF par_daydate IS NOT NULL THEN
		SET @sql = CONCAT('SELECT *, (SELECT count(person_id) FROM PRJM010010) / ', par_limit, ' AS pgs');
		SET @sql = CONCAT(@sql, ' FROM (SELECT * FROM PRJM010010 PRJM010 LIMIT ', par_start, ', ', par_limit, ' ) AS PRJM010 ');
		SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010014 PRJM014 USING(person_id) ');
		SET @sql = CONCAT(@sql, ' WHERE PRJM014.situation = 0 ');
		
		IF par_daydate IS NOT NULL AND par_daydate != '' THEN
			SET @sql = CONCAT(@sql, ' AND PRJM014.daydate >= "', par_daydate, '"');
		END IF;
		
		IF par_date_fim IS NOT NULL AND par_date_fim != '' THEN
			SET @sql = CONCAT(@sql, ' AND PRJM014.daydate <= "',par_date_fim, '"');
		END IF;
		
		IF par_name_person IS NOT NULL AND par_name_person != '' THEN
		BEGIN
			SET @sql = CONCAT(@sql, ' AND PRJM010.name_person LIKE "%', par_name_person, '%"' );
		END;
		END IF;
		
		#SELECT @sql;
		PREPARE STMT FROM @sql;
		EXECUTE STMT;
		
		IF EX = 1 THEN
			SET MESSAGE = "ERROR: Erro ao filtrar registro na tabela PRJM010010";
			SELECT MESSAGE;
			ROLLBACK;
		ELSE
			SET MESSAGE = "SUCCESS: Dados salvo com sucesso!!" ;
			SELECT MESSAGE;
			COMMIT;
		END IF; #Fim do if EX = 1 THEN
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_visitant_sel_byid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_visitant_sel_byid`(
	par_person_id INT(11)
)
BEGIN
	DECLARE MESSAGE, MSG001, MSG010 varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
    SET @sql = CONCAT('SELECT * ');
	SET @sql = CONCAT(@sql, ' FROM PRJM010001 PRJM001 ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010010 PRJM010 USING(person_id) ');
	SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010014 PRJM014 USING(person_id) ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010012 PRJM012 USING(person_id) ');
    SET @sql = CONCAT(@sql, ' WHERE PRJM010.person_id = "', par_person_id, '"');
    
    PREPARE STMT FROM @sql;
    EXECUTE STMT;
    
    IF EX = 1 THEN
		SELECT MESSAGE = "ERROR: Erro ao filtrar registro na tabela PRJM010010";
		ROLLBACK;
	ELSE
		#SELECT "SUCCESS: Dados filtrado com sucesso!!" MESSAGE;
		COMMIT;
	END IF; #Fim do if EX = 1 THEN

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_visitant_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_visitant_update`(
	par_seq_person_id int,
    par_seq_classp_id int,
    par_visitant_id int,
    par_person_id int,
    par_name_person varchar(200),
	par_rg_person varchar(10),
    par_cpf_person varchar(11),
	par_phonenumber varchar(11),
    par_photo blob,
	par_company varchar(100),
	par_reason varchar(100),
	par_badge char(3),
	par_auth varchar(45), 
	par_sign varchar(100),
	par_daydate date,
	par_dayhour time,
	par_classification_id int,
    par_situation tinyint(1)
)
BEGIN
	DECLARE MESSAGE, MSG001, MSG010 varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERROR: ERRO de duplicidade do ID." AS MESSAGE;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'ERROR: Erro no código SQL.' AS MESSAGE;
    START TRANSACTION;
    
	CALL prc_person_update(par_seq_person_id,par_seq_classp_id,par_person_id,par_name_person,par_phonenumber,par_photo,par_rg_person,par_cpf_person,par_classification_id,par_daydate,par_situation,'','','0');
     
    IF EX = 1 THEN
		SET MESSAGE = CONCAT("ERROR: Erro ao atualizar registro na procedure prc_person_update");
	ELSE
		UPDATE PRJM010014
		SET
			company		= par_company,
			reason		= par_reason,
			badge		= par_badge,
			auth		= par_auth,
			sign		= par_sign,
            situation	=par_situation
		WHERE visitant_id 	= par_visitant_id;
		
		IF EX = 1 THEN
			SET MESSAGE = CONCAT("ERROR: Erro ao atualizar registro na tabela PRJM010014 ");
		END IF;
    END IF;
    
    IF EX = 1 THEN
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = CONCAT("SUCCESS: Dados atualizados com sucesso!! ") ;
        SELECT MESSAGE;
		COMMIT;
	END IF; #Fim do if EX = 1 THEN
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-06-18 17:02:13
