DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_hydrant_delete`(
	par_hydrant_id int(11),
    par_user_id int(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
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
	
	#SELECT @sql;
	#PREPARE STMT FROM @sql;
	#EXECUTE STMT;
     
    IF EX = 1 THEN
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = "SUCCESS: Registro excluído com sucesso!!" ;
        SELECT MESSAGE;
		COMMIT;
	END IF;

END$$
DELIMITER ;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_hydrant_save`(
	par_user_id int(11),
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
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
    START TRANSACTION;
    
    INSERT INTO PRJM010024
		(user_id,person_id,location,tipe,idnumber,observation)
		VALUES(par_user_id,par_person_id,par_location,par_tipe,par_idnumber,par_observation);
    
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
END$$
DELIMITER ;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_hydrant_sel`(
	par_start INT(10),
    par_limit INT(10)
)
BEGIN
	
    DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
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
END$$
DELIMITER ;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_hydrant_sel_byid`(
	par_hydrant_id INT(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
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
END$$
DELIMITER ;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_hydrant_update`(
	par_hydrant_id int(11),
    par_user_id int(11),
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
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
    START TRANSACTION;
    
	UPDATE PRJM010024
	SET
		user_id         = par_user_id,
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
END$$
DELIMITER ;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_historicH_delete`(
	par_historic_id int(11), 
    par_user_id int(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
	DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
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
END$$
DELIMITER ;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_historicH_save`(
	par_user_id int(11),
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
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
    START TRANSACTION;
    
    INSERT INTO PRJM010025
		(user_id,hydrant_id,daydate,idkey,hose,squirt,painting,alarmcentral,glass,inlock,record,signaling,obstruction,observation)
		VALUES(par_user_id,par_hydrant_id,par_daydate,par_idkey,par_hose,par_squirt,par_painting,par_alarmcentral,par_glass,par_inlock,par_record,par_signaling,par_obstruction,par_observation);
    
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
END$$
DELIMITER ;
DELIMITER $$
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
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
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

END$$
DELIMITER ;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_historicH_sel_byid`(
	par_hydrant_id INT(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
    START TRANSACTION;
    
    SET @sql = CONCAT('SELECT PRJM025.*');
	SET @sql = CONCAT(@sql, ' FROM PRJM010025 PRJM025 ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010024 PRJM024 USING(hydrant_id) ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM025.hydrant_id = ', par_hydrant_id);
    
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
END$$
DELIMITER ;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_historicH_update`(
	par_historic_id int(11),
	par_user_id int(11),
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
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
    START TRANSACTION;
    
	UPDATE PRJM010025
	SET
		user_id = par_user_id,
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
END$$
DELIMITER ;
