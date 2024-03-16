/*
SQL TUTORIAL #1 
In this tutorial, we learn how to create a database, add a table, and add records.  
- DDL Used: CREATE, DROP, ALTER 
- DML Used: INSERT 

PART A: CREATE DATABASE FROM SCRATCH, ADD TABLE, ADD ROWS/RECORDS 
*/
-- create database called vehicles 
CREATE DATABASE db_vehicles;
USE db_vehicles;

/*
 create empty table called new_cars with column headings model name, 
 manufacturing date and quantity 
 */
CREATE TABLE new_cars(
	model_name VARCHAR(10),
    manufacturing_date DATE,
    quantity INT
);

-- view the newly created empty table
SELECT * FROM new_cars;

-- insert a record into the table 
INSERT INTO new_cars
VALUES 
	("mercedes", "2023-11-20", 1);
    
-- view the table with the newly inserted record
SELECT * FROM new_cars;

-- insert additional three records into the table
INSERT INTO new_cars
VALUES 
	("porsche", "2022-10-21", 11),
    ("bmw", "2022-08-18", 10),
    ("toyota", "2022-12-21", 9);

-- view the table with the newly inserted record
SELECT * FROM new_cars;


/*Add an extra record to the table, however with a missing record.
Leave the quantity column empty */
INSERT INTO new_cars (model_name, manufacturing_date)
VALUES 
	("chevrolet", "2024-01-01");

SELECT * FROM new_cars;

ALTER TABLE new_cars 
RENAME COLUMN quantity to quantity_sold;

SELECT * FROM new_cars;

ALTER TABLE new_cars
DROP COLUMN quantity_sold;

SELECT * FROM new_cars;

/*
PART B: CREATE DATABASE, ADD TABLE, IMPORT DATA 
*/
CREATE DATABASE db_auto_mpg;
USE db_auto_mpg;

CREATE TABLE vehicle_specs(
	mpg INT,
    cylinders INT,
    displacement INT,
    horsepower INT,
    weight INT,
    acceleration VARCHAR(7),
    model_year INT,
    origin INT,
    model_name VARCHAR(20)
);

SELECT * FROM vehicle_specs;



