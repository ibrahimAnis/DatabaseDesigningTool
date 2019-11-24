-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** `subscription_plan`

CREATE TABLE `subscription_plan`
(
 `code`           integer NOT NULL AUTO_INCREMENT ,
 `effective_from` date NOT NULL ,
 `monthly_rate`   integer NOT NULL ,
 `yearly_rate`    integer NOT NULL ,
 `free_projects`  integer NOT NULL ,
 `free_tables`    integer NOT NULL ,
PRIMARY KEY (`code`)
) AUTO_INCREMENT=0 ENGINE=INNODB;






-- ************************************** `member`

CREATE TABLE `member`
(
 `code`               integer NOT NULL AUTO_INCREMENT ,
 `email_id`           char(100) NOT NULL Unique ,
 `password`           char(100) NOT NULL ,
 `password_key`       char(100) NOT NULL ,
 `first_name`         char(25) NOT NULL ,
 `last_name`          char(25) NOT NULL ,
 `mobile_number`      char(15) NOT NULL Unique ,
 `status`             char(1) NOT NULL ,
 `number_of_projects` integer NOT NULL ,
PRIMARY KEY (`code`)
) AUTO_INCREMENT=0 ENGINE=INNODB;






-- ************************************** `database_architecture`

CREATE TABLE `database_architecture`
(
 `code`                           integer NOT NULL AUTO_INCREMENT ,
 `name`                           char(100) NOT NULL Unique ,
 `max_width_of_column_name`       integer NOT NULL ,
 `max_width_of_table_name`        integer NOT NULL ,
 `max_width_of_relationship_name` integer NOT NULL ,
PRIMARY KEY (`code`)
) AUTO_INCREMENT=0 ENGINE=INNODB;






-- ************************************** `administrator`

CREATE TABLE `administrator`
(
 `username`      char(15) NOT NULL ,
 `password`      char(100) NOT NULL ,
 `password_key`  char(100) NOT NULL ,
 `email_id`      char(100) NOT NULL ,
 `first_name`    char(25) NOT NULL ,
 `last_name`     char(25) NOT NULL ,
 `mobile_number` char(15) NOT NULL ,
PRIMARY KEY (`username`)
) ENGINE=INNODB;






-- ************************************** `project`

CREATE TABLE `project`
(
 `code`                       integer NOT NULL AUTO_INCREMENT ,
 `title`                      char(100) NOT NULL ,
 `date_of_creation`           date NOT NULL ,
 `time_of_creation`           time NOT NULL ,
 `number_of_tables`           integer NOT NULL ,
 `database_architecture_code` integer NOT NULL ,
 `member_code`                integer NOT NULL ,
PRIMARY KEY (`code`),
KEY `fkIdx_124` (`database_architecture_code`),
CONSTRAINT `FK_124` FOREIGN KEY `fkIdx_124` (`database_architecture_code`) REFERENCES `database_architecture` (`code`),
KEY `fkIdx_127` (`member_code`),
CONSTRAINT `FK_127` FOREIGN KEY `fkIdx_127` (`member_code`) REFERENCES `member` (`code`)
) AUTO_INCREMENT=0 ENGINE=INNODB;






-- ************************************** `member_verification_token`

CREATE TABLE `member_verification_token`
(
 `member_code` integer NOT NULL ,
 `token`       char(100) NOT NULL ,
PRIMARY KEY (`member_code`),
KEY `fkIdx_104` (`member_code`),
CONSTRAINT `FK_104` FOREIGN KEY `fkIdx_104` (`member_code`) REFERENCES `member` (`code`)
) ENGINE=INNODB;






-- ************************************** `member_subscription`

CREATE TABLE `member_subscription`
(
 `invoice_number` integer NOT NULL AUTO_INCREMENT ,
 `invoice_date`   date NOT NULL ,
 `plan_type`      char(1) NOT NULL ,
 `quantity`       integer NOT NULL ,
 `rate`           integer NOT NULL ,
 `effective_from` date NOT NULL ,
 `effective_upto` date NOT NULL ,
 `member_code`    integer NOT NULL ,
 `code`           integer NOT NULL ,
PRIMARY KEY (`invoice_number`),
KEY `fkIdx_191` (`code`),
CONSTRAINT `FK_191` FOREIGN KEY `fkIdx_191` (`code`) REFERENCES `subscription_plan` (`code`),
KEY `fkIdx_96` (`member_code`),
CONSTRAINT `FK_96` FOREIGN KEY `fkIdx_96` (`member_code`) REFERENCES `member` (`code`)
) AUTO_INCREMENT=0 ENGINE=INNODB;






-- ************************************** `member_address`

CREATE TABLE `member_address`
(
 `code`           integer NOT NULL AUTO_INCREMENT ,
 `address`        varchar(800) NOT NULL ,
 `effective_from` date NOT NULL ,
 `member_code`    integer NOT NULL ,
PRIMARY KEY (`code`),
KEY `fkIdx_93` (`member_code`),
CONSTRAINT `FK_93` FOREIGN KEY `fkIdx_93` (`member_code`) REFERENCES `member` (`code`)
) AUTO_INCREMENT=0 ENGINE=INNODB;






-- ************************************** `database_engine`

