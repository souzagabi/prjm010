DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_fireexting_delete`(
	par_fireexting_id int(11),
    par_user_id int(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_fireexting_save`(
	par_user_id int(11),
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
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
    START TRANSACTION;
    
    INSERT INTO PRJM010018
		(user_id,person_id,daydate,dayhour,location,tipe,weight,capacity,rechargedate)
		VALUES(par_user_id,par_person_id,par_daydate,par_dayhour,par_location,par_tipe,par_weight,par_capacity,par_rechargedate);
    
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
END$$
DELIMITER ;
DELIMITER $$
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
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
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
END$$
DELIMITER ;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_fireexting_sel_byid`(
	par_fireexting_id INT(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
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
END$$
DELIMITER ;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_fireexting_update`(
	par_fireexting_id int(11),
    par_user_id int(11),
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
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
    START TRANSACTION;
    
	UPDATE PRJM010018
	SET
		user_id         = par_user_id,
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
END$$
DELIMITER ;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_historicE_delete`(
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
END$$
DELIMITER ;
DELIMITER $$
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
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
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
		#SET MESSAGE = "SUCCESS: Dados salvo com sucesso!!" ;
		SELECT MESSAGE;
		COMMIT;
	END IF;

END$$
DELIMITER ;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_historicE_update`(
	par_historic_id int(11),
	par_fireexting_id int(11),
	par_user_id int(11),
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
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
    START TRANSACTION;
    
	UPDATE PRJM010019
	SET
		user_id         = par_user_id,
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
END$$
DELIMITER ;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_historicE_save`(
	par_user_id int(11),
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
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
    START TRANSACTION;
    
    INSERT INTO PRJM010019
		(user_id,fireexting_id,daydate,htrigger,hose,diffuser,painting,hydrostatic,hothers)
		VALUES(par_user_id,par_fireexting_id,par_daydate,par_htrigger,par_hose,par_diffuser,par_painting,par_hydrostatic,par_hothers);
    
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
END$$
DELIMITER ;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_historicE_sel_byid`(
	par_fireexting_id INT(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
    START TRANSACTION;
    
    SET @sql = CONCAT('SELECT PRJM019.*');
	SET @sql = CONCAT(@sql, ' FROM PRJM010019 PRJM019 ');
    SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010018 PRJM018 USING(fireexting_id) ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM019.fireexting_id = ', par_fireexting_id);
    
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
