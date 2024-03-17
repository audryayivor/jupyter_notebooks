/*
SQL TUTORIAL #2: AUTOMOBILES 

In this tutorial, we practise the following: 
- SELECT * FROM
- SELECT DISTINCT 
- WHERE 
- LIKE 
- GROUP BY 
- HAVING 
- ORDER BY 
*/

CREATE DATABASE db_sql_tutorial2_auto_mpg;
USE db_sql_tutorial2_auto_mpg;

CREATE TABLE specifications(
	mpg INT,
    cylinders INT,
    displacement INT,
    horsepower VARCHAR(4),
    weight INT,
    acceleration FLOAT,
    model_year INT,
    origin INT,
    model_name VARCHAR(50)
);

CREATE TABLE ratings(
	model_name VARCHAR(50),
    fake_ratings INT 
);

CREATE TABLE factory_locations(
	origin INT,
    f_locations VARCHAR(15)
);

/* ----------------- QUERIES --------------------- */
-- 1. Extract all data from the specifications of the car 
SELECT * 
FROM specifications;

-- 2. Extract only the model names, model year, and miles per gallon on all cars
SELECT 
	model_name,
    model_year,
    mpg
FROM 
	specifications;

-- 3. Extract the different kinds of cylinders in the dataset. 
SELECT DISTINCT 
	cylinders
FROM 
	specifications;

-- 4. Extract vehicles with mpg at least 40
SELECT 
	model_name,
    model_year,
    mpg
FROM specifications 
WHERE mpg >= 40;


-- 5. Extract vehicles with displacement > 450 and at least 5 cylinders 
SELECT
	model_name,
    model_year,
    displacement, -- mpg,
    cylinders
FROM 
	specifications
WHERE displacement > 450 -- mpg >= 35
AND cylinders >= 5;


-- 6. Extract vehicles with acceleration > 20 or posess 4 and 5 cylinders.   
SELECT
	model_name,
    model_year,
    cylinders,
    acceleration
FROM specifications 
WHERE acceleration > 20 
OR cylinders IN (4,5);


-- 7. Extract vehicle names which end with torino
SELECT 
	model_name,
    model_year
FROM specifications
WHERE model_name LIKE '%torino';


-- 8. Extract vehicle names which do not contain ford
SELECT 
	model_name,
    model_year
FROM specifications
WHERE model_name NOT LIKE '%ford%';


-- 9. Calculate number of ratings received per type.  
SELECT   
    fake_ratings,
    COUNT(model_name) AS Number_of_ratings_received
FROM ratings
GROUP BY fake_ratings;   


-- 10. Extract number of cars produced per origin per model year
SELECT 
	origin,
    model_year,
    COUNT(model_name) AS count_of_cars
FROM specifications
GROUP BY
	origin,
    model_year;


-- 11. Number of cars, lightest car, heaviest car, and average weight per origin
SELECT 
	origin,
    COUNT(model_name) AS number_of_cars,
    MIN(weight) AS lightest_car,
    MAX(weight) AS heaviest_car,
    AVG(weight) AS average_weight
FROM specifications
GROUP BY
	origin;


-- 12. areas with manufacuting totals exceeding 100 cars.
SELECT 
	origin,
    COUNT(model_name) AS number_of_cars
FROM specifications
GROUP BY 
	origin
HAVING COUNT(*) > 100;


-- 13. Ordering features by mpg descending and weight ascending
SELECT 
	model_name,
    mpg,
    weight,
    horsepower,
    cylinders
FROM specifications
ORDER BY mpg DESC, weight ASC;


-- 14. total number of cars per cylinder in a descending order.
SELECT 
	cylinders,
    COUNT(model_name) AS total_number_of_cars
FROM specifications
GROUP BY 
	cylinders
ORDER BY 
	COUNT(model_name) DESC;
