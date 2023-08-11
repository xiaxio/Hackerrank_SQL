-- On this module, I share the commands to create the Hackerrank databases used on their website
-- These commands work with Microsoft SQL Server Management Studio (SSMS) v19.1

/*
Code for Microsoft SQL Server Management Studio (SMSS)
Query to create a database similar to the ones used in Hackerrank
Link: https://www.hackerrank.com/challenges/revising-the-select-query/problem?isFullScreen=true
CREATED BY: Aroom Gonzalez
July 2023
*/

/*********************************************************************************************************************************************************/
/* Database creation and initial system configuration */

CREATE DATABASE HackerRank
GO

USE HackerRank
GO

SET NOCOUNT ON
GO

SET ANSI_NULLS ON
GO

set quoted_identifier on
GO

/* Set DATEFORMAT so that the date strings are interpreted correctly regardless of
   the default DATEFORMAT on the server.
*/
SET DATEFORMAT mdy
GO


/*********************************************************************************************************************************************************/
/* Tables creation commands. Create CITY Table

We need these relations (tables):
   * CITY (ID, NAME, COUNTRYCODE, DISTRICT, POPULATION)	

sysstat flags:
   sysstat & 0xf = 2 refers to Views
   sysstat & 0xf = 3 refers to Tables
   sysstat & 0xf = 4 refers to Procedures
*/

if exists (select * from sysobjects where id = object_id('dbo.CITY') and sysstat & 0xf = 3)
	drop table "dbo"."CITY"
GO

CREATE TABLE CITY (
	"ID" INT NOT NULL UNIQUE,
	"NAME" varchar(17) NOT NULL,
	"COUNTRYCODE" varchar(3) NOT NULL,
	"DISTRICT" varchar(20) NOT NULL,
	"POPULATION" INT NOT NULL
)
GO

/*********************************************************************************************************************************************************/
/* Fill in the data for CITY table */
ALTER TABLE "CITY" NOCHECK CONSTRAINT ALL
GO

INSERT "CITY"("ID","NAME","COUNTRYCODE","DISTRICT","POPULATION") VALUES (6, 'Rotterdam', 'NLD', 'Zuid-Holland', 593321)
INSERT "CITY"("ID","NAME","COUNTRYCODE","DISTRICT","POPULATION") VALUES (3878, 'Scottsdale', 'USA', 'Arizona', 202705)
INSERT "CITY"("ID","NAME","COUNTRYCODE","DISTRICT","POPULATION") VALUES (3965, 'Corona', 'USA', 'California', 124966)
INSERT "CITY"("ID","NAME","COUNTRYCODE","DISTRICT","POPULATION") VALUES (3973, 'Concord', 'USA', 'California', 121780)
INSERT "CITY"("ID","NAME","COUNTRYCODE","DISTRICT","POPULATION") VALUES (3977, 'Cedar Rapids', 'USA', 'Iowa', 120758)
INSERT "CITY"("ID","NAME","COUNTRYCODE","DISTRICT","POPULATION") VALUES (3982, 'Coral Springs', 'USA', 'Florida', 117549)
INSERT "CITY"("ID","NAME","COUNTRYCODE","DISTRICT","POPULATION") VALUES (4054, 'Fairfield', 'USA', 'California', 92256)
INSERT "CITY"("ID","NAME","COUNTRYCODE","DISTRICT","POPULATION") VALUES (4058, 'Boulder', 'USA', 'Colorado', 91238)
INSERT "CITY"("ID","NAME","COUNTRYCODE","DISTRICT","POPULATION") VALUES (4061, 'Fall River', 'USA', 'Massachusetts', 90555)
INSERT "CITY"("ID","NAME","COUNTRYCODE","DISTRICT","POPULATION") VALUES (1613, 'Neyagawa', 'JPN', 'Osaka', 257315)
INSERT "CITY"("ID","NAME","COUNTRYCODE","DISTRICT","POPULATION") VALUES (1661, 'Sayama', 'JPN', 'Saitama', 162472)
INSERT "CITY"("ID","NAME","COUNTRYCODE","DISTRICT","POPULATION") VALUES (1630, 'Ageo', 'JPN', 'Saitama', 209442)
INSERT "CITY"("ID","NAME","COUNTRYCODE","DISTRICT","POPULATION") VALUES (1681, 'Omuta', 'JPN', 'Fukuoka', 142889)
INSERT "CITY"("ID","NAME","COUNTRYCODE","DISTRICT","POPULATION") VALUES (1739, 'Tokuyama', 'JPN', 'Yamaguchi', 107078)

GO

ALTER TABLE "CITY" CHECK CONSTRAINT ALL
GO


/*********************************************************************************************************************************************************/
/* Tables creation commands. Create STATION table
We need these relations (tables):
 * STATION (ID, CITY, STATE, LAT_N, LONG_W)	
 * MUST INCLUDE CVS FILE: STATION.CSV

sysstat flags:
   sysstat & 0xf = 2 refers to Views
   sysstat & 0xf = 3 refers to Tables
   sysstat & 0xf = 4 refers to Procedures
*/

if exists (select * from sysobjects where id = object_id('dbo.STATION') and sysstat & 0xf = 3)
	drop table "dbo"."STATION"
GO

CREATE TABLE STATION (
	"ID" INT NOT NULL UNIQUE,
	"CITY" varchar(21) NOT NULL,
	"STATE" varchar(2) NOT NULL,
	"LAT_N" INT NOT NULL,
	"LONG_W" INT NOT NULL
)
GO

/*********************************************************************************************************************************************************/
/* LOAD DATA FROM CSV FILE */
BULK INSERT STATION
FROM 'C:\Users\aroom\Documents\SQL Server Management Studio\STATION.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
)



/* Tables creation commands
We need these relations (tables):
 * OCUPATION (NAME, OCCUPATION)	
 * MUST INCLUDE CSV FILE: OCCUPATION.CSV

sysstat flags:
   sysstat & 0xf = 2 refers to Views
   sysstat & 0xf = 3 refers to Tables
   sysstat & 0xf = 4 refers to Procedures
*/

if exists (select * from sysobjects where id = object_id('dbo.OCCUPATION') and sysstat & 0xf = 3)
	drop table "dbo"."OCCUPATIONS"
GO

CREATE TABLE OCCUPATIONS (
	"NAME" varchar(20) NOT NULL,
	"OCCUPATION" varchar(20) NOT NULL,
)
GO

/* LOAD DATA FROM CSV FILE */
BULK INSERT OCCUPATIONS
FROM 'C:\Users\aroom\Documents\SQL Server Management Studio\Occupation.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
)
