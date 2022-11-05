CREATE DATABASE  IF NOT EXISTS `employees`;
USE `employees`;

DROP TABLE IF EXISTS `departments`;

CREATE TABLE `departments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `chief_id` int(11) DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

INSERT INTO `departments` VALUES (1,'Бухгалтерия',1,3);
INSERT INTO `departments` VALUES (2,'Отдел кадров',2,2);
INSERT INTO `departments` VALUES (3,'отдел Интеллектуального анализа данных',6,3);
INSERT INTO `departments` VALUES (4,'водители',NULL,1);

DROP TABLE IF EXISTS `employees`;

CREATE TABLE `employees` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `working_start` date DEFAULT NULL,
  `position` varchar(45) DEFAULT NULL,
  `level` varchar(10) DEFAULT NULL,
  `pay_level` decimal(5,2) DEFAULT NULL,
  `bonus` int(2) DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL,
  `permission` varchar(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

INSERT INTO `employees` VALUES (1,'Иванов И.И.','1979-01-01','2020-05-08','lead','hi',800.00,0,1,'0');
INSERT INTO `employees` VALUES (2,'Петров П.П.','1980-01-01','2021-03-02','lead','hi',800.00,NULL,2,'0');
INSERT INTO `employees` VALUES (3,'Сидоров А.А.','1980-01-01','2021-03-02','middle','med',200.00,NULL,1,'0');
INSERT INTO `employees` VALUES (4,'Васильев В.В.','1980-01-01','2021-03-02','middle','med',200.00,NULL,1,'0');
INSERT INTO `employees` VALUES (5,'Адексеев А.А.','1980-01-01','2021-03-02','middle','med',200.00,NULL,2,'0');
INSERT INTO `employees` VALUES (6,'Соколов Д.А.','1980-01-01','2021-03-02','lead','hi',900.00,NULL,3,'1');
INSERT INTO `employees` VALUES (7,'Маслова А.А.','1980-01-01','2021-03-02','middle','hi',600.00,NULL,3,'1');
INSERT INTO `employees` VALUES (8,'Степанов Д.Д.','1980-01-01','2021-03-02','middle','hi',500.00,NULL,3,'0');
INSERT INTO `employees` VALUES (9,'Волков А.С.','1960-05-12','2020-01-11','middle','med',300.00,NULL,4,'0');

DROP TABLE IF EXISTS `work_results`;

CREATE TABLE `work_results` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) DEFAULT NULL,
  `year` int(11) DEFAULT '2022',
  `Q1` varchar(1) DEFAULT 'E',
  `Q2` varchar(1) DEFAULT 'E',
  `Q3` varchar(1) DEFAULT 'E',
  `Q4` varchar(1) DEFAULT 'E',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

INSERT INTO `work_results` VALUES (1,1,2022,'E','D','A','E');
INSERT INTO `work_results` VALUES (2,2,2022,'B','B','A','C');
INSERT INTO `work_results` VALUES (3,3,2022,'A','E','E','E');
INSERT INTO `work_results` VALUES (4,4,2022,'C','E','E','E');
INSERT INTO `work_results` VALUES (5,5,2022,'E','E','E','E');
INSERT INTO `work_results` VALUES (6,6,2022,'D','E','E','E');
INSERT INTO `work_results` VALUES (7,7,2022,'E','E','E','E');
INSERT INTO `work_results` VALUES (8,8,2022,'E','E','E','E');
