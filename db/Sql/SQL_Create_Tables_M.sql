CREATE TABLE `prjm010001` (
  `person_id` int NOT NULL AUTO_INCREMENT,
  `dt_save` date DEFAULT NULL,
  `user_id_deleted` int DEFAULT NULL,
  `dt_deleted` timestamp NULL DEFAULT NULL,
  `situation` varchar(10) DEFAULT NULL,
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `prjm010`.`prjm010009` (
  `recovery_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `desip` varchar(45) NOT NULL,
  `dtrecovery` datetime DEFAULT NULL,
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`recovery_id`),
  KEY `fk_prjm010009_prjm010013_idx` (`user_id`),
  CONSTRAINT `fk_prjm010009_prjm010010` FOREIGN KEY (`user_id`) REFERENCES `prjm010013` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

CREATE TABLE `prjm010010` (
  `seq_person_id` int NOT NULL AUTO_INCREMENT,
  `person_id` int NOT NULL,
  `name_person` varchar(64) NOT NULL,
  `phonenumber` varchar(11) DEFAULT NULL,
  `rg_person` varchar(10) NOT NULL,
  `cpf_person` varchar(11) DEFAULT NULL,
  `photo` blob,
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`seq_person_id`),
  KEY `FK_PRJM010010_PRJM010001_idx` (`person_id`),
  CONSTRAINT `fk_PRJM010010_PRJM010001` FOREIGN KEY (`person_id`) REFERENCES `prjm010001` (`person_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `prjm010011` (
  `classification_id` int NOT NULL AUTO_INCREMENT,
  `description` varchar(64) NOT NULL,
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`classification_id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `prjm010012` (
  `seq_classp_id` int NOT NULL AUTO_INCREMENT,
  `classification_id` int NOT NULL,
  `person_id` int NOT NULL,
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`seq_classp_id`,`classification_id`,`person_id`),
  KEY `FK_PRJM010012_PRJM010001_idx` (`person_id`),
  KEY `FK_PRJM010012_PRJM010011_idx` (`classification_id`),
  CONSTRAINT `fk_PRJM010012_PRJM010001` FOREIGN KEY (`person_id`) REFERENCES `prjm010001` (`person_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_PRJM010012_PRJM010011` FOREIGN KEY (`classification_id`) REFERENCES `prjm010011` (`classification_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `prjm010013` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `person_id` int NOT NULL,
  `login` varchar(20) NOT NULL,
  `pass` varchar(200) NOT NULL,
  `inadmin` tinyint(1) NOT NULL DEFAULT '0',
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  KEY `FK_PRJM010013_PRJM010001_idx` (`person_id`),
  CONSTRAINT `fk_PRJM010013_PRJM010001` FOREIGN KEY (`person_id`) REFERENCES `prjm010001` (`person_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `prjm010014` (
  `visitant_id` int NOT NULL AUTO_INCREMENT,
  `person_id` int NOT NULL,
  `daydate` date NOT NULL,
  `dayhour` time DEFAULT NULL,
  `company` varchar(100) DEFAULT NULL,
  `reason` varchar(100) DEFAULT NULL,
  `badge` char(3) NOT NULL,
  `auth` varchar(45) NOT NULL,
  `sign` varchar(100) NOT NULL,
  `situation` char(1) DEFAULT '0',
  `user_id_deleted` int DEFAULT NULL,
  `dt_deleted` timestamp NULL DEFAULT NULL,
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`visitant_id`),
  KEY `FK_PRJM010014_PRJM010001_idx` (`person_id`),
  CONSTRAINT `fk_PRJM010014_PRJM010001` FOREIGN KEY (`person_id`) REFERENCES `prjm010001` (`person_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `prjm010015` (
  `residual_id` int NOT NULL AUTO_INCREMENT,
  `person_id` int NOT NULL,
  `daydate` date NOT NULL,
  `dayhour` time NOT NULL,
  `name_person` varchar(100) DEFAULT NULL,
  `material` varchar(100) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `warehouse` varchar(100) DEFAULT NULL,
  `user_id_deleted` int DEFAULT NULL,
  `dt_deleted` timestamp NULL DEFAULT NULL,
  `situation` char(1) DEFAULT '0',
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`residual_id`),
  KEY `FK_prjm010015_PRJM010001_idx` (`person_id`),
  CONSTRAINT `fk_prjm010015_PRJM010001` FOREIGN KEY (`person_id`) REFERENCES `prjm010001` (`person_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `prjm010016` (
  `goods_id` int NOT NULL AUTO_INCREMENT,
  `person_id` int NOT NULL,
  `daydate` date NOT NULL,
  `dayhour` time NOT NULL,
  `goods` varchar(100) DEFAULT NULL,
  `qtde` decimal(10,2) DEFAULT NULL,
  `packing` char(1) DEFAULT NULL,
  `receiver` varchar(100) DEFAULT NULL,
  `deliveryman` varchar(100) DEFAULT NULL,
  `user_id_deleted` int DEFAULT NULL,
  `dt_deleted` timestamp NULL DEFAULT NULL,
  `situation` char(1) DEFAULT '0',
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`goods_id`),
  KEY `FK_prjm010016_PRJM010001_idx` (`person_id`),
  CONSTRAINT `fk_prjm010016_PRJM010001` FOREIGN KEY (`person_id`) REFERENCES `prjm010001` (`person_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `prjm010017` (
  `nobreak_id` int NOT NULL AUTO_INCREMENT,
  `person_id` int NOT NULL,
  `daydate` date NOT NULL,
  `dayhour` time NOT NULL,
  `name_person` varchar(100) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `nobreakmodel` varchar(100) DEFAULT NULL,
  `resulttest` char(1) DEFAULT NULL,
  `observation` varchar(100) DEFAULT NULL,
  `serialnumber` varchar(50) DEFAULT NULL,
  `user_id_deleted` int DEFAULT NULL,
  `dt_deleted` timestamp NULL DEFAULT NULL,
  `situation` char(1) DEFAULT '0',
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`nobreak_id`),
  KEY `FK_prjm010017_PRJM010001_idx` (`person_id`),
  CONSTRAINT `fk_prjm010017_PRJM010001` FOREIGN KEY (`person_id`) REFERENCES `prjm010001` (`person_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `prjm010018` (
  `fireexting_id` int NOT NULL AUTO_INCREMENT,
  `person_id` int NOT NULL,
  `daydate` date NOT NULL,
  `dayhour` time NOT NULL,
  `location` varchar(100) DEFAULT NULL,
  `tipe` varchar(20) DEFAULT NULL,
  `weight` varchar(10) DEFAULT NULL,
  `capacity` varchar(10) DEFAULT NULL,
  `rechargedate` date DEFAULT NULL,
  `user_id_deleted` int DEFAULT NULL,
  `dt_deleted` timestamp NULL DEFAULT NULL,
  `situation` char(1) DEFAULT '0',
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`fireexting_id`),
  KEY `FK_prjm010018_PRJM010001_idx` (`person_id`),
  CONSTRAINT `fk_prjm010018_PRJM010001` FOREIGN KEY (`person_id`) REFERENCES `prjm010001` (`person_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `prjm010019` (
  `historic_id` int NOT NULL AUTO_INCREMENT,
  `fireexting_id` int NOT NULL,
  `daydate` date NOT NULL,
  `htrigger` char(1) DEFAULT NULL,
  `hose` char(1) DEFAULT NULL,
  `diffuser` char(1) DEFAULT NULL,
  `painting` char(1) DEFAULT NULL,
  `hydrostatic` char(1) DEFAULT NULL,
  `hothers` varchar(100) DEFAULT NULL,
  `user_id_deleted` int DEFAULT NULL,
  `dt_deleted` timestamp NULL DEFAULT NULL,
  `situation` char(1) DEFAULT '0',
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`historic_id`),
  KEY `FK_prjm010019_PRJM010018_idx` (`fireexting_id`),
  CONSTRAINT `fk_prjm010019_PRJM010018` FOREIGN KEY (`fireexting_id`) REFERENCES `prjm010018` (`fireexting_id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `prjm010020` (
  `purifier_id` int NOT NULL AUTO_INCREMENT,
  `person_id` int NOT NULL,
  `daydate` date NOT NULL,
  `serialnumber` varchar(50) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `nextmanager` date DEFAULT NULL,
  `user_id_deleted` int DEFAULT NULL,
  `dt_deleted` timestamp NULL DEFAULT NULL,
  `situation` char(1) DEFAULT '0',
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`purifier_id`),
  KEY `FK_prjm010020_PRJM010001_idx` (`person_id`),
  CONSTRAINT `fk_prjm010020_PRJM010001` FOREIGN KEY (`person_id`) REFERENCES `prjm010001` (`person_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `prjm010021` (
  `historic_id` int NOT NULL AUTO_INCREMENT,
  `purifier_id` int NOT NULL,
  `serialnumber` varchar(50) NOT NULL,
  `daydate` date NOT NULL,
  `user_id_deleted` int DEFAULT NULL,
  `dt_deleted` timestamp NULL DEFAULT NULL,
  `situation` char(1) DEFAULT '0',
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`historic_id`),
  KEY `FK_prjm010021_PRJM010020_idx` (`purifier_id`),
  CONSTRAINT `fk_prjm010021_PRJM010020` FOREIGN KEY (`purifier_id`) REFERENCES `prjm010020` (`purifier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `prjm010022` (
  `clothing_id` int NOT NULL AUTO_INCREMENT,
  `person_id` int NOT NULL,
  `dateout` date NOT NULL,
  `qtdeout` int DEFAULT '0',
  `signout` varchar(100) DEFAULT NULL,
  `datein` date DEFAULT NULL,
  `qtdein` int DEFAULT '0',
  `signin` varchar(100) DEFAULT NULL,
  `user_id_deleted` int DEFAULT NULL,
  `dt_deleted` timestamp NULL DEFAULT NULL,
  `situation` char(1) DEFAULT '0',
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`clothing_id`),
  KEY `FK_prjm010022_PRJM010001_idx` (`person_id`),
  CONSTRAINT `fk_prjm010022_PRJM010001` FOREIGN KEY (`person_id`) REFERENCES `prjm010001` (`person_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `prjm010023` (
  `material_id` int NOT NULL AUTO_INCREMENT,
  `person_id` int NOT NULL,
  `daydate` date NOT NULL,
  `dayhour` time NOT NULL,
  `material` varchar(100) DEFAULT NULL,
  `qtde` decimal(10,2) DEFAULT NULL,
  `receiver` varchar(100) DEFAULT NULL,
  `deliveryman` varchar(100) DEFAULT NULL,
  `user_id_deleted` int DEFAULT NULL,
  `dt_deleted` timestamp NULL DEFAULT NULL,
  `situation` char(1) DEFAULT '0',
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`material_id`),
  KEY `FK_prjm010023_PRJM010001_idx` (`person_id`),
  CONSTRAINT `fk_prjm010023_PRJM010001` FOREIGN KEY (`person_id`) REFERENCES `prjm010001` (`person_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `prjm010024` (
  `hydrant_id` int NOT NULL AUTO_INCREMENT,
  `person_id` int NOT NULL,
  `location` varchar(100) DEFAULT NULL,
  `tipe` varchar(20) DEFAULT NULL,
  `idnumber` varchar(20) DEFAULT NULL,
  `observation` varchar(255) DEFAULT NULL,
  `user_id_deleted` int DEFAULT NULL,
  `dt_deleted` timestamp NULL DEFAULT NULL,
  `situation` char(1) DEFAULT '0',
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`hydrant_id`),
  KEY `FK_prjm010024_PRJM010001_idx` (`person_id`),
  CONSTRAINT `fk_prjm010024_PRJM010001` FOREIGN KEY (`person_id`) REFERENCES `prjm010001` (`person_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `prjm010025` (
  `historic_id` int NOT NULL AUTO_INCREMENT,
  `hydrant_id` int NOT NULL,
  `daydate` date NOT NULL,
  `idkey` char(1) DEFAULT NULL,
  `hose` char(1) DEFAULT NULL,
  `squirt` char(1) DEFAULT NULL,
  `painting` char(1) DEFAULT NULL,
  `alarmcentral` char(1) DEFAULT NULL,
  `glass` char(1) DEFAULT NULL,
  `inlock` char(1) DEFAULT NULL,
  `record` char(1) DEFAULT NULL,
  `signaling` char(1) DEFAULT NULL,
  `obstruction` char(1) DEFAULT NULL,
  `observation` varchar(255) DEFAULT NULL,
  `user_id_deleted` int DEFAULT NULL,
  `dt_deleted` timestamp NULL DEFAULT NULL,
  `situation` char(1) DEFAULT '0',
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`historic_id`),
  KEY `FK_prjm010025_PRJM010024_idx` (`hydrant_id`),
  CONSTRAINT `fk_prjm010025_PRJM010024` FOREIGN KEY (`hydrant_id`) REFERENCES `prjm010024` (`hydrant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `prjm010026` (
  `airconditioning_id` int NOT NULL AUTO_INCREMENT,
  `person_id` int NOT NULL,
  `location` varchar(100) DEFAULT NULL,
  `user_id_deleted` int DEFAULT NULL,
  `dt_deleted` timestamp NULL DEFAULT NULL,
  `situation` char(1) DEFAULT '0',
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`airconditioning_id`),
  KEY `FK_prjm010026_PRJM010001_idx` (`person_id`),
  CONSTRAINT `fk_prjm010026_PRJM010001` FOREIGN KEY (`person_id`) REFERENCES `prjm010001` (`person_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `prjm010027` (
  `historic_id` int NOT NULL AUTO_INCREMENT,
  `airconditioning_id` int NOT NULL,
  `inmonth` varchar(15) DEFAULT NULL,
  `daydate` date DEFAULT NULL,
  `dt_deleted` timestamp NULL DEFAULT NULL,
  `user_id_deleted` int DEFAULT NULL,
  `situation` char(1) DEFAULT '0',
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`historic_id`),
  KEY `FK_prjm010027_PRJM010026_idx` (`airconditioning_id`),
  CONSTRAINT `fk_prjm010027_PRJM010026` FOREIGN KEY (`airconditioning_id`) REFERENCES `prjm010026` (`airconditioning_id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `prjm010028` (
  `equipament_id` int NOT NULL AUTO_INCREMENT,
  `desequipament` varchar(64) NOT NULL,
  `user_id_deleted` int DEFAULT NULL,
  `dt_deleted` timestamp NULL DEFAULT NULL,
  `situation` char(1) DEFAULT '0',
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`equipament_id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `prjm010029` (
  `location_id` int NOT NULL AUTO_INCREMENT,
  `deslocation` varchar(100) DEFAULT NULL,
  `user_id_deleted` int DEFAULT NULL,
  `dt_deleted` timestamp NULL DEFAULT NULL,
  `situation` char(1) DEFAULT '0',
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`location_id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `prjm010030` (
  `anualplan_id` int NOT NULL AUTO_INCREMENT,
  `yyear` int DEFAULT NULL,
  `equipament_id` int NOT NULL,
  `person_id` int NOT NULL,
  `location_id` int NOT NULL,
  `frequency` varchar(50) DEFAULT NULL,
  `amonth` varchar(20) DEFAULT NULL,
  `rstatus` int DEFAULT NULL,
  `dtprevision` date DEFAULT NULL,
  `user_id_deleted` int DEFAULT NULL,
  `dt_deleted` timestamp NULL DEFAULT NULL,
  `situation` char(1) DEFAULT '0',
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`anualplan_id`),
  KEY `FK_prjm010030_PRJM010001_idx` (`person_id`),
  KEY `FK_prjm010030_PRJM010028_idx` (`equipament_id`),
  KEY `FK_prjm010030_PRJM010029_idx` (`location_id`),
  CONSTRAINT `fk_prjm010030_PRJM010001` FOREIGN KEY (`person_id`) REFERENCES `prjm010001` (`person_id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_prjm010030_PRJM010028` FOREIGN KEY (`equipament_id`) REFERENCES `prjm010028` (`equipament_id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_prjm010030_PRJM010029` FOREIGN KEY (`location_id`) REFERENCES `prjm010029` (`location_id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb3;
