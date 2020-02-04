/*
Created		11/29/2018
Modified		12/11/2018
Project		
Model		
Company		
Author		
Version		
Database		mySQL 5 
*/

















drop table IF EXISTS database_table_relationship_key;
drop table IF EXISTS database_engine;
drop table IF EXISTS member_address;
drop table IF EXISTS database_architecture_data_type;
drop table IF EXISTS database_architecture;
drop table IF EXISTS database_table_relationship;
drop table IF EXISTS database_table_field;
drop table IF EXISTS database_table;
drop table IF EXISTS project;
drop table IF EXISTS member_vertification_token;
drop table IF EXISTS member_subscription;
drop table IF EXISTS subscription_plan;
drop table IF EXISTS member;
drop table IF EXISTS administrator;




Create table administrator (
	username Char(15) NOT NULL,
	password Char(100) NOT NULL,
	password_key Char(100) NOT NULL,
	email_id Char(100) NOT NULL,
	first_name Char(25) NOT NULL,
	last_name Char(25) NOT NULL,
	mobile_number Char(15) NOT NULL,
 Primary Key (username)) ENGINE = InnoDB;

Create table member (
	code Int NOT NULL AUTO_INCREMENT,
	email_id Char(100) NOT NULL,
	password Char(100) NOT NULL,
	password_key Char(100) NOT NULL,
	first_name Char(25) NOT NULL,
	last_name Char(25) NOT NULL,
	mobile_number Char(15) NOT NULL,
	status Char(1) NOT NULL,
	number_of_projects Int NOT NULL,
	UNIQUE (email_id),
	UNIQUE (mobile_number),
 Primary Key (code)) ENGINE = InnoDB;

Create table subscription_plan (
	code Int NOT NULL AUTO_INCREMENT,
	effective_from Date NOT NULL,
	monthly_rate Int NOT NULL,
	yearly_rate Int NOT NULL,
	free_projects Int NOT NULL,
	free_tables Int NOT NULL,
 Primary Key (code)) ENGINE = InnoDB;

Create table member_subscription (
	invoice_number Int NOT NULL AUTO_INCREMENT,
	invoice_date Date NOT NULL,
	member_code Int NOT NULL,
	subscription_plan_code Int NOT NULL,
	plan_type Char(1) NOT NULL,
	quantity Int NOT NULL,
	rate Int NOT NULL,
	effective_from Date NOT NULL,
	effective_upto Date NOT NULL,
 Primary Key (invoice_number)) ENGINE = InnoDB;

Create table member_vertification_token (
	member_code Int NOT NULL,
	token Char(100) NOT NULL,
 Primary Key (member_code)) ENGINE = InnoDB;

Create table project (
	code Int NOT NULL AUTO_INCREMENT,
	title Char(100) NOT NULL,
	member_code Int NOT NULL,
	database_architecture_code Int NOT NULL,
	date_of_creation Date NOT NULL,
	time_of_creation Time NOT NULL,
	number_of_table Int NOT NULL,
 Primary Key (code)) ENGINE = InnoDB;

Create table database_table (
	code Int NOT NULL AUTO_INCREMENT,
	project_code Int NOT NULL,
	name Varchar(300) NOT NULL,
	database_engine_code Int,
	note Varchar(300),
	number_of_fields Int,
	abscissa Int,
	ordinate Int,
 Primary Key (code)) ENGINE = InnoDB;

Create table database_table_field (
	code Int NOT NULL AUTO_INCREMENT,
	table_code Int NOT NULL,
	name Varchar(300) NOT NULL,
	database_architecture_data_type_code Int NOT NULL,
	width Int NOT NULL,
	number_of_decimal_places Int NOT NULL,
	is_primary_key Bool NOT NULL,
	is_auto_increment Bool NOT NULL,
	is_unique Bool NOT NULL,
	is_not_null Bool NOT NULL,
	default_value Varchar(800) NOT NULL,
	check_constraint Varchar(100) NOT NULL,
	note Varchar(300) NOT NULL,
 Primary Key (code)) ENGINE = InnoDB;

