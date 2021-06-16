DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_purifier_delete`(
	par_purifier_id int(11),
    par_user_id int(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_purifier_save`(
	par_user_id int(11),
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
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
    START TRANSACTION;
    
    SELECT location INTO LOC FROM PRJM010020 WHERE location = par_location;
    
    IF LOC IS NULL THEN
		INSERT INTO PRJM010020
			(user_id, person_id, daydate,serialnumber , location, nextmanager)
			VALUES(par_user_id, par_person_id, par_daydate,par_serialnumber , par_location, par_nextmanager);
		
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
END$$
DELIMITER ;
DELIMITER $$
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
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
    START TRANSACTION;
    
    SET @sql = CONCAT('SELECT PRJM020.*, PRJM010.name_person AS responsable, (SELECT count(purifier_id) FROM PRJM010020) / ', par_limit, ' AS pgs');
	SET @sql = CONCAT(@sql, ' FROM PRJM010020 PRJM020  ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010010 PRJM010  ');
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
END$$
DELIMITER ;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_purifier_sel_byid`(
	par_purifier_id INT(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
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
END$$
DELIMITER ;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_purifier_update`(
	par_purifier_id int(11),
	par_user_id int(11),
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
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
    START TRANSACTION;
    
	UPDATE PRJM010020
	SET
		user_id      = par_user_id,
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
END$$
DELIMITER ;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_historicP_delete`(
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
END$$
DELIMITER ;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_historicP_sel_byid`(
	par_historic_id INT(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
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
END$$
DELIMITER ;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_historicP_save`(
	par_user_id int(11),
	par_purifier_id int(11),
	par_daydate date,
	par_serialnumber varchar(50)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
    START TRANSACTION;
    
    INSERT INTO PRJM010021
		(user_id,purifier_id,daydate,serialnumber)
		VALUES(par_user_id,par_purifier_id,par_daydate,par_serialnumber);
    
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
END$$
DELIMITER ;
DELIMITER $$
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
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
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

END$$
DELIMITER ;
DELIMITER $$
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
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
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
END$$
DELIMITER ;
