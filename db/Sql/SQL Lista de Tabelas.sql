CREATE TABLE `prjm010001` (
  `person_id` int NOT NULL AUTO_INCREMENT,
  `dt_save` date DEFAULT NULL,
  `situation` varchar(10) DEFAULT NULL,
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb3;

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
  `user_id` int NOT NULL,
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
  KEY `FK_PRJM010014_PRJM010013_idx` (`user_id`),
  CONSTRAINT `fk_PRJM010014_PRJM010001` FOREIGN KEY (`person_id`) REFERENCES `prjm010001` (`person_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_PRJM010014_PRJM010013` FOREIGN KEY (`user_id`) REFERENCES `prjm010013` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb3;
CREATE TABLE `prjm010015` (
  `residual_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
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
  KEY `FK_prjm010015_PRJM010013_idx` (`user_id`),
  CONSTRAINT `fk_prjm010015_PRJM010001` FOREIGN KEY (`person_id`) REFERENCES `prjm010001` (`person_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_prjm010015_PRJM010013` FOREIGN KEY (`user_id`) REFERENCES `prjm010013` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb3;
CREATE TABLE `prjm010016` (
  `material_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `person_id` int NOT NULL,
  `daydate` date NOT NULL,
  `dayhour` time NOT NULL,
  `material` varchar(100) DEFAULT NULL,
  `qtde` decimal(10,2) DEFAULT NULL,
  `packing` char(1) DEFAULT NULL,
  `receiver` varchar(100) DEFAULT NULL,
  `deliveryman` varchar(100) DEFAULT NULL,
  `user_id_deleted` int DEFAULT NULL,
  `dt_deleted` timestamp NULL DEFAULT NULL,
  `situation` char(1) DEFAULT '0',
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`material_id`),
  KEY `FK_prjm010016_PRJM010001_idx` (`person_id`),
  KEY `FK_prjm010016_PRJM010013_idx` (`user_id`),
  CONSTRAINT `fk_prjm010016_PRJM010001` FOREIGN KEY (`person_id`) REFERENCES `prjm010001` (`person_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_prjm010016_PRJM010013` FOREIGN KEY (`user_id`) REFERENCES `prjm010013` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `prjm010017` (
  `nobreak_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `person_id` int NOT NULL,
  `daydate` date NOT NULL,
  `dayhour` time NOT NULL,
  `name_person` varchar(100) DEFAULT NULL,
  `location` varchar(100),
  `nobreakmodel` varchar(100),
  `resulttest` char(1),
  `observation` varchar(100),
  `serialnumber` varchar(50),
  `user_id_deleted` int DEFAULT NULL,
  `dt_deleted` timestamp NULL DEFAULT NULL,
  `situation` char(1) DEFAULT '0',
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`nobreak_id`),
  KEY `FK_prjm010017_PRJM010001_idx` (`person_id`),
  KEY `FK_prjm010017_PRJM010013_idx` (`user_id`),
  CONSTRAINT `fk_prjm010017_PRJM010001` FOREIGN KEY (`person_id`) REFERENCES `prjm010001` (`person_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_prjm010017_PRJM010013` FOREIGN KEY (`user_id`) REFERENCES `prjm010013` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `prjm010018` (
  `fireexting_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `person_id` int NOT NULL,
  `daydate` date NOT NULL,
  `dayhour` time NOT NULL,
  `location` varchar(100) DEFAULT NULL,
  `tipe` varchar(20) DEFAULT NULL,
  `weight` varchar(10) DEFAULT NULL,
  `capacity` char(1) DEFAULT NULL,
  `rechargedate` date DEFAULT NULL,
  `user_id_deleted` int DEFAULT NULL,
  `dt_deleted` timestamp NULL DEFAULT NULL,
  `situation` char(1) DEFAULT '0',
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`fireexting_id`),
  KEY `FK_prjm010018_PRJM010001_idx` (`person_id`),
  KEY `FK_prjm010018_PRJM010013_idx` (`user_id`),
  CONSTRAINT `fk_prjm010018_PRJM010001` FOREIGN KEY (`person_id`) REFERENCES `prjm010001` (`person_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_prjm010018_PRJM010013` FOREIGN KEY (`user_id`) REFERENCES `prjm010013` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb3;
CREATE TABLE `prjm010019` (
  `historic_id` int NOT NULL AUTO_INCREMENT,
  `fireexting_id` int NOT NULL,
  `user_id` int NOT NULL,
  `daydate` date NOT NULL,
  `trigger` char(1) DEFAULT NULL,
  `hose` char(1) DEFAULT NULL,
  `diffuser` char(1) DEFAULT NULL,
  `painting` char(1) DEFAULT NULL,
  `hydrostatic` char(1) DEFAULT NULL,
  `others` varchar(100) DEFAULT NULL,
  `user_id_deleted` int DEFAULT NULL,
  `dt_deleted` timestamp NULL DEFAULT NULL,
  `situation` char(1) DEFAULT '0',
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`historic_id`),
  KEY `FK_prjm010019_PRJM010018_idx` (`fireexting_id`),
  CONSTRAINT `fk_prjm010019_PRJM010018` FOREIGN KEY (`fireexting_id`) REFERENCES `prjm010018` (`fireexting_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `prjm010020` (
  `purifier_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `person_id` int NOT NULL,
  `daydate` date NOT NULL,
  `location` varchar(100) DEFAULT NULL,
  `nextmanager` date DEFAULT NULL,
  `user_id_deleted` int DEFAULT NULL,
  `dt_deleted` timestamp NULL DEFAULT NULL,
  `situation` char(1) DEFAULT '0',
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`purifier_id`),
  KEY `FK_prjm010020_PRJM010001_idx` (`person_id`),
  KEY `FK_prjm010020_PRJM010013_idx` (`user_id`),
  CONSTRAINT `fk_prjm010020_PRJM010001` FOREIGN KEY (`person_id`) REFERENCES `prjm010001` (`person_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_prjm010020_PRJM010013` FOREIGN KEY (`user_id`) REFERENCES `prjm010013` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb3;