Create table database_table_relationship (
	code Int NOT NULL AUTO_INCREMENT,
	name Varchar(300) NOT NULL,
	parent_database_table_code Int NOT NULL,
	child_database_table_code Int NOT NULL,
 Primary Key (code)) ENGINE = InnoDB;

Create table database_architecture (
	code Int NOT NULL AUTO_INCREMENT,
	name Char(100) NOT NULL,
	max_width_of_column_name Int,
	max_width_of_table_name Int,
	max_width_of_relationship_name Int,
	UNIQUE (name),
 Primary Key (code)) ENGINE = InnoDB;

Create table database_architecture_data_type (
	code Int NOT NULL AUTO_INCREMENT,
	database_architecture_code Int NOT NULL,
	data_type Char(25) NOT NULL,
	max_width Int NOT NULL,
	default_size Int,
	max_width_of_precision Int NOT NULL,
	allow_auto_increment Bool NOT NULL,
 Primary Key (code)) ENGINE = InnoDB;

Create table member_address (
	code Int NOT NULL AUTO_INCREMENT,
	member_code Int NOT NULL,
	address Varchar(800) NOT NULL,
	effective_from Date NOT NULL,
 Primary Key (code)) ENGINE = InnoDB;

Create table database_engine (
	code Int NOT NULL AUTO_INCREMENT,
	database_architecture_code Int NOT NULL,
	name Char(25) NOT NULL,
 Primary Key (code)) ENGINE = InnoDB;

Create table database_table_relationship_key (
	code Int NOT NULL AUTO_INCREMENT,
	database_table_relationship_code Int NOT NULL,
	parent_database_table_field_code Int NOT NULL,
	child_database_table_field_code Int NOT NULL,
 Primary Key (code)) ENGINE = InnoDB;












Alter table member_address add Foreign Key (member_code) references member (code) on delete  restrict on update  restrict;
Alter table member_vertification_token add Foreign Key (member_code) references member (code) on delete  restrict on update  restrict;
Alter table project add Foreign Key (member_code) references member (code) on delete  restrict on update  restrict;
Alter table member_subscription add Foreign Key (member_code) references member (code) on delete  restrict on update  restrict;
Alter table member_subscription add Foreign Key (subscription_plan_code) references subscription_plan (code) on delete  restrict on update  restrict;
Alter table database_table add Foreign Key (project_code) references project (code) on delete  restrict on update  restrict;
Alter table database_table_field add Foreign Key (table_code) references database_table (code) on delete  restrict on update  restrict;
Alter table database_table_relationship add Foreign Key (parent_database_table_code) references database_table (code) on delete  restrict on update  restrict;
Alter table database_table_relationship add Foreign Key (child_database_table_code) references database_table (code) on delete  restrict on update  restrict;
Alter table database_table_relationship_key add Foreign Key (parent_database_table_field_code) references database_table_field (code) on delete  restrict on update  restrict;
Alter table database_table_relationship_key add Foreign Key (child_database_table_field_code) references database_table_field (code) on delete  restrict on update  restrict;
Alter table database_table_relationship_key add Foreign Key (database_table_relationship_code) references database_table_relationship (code) on delete  restrict on update  restrict;
Alter table database_architecture_data_type add Foreign Key (database_architecture_code) references database_architecture (code) on delete  restrict on update  restrict;
Alter table database_engine add Foreign Key (database_architecture_code) references database_architecture (code) on delete  restrict on update  restrict;
Alter table project add Foreign Key (database_architecture_code) references database_architecture (code) on delete  restrict on update  restrict;
Alter table database_table_field add Foreign Key (database_architecture_data_type_code) references database_architecture_data_type (code) on delete  restrict on update  restrict;
Alter table database_table add Foreign Key (database_engine_code) references database_engine (code) on delete  restrict on update  restrict;















/* Users permissions */






