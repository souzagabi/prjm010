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
	par_airconditioning_id int(11)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Não é possível excluir esse registro, pois tem histórico vinculado nele. : Erro ', ERRNUMBER,' msg= ', ERR);
            SELECT MESSAGE;
        END IF;
    END;
 
	DELETE FROM PRJM010026 WHERE airconditioning_id = par_airconditioning_id;
    SELECT "SUCCESS: Registro excluído Extintor com sucesso!! " AS MESSAGE ;
  
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
    par_location_id int(11),
    par_local_id int(11),
    par_brand varchar(100),
    par_serialnumber varchar(50)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao cadastrar equipamento novo. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    INSERT INTO PRJM010026
		(person_id,location_id,local_id, brand, serialnumber)
		VALUES(par_person_id,par_location_id,par_local_id, par_brand, par_serialnumber);
    
    SELECT  "SUCCESS: Dados salvos com sucesso!!" AS MESSAGE;
	
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
	par_location varchar(64),
    par_serialnumber varchar(64),
    par_brand varchar(64),
    par_start INT(10),
    par_limit INT(10)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';

	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao filtrar registro na tabela PRJM010026. : Erro ', ERRNUMBER,' msg= ', ERR);
            SELECT MESSAGE;
        END IF;
    
	END;
    
    SET @sql = CONCAT('SELECT *, (SELECT count(airconditioning_id) FROM PRJM010026 PRJ026');
    SET @sql = CONCAT(@sql, ' WHERE PRJ026.situation = 0 ');
    
    IF par_location IS NOT NULL AND par_location != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM032.deslocation LIKE "%', par_location, '%"');
	END IF;
	
	IF par_serialnumber IS NOT NULL AND par_serialnumber != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJ026.serialnumber LIKE "%',par_serialnumber, '%"');
	END IF;
    
    IF par_brand IS NOT NULL AND par_brand != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJ026.brand LIKE "%', par_brand, '%"');
	END IF;
        
    SET @sql = CONCAT(@sql, ') / ',par_limit, ' AS pgs');
    
	SET @sql = CONCAT(@sql, ' FROM PRJM010026 PRJM026  ');
	SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010029 PRJM029 ON PRJM029.local_id = PRJM026.local_id');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010032 PRJM032 ON PRJM032.location_id = PRJM026.location_id ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM026.situation = 0 ');
	
	IF par_location IS NOT NULL AND par_location != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM032.deslocation LIKE "%', par_location, '%"');
	END IF;
	
	IF par_serialnumber IS NOT NULL AND par_serialnumber != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM026.serialnumber LIKE "%',par_serialnumber, '%"');
	END IF;
    
    IF par_brand IS NOT NULL AND par_brand != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM026.brand LIKE "%', par_brand, '%"');
	END IF;
    
	SET @sql = CONCAT(@sql, ' LIMIT ', par_start, ', ', par_limit);
	
	PREPARE STMT FROM @sql;
	EXECUTE STMT;

	SELECT "SUCCESS: Dados salvo com sucesso!!" AS MESSAGE;

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
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao filtrar registro na tabela de Ar Condicionado. : Erro ', ERRNUMBER,' msg= ', ERR);
            SELECT MESSAGE;
        END IF;
    
	END;
    
    SET @sql = CONCAT('SELECT * ');
	SET @sql = CONCAT(@sql, ' FROM PRJM010026 PRJM026 ');
    SET @sql = CONCAT(@sql, ' WHERE PRJM026.airconditioning_id = "', par_airconditioning_id, '"');
    
    PREPARE STMT FROM @sql;
    EXECUTE STMT;
    
	SELECT  "SUCCESS: Dados filtrado com sucesso!!" AS MESSAGE;
	
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
	par_location_id int(11),
    par_local_id int(11),
    par_brand varchar(100),
    par_serialnumber varchar(50)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao atualizar registro na tabela de Ar Condicionado. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
    
	END;
    
	UPDATE PRJM010026
	SET
		person_id       = par_person_id,
		location_id     = par_location_id,
        local_id		= par_local_id,
		brand			= par_brand ,
		serialnumber	= par_serialnumber
	WHERE airconditioning_id = par_airconditioning_id;

	SELECT "SUCCESS: Dados atualizados com sucesso!! " AS MESSAGE;
	
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
	par_anualplan_id int(11)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao excluir o registro. : Erro ', ERRNUMBER,' msg= ', ERR);
            SELECT MESSAGE;
        END IF;
    END;
    
    DELETE FROM PRJM010030 WHERE anualplan_id = par_anualplan_id;
    
    SELECT "SUCCESS: Dados excluído com sucesso!!" AS MESSAGE;
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
    par_local_id int(11),
	par_person_id int(11),
	par_frequency varchar(50),
	par_amonth varchar(20),
	par_dtprevision date,
	par_rstatus int(11)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao cadastrar registro na tabela PRJM010030. : Erro ', ERRNUMBER,' msg= ', ERR);
            SELECT MESSAGE;
        END IF;
    END;
    
    INSERT INTO PRJM010030 (yyear,equipament_id,location_id,local_id,person_id,frequency,amonth,dtprevision,rstatus) 
		VALUES (par_yyear,par_equipament_id,par_location_id,par_local_id,par_person_id,par_frequency,par_amonth,par_dtprevision,par_rstatus);
    
    SELECT "SUCCESS: Dados filtrado com sucesso!!" AS MESSAGE;

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
	par_deslocation varchar(64),
    par_daydate varchar(10),
    par_date_fim varchar(10),
    par_start INT(10),
    par_limit INT(10)
)
BEGIN
	
   -- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao filtrar registro na tabela PRJM010030. : Erro ', ERRNUMBER,' msg= ', ERR);
            SELECT MESSAGE;
        END IF;
    END;
    
    SET @sql = CONCAT('SELECT *, PRJM010.name_person as responsable, (SELECT count(anualplan_id) FROM PRJM010030 PRJ030 ');
	SET @sql = CONCAT(@sql, ' WHERE PRJ030.situation = 0 ');
    
    IF par_deslocation IS NOT NULL AND par_deslocation != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM032.deslocation LIKE "%', par_deslocation, '%"');
	END IF;
    IF par_daydate IS NOT NULL AND par_daydate != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJ030.dtprevision >= "', par_daydate, '"');
	END IF;
	
	IF par_date_fim IS NOT NULL AND par_date_fim != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJ030.dtprevision <= "',par_date_fim, '"');
	END IF;
    
    SET @sql = CONCAT(@sql, ') / ',par_limit, ' AS pgs');
    
    SET @sql = CONCAT(@sql, ' FROM PRJM010030 PRJM030  ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010010 PRJM010 ON PRJM010.person_id = PRJM030.person_id ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010029 PRJM029 ON PRJM029.local_id = PRJM030.local_id  ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010032 PRJM032 ON PRJM032.location_id = PRJM030.location_id  ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010028 PRJM028 ON PRJM028.equipament_id = PRJM030.equipament_id  ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM030.situation = 0 ');
	
    IF par_deslocation IS NOT NULL AND par_deslocation != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM032.deslocation LIKE "%', par_deslocation, '%"');
	END IF;
	
    IF par_daydate IS NOT NULL AND par_daydate != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM030.dtprevision >= "', par_daydate, '"');
	END IF;
	
	IF par_date_fim IS NOT NULL AND par_date_fim != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM030.dtprevision <= "',par_date_fim, '"');
	END IF;
    
	SET @sql = CONCAT(@sql, ' LIMIT ', par_start, ', ', par_limit);
	
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	
	SELECT "SUCCESS: Dados filtrado com sucesso!!" AS MESSAGE;
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
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
   
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao filtrar registro na tabela PRJM010030. : Erro ', ERRNUMBER,' msg= ', ERR);
            SELECT MESSAGE;
        END IF;
    END;
    
    SET @sql = CONCAT('SELECT * ');
	SET @sql = CONCAT(@sql, ' FROM PRJM010030 PRJM030 ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010010 PRJM010 ON PRJM010.person_id = PRJM030.person_id ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010028 PRJM028 ON PRJM028.equipament_id = PRJM030.equipament_id ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010029 PRJM029 ON PRJM029.local_id = PRJM030.local_id ');
	SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010032 PRJM032 ON PRJM032.location_id = PRJM030.location_id ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM030.anualplan_id = "', par_anualplan_id, '"');
    
    #SELECT @sql;
    PREPARE STMT FROM @sql;
    EXECUTE STMT;
    
   SELECT "SUCCESS: Dados filtrado com sucesso!!" AS MESSAGE;
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
    par_local_id int(11),
	par_person_id int(11),
	par_frequency varchar(50),
	par_amonth varchar(20),
	par_dtprevision date,
    par_dtexecution date,
	par_rstatus int(11)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao atualizar registro na tabela PRJM010030. : Erro ', ERRNUMBER,' msg= ', ERR);
            SELECT MESSAGE;
        END IF;
    END;
    
    UPDATE PRJM010030 
	SET
			yyear          = par_yyear,
            equipament_id  = par_equipament_id,
            location_id    = par_location_id,
            local_id	   = par_local_id,
            person_id      = par_person_id,
            frequency      = par_frequency,
            amonth         = par_amonth,
            dtprevision    = par_dtprevision,
            dtexecution    = par_dtexecution,
            rstatus        = par_rstatus
            
	WHERE anualplan_id = par_anualplan_id;
    
   SELECT "SUCCESS: Dados filtrado com sucesso!!" AS MESSAGE;
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
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao filtrar tabela PRJM010011!! : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
	SELECT * FROM PRJM010011 ORDER BY PRJM010011.description;
    
    SELECT "SUCCESS: Dados salvos com sucesso!!" AS MESSAGE;
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
	par_clothing_id int(11)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao excluir registro na tabela de roupas. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    	       
	SET @sql = CONCAT('DELETE FROM PRJM010022  ');
	SET @sql = CONCAT(@sql,' WHERE clothing_id = ',par_clothing_id,';');
	
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	
    SELECT "SUCCESS: Registro excluído com sucesso!!" AS MESSAGE;
   
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
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao gravar registro na tabela PRJM010022. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
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
  
    PREPARE STMT FROM @sql;
    EXECUTE STMT;
    
	SELECT "SUCCESS: Dados salvos com sucesso!!" AS MESSAGE;
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
	par_company varchar(100),
    par_dateout varchar(10),
    par_datein varchar(10),
    par_start INT(10),
    par_limit INT(10)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao filtrar registro na tabela PRJM010022. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
	SET @sql = CONCAT('SELECT *, (SELECT count(clothing_id) FROM PRJM010022 PRJ022');
    SET @sql = CONCAT(@sql, ' WHERE PRJ022.situation = 0 ');
    
    IF par_company IS NOT NULL AND par_company != '' THEN
		SET @sql = CONCAT(@sql, ' AND (PRJ022.signin LIKE "%', par_company, '%"');
        SET @sql = CONCAT(@sql, ' OR PRJ022.signout LIKE "%', par_company, '%")');
	END IF;
	
	IF par_dateout IS NOT NULL AND par_dateout != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJ022.dateout >= "', par_dateout, '"');
	END IF;
	
	IF par_datein IS NOT NULL AND par_datein != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJ022.datein <= "',par_datein, '"');
	END IF;
    
    SET @sql = CONCAT(@sql, ') / ',par_limit, ' AS pgs');
    
	SET @sql = CONCAT(@sql, ' FROM PRJM010022 PRJM022 ');
	SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010010 PRJM010 USING(person_id) ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM022.situation = 0 ');
	
    IF par_company IS NOT NULL AND par_company != '' THEN
		SET @sql = CONCAT(@sql, ' AND (PRJM022.signin LIKE "%', par_company, '%"');
        SET @sql = CONCAT(@sql, ' OR PRJM022.signout LIKE "%', par_company, '%")');
	END IF;
    
	IF par_dateout IS NOT NULL AND par_dateout != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM022.dateout >= "', par_dateout, '"');
	END IF;
	
	IF par_datein IS NOT NULL AND par_datein != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM022.datein <= "',par_datein, '"');
	END IF;
	
    SET @sql = CONCAT(@sql, ' LIMIT ', par_start, ', ', par_limit);
	
    PREPARE STMT FROM @sql;
	EXECUTE STMT;
	
	SELECT  "SUCCESS: Dados salvo com sucesso!!" AS MESSAGE;

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
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao filtrar registro na tabela de roupas. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    SET @sql = CONCAT('SELECT * ');
	SET @sql = CONCAT(@sql, ' FROM PRJM010022 PRJM022 ');
    #SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010010 PRJM010 USING(person_id) ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM022.clothing_id = "', par_clothing_id, '"');
    
    PREPARE STMT FROM @sql;
    EXECUTE STMT;
    
    SELECT "SUCCESS: Dados filtrado com sucesso!!" AS MESSAGE;

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
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao atualizar registro na tabela de roupas. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
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
	
	SELECT "SUCCESS: Dados atualizados com sucesso!! " AS MESSAGE;
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
	par_equipament_id int(11)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao excluir registro na tabela PRJM010028. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    DELETE FROM PRJM010028 WHERE equipament_id = par_equipament_id;
         
    SELECT "SUCCESS: Registro excluído com sucesso!!" AS MESSAGE;

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
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao gravar registro na tabela PRJM010029. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    INSERT INTO PRJM010028 (desequipament) VALUES (par_desequipament);
        
    SELECT "SUCCESS: Dados salvos com sucesso!!" AS MESSAGE;
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
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao filtrar registro na tabela PRJM010028. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    SET @sql = CONCAT('SELECT *, (SELECT count(equipament_id) FROM PRJM010028 PRJ028');
    SET @sql = CONCAT(@sql, ' WHERE PRJ028.situation = 0 ');
        
    SET @sql = CONCAT(@sql, ') / ',par_limit, ' AS pgs');
    
	SET @sql = CONCAT(@sql, ' FROM PRJM010028 PRJM028  ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM028.situation = 0 ');
	
    SET @sql = CONCAT(@sql, ' ORDER BY PRJM028.desequipament ');
    
	SET @sql = CONCAT(@sql, ' LIMIT ', par_start, ', ', par_limit);
	
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	
	SELECT "SUCCESS: Dados filtrado com sucesso!!" AS MESSAGE;
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
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao filtrar registro na tabela de equipamento. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    SET @sql = CONCAT('SELECT * ');
	SET @sql = CONCAT(@sql, ' FROM PRJM010028 PRJM028 ');
    #SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010010 PRJM010 USING(person_id) ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM028.equipament_id = "', par_equipament_id, '"');
    
    PREPARE STMT FROM @sql;
    EXECUTE STMT;
    
    SELECT "SUCCESS: Dados filtrado com sucesso!!" AS MESSAGE;
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
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao atualizar registro na tabela PRJM010028. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    UPDATE PRJM010028 SET desequipament = par_desequipament WHERE equipament_id = par_equipament_id;
  	
    SELECT "SUCCESS: Registro atualizados com sucesso!!" AS MESSAGE;
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
	par_fireexting_id int(11)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao excluir registro na tabela de Extintor. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    DELETE FROM PRJM010018 WHERE fireexting_id = par_fireexting_id;
	SELECT "SUCCESS: Registro excluído com sucesso!!" AS MESSAGE;
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
	par_location_id int(11),
    par_local_id int(11),
	par_tipe varchar(20),
	par_weight varchar(10),
	par_capacity varchar(10),
	par_rechargedate date
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao gravar registro na tabela PRJM010018. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    INSERT INTO PRJM010018
		(person_id,daydate,dayhour,location_id,local_id,tipe,weight,capacity,rechargedate)
		VALUES(par_person_id,par_daydate,par_dayhour,par_location_id,par_local_id,par_tipe,par_weight,par_capacity,par_rechargedate);
    
   SELECT "SUCCESS: Dados salvos com sucesso!!" AS MESSAGE;
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
	par_deslocation varchar(64),
    par_tipe varchar(64),
    par_daydate varchar(10),
    par_date_fim varchar(10),
    par_start INT(10),
    par_limit INT(10)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao filtrar registro na tabela PRJM010018. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    SET @sql = CONCAT('SELECT *, (SELECT count(fireexting_id) FROM PRJM010018 PRJ018');
    SET @sql = CONCAT(@sql, ' WHERE PRJ018.situation = 0 ');
    
    IF par_deslocation IS NOT NULL AND par_deslocation != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM032.deslocation LIKE "%', par_deslocation, '%"');
	END IF;
	
	IF par_tipe IS NOT NULL AND par_tipe != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJ018.tipe LIKE "%',par_tipe, '%"');
	END IF;
    
    IF par_daydate IS NOT NULL AND par_daydate != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJ018.rechargedate >= "', par_daydate, '"');
	END IF;
	
	IF par_date_fim IS NOT NULL AND par_date_fim != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJ018.rechargedate <= "',par_date_fim, '"');
	END IF;
    
    SET @sql = CONCAT(@sql, ') / ',par_limit, ' AS pgs');
    
	SET @sql = CONCAT(@sql, ' FROM PRJM010018 PRJM018  ');
	SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010029 PRJM029 ON PRJM029.local_id = PRJM018.local_id');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010032 PRJM032 ON PRJM032.location_id = PRJM018.location_id ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM018.situation = 0 ');
	
    IF par_deslocation IS NOT NULL AND par_deslocation != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM032.deslocation LIKE "%', par_deslocation, '%"');
	END IF;
	
	IF par_tipe IS NOT NULL AND par_tipe != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM018.tipe LIKE "%',par_tipe, '%"');
	END IF;
    
	IF par_daydate IS NOT NULL AND par_daydate != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM018.rechargedate >= "', par_daydate, '"');
	END IF;
	
	IF par_date_fim IS NOT NULL AND par_date_fim != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM018.rechargedate <= "',par_date_fim, '"');
	END IF;
    
	SET @sql = CONCAT(@sql, ' LIMIT ', par_start, ', ', par_limit);
	
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	
	SELECT "SUCCESS: Dados salvo com sucesso!!" AS MESSAGE;
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
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao filtrar registro na tabela de Extintor. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    SET @sql = CONCAT('SELECT * ');
	SET @sql = CONCAT(@sql, ' FROM PRJM010018 PRJM018 ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010010 PRJM010 USING(person_id) ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM018.fireexting_id = "', par_fireexting_id, '"');
    
    PREPARE STMT FROM @sql;
    EXECUTE STMT;
    
    SELECT "SUCCESS: Dados filtrado com sucesso!!" AS MESSAGE;
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
	par_location_id int(11),
    par_local_id int(11),
	par_tipe varchar(20),
	par_weight varchar(10),
	par_capacity varchar(10),
	par_rechargedate date
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao atualizar registro na tabela de Extintor. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
	UPDATE PRJM010018
	SET
		person_id       = par_person_id,
		daydate         = par_daydate,
		dayhour         = par_dayhour,
		location_id     = par_location_id,
        local_id		= par_local_id,
		tipe            = par_tipe,
		weight          = par_weight,
		capacity        = par_capacity,
		rechargedate    = par_rechargedate
	WHERE fireexting_id = par_fireexting_id;
	
	SELECT "SUCCESS: Dados atualizados com sucesso!! " AS MESSAGE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_generalcontrol_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_generalcontrol_delete`(
	par_generalcontrol_id int(11)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao excluir registro na tabela PRJM011031. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
	SET @sql = CONCAT('DELETE FROM PRJM010031  ');
	SET @sql = CONCAT(@sql,' WHERE generalcontrol_id = ',par_generalcontrol_id,';');
	
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	
    SELECT "SUCCESS: Registro excluído com sucesso!!" AS MESSAGE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_generalcontrol_save` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_generalcontrol_save`(
	par_location_id int(11),
	par_local_id int(11),
	par_dthydraulic date,
	par_dteletric date,
	par_dtbuilding date
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao gravar registro na tabela PRJM010031. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    INSERT INTO PRJM010031
		(location_id,local_id,dthydraulic,dteletric,dtbuilding)
		VALUES(par_location_id,par_local_id,par_dthydraulic,par_dteletric,par_dtbuilding);
    
    SELECT "SUCCESS: Dados salvos com sucesso!!" AS MESSAGE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_generalcontrol_sel` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_generalcontrol_sel`(
	par_deslocation varchar(64),
    par_daydate varchar(10),
    par_date_fim varchar(10),
    par_start INT(10),
    par_limit INT(10)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao filtrar registro na tabela PRJM010031. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    SET @sql = CONCAT('SELECT *, (SELECT count(generalcontrol_id) FROM PRJM010031 PRJ031');
    SET @sql = CONCAT(@sql, ' WHERE PRJ031.situation = 0 ');
    
    IF par_deslocation IS NOT NULL AND par_deslocation != '' THEN
		SET @sql = CONCAT(@sql, ' AND (PRJM032.deslocation LIKE "%', par_deslocation, '%")');
	END IF;
    
    IF par_daydate IS NOT NULL AND par_daydate != '' THEN
		SET @sql = CONCAT(@sql, ' AND ((PRJ031.dthydraulic >= "', par_daydate, '")');
        SET @sql = CONCAT(@sql, ' OR (PRJ031.dtbuilding >= "', par_daydate, '"');
        SET @sql = CONCAT(@sql, ' OR PRJ031.dteletric >= "', par_daydate, '"))');
	END IF;
	
	IF par_date_fim IS NOT NULL AND par_date_fim != '' THEN
		SET @sql = CONCAT(@sql, ' AND ((PRJ031.dthydraulic <= "',par_date_fim, '")');
        SET @sql = CONCAT(@sql, ' OR (PRJ031.dtbuilding <= "', par_date_fim, '"');
        SET @sql = CONCAT(@sql, ' OR PRJ031.dteletric <= "', par_date_fim, '"))');
	END IF;
    
    SET @sql = CONCAT(@sql, ') / ',par_limit, ' AS pgs');
	
    SET @sql = CONCAT(@sql, ' FROM PRJM010031 PRJM031  ');
	SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010029 PRJM029 ON PRJM029.local_id = PRJM031.local_id');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010032 PRJM032 ON PRJM032.location_id = PRJM031.location_id ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM031.situation = 0 ');
	
    IF par_deslocation IS NOT NULL AND par_deslocation != '' THEN
		SET @sql = CONCAT(@sql, ' AND (PRJM032.deslocation LIKE "%', par_deslocation, '%")');
	END IF;
    
    IF par_daydate IS NOT NULL AND par_daydate != '' THEN
		SET @sql = CONCAT(@sql, ' AND ((PRJM031.dthydraulic >= "', par_daydate, '")');
        SET @sql = CONCAT(@sql, ' OR (PRJM031.dtbuilding >= "', par_daydate, '"');
        SET @sql = CONCAT(@sql, ' OR PRJM031.dteletric >= "', par_daydate, '"))');
	END IF;
	
	IF par_date_fim IS NOT NULL AND par_date_fim != '' THEN
		SET @sql = CONCAT(@sql, ' AND ((PRJM031.dthydraulic <= "',par_date_fim, '")');
        SET @sql = CONCAT(@sql, ' OR (PRJM031.dtbuilding <= "', par_date_fim, '"');
        SET @sql = CONCAT(@sql, ' OR PRJM031.dteletric <= "', par_date_fim, '"))');
	END IF;
    
	SET @sql = CONCAT(@sql, ' LIMIT ', par_start, ', ', par_limit);
	
	#SELECT @sql;
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	
	SELECT "SUCCESS: Dados filtrado com sucesso!!" AS MESSAGE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_generalcontrol_sel_byid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_generalcontrol_sel_byid`(
	par_generalcontrol_id INT(11)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao filtrar registro na tabela PRJM011031. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    SET @sql = CONCAT('SELECT * ');
	SET @sql = CONCAT(@sql, ' FROM PRJM010031 PRJM031 ');
    SET @sql = CONCAT(@sql, ' WHERE PRJM031.generalcontrol_id = "', par_generalcontrol_id, '"');
    
    PREPARE STMT FROM @sql;
    EXECUTE STMT;
    
    SELECT "SUCCESS: Dados filtrado com sucesso!!" AS MESSAGE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_generalcontrol_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_generalcontrol_update`(
	par_generalcontrol_id int(11),
    par_location_id int(11),
	par_local_id int(11),
	par_dthydraulic date,
	par_dteletric date,
	par_dtbuilding date
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao atualizar registro na tabela prjm011031. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
	UPDATE PRJM010031
	SET
		location_id = par_location_id,
		local_id    = par_local_id,
		dthydraulic = par_dthydraulic,
		dteletric   = par_dteletric,
		dtbuilding  = par_dtbuilding
	WHERE generalcontrol_id = par_generalcontrol_id;
    
   SELECT "SUCCESS: Dados atualizados com sucesso!! " AS MESSAGE;
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
	par_goods_id int(11)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao excluir registro na tabela de materiais. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
	SET @sql = CONCAT('DELETE FROM PRJM010016  ');
	SET @sql = CONCAT(@sql,' WHERE goods_id = ',par_goods_id,';');
	
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	
    SELECT "SUCCESS: Registro excluído com sucesso!!" AS MESSAGE;
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
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao gravar registro na tabela PRJM010016. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    INSERT INTO PRJM010016
		(person_id,daydate,dayhour,goods,qtde,packing,receiver,deliveryman)
		VALUES(par_person_id,par_daydate,par_dayhour,par_goods,par_qtde,par_packing,par_receiver,par_deliveryman);
     
	SELECT "SUCCESS: Dados salvos com sucesso!!" AS MESSAGE;
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
	par_goods varchar(64),
    par_daydate varchar(10),
    par_date_fim varchar(10),
    par_start INT(10),
    par_limit INT(10)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao filtrar registro na tabela PRJM010016. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
        
	SET @sql = CONCAT('SELECT *, ');
    SET @sql = CONCAT(@sql, '(SELECT count(goods_id) FROM PRJM010016 PRJ016');
    SET @sql = CONCAT(@sql, ' WHERE PRJ016.situation = 0 ');
    
    IF par_goods IS NOT NULL AND par_goods != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJ016.goods LIKE "%', par_goods, '%"' );
	END IF;
    
    IF par_daydate IS NOT NULL AND par_daydate != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJ016.daydate >= "', par_daydate, '"');
	END IF;
	
	IF par_date_fim IS NOT NULL AND par_date_fim != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJ016.daydate <= "',par_date_fim, '"');
	END IF;
    
    SET @sql = CONCAT(@sql, ') / ',par_limit, ' AS pgs');
    
    SET @sql = CONCAT(@sql, ' FROM PRJM010016 PRJM016 ');
	SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010010 PRJM010 ON PRJM010.person_id = PRJM016.person_id ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM016.situation = 0 ');
	
	IF par_daydate IS NOT NULL AND par_daydate != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM016.daydate >= "', par_daydate, '"');
	END IF;
	
	IF par_date_fim IS NOT NULL AND par_date_fim != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM016.daydate <= "',par_date_fim, '"');
	END IF;
	
	IF par_goods IS NOT NULL AND par_goods != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM016.goods LIKE "%', par_goods, '%"' );
	END IF;
	
    SET @sql = CONCAT(@sql, ' ORDER BY PRJM016.goods ' );
    SET @sql = CONCAT(@sql, ' LIMIT ', par_start, ', ', par_limit, ';');
    
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	
	SELECT "SUCCESS: Dados salvo com sucesso!!" AS MESSAGE;
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
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao filtrar registro na tabela de materiais. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    SET @sql = CONCAT('SELECT * ');
	SET @sql = CONCAT(@sql, ' FROM PRJM010016 PRJM016 ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010010 PRJM010 USING(person_id) ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM016.goods_id = "', par_goods_id, '"');
    
    PREPARE STMT FROM @sql;
    EXECUTE STMT;
    
    SELECT "SUCCESS: Dados filtrado com sucesso!!" AS MESSAGE;
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
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao atualizar registro na tabela de goods. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
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
	
	SELECT "SUCCESS: Dados atualizados com sucesso!! " AS MESSAGE;
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
	par_historic_id int(11)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
   
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Não é possível excluir esse registro. : Erro ', ERRNUMBER,' msg= ', ERR);
            SELECT MESSAGE;
        END IF;
    END;
	
	SET @sql = CONCAT('DELETE FROM PRJM010027  ');
	SET @sql = CONCAT(@sql,' WHERE historic_id = ',par_historic_id,';');
	
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
    SELECT "SUCCESS: Registro excluído Extintor com sucesso!! " AS MESSAGE;
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
	par_daydate date,
    par_dtnextmanager date
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao gravar registro na tabela PRJM010027. : Erro ', ERRNUMBER,' msg= ', ERR);
            SELECT MESSAGE;
        END IF;
    END;
    
    INSERT INTO PRJM010027
		(airconditioning_id,inmonth,daydate, dtnextmanager)
		VALUES(par_airconditioning_id,par_inmonth,par_daydate, par_dtnextmanager);
    
    SELECT "SUCCESS: Dados salvos com sucesso!!" AS MESSAGE;

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
	
   -- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao filtrar registro na tabela PRJM010027. : Erro ', ERRNUMBER,' msg= ', ERR);
            SELECT MESSAGE;
        END IF;
    END;
    
    SET @sql = CONCAT('SELECT *, (SELECT count(airconditioning_id) FROM PRJM010027 PRJ027');
    SET @sql = CONCAT(@sql, ' WHERE PRJ027.situation = 0 ');
    
    IF par_daydate IS NOT NULL AND par_daydate != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJ027.daydate >= "', par_daydate, '"');
	END IF;
    
    SET @sql = CONCAT(@sql, ') / ',par_limit, ' AS pgs');
    
	SET @sql = CONCAT(@sql, ' FROM PRJM010026 PRJM026  ');
    SET @sql = CONCAT(@sql, ' LEFT JOIN PRJM010027 PRJM027 USING(airconditioning_id) ');
	SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010029 PRJM029 ON PRJM029.local_id = PRJM026.local_id');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010032 PRJM032 ON PRJM032.location_id = PRJM026.location_id ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM026.situation = 0 AND PRJM026.airconditioning_id = ',par_airconditioning_id);
	
	IF par_daydate IS NOT NULL AND par_daydate != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM027.daydate >= "', par_daydate, '"');
	END IF;
	
	SET @sql = CONCAT(@sql, ' LIMIT ', par_start, ', ', par_limit);
	
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	  
    SELECT "SUCCESS: Dados salvo com sucesso!!" AS MESSAGE;

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
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao filtrar registro na tabela de Histórico. : Erro ', ERRNUMBER,' msg= ', ERR);
            SELECT MESSAGE;
        END IF;
    END;
    
    SET @sql = CONCAT('SELECT PRJM027.*');
	SET @sql = CONCAT(@sql, ' FROM PRJM010027 PRJM027 ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010026 PRJM026 USING(airconditioning_id) ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM027.historic_id = ', par_historic_id);
    
    PREPARE STMT FROM @sql;
    EXECUTE STMT;
    
    SELECT "SUCCESS: Dados filtrado com sucesso!!" AS MESSAGE;
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
    par_daydate date,
    par_dtnextmanager date
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao atualizar registro na tabela de Histórico do Ar Condicionado. : Erro ', ERRNUMBER,' msg= ', ERR);
            SELECT MESSAGE;
        END IF;
    END;
    
	UPDATE PRJM010027
	SET
		airconditioning_id 	= par_airconditioning_id,
        inmonth				= par_inmonth,
		daydate         	= par_daydate,
		dtnextmanager		= par_dtnextmanager
	WHERE historic_id 	= par_historic_id;
	
	SELECT "SUCCESS: Dados atualizados com sucesso!! " AS MESSAGE;

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
	par_historic_id int(11)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao excluir registro na tabela de Histódico de Extintor. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    	
	SET @sql = CONCAT('DELETE FROM PRJM010019  ');
	SET @sql = CONCAT(@sql,' WHERE historic_id = ',par_historic_id,';');
	
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	SELECT "SUCCESS: Registro excluído com sucesso!!" AS MESSAGE;
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
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao gravar registro na tabela PRJM010019. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    INSERT INTO PRJM010019
		(fireexting_id,daydate,htrigger,hose,diffuser,painting,hydrostatic,hothers)
		VALUES(par_fireexting_id,par_daydate,par_htrigger,par_hose,par_diffuser,par_painting,par_hydrostatic,par_hothers);
    
    SELECT "SUCCESS: Dados salvos com sucesso!!" AS MESSAGE;
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
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao filtrar registro na tabela PRJM010019. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    SET @sql = CONCAT('SELECT *, PRJM018.fireexting_id as fireexting_id, (SELECT count(fireexting_id) FROM PRJM010019 PRJ019');
    SET @sql = CONCAT(@sql, ' WHERE PRJ019.situation = 0 ');
    
    IF par_daydate IS NOT NULL AND par_daydate != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJ019.daydate >= "', par_daydate, '"');
	END IF;
	
	IF par_date_fim IS NOT NULL AND par_date_fim != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJ019.daydate <= "',par_date_fim, '"');
	END IF;
    
    SET @sql = CONCAT(@sql, ') / ',par_limit, ' AS pgs');
    
	SET @sql = CONCAT(@sql, ' FROM PRJM010018 PRJM018  ');
    SET @sql = CONCAT(@sql, ' LEFT JOIN PRJM010019 PRJM019 ON PRJM019.fireexting_id = PRJM018.fireexting_id ');
	SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010029 PRJM029 ON PRJM029.local_id = PRJM018.local_id');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010032 PRJM032 ON PRJM032.location_id = PRJM018.location_id ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM018.fireexting_id = ',par_fireexting_id);
	
	IF par_daydate IS NOT NULL AND par_daydate != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM019.daydate >= "', par_daydate, '"');
	END IF;
	
	IF par_date_fim IS NOT NULL AND par_date_fim != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM019.daydate <= "',par_date_fim, '"');
	END IF;
	SET @sql = CONCAT(@sql, ' LIMIT ', par_start, ', ', par_limit);
	
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	  
   SELECT "SUCCESS: Dados salvo com sucesso!!" AS MESSAGE;
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
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao filtrar registro na tabela de Histórico. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    SET @sql = CONCAT('SELECT PRJM019.*');
	SET @sql = CONCAT(@sql, ' FROM PRJM010019 PRJM019 ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010018 PRJM018 USING(fireexting_id) ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM019.historic_id = ', par_historic_id);
    
    PREPARE STMT FROM @sql;
    EXECUTE STMT;
    
    SELECT "SUCCESS: Dados filtrado com sucesso!!" AS MESSAGE;
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
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao atualizar registro na tabela de Histórico de Extintor. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
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
	
	SELECT "SUCCESS: Dados atualizados com sucesso!! " AS MESSAGE;
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
	par_historic_id int(11)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao excluir registro na tabela de Histódico de Hidrante. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    	
	SET @sql = CONCAT('DELETE FROM PRJM010025  ');
	SET @sql = CONCAT(@sql,' WHERE historic_id = ',par_historic_id,';');
	
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	
    SELECT "SUCCESS: Registro excluído com sucesso!!" AS MESSAGE;
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
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao gravar registro na tabela PRJM010025. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    INSERT INTO PRJM010025
		(hydrant_id,daydate,idkey,hose,squirt,painting,alarmcentral,glass,inlock,record,signaling,obstruction,observation)
		VALUES(par_hydrant_id,par_daydate,par_idkey,par_hose,par_squirt,par_painting,par_alarmcentral,par_glass,par_inlock,par_record,par_signaling,par_obstruction,par_observation);
   
   SELECT "SUCCESS: Dados salvos com sucesso!!" AS MESSAGE;
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
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao filtrar registro na tabela PRJM010025. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    SET @sql = CONCAT('SELECT *, (SELECT count(hydrant_id) FROM PRJM010025 PRJ025');
    SET @sql = CONCAT(@sql, ' WHERE PRJ025.situation = 0 ');
    
    IF par_daydate IS NOT NULL AND par_daydate != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJ025.daydate >= "', par_daydate, '"');
	END IF;
	
	IF par_date_fim IS NOT NULL AND par_date_fim != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJ025.daydate <= "',par_date_fim, '"');
	END IF;
    
    SET @sql = CONCAT(@sql, ') / ',par_limit, ' AS pgs');
    
	SET @sql = CONCAT(@sql, ' FROM PRJM010024 PRJM024 ');
    SET @sql = CONCAT(@sql, ' LEFT JOIN PRJM010025 PRJM025 ON PRJM025.hydrant_id = PRJM024.hydrant_id ');
	SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010029 PRJM029 ON PRJM029.local_id = PRJM024.local_id');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010032 PRJM032 ON PRJM032.location_id = PRJM024.location_id ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM024.hydrant_id = ',par_hydrant_id);
	
	IF par_daydate IS NOT NULL AND par_daydate != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM025.daydate >= "', par_daydate, '"');
	END IF;
	
	IF par_date_fim IS NOT NULL AND par_date_fim != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM025.daydate <= "',par_date_fim, '"');
	END IF;
	SET @sql = CONCAT(@sql, ' LIMIT ', par_start, ', ', par_limit);
	
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	  
    SELECT "SUCCESS: Dados salvo com sucesso!!" AS MESSAGE;
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
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao filtrar registro na tabela de Histórico. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    SET @sql = CONCAT('SELECT PRJM025.*');
	SET @sql = CONCAT(@sql, ' FROM PRJM010025 PRJM025 ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010024 PRJM024 ON PRJM024.hydrant_id = PRJM025.hydrant_id ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM025.historic_id = ', par_historic_id);
    
    PREPARE STMT FROM @sql;
    EXECUTE STMT;
    
    SELECT "SUCCESS: Dados filtrado com sucesso!!" AS MESSAGE;
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
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao atualizar registro na tabela de Histórico de Hidrante. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
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
	
	SELECT "SUCCESS: Dados atualizados com sucesso!! " AS MESSAGE;
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
	par_historic_id int(11)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao excluir registro na tabela de Histódico de Purificador. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    	
	SET @sql = CONCAT('DELETE FROM PRJM010021  ');
	SET @sql = CONCAT(@sql,' WHERE historic_id = ',par_historic_id,';');
	
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	
    SELECT "SUCCESS: Registro excluído com sucesso!!" AS MESSAGE;
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
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao gravar registro na tabela PRJM010021. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    INSERT INTO PRJM010021
		(purifier_id,daydate,serialnumber)
		VALUES(par_purifier_id,par_daydate,par_serialnumber);
    
    SELECT "SUCCESS: Dados salvos com sucesso!!"AS MESSAGE;
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
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao filtrar registro na tabela PRJM010021. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    SET @sql = CONCAT('SELECT *, (SELECT count(purifier_id) FROM PRJM010021 PRJ021');
    SET @sql = CONCAT(@sql, ' WHERE PRJ021.situation = 0 ');
    
    IF par_daydate IS NOT NULL AND par_daydate != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJ021.daydate >= "', par_daydate, '"');
	END IF;
	
	IF par_date_fim IS NOT NULL AND par_date_fim != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJ021.daydate <= "',par_date_fim, '"');
	END IF;
    
    SET @sql = CONCAT(@sql, ') / ',par_limit, ' AS pgs');
    
	SET @sql = CONCAT(@sql, ' FROM PRJM010020 PRJM020  ');
    SET @sql = CONCAT(@sql, ' LEFT JOIN PRJM010021 PRJM021 USING(purifier_id) ');
	SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010029 PRJM029 ON PRJM029.local_id = PRJM020.local_id');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010032 PRJM032 ON PRJM032.location_id = PRJM020.location_id ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM021.situation = 0 AND PRJM021.purifier_id = ',par_purifier_id);
	
	IF par_daydate IS NOT NULL AND par_daydate != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM021.daydate >= "', par_daydate, '"');
	END IF;
	
	IF par_date_fim IS NOT NULL AND par_date_fim != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM021.daydate <= "',par_date_fim, '"');
	END IF;
	SET @sql = CONCAT(@sql, ' LIMIT ', par_start, ', ', par_limit);
	
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	  
    SELECT "SUCCESS: Dados salvo com sucesso!!" AS MESSAGE;
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
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao filtrar registro na tabela de Histórico. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    SET @sql = CONCAT('SELECT PRJM021.*');
	SET @sql = CONCAT(@sql, ' FROM PRJM010021 PRJM021 ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010020 PRJM020 USING(purifier_id) ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM021.historic_id = ', par_historic_id);
    
    PREPARE STMT FROM @sql;
    EXECUTE STMT;
    
    SELECT "SUCCESS: Dados filtrado com sucesso!!" AS MESSAGE;
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
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao atualizar registro na tabela de Histórico de Purificador. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
	UPDATE PRJM010021
	SET
		purifier_id  = par_purifier_id, 
		daydate      = par_daydate, 
		serialnumber = par_serialnumber
        
	WHERE historic_id  = par_historic_id;
	
	SELECT "SUCCESS: Dados atualizados com sucesso!! " AS MESSAGE;
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
	par_hydrant_id int(11)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao excluir registro na tabela de Hidrante. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    DELETE FROM PRJM010024 WHERE hydrant_id = par_hydrant_id;
	
	SELECT "SUCCESS: Registro excluído com sucesso!!" AS MESSAGE;
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
	par_location_id int(11),
    par_local_id int(11),
	par_tipe varchar(20),
	par_idnumber varchar(20),
	par_observation varchar(255)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao gravar registro na tabela PRJM010024. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    INSERT INTO PRJM010024
		(person_id,location_id,local_id,tipe,idnumber,observation)
		VALUES(par_person_id,par_location_id,par_local_id,par_tipe,par_idnumber,par_observation);
    
    SELECT "SUCCESS: Dados salvos com sucesso!!" AS MESSAGE;
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
	par_deslocation varchar(64),
    par_tipe varchar(64),
    par_idnumber varchar(64),
    par_start INT(10),
    par_limit INT(10)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao filtrar registro na tabela PRJM010024. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    SET @sql = CONCAT('SELECT *, (SELECT count(hydrant_id) FROM PRJM010024 PRJ024');
    SET @sql = CONCAT(@sql, ' WHERE PRJ024.situation = 0 ');
    
    IF par_deslocation IS NOT NULL AND par_deslocation != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM032.deslocation LIKE "%', par_deslocation, '%"');
	END IF;
	
	IF par_tipe IS NOT NULL AND par_tipe != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJ024.tipe LIKE "%',par_tipe, '%"');
	END IF;
    
    IF par_idnumber IS NOT NULL AND par_idnumber != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJ024.idnumber LIKE "%', par_idnumber, '%"');
	END IF;
    
    SET @sql = CONCAT(@sql, ') / ',par_limit, ' AS pgs');
    
	SET @sql = CONCAT(@sql, ' FROM PRJM010024 PRJM024 ');
	SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010029 PRJM029 ON PRJM029.local_id = PRJM024.local_id');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010032 PRJM032 ON PRJM032.location_id = PRJM024.location_id ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM024.situation = 0 ');
	
    IF par_deslocation IS NOT NULL AND par_deslocation != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM032.deslocation LIKE "%', par_deslocation, '%"');
	END IF;
	
	IF par_tipe IS NOT NULL AND par_tipe != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM024.tipe LIKE "%',par_tipe, '%"');
	END IF;
    
    IF par_idnumber IS NOT NULL AND par_idnumber != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM024.idnumber LIKE "%', par_idnumber, '%"');
	END IF;
	
	SET @sql = CONCAT(@sql, ' LIMIT ', par_start, ', ', par_limit);
	
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	
	SELECT "SUCCESS: Dados salvo com sucesso!!" AS MESSAGE;
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
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao filtrar registro na tabela de Hidrante. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    SET @sql = CONCAT('SELECT * ');
	SET @sql = CONCAT(@sql, ' FROM PRJM010024 PRJM024 ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010010 PRJM010 USING(person_id) ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM024.hydrant_id = "', par_hydrant_id, '"');
    
    PREPARE STMT FROM @sql;
    EXECUTE STMT;
    
    SELECT "SUCCESS: Dados filtrado com sucesso!!" AS MESSAGE;
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
	par_location_id int(11),
    par_local_id int(11),
	par_tipe varchar(20),
	par_idnumber varchar(20),
	par_observation varchar(255)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao atualizar registro na tabela de Hidrante. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
	UPDATE PRJM010024
	SET
		person_id       = par_person_id,
		location_id     = par_location_id,
        local_id		= par_local_id,
		tipe            = par_tipe,
		idnumber        = par_idnumber,
		observation     = par_observation
	WHERE hydrant_id = par_hydrant_id;
	
	SELECT "SUCCESS: Dados atualizados com sucesso!! " AS MESSAGE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_local_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_local_delete`(
	par_local_id int(11)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao excluir registro na tabela PRJM010029. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    DELETE FROM PRJM010029 WHERE local_id = par_local_id;
   
    SELECT "SUCCESS: Registro excluído com sucesso!!" AS MESSAGE; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_local_save` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_local_save`(
	par_deslocal varchar(64)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao gravar registro na tabela PRJM010029. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    INSERT INTO PRJM010029 (deslocal) VALUES (par_deslocal);
        
    SELECT "SUCCESS: Dados salvos com sucesso!!" AS MESSAGE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_local_sel` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_local_sel`(
	par_start INT(10),
    par_limit INT(10)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao filtrar registro na tabela PRJM010029. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    SET @sql = CONCAT('SELECT *, (SELECT count(local_id) FROM PRJM010029 PRJ029');
    SET @sql = CONCAT(@sql, ' WHERE PRJ029.situation = 0 ');
       
    SET @sql = CONCAT(@sql, ') / ',par_limit, ' AS pgs');
    
	SET @sql = CONCAT(@sql, ' FROM PRJM010029 PRJM029  ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM029.situation = 0 ');
	
    SET @sql = CONCAT(@sql, ' ORDER BY PRJM029.deslocal ');
    
	SET @sql = CONCAT(@sql, ' LIMIT ', par_start, ', ', par_limit);
	
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	
	SELECT "SUCCESS: Dados filtrado com sucesso!!" AS MESSAGE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_local_sel_byid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_local_sel_byid`(
	par_local_id INT(11)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao filtrar registro na tabela de local. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    SET @sql = CONCAT('SELECT * ');
	SET @sql = CONCAT(@sql, ' FROM PRJM010029 PRJM029 ');
    #SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010010 PRJM010 USING(person_id) ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM029.local_id = "', par_local_id, '"');
    
    PREPARE STMT FROM @sql;
    EXECUTE STMT;
    
    SELECT "SUCCESS: Dados filtrado com sucesso!!" AS MESSAGE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_local_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_local_update`(
	par_local_id int(11),
    par_deslocal varchar(64)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao atualizar registro na tabela PRJM010029. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    UPDATE PRJM010029 SET deslocal = par_deslocal WHERE local_id = par_local_id;
        
    SELECT "SUCCESS: Registro atualizados com sucesso!!" AS MESSAGE;
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
	par_location_id int(11)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao excluir registro na tabela PRJM010032. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    DELETE FROM PRJM010032 WHERE location_id = par_location_id;
    
    SELECT "SUCCESS: Registro excluído com sucesso!!" AS MESSAGE;
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
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao gravar registro na tabela PRJM010032. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    INSERT INTO PRJM010032 (deslocation) VALUES (par_deslocation);
        
    SELECT "SUCCESS: Dados salvos com sucesso!!" AS MESSAGE;
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
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao filtrar registro na tabela PRJM010032. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    SET @sql = CONCAT('SELECT *, (SELECT count(location_id) FROM PRJM010032 PRJ032');
    SET @sql = CONCAT(@sql, ' WHERE PRJ032.situation = 0 ');
    
    SET @sql = CONCAT(@sql, ') / ',par_limit, ' AS pgs');
    
	SET @sql = CONCAT(@sql, ' FROM PRJM010032 PRJM032  ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM032.situation = 0 ');
	
	SET @sql = CONCAT(@sql, ' ORDER BY PRJM032.deslocation ');
	
    SET @sql = CONCAT(@sql, ' LIMIT ', par_start, ', ', par_limit);
    
	#SELECT @sql;
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	
	SELECT "SUCCESS: Dados filtrado com sucesso!!" AS MESSAGE;
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
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao filtrar registro na tabela de localidade. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    SET @sql = CONCAT('SELECT * ');
	SET @sql = CONCAT(@sql, ' FROM PRJM010032 PRJM032 ');
    #SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010010 PRJM010 USING(person_id) ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM032.location_id = "', par_location_id, '"');
    
    PREPARE STMT FROM @sql;
    EXECUTE STMT;
    
    SELECT "SUCCESS: Dados filtrado com sucesso!!" AS MESSAGE;
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
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao atualizar registro na tabela PRJM010032. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    UPDATE PRJM010032 SET deslocation = par_deslocation WHERE location_id = par_location_id;
        
    SELECT "SUCCESS: Registro atualizados com sucesso!!" AS MESSAGE;
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
	par_material_id int(11)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao excluir registro na tabela de materiais. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
  
	SET @sql = CONCAT('DELETE FROM PRJM010023  ');
	SET @sql = CONCAT(@sql,' WHERE material_id = ',par_material_id,';');
	
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	
    SELECT "SUCCESS: Registro excluído com sucesso!!" AS MESSAGE;
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
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao gravar registro na tabela PRJM010023. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    INSERT INTO PRJM010023
		(person_id,daydate,dayhour,material,qtde,receiver,deliveryman)
		VALUES(par_person_id,par_daydate,par_dayhour,par_material,par_qtde,par_receiver,par_deliveryman);
     
	SELECT "SUCCESS: Dados salvos com sucesso!!" AS MESSAGE;
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
	par_material varchar(64),
    par_daydate varchar(10),
    par_date_fim varchar(10),
    par_start INT(10),
    par_limit INT(10)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao filtrar registro na tabela PRJM010023. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
  
	SET @sql = CONCAT('SELECT *, (SELECT count(material_id) FROM PRJM010023 PRJ023 ');
    SET @sql = CONCAT(@sql, ' WHERE PRJ023.situation = 0 ');
    
    IF par_material IS NOT NULL AND par_material != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJ023.material LIKE "%', par_material, '%"' );
	END IF;
	
    IF par_daydate IS NOT NULL AND par_daydate != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM023.daydate >= "', par_daydate, '"');
	END IF;
	
	IF par_date_fim IS NOT NULL AND par_date_fim != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM023.daydate <= "',par_date_fim, '"');
	END IF;
    
    SET @sql = CONCAT(@sql, ') / ',par_limit, ' AS pgs');
    
	SET @sql = CONCAT(@sql, ' FROM PRJM010023 PRJM023 ');
	SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010010 PRJM010 USING(person_id) ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM023.situation = 0 ');
	
	IF par_daydate IS NOT NULL AND par_daydate != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM023.daydate >= "', par_daydate, '"');
	END IF;
	
	IF par_date_fim IS NOT NULL AND par_date_fim != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM023.daydate <= "',par_date_fim, '"');
	END IF;
	
	IF par_material IS NOT NULL AND par_material != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM023.material LIKE "%', par_material, '%"' );
	END IF;
	
    SET @sql = CONCAT(@sql, ' LIMIT ', par_start, ', ', par_limit, ';');
	
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	
	SELECT "SUCCESS: Dados salvo com sucesso!!" AS MESSAGE;
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
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao filtrar registro na tabela de materiais. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    SET @sql = CONCAT('SELECT * ');
	SET @sql = CONCAT(@sql, ' FROM PRJM010023 PRJM023 ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010010 PRJM010 USING(person_id) ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM023.material_id = "', par_material_id, '"');
    
    PREPARE STMT FROM @sql;
    EXECUTE STMT;
    
    SELECT "SUCCESS: Dados filtrado com sucesso!!" AS MESSAGE;
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
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao atualizar registro na tabela de material. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
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
	
	SELECT "SUCCESS: Dados atualizados com sucesso!! " AS MESSAGE;
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
	par_nobreak_id int(11)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao excluir registro na tabela de Nobreak. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
   
    SET @sql = CONCAT('DELETE FROM PRJM010017  ');
	SET @sql = CONCAT(@sql,' WHERE nobreak_id = ',par_nobreak_id,';');
	
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	
    SELECT "SUCCESS: Registro excluído com sucesso!!" AS MESSAGE;
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
	par_daydate date,
	par_dayhour time,
	par_location_id int(11),
    par_local_id int(11),
	par_nobreakmodel varchar(100),
	par_resulttest char(1),
	par_observation varchar(100),
	par_serialnumber varchar(50)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao gravar registro na tabela PRJM010017. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    INSERT INTO PRJM010017 
		(person_id,daydate,dayhour,location_id,local_id,nobreakmodel,resulttest,observation,serialnumber)
		VALUES (par_person_id,par_daydate,par_dayhour,par_location_id,par_local_id,par_nobreakmodel,par_resulttest,par_observation,par_serialnumber);
     
	
	SELECT "SUCCESS: Dados salvos com sucesso!!" AS MESSAGE;
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
	par_location varchar(64),
    par_serialnumber varchar(64),
    par_daydate varchar(10),
    par_date_fim varchar(10),
    par_start INT(10),
    par_limit INT(10)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao filtrar registro na tabela PRJM010017. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
	SET @sql = CONCAT('SELECT *, (SELECT count(nobreak_id) FROM PRJM010017 PRJ017');
    SET @sql = CONCAT(@sql, ' WHERE PRJ017.situation = 0 ');
    
    IF par_location IS NOT NULL AND par_location != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM032.deslocation LIKE "%', par_location, '%"' );
	END IF;
    IF par_serialnumber IS NOT NULL AND par_serialnumber != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJ017.serialnumber LIKE "%', par_serialnumber, '%"' );
	END IF;
    
    IF par_daydate IS NOT NULL AND par_daydate != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJ017.daydate >= "', par_daydate, '"');
	END IF;
	
	IF par_date_fim IS NOT NULL AND par_date_fim != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJ017.daydate <= "',par_date_fim, '"');
	END IF;
    
    SET @sql = CONCAT(@sql, ') / ',par_limit, ' AS pgs');
    
	SET @sql = CONCAT(@sql, ' FROM PRJM010017 PRJM017 ');
	SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010010 PRJM010 ON PRJM010.person_id = PRJM017.person_id ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010029 PRJM029 ON PRJM029.local_id = PRJM017.local_id');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010032 PRJM032 ON PRJM032.location_id = PRJM017.location_id ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM017.situation = 0 ');
	
	IF par_daydate IS NOT NULL AND par_daydate != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM017.daydate >= "', par_daydate, '"');
	END IF;
	
	IF par_date_fim IS NOT NULL AND par_date_fim != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM017.daydate <= "',par_date_fim, '"');
	END IF;
	
	IF par_location IS NOT NULL AND par_location != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM032.deslocation LIKE "%', par_location, '%"' );
	END IF;
    IF par_serialnumber IS NOT NULL AND par_serialnumber != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM017.serialnumber LIKE "%', par_serialnumber, '%"' );
	END IF;
    
	SET @sql = CONCAT(@sql, ' LIMIT ', par_start, ', ', par_limit, ';');
	
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	
	SELECT "SUCCESS: Dados filtrado com sucesso!!" AS MESSAGE;
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
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao filtrar registro na tabela de Nobreak. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    SET @sql = CONCAT('SELECT * ');
	SET @sql = CONCAT(@sql, ' FROM PRJM010017 PRJM017 ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010010 PRJM010 USING(person_id) ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM017.nobreak_id = "', par_nobreak_id, '"');
    
    PREPARE STMT FROM @sql;
    EXECUTE STMT;
    
    SELECT "SUCCESS: Dados filtrado com sucesso!!" AS MESSAGE;
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
	par_daydate date,
	par_dayhour time,
	par_location_id int(11),
    par_local_id int(11),
	par_nobreakmodel varchar(100),
	par_resulttest char(1),
	par_observation varchar(100),
	par_serialnumber varchar(50)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao atualizar registro na tabela de Nobreak. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
	UPDATE PRJM010017
	SET
		person_id      = par_person_id,
		daydate        = par_daydate,
		dayhour        = par_dayhour,
		location_id    = par_location_id,
        local_id	   = par_local_id,
		nobreakmodel   = par_nobreakmodel,  
		resulttest     = par_resulttest,
		observation    = par_observation,
		serialnumber   = par_serialnumber
		
	WHERE nobreak_id 	= par_nobreak_id;
	
	SELECT "SUCCESS: Dados atualizados com sucesso!! " AS MESSAGE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_passwordsrecoveries_create` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_passwordsrecoveries_create`(
	par_user_id int(11),
    par_desip varchar(45)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao gravar registro na tabela PRJM010009. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;

	INSERT INTO PRJM010009 (user_id,desip) VALUES (par_user_id,par_desip);
		
	SELECT * FROM PRJM010009 WHERE recovery_id = LAST_INSERT_ID();

	SELECT "Enviado reativação de senha com sucesso!" AS MESSAGE;
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
	par_person_id int(11)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao excluir registro na tabela PRJM010001. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    DELETE FROM PRJM010001 WHERE person_id = par_person_id;
        
    SELECT "SUCCESS: Registro excluído com sucesso!!" AS MESSAGE;
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
    par_email varchar(100),
    par_classification_id tinyint(1),
    par_daydate date,
    par_situation tinyint(1),
    par_login varchar(64),
    par_password varchar(200),
    par_inadmin tinyint(1)

)
BEGIN
	DECLARE par_person_id INT;
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao gravar registro na tabela PRJM010010. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    SELECT person_id INTO par_person_id FROM PRJM010010 WHERE rg_person = par_rg_person;
    
    IF par_person_id IS NULL THEN
		INSERT INTO PRJM010001 (dt_save, situation) VALUES (par_daydate, par_situation);
		SET par_person_id = LAST_INSERT_ID();
        
		IF EX = 1 THEN
			SELECT MESSAGE = "ERROR: Erro ao gravar registro na tabela PRJM010001";
		END IF;
        
		INSERT INTO PRJM010010 (person_id, name_person, email, phonenumber, photo, rg_person, cpf_person) 
			VALUES (par_person_id, par_name_person, par_email, par_phonenumber,par_photo, par_rg_person, par_cpf_person);
		 
		IF EX = 1 THEN
			SELECT  MESSAGE = "ERROR: Erro ao gravar registro na tabela PRJM010010";
		END IF;
        
        INSERT INTO PRJM010012 (classification_id, person_id) VALUES ( par_classification_id, par_person_id);
    
		IF EX = 1 THEN
			SET MESSAGE = "ERROR: Erro ao gravar registro na tabela PRJM010012";
		END IF;
	END IF;
    
    IF (par_login IS NOT NULL AND par_login != '') AND (par_password IS NOT NULL AND par_password != '') THEN
		INSERT INTO PRJM010013 (person_id, login, pass, inadmin)
			VALUES(par_person_id, par_login, par_password, par_inadmin);
    END IF;
    
    SELECT "SUCCESS: Dados salvos com sucesso!!" AS MESSAGE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_person_sel` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_person_sel`()
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao filtrar registro na tabela PRJM010010. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    SET @sql = CONCAT(' SELECT  PRJM010.person_id,PRJM010.name_person AS responsable FROM PRJM010010 PRJM010 ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010012 PRJM012 ON PRJM012.person_id = PRJM010.person_id ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM012.classification_id = 5 ');
     
    PREPARE STMT FROM @sql;
	EXECUTE STMT;
    
	SELECT "SUCCESS: Dados filtrado com sucesso!!" AS MESSAGE;
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
    par_email varchar(100),
    par_classification_id tinyint(1),
    par_daydate date,
    par_situation tinyint(1),
    par_login varchar(64),
    par_password varchar(200),
    par_inadmin tinyint(1)
)
BEGIN
	DECLARE pID INT;
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao atualizar registro da pessoa. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
            ROLLBACK;
        END IF;
	END;
    
    UPDATE PRJM010010
		SET
			name_person      =  par_name_person,
			phonenumber      =  par_phonenumber,
            email			 =  par_email,
            photo			 =  par_photo,
			rg_person        =  par_rg_person,
			cpf_person       =  par_cpf_person

	WHERE seq_person_id = par_seq_person_id;
    
    IF (par_login IS NOT NULL AND par_login != '') AND (par_password IS NOT NULL AND par_password != '') THEN
    BEGIN
		SELECT person_id INTO pID FROM PRJM010013 WHERE person_id = par_person_id;
        
        IF pID IS NOT NULL THEN
			UPDATE PRJM010013
				SET 
					login 		= par_login, 
					pass	 	= par_password, 
					inadmin 	= par_inadmin
			WHERE person_id = pID;
			IF EX = 1 THEN
				SET  MESSAGE = '';
			END IF;
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
    COMMIT;
    SELECT "SUCCESS: Dados atualizados com sucesso!!" AS MESSAGE;
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
	par_purifier_id int(11)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao excluir registro na tabela de Purificador. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    DELETE FROM PRJM010020 WHERE purifier_id = par_purifier_id;
	
	SELECT "SUCCESS: Registro excluído com sucesso!!" AS MESSAGE;
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
	par_location_id int(11),
    par_local_id int(11),
	par_nextmanager date
    
)
BEGIN
	DECLARE LOC varchar(1000);
    -- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao gravar registro na tabela PRJM010020. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
	SET @sql = concat('INSERT INTO PRJM010020 ');
	SET @sql = concat(@sql,'	( person_id, daydate, serialnumber, location_id, local_id, nextmanager) ');
	SET @sql = concat(@sql,'	VALUES(',par_person_id,',"', par_daydate,'","', par_serialnumber,'",', par_location_id,',', par_local_id,',"', par_nextmanager,'"); ');
	
    PREPARE STMT FROM @sql;
    EXECUTE STMT;
    
    SELECT "SUCCESS: Registro salvo com sucesso!!" AS MESSAGE;
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
	par_location varchar(64),
    par_serialnumber varchar(64),
    par_daydate varchar(10),
    par_date_fim varchar(10),
    par_start INT(10),
    par_limit INT(10)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao filtrar registro na tabela PRJM010020. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    SET @sql = CONCAT('SELECT *, PRJM010.name_person AS responsable, (SELECT count(purifier_id) FROM PRJM010020 PRJ020');
    SET @sql = CONCAT(@sql, ' WHERE PRJ020.situation = 0 ');
    
    IF par_location IS NOT NULL AND par_location != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM032.deslocation LIKE "%', par_location, '%"');
	END IF;
    
    IF par_serialnumber IS NOT NULL AND par_serialnumber != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJ020.serialnumber LIKE "', par_serialnumber, '"');
	END IF;
    
    IF par_daydate IS NOT NULL AND par_daydate != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJ020.daydate >= "', par_daydate, '"');
	END IF;
	
	IF par_date_fim IS NOT NULL AND par_date_fim != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJ020.daydate <= "',par_date_fim, '"');
	END IF;
    
    SET @sql = CONCAT(@sql, ') / ',par_limit, ' AS pgs');
    
	SET @sql = CONCAT(@sql, ' FROM PRJM010020 PRJM020  ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010010 PRJM010 ON PRJM010.person_id = PRJM020.person_id  ');
	SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010029 PRJM029 ON PRJM029.local_id = PRJM020.local_id');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010032 PRJM032 ON PRJM032.location_id = PRJM020.location_id ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM020.situation = 0 ');
	
    IF par_location IS NOT NULL AND par_location != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJ032.deslocation LIKE "%', par_location, '%"');
	END IF;
    
    IF par_serialnumber IS NOT NULL AND par_serialnumber != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM020.serialnumber LIKE "', par_serialnumber, '"');
	END IF;
    
	IF par_daydate IS NOT NULL AND par_daydate != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM020.daydate >= "', par_daydate, '"');
	END IF;
	
	IF par_date_fim IS NOT NULL AND par_date_fim != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM020.daydate <= "',par_date_fim, '"');
	END IF;
	SET @sql = CONCAT(@sql, ' LIMIT ', par_start, ', ', par_limit);
	
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	
	SELECT "SUCCESS: Dados salvo com sucesso!!" AS MESSAGE;
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
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao filtrar registro na tabela de purificador. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    SET @sql = CONCAT('SELECT PRJM020.*, PRJM010.name_person AS responsable ');
	SET @sql = CONCAT(@sql, ' FROM PRJM010020 PRJM020 ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010010 PRJM010 USING(person_id) ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM020.purifier_id = "', par_purifier_id, '"');
    
    PREPARE STMT FROM @sql;
    EXECUTE STMT;
    
    SELECT "SUCCESS: Dados filtrado com sucesso!!" AS MESSAGE;
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
	par_location_id int(11),
    par_local_id int(11),
	par_nextmanager date
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao atualizar registro na tabela de purificador. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
	UPDATE PRJM010020
	SET
		person_id    = par_person_id,
		daydate      = par_daydate,
        serialnumber = par_serialnumber,
		location_id  = par_location_id,
        local_id	 = par_local_id,
		nextmanager  = par_nextmanager
			
	WHERE purifier_id  = par_purifier_id;
	
	SELECT "SUCCESS: Dados atualizados com sucesso!! " AS MESSAGE;
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
	par_residual_id int(11)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao excluir registro na tabela de resíduos. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
	SET @sql = CONCAT('DELETE FROM PRJM010015  ');
	SET @sql = CONCAT(@sql,' WHERE residual_id = ',par_residual_id,';');
	
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	
    SELECT "SUCCESS: Registro excluído com sucesso!!" AS MESSAGE;
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
	par_material varchar(100),
	par_location_id int(11),
    par_local_id int(11),
	par_warehouse varchar(100)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao gravar registro na tabela PRJM010015. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    INSERT INTO PRJM010015
		( person_id, daydate, dayhour, material, location_id,local_id, warehouse)
		VALUES( par_person_id, par_daydate, par_dayhour, par_material, par_location_id, par_local_id, par_warehouse);
     
	SELECT "SUCCESS: Dados salvos com sucesso!!" AS MESSAGE;
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
	par_deslocation varchar(64),
    par_material varchar(64),
    par_daydate varchar(10),
    par_date_fim varchar(10),
    par_start INT(10),
    par_limit INT(10)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao filtrar registro na tabela PRJM010015. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
	SET @sql = CONCAT('SELECT *, (SELECT count(residual_id) FROM PRJM010015 PRJ015');
    SET @sql = CONCAT(@sql, ' WHERE PRJ015.situation = 0 ');
    
    IF par_deslocation IS NOT NULL AND par_deslocation != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM032.deslocation LIKE "%', par_deslocation, '%"' );
	END IF;
    
    IF par_material IS NOT NULL AND par_material != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJ015.material LIKE "%', par_material, '%"' );
	END IF;
    
    IF par_daydate IS NOT NULL AND par_daydate != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJ015.daydate >= "', par_daydate, '"');
	END IF;
	
	IF par_date_fim IS NOT NULL AND par_date_fim != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJ015.daydate <= "',par_date_fim, '"');
	END IF;
    
    SET @sql = CONCAT(@sql, ') / ',par_limit, ' AS pgs');
    
	SET @sql = CONCAT(@sql, ' FROM PRJM010015 PRJM015 ');
	SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010010 PRJM010 ON PRJM010.person_id = PRJM015.person_id ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010029 PRJM029 ON PRJM029.local_id = PRJM015.local_id ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010032 PRJM032 ON PRJM032.location_id = PRJM015.location_id ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM015.situation = 0 ');
	
	IF par_daydate IS NOT NULL AND par_daydate != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM015.daydate >= "', par_daydate, '"');
	END IF;
	
	IF par_date_fim IS NOT NULL AND par_date_fim != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM015.daydate <= "',par_date_fim, '"');
	END IF;
	
	IF par_deslocation IS NOT NULL AND par_deslocation != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM032.deslocation LIKE "%', par_deslocation, '%"' );
	END IF;
    
    IF par_material IS NOT NULL AND par_material != '' THEN
		SET @sql = CONCAT(@sql, ' AND PRJM015.material LIKE "%', par_material, '%"' );
	END IF;
    
    SET @sql = CONCAT(@sql, ' ORDER BY PRJM010.name_person ' );
	SET @sql = CONCAT(@sql, ' LIMIT ', par_start,par_limit, ';' );
	
    PREPARE STMT FROM @sql;
	EXECUTE STMT;
	
	SELECT "SUCCESS: Dados filtrado com sucesso!!" AS MESSAGE;
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
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao filtrar registro na tabela de resíduos. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    SET @sql = CONCAT('SELECT * ');
	SET @sql = CONCAT(@sql, ' FROM PRJM010015 PRJM015 ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010010 PRJM010 USING(person_id) ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM015.residual_id = "', par_residual_id, '"');
    
    PREPARE STMT FROM @sql;
    EXECUTE STMT;
    
    SELECT "SUCCESS: Dados filtrado com sucesso!!" AS MESSAGE;
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
	par_material varchar(100),
	par_location_id int(11),
    par_local_id int(11),
	par_warehouse varchar(100),
    par_situation tinyint(1)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao atualizar registro na tabela de resíduos. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
	UPDATE PRJM010015
	SET
		person_id	= par_person_id,
        daydate		= par_daydate,
		dayhour		= par_dayhour,
		material	= par_material,
		location_id	= par_location_id,
        local_id	= par_local_id,
		warehouse	= par_warehouse,
		situation	= par_situation
	WHERE residual_id 	= par_residual_id;
	
	SELECT "SUCCESS: Dados atualizados com sucesso!! "AS MESSAGE;
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
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao filtrar registro na tabela PRJM010010. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    SET @sql = CONCAT('SELECT PRJM010.name_person as responsable, PRJM010.*, (SELECT count(person_id) FROM PRJM010010 ) / ', par_limit, ' AS pgs');
	SET @sql = CONCAT(@sql, ' FROM PRJM010010 PRJM010  ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010001 PRJM001 ON PRJM001.person_id = PRJM010.person_id  ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010012 PRJM012 ON PRJM012.person_id = PRJM010.person_id ');
    SET @sql = CONCAT(@sql, ' WHERE PRJM001.situation = 0 AND PRJM012.classification_id = 4 OR (PRJM012.classification_id = 5)');
	
	SET @sql = CONCAT(@sql, ' LIMIT ', par_start, ', ', par_limit);
	
	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	
	SELECT "SUCCESS: Dados filtrado com sucesso!!" AS MESSAGE;
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
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao atualizar registro na tabela PRJM010013. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
        END IF;
	END;
    
    UPDATE PRJM010013
	SET 
		login 		= par_login, 
		pass 		= par_password, 
		inadmin 	= par_inadmin
	WHERE user_id = par_user_id;
                
   SELECT "SUCCESS: Dados atualizados com sucesso!!" AS MESSAGE;
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
	par_visitant_id int(11)
)
BEGIN
	DECLARE par_person_id INT;
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao excluir registro na tabela PRJM010001. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
            ROLLBACK;
        END IF;
	END;
   	
    SELECT person_id INTO par_person_id FROM PRJM010014 WHERE visitant_id = par_visitant_id;
    DELETE FROM PRJM010001 WHERE person_id = par_person_id;
    
    COMMIT;
    SELECT "SUCCESS: Registro excluído com sucesso!!" AS MESSAGE;
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
	par_email varchar(100),
    par_phonenumber varchar(11),
    par_photo blob,
	par_company varchar(100),
	par_reason varchar(100),
	par_badge char(3),
	par_auth varchar(45), 
	par_sign varchar(100),
	par_daydate date,
	par_dayhour time,
	par_classification_id int
)
BEGIN
	DECLARE par_person_id int;
    -- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao gravar registro do visitante. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
            ROLLBACK;
        END IF;
	END;
    
	INSERT INTO PRJM010001 (dt_save, situation) VALUES (par_daydate, '0');
	SET par_person_id = LAST_INSERT_ID();
	
	INSERT INTO PRJM010010 (person_id, name_person, email, phonenumber, photo, rg_person, cpf_person) 
		VALUES (par_person_id, par_name_person, par_email, par_phonenumber,par_photo, par_rg_person, par_cpf_person);
	
	INSERT INTO PRJM010012 (classification_id, person_id) VALUES ( par_classification_id, par_person_id);
		
	INSERT INTO prjm010014
		(person_id,daydate,dayhour,company,reason,badge,auth,sign)
		VALUES( par_person_id,par_daydate,par_dayhour,par_company,par_reason,par_badge,par_auth,par_sign);

	COMMIT;
	SELECT "SUCCESS: Registro cadastrado com sucesso!!" AS MESSAGE;
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
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao filtrar registro na tabela PRJM010010. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
            ROLLBACK;
        END IF;
	END;
    
    IF par_daydate IS NULL THEN
		SELECT daydate into par_daydate FROM PRJM010014 LIMIT 1;
	END IF;
    IF par_daydate IS NOT NULL THEN
		SET @sql = CONCAT('SELECT *, (SELECT count(person_id) FROM PRJM010014 PRJ014');
        SET @sql = CONCAT(@sql, ' WHERE PRJ014.situation = 0 ');
        
        IF par_name_person IS NOT NULL AND par_name_person != '' THEN
			SET @sql = CONCAT(@sql, ' AND PRJM010.name_person LIKE "%', par_name_person, '%"' );
		END IF;
        
        IF par_daydate IS NOT NULL AND par_daydate != '' THEN
			SET @sql = CONCAT(@sql, ' AND PRJ014.daydate >= "', par_daydate, '"');
		END IF;
		
		IF par_date_fim IS NOT NULL AND par_date_fim != '' THEN
			SET @sql = CONCAT(@sql, ' AND PRJ014.daydate <= "',par_date_fim, '"');
		END IF;
        
        SET @sql = CONCAT(@sql, ') / ',par_limit, ' AS pgs');
        
		SET @sql = CONCAT(@sql, ' FROM PRJM010010 PRJM010 ');
		SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010014 PRJM014 USING(person_id) ');
		SET @sql = CONCAT(@sql, ' WHERE PRJM014.situation = 0 ');
		
		IF par_daydate IS NOT NULL AND par_daydate != '' THEN
			SET @sql = CONCAT(@sql, ' AND PRJM014.daydate >= "', par_daydate, '"');
		END IF;
		
		IF par_date_fim IS NOT NULL AND par_date_fim != '' THEN
			SET @sql = CONCAT(@sql, ' AND PRJM014.daydate <= "',par_date_fim, '"');
		END IF;
		
		IF par_name_person IS NOT NULL AND par_name_person != '' THEN
			SET @sql = CONCAT(@sql, ' AND PRJM010.name_person LIKE "%', par_name_person, '%"' );
		END IF;
        
		SET @sql = CONCAT(@sql, ' ORDER BY PRJM010.name_person ' );
        SET @sql = CONCAT(@sql, ' LIMIT ', par_start, ', ', par_limit );
        
		PREPARE STMT FROM @sql;
		EXECUTE STMT;
		
        COMMIT;
		SELECT "SUCCESS: Dados salvo com sucesso!!" AS MESSAGE;
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
	par_visitant_id INT(11)
)
BEGIN
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao filtrar registro na tabela PRJM010010. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
            ROLLBACK;
        END IF;
	END;
    
    SET @sql = CONCAT('SELECT * ');
	SET @sql = CONCAT(@sql, ' FROM PRJM010001 PRJM001 ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010010 PRJM010 USING(person_id) ');
	SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010014 PRJM014 USING(person_id) ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010012 PRJM012 USING(person_id) ');
    SET @sql = CONCAT(@sql, ' WHERE PRJM014.visitant_id = "', par_visitant_id, '"');
    
    PREPARE STMT FROM @sql;
    EXECUTE STMT;
    
    COMMIT;
    SELECT "SUCCESS: Dados filtrado com sucesso!!" AS MESSAGE;
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
    par_email varchar(100),
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
	-- Declare variables to hold diagnostics area information
    DECLARE MESSAGE TEXT;
	DECLARE ERRNUMBER INT;
	DECLARE ERR varchar(1000) default '';
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- Here the current DA is nonempty because no prior statements
		-- executing within the handler have cleared it
		GET CURRENT DIAGNOSTICS CONDITION 1
		  ERRNUMBER = MYSQL_ERRNO, ERR = MESSAGE_TEXT;
		
        IF ERR IS NOT NULL THEN
			SET  MESSAGE = concat('ERROR: Erro ao atualizar registro do visitante. : Erro ', ERRNUMBER,' : ', ERR);
            SELECT MESSAGE;
            ROLLBACK;
        END IF;
	END;
    START TRANSACTION;
	#CALL prc_person_update(par_seq_person_id,par_seq_classp_id,par_person_id,par_name_person,par_phonenumber,par_photo,par_rg_person,par_cpf_person,par_email,par_classification_id,par_daydate,par_situation,'','','0');
    
    UPDATE PRJM010010
		SET
			name_person      =  par_name_person,
			phonenumber      =  par_phonenumber,
            email			 =  par_email,
            photo			 =  par_photo,
			rg_person        =  par_rg_person,
			cpf_person       =  par_cpf_person

	WHERE seq_person_id = par_seq_person_id;
    
   	UPDATE PRJM010012 
		SET classification_id = par_classification_id
	WHERE seq_classp_id = par_seq_classp_id;   
  	 
    UPDATE PRJM010014
	SET
		company		= par_company,
		reason		= par_reason,
		badge		= par_badge,
		auth		= par_auth,
		sign		= par_sign,
		situation	=par_situation
	WHERE visitant_id 	= par_visitant_id;
   
	COMMIT;
    SELECT "SUCCESS: Dados atualizados com sucesso!! " AS MESSAGE;
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

-- Dump completed on 2021-08-24 11:42:29
