DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_material_delete`(
	par_material_id int(11),
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
    
    IF par_material_id IS NOT NULL OR par_material_id != '' THEN
		       
		SET @sql = CONCAT('UPDATE PRJM010023  ');
        SET @sql = CONCAT(@sql,' SET situation = 1,');
        SET @sql = CONCAT(@sql,' user_id_deleted = ',par_user_id,',');
        SET @sql = CONCAT(@sql,' dt_deleted = ','"',now(),'"');
		SET @sql = CONCAT(@sql,' WHERE material_id = ',par_material_id,';');
		
        #SELECT @sql;
        PREPARE STMT FROM @sql;
        EXECUTE STMT;
        IF EX = 1 THEN
			SET MESSAGE = "ERROR: Erro ao excluir registro na tabela de mercadorias";
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_material_save`(
	par_user_id int,
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
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
    START TRANSACTION;
    
    INSERT INTO PRJM010023
		(user_id,person_id,daydate,dayhour,material,qtde,receiver,deliveryman)
		VALUES(par_user_id,par_person_id,par_daydate,par_dayhour,par_material,par_qtde,par_receiver,par_deliveryman);
     
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
	
END$$
DELIMITER ;
DELIMITER $$
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
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
    START TRANSACTION;
    
    
	SET @sql = CONCAT('SELECT *, (SELECT count(material_id) FROM PRJM010023) / ', par_limit, ' AS pgs');
	SET @sql = CONCAT(@sql, ' FROM (SELECT * FROM PRJM010023 PRJM023 LIMIT ', par_start, ', ', par_limit, ' ) AS PRJM023 ');
	SET @sql = CONCAT(@sql, ' INNER JOIN PRJM010010 PRJM010 USING(person_id) ');
	SET @sql = CONCAT(@sql, ' WHERE PRJM023.material_id IS NOT NULL ');
	
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
END$$
DELIMITER ;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_material_sel_byid`(
	par_material_id INT(11)
)
BEGIN
	DECLARE MESSAGE varchar(1000);
    DECLARE EX SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET EX = 1;
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
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

END$$
DELIMITER ;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_material_update`(
	par_material_id int,
    par_user_id int,
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
    DECLARE EXIT HANDLER FOR 1062 SELECT  "ERRO de duplicidade do ID." AS MSGID;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Erro no código SQL.' AS MSGSQL;
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
		SET MESSAGE = CONCAT("ERROR: Erro ao atualizar registro na tabela de materiais. ");
		SELECT MESSAGE;
		ROLLBACK;
	ELSE
		SET MESSAGE = CONCAT("SUCCESS: Dados atualizados com sucesso!! ") ;
        SELECT MESSAGE;
		COMMIT;
	END IF; #Fim do if EX = 1 THEN
END$$
DELIMITER ;
