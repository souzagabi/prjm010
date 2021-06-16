DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_visitant_delete`(
	par_visitant_id int(11),
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
    
    IF par_person_id IS NOT NULL OR par_person_id != '' THEN
		
        #SET @sql = CONCAT('DELETE FROM PRJM010001  WHERE person_id = ',par_person_id,';');
		SET @sql = CONCAT('UPDATE PRJM010014  ');
        SET @sql = CONCAT(@sql,' SET situation = 1,');
        SET @sql = CONCAT(@sql,' user_id_deleted = ',par_user_id,',');
        SET @sql = CONCAT(@sql,' dt_deleted = ','"',now(),'"');
		SET @sql = CONCAT(@sql,' WHERE visitant_id = ',par_visitant_id,';');
		
        #SELECT @sql;
        PREPARE STMT FROM @sql;
        EXECUTE STMT;
        IF EX = 1 THEN
			SET MESSAGE = "ERROR: Erro ao excluir registro na tabela PRJM010001";
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
	END IF; #Fim do if EX = 1 THEN
    
END$$
DELIMITER ;
DELIMITER $$
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
	par_user_id int,
    par_classification int
)
BEGIN
	DECLARE par_person_id int;
    DECLARE MESSAGE, MSG001, MSG010 varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
    START TRANSACTION;
    
    CALL prc_person_save(par_name_person,par_phonenumber,par_photo,par_rg_person,par_cpf_person,par_classification,par_daydate,'0','','',0);
    IF EX = 1 THEN
		SET MESSAGE = "ERROR: Erro ao gravar registro na tabela PRJM010010";
	END IF;
    
    SELECT LAST_INSERT_ID() INTO par_person_id FROM PRJM010001 ;
    
	INSERT INTO prjm010014
		(person_id,user_id,daydate,dayhour,company,reason,badge,auth,sign)
		VALUES( par_person_id,par_user_id,par_daydate,par_dayhour,par_company,par_reason,par_badge,par_auth,par_sign);
     
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
END$$
DELIMITER ;
DELIMITER $$
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
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
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
END$$
DELIMITER ;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_visitant_sel_byid`(
	par_person_id INT(11)
)
BEGIN
	DECLARE MESSAGE, MSG001, MSG010 varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
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

END$$
DELIMITER ;
DELIMITER $$
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
	par_user_id int,
    par_classification_id int,
    par_situation tinyint(1)
)
BEGIN
	DECLARE MESSAGE, MSG001, MSG010 varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
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
END$$
DELIMITER ;