CREATE TABLE `database_engine`
(
 `code`                       integer NOT NULL AUTO_INCREMENT ,
 `name`                       char(25) NOT NULL ,
 `database_architecture_code` integer NOT NULL ,
PRIMARY KEY (`code`),
KEY `fkIdx_114` (`database_architecture_code`),
CONSTRAINT `FK_114` FOREIGN KEY `fkIdx_114` (`database_architecture_code`) REFERENCES `database_architecture` (`code`)
) AUTO_INCREMENT=0 ENGINE=INNODB;






-- ************************************** `database_architecture_data_type`

CREATE TABLE `database_architecture_data_type`
(
 `code`                       integer NOT NULL AUTO_INCREMENT ,
 `data_type`                  char(25) NOT NULL ,
 `max_width`                  integer NOT NULL ,
 `max_width_of_precision`     integer NOT NULL ,
 `default_size`               integer NOT NULL ,
 `allow_auto_increment`       bool NOT NULL ,
 `database_architecture_code` integer NOT NULL ,
PRIMARY KEY (`code`),
KEY `fkIdx_107` (`database_architecture_code`),
CONSTRAINT `FK_107` FOREIGN KEY `fkIdx_107` (`database_architecture_code`) REFERENCES `database_architecture` (`code`)
) AUTO_INCREMENT=0 ENGINE=INNODB;






-- ************************************** `database_table`

CREATE TABLE `database_table`
(
 `code`                 integer NOT NULL AUTO_INCREMENT ,
 `name`                 varchar(300) NOT NULL ,
 `note`                 varchar(300) NOT NULL ,
 `number_of_fields`     integer NOT NULL ,
 `database_engine_code` integer NOT NULL ,
 `project_code`         integer NOT NULL ,
PRIMARY KEY (`code`),
KEY `fkIdx_136` (`database_engine_code`),
CONSTRAINT `FK_136` FOREIGN KEY `fkIdx_136` (`database_engine_code`) REFERENCES `database_engine` (`code`),
KEY `fkIdx_139` (`project_code`),
CONSTRAINT `FK_139` FOREIGN KEY `fkIdx_139` (`project_code`) REFERENCES `project` (`code`)
) AUTO_INCREMENT=0 ENGINE=INNODB;






-- ************************************** `database_table_relationship`

CREATE TABLE `database_table_relationship`
(
 `code`                       integer NOT NULL AUTO_INCREMENT ,
 `name`                       varchar(300) NOT NULL ,
 `parent_database_table_code` integer NOT NULL ,
 `child_database_table_code`  integer NOT NULL ,
PRIMARY KEY (`code`),
KEY `fkIdx_167` (`parent_database_table_code`),
CONSTRAINT `FK_167` FOREIGN KEY `fkIdx_167` (`parent_database_table_code`) REFERENCES `database_table` (`code`),
KEY `fkIdx_170` (`child_database_table_code`),
CONSTRAINT `FK_170` FOREIGN KEY `fkIdx_170` (`child_database_table_code`) REFERENCES `database_table` (`code`)
) AUTO_INCREMENT=0 ENGINE=INNODB;






-- ************************************** `database_table_field`

CREATE TABLE `database_table_field`
(
 `code`                                 integer NOT NULL AUTO_INCREMENT ,
 `name`                                 varchar(300) NOT NULL ,
 `width`                                integer NOT NULL ,
 `number_of_decimal_places`             integer NOT NULL ,
 `is_primary_key`                       bool NOT NULL ,
 `is_auto_increment`                    bool NOT NULL ,
 `is_unique`                            bool NOT NULL ,
 `is_not_null`                          bool NOT NULL ,
 `default_value`                        varchar(800) NOT NULL ,
 `check_constraint`                     varchar(100) NOT NULL ,
 `note`                                 varchar(300) NOT NULL ,
 `table_code`                           integer NOT NULL ,
 `database_architecture_data_type_code` integer NOT NULL ,
PRIMARY KEY (`code`),
KEY `fkIdx_155` (`table_code`),
CONSTRAINT `FK_155` FOREIGN KEY `fkIdx_155` (`table_code`) REFERENCES `database_table` (`code`),
KEY `fkIdx_158` (`database_architecture_data_type_code`),
CONSTRAINT `FK_158` FOREIGN KEY `fkIdx_158` (`database_architecture_data_type_code`) REFERENCES `database_architecture` (`code`)
) AUTO_INCREMENT=0 ENGINE=INNODB;






-- ************************************** `database_table_relationship_key`

CREATE TABLE `database_table_relationship_key`
(
 `code`                             integer NOT NULL AUTO_INCREMENT ,
 `database_table_relationship_code` integer NOT NULL ,
 `parent_database_table_field_code` integer NOT NULL ,
 `child_database_table_field_code`  integer NOT NULL ,
PRIMARY KEY (`code`),
KEY `fkIdx_176` (`database_table_relationship_code`),
CONSTRAINT `FK_176` FOREIGN KEY `fkIdx_176` (`database_table_relationship_code`) REFERENCES `database_table_relationship` (`code`),
KEY `fkIdx_179` (`parent_database_table_field_code`),
CONSTRAINT `FK_179` FOREIGN KEY `fkIdx_179` (`parent_database_table_field_code`) REFERENCES `database_table_field` (`code`),
KEY `fkIdx_188` (`child_database_table_field_code`),
CONSTRAINT `FK_188` FOREIGN KEY `fkIdx_188` (`child_database_table_field_code`) REFERENCES `database_table_field` (`code`)
) AUTO_INCREMENT=0 ENGINE=INNODB;





