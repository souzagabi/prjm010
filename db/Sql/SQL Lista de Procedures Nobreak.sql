DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_nobreak_delete`(
	par_nobreak_id int(11),
    par_user_id int(11)
)
BEGIN
	DECLARE P_person_id int;
	DECLARE MESSAGE, MSG001, MSG010 varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
    START TRANSACTION;
    
    IF par_nobreak_id IS NOT NULL OR par_nobreak_id != '' THEN
		
        #SET @sql = CONCAT('DELETE FROM PRJM010001  WHERE person_id = ',par_person_id,';');
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
		
	ELSE
    	SET MESSAGE = "Este registro não existe!!";
        SET EX = 1;
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_nobreak_save`(
	par_user_id int(11),
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
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
    START TRANSACTION;
    
    INSERT INTO PRJM010017 
		(user_id,person_id,name_person,daydate,dayhour,location,nobreakmodel,resulttest,observation,serialnumber)
		VALUES (par_user_id,par_person_id,par_name_person,par_daydate,par_dayhour,par_location,par_nobreakmodel,par_resulttest,par_observation,par_serialnumber);
     
	
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
	
END$$
DELIMITER ;
DELIMITER $$
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
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
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
	
END$$
DELIMITER ;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_nobreak_sel_byid`(
	par_nobreak_id INT(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
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

END$$
DELIMITER ;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_nobreak_update`(
	par_nobreak_id int(11),
    par_user_id int(11),
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
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
    START TRANSACTION;
    
	UPDATE PRJM010017
	SET
		user_id        = par_user_id,
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
END$$
DELIMITER ;
