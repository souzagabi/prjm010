DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_clothing_update`(
	par_clothing_id int(11),
	par_user_id int(11),
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
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
    START TRANSACTION;
    
	UPDATE PRJM010022
	SET
		user_id        = par_user_id,
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
END$$
DELIMITER ;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_clothing_delete`(
	par_clothing_id int(11),
    par_user_id int(11)
)
BEGIN
	DECLARE P_person_id int;
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
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
	END IF; #Fim do if EX = 1 THEN
    
END$$
DELIMITER ;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_clothing_save`(
	par_user_id int(11),
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
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
    START TRANSACTION;
    
    set @sql = concat('INSERT INTO PRJM010022 ');
	set @sql = concat(@sql, ' (user_id,person_id,dateout,qtdeout,signout');
	
    IF par_datein IS NOT NULL AND par_datein != '' THEN
		set @sql = concat(@sql, ',datein,qtdein,signin');
 	END IF;
    
    set @sql = concat(@sql, ' )');
    set @sql = concat(@sql, ' VALUES (',par_user_id,',',par_person_id,',"',par_dateout,'",',par_qtdeout,',"',par_signout,'"');
    
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
END$$
DELIMITER ;
DELIMITER $$
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
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
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

END$$
DELIMITER ;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_clothing_sel_byid`(
	par_clothing_id INT(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
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

END$$
DELIMITER ;
