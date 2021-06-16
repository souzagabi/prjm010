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
