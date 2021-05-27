DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_classification_sel`()
BEGIN
	SELECT * FROM PRJM010011;
END$$
DELIMITER ;

DELIMITER $$
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
    DECLARE MESSAGE, MSG001, MSG010 varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
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
	END IF; #Fim do if EX = 1 THEN

END$$
DELIMITER ;

DELIMITER $$
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
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
    
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
		SET  MESSAGE = CONCAT("ERROR: Erro ao atualizar registro na tabela PRJM010010 <=>
        UPDATE PRJM010010 SET name_person = ", par_name_person, "phonenumber = ",par_phonenumber, " rg_person = ",par_rg_person,
			" cpf_person = ",par_cpf_person, " WHERE seq_person_id = ",par_seq_person_id,";", "  <=> ", MESSAGE);
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
		SET  MESSAGE = CONCAT("ERROR: Erro ao atualizar registro na tabela PRJM010012 
						<=> UPDATE PRJM010012 
						SET classification_id = ",par_classification_id,
							" WHERE seq_classp_id = ", par_seq_classp_id,";", "  <=> ", MESSAGE);
	END IF;
    
    IF EX = 1 THEN
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = CONCAT("SUCCESS: Dados atualizados com sucesso!!");
        SELECT MESSAGE;
		COMMIT;
	END IF; #Fim do if EX = 1 THEN
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_residual_delete`(
	par_residual_id int(11),
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
    
    IF par_residual_id IS NOT NULL OR par_residual_id != '' THEN
		
        #SET @sql = CONCAT('DELETE FROM PRJM010001  WHERE person_id = ',par_person_id,';');
		SET @sql = CONCAT('UPDATE PRJM010015  ');
        SET @sql = CONCAT(@sql,' SET situation = 1,');
        SET @sql = CONCAT(@sql,' user_id_deleted = ',par_user_id,',');
        SET @sql = CONCAT(@sql,' dt_deleted = ','"',now(),'"');
		SET @sql = CONCAT(@sql,' WHERE residual_id = ',par_residual_id,';');
		
        #SELECT @sql;
        PREPARE STMT FROM @sql;
        EXECUTE STMT;
        IF EX = 1 THEN
			SET MESSAGE = "ERROR: Erro ao excluir registro na tabela PRJM010015";
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_residual_save`(
	par_user_id int,
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
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
    START TRANSACTION;
    
    INSERT INTO PRJM010015
		(user_id, person_id, daydate, dayhour, name_person, material, location, warehouse)
		VALUES(par_user_id, par_person_id, par_daydate, par_dayhour, par_name_person, par_material, par_location, par_warehouse);
     
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
	
END$$
DELIMITER ;

DELIMITER $$
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
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
    START TRANSACTION;
    
    IF par_daydate IS NULL THEN
		SELECT daydate into par_daydate FROM PRJM010015 LIMIT 1;
	END IF;
    IF par_daydate IS NOT NULL THEN
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
			SET MESSAGE = "SUCCESS: Dados salvo com sucesso!!" ;
			SELECT MESSAGE;
			COMMIT;
		END IF; #Fim do if EX = 1 THEN
	END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_residual_sel_byid`(
	par_residual_id INT(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
    START TRANSACTION;
    
    SET @sql = CONCAT('SELECT * ');
	SET @sql = CONCAT(@sql, ' FROM PRJM010015 PRJM015 ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010010 PRJM010 USING(person_id) ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM015.residual_id = "', par_residual_id, '"');
    
    PREPARE STMT FROM @sql;
    EXECUTE STMT;
    
    IF EX = 1 THEN
		SELECT MESSAGE = "ERROR: Erro ao filtrar registro na tabela PRJM010015";
		ROLLBACK;
	ELSE
		SELECT "SUCCESS: Dados filtrado com sucesso!!" MESSAGE;
		COMMIT;
	END IF; #Fim do if EX = 1 THEN

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_residual_update`(
	par_residual_id int,
    par_user_id int,
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
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
    START TRANSACTION;
    
	UPDATE PRJM010015
	SET
		name_person	= par_name_person,
		material	= par_material,
		location	= par_location,
		warehouse	= par_warehouse
	WHERE residual_id 	= par_residual_id;
	
	IF EX = 1 THEN
		SET MESSAGE = CONCAT("ERROR: Erro ao atualizar registro na tabela PRJM010014 ");
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = CONCAT("SUCCESS: Dados atualizados com sucesso!! ") ;
        SELECT MESSAGE;
		COMMIT;
	END IF; #Fim do if EX = 1 THEN
END$$
DELIMITER ;

DELIMITER $$
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
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
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
END$$
DELIMITER ;

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

