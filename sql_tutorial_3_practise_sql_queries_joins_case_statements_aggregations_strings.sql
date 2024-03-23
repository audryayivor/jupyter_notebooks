/*
SQL TUTORIAL #3: AUTOMOBILES 

In this tutorial, we practise the following: 
- CASE statements
- JOINS
- Sub-queries
- Aggregation
- String Operations 
*/
CREATE DATABASE db_sql_tutorial3_auto_mpg;
USE db_sql_tutorial3_auto_mpg;  

CREATE TABLE specifications(
	mpg INT,
    cylinders INT,
    displacement INT,
    horsepower VARCHAR(4),
    weight INT,
    acceleration FLOAT,
    model_year INT,
    origin INT,
    model_name VARCHAR(50),
    vehicle_id INT PRIMARY KEY
);

CREATE TABLE locations_main(
    f_location VARCHAR(10),
    vehicle_id INT PRIMARY KEY
);

CREATE TABLE locations_dim(
    origin INT,
    location VARCHAR(10),
    location_ID INT PRIMARY KEY
);

CREATE TABLE ratings_main(
    vehicle_id INT PRIMARY KEY,
    vehicle_name VARCHAR(50),
    fake_ratings INT,
    ratings_id INT
);

CREATE TABLE ratings_dim(
    ratings_ID INT PRIMARY KEY,
    ratings VARCHAR(10)
);


-- 1. Categorize the cars based on the number of cylinders
SELECT DISTINCT 
	cylinders,
	CASE 
		WHEN cylinders IN (1,2,3) THEN 'low fuel'
        WHEN cylinders BETWEEN 4 AND 6 THEN 'medium fuel'
        WHEN cylinders > 6 THEN 'high fuel'
		ELSE 'check data for nan value'
	END AS 'fuel_consumption_type'
FROM specifications; 


-- 2. Find total number of cars per region per cylinder type. 
 SELECT
	-- model_year,
    cylinders,
    COUNT( CASE WHEN origin = 1 THEN cylinders ELSE NULL END ) AS count_cylinders_region_1,
    COUNT( CASE WHEN origin = 2 THEN cylinders ELSE NULL END ) AS count_cylinders_region_2,
    COUNT( CASE WHEN origin = 3 THEN cylinders ELSE NULL END ) AS count_cylinders_regione_3
 FROM specifications
 GROUP BY 
    cylinders 
 ORDER BY cylinders DESC;
 
-- 3. extract list of ratings assigned to each vehicle.
SELECT DISTINCT 
	specifications.vehicle_id,
    specifications.model_name,
    ratings_main.fake_ratings
    -- ratings_dim.ratings
FROM specifications
	INNER JOIN ratings_main
		ON specifications.vehicle_id = ratings_main.vehicle_id; 
 
-- 4. LEFT JOIN 
-- extract number of cars rated per category of rating, display results in ascending order of number of cars rated
SELECT 
	ratings_main.ratings_id,
    COUNT(specifications.vehicle_id) AS number_of_rated_cars
FROM ratings_main
	LEFT JOIN specifications
		ON specifications.vehicle_id = ratings_main.vehicle_id 
GROUP BY 
	ratings_main.ratings_id
 ORDER BY
	number_of_rated_cars;
    
-- 5. extract sum of vehicles in a location
SELECT 
	locations_main.f_location,
    COUNT(ratings_main.ratings_id) AS countings
FROM locations_main
	LEFT JOIN ratings_main
		ON locations_main.vehicle_id = ratings_main.vehicle_id
GROUP BY 
	locations_main.f_location;
 
 
-- 6. INNER JOIN -- extract the ratings for each car from the specifications and ratings tables.
SELECT
	specifications.vehicle_id,
    specifications.model_name,
    ratings_main.fake_ratings,
    ratings_dim.ratings
FROM specifications
	INNER JOIN ratings_main
		ON specifications.vehicle_id = ratings_main.vehicle_id
	INNER JOIN ratings_dim
		ON ratings_main.ratings_id = ratings_dim.ratings_ID;
 
-- 7. MULTI-CONDITION JOINS 
-- extract the vehicle names, mpg, and weights available which have a rating of at least 4
SELECT
	specifications.vehicle_id,
    specifications.model_name,
    specifications.model_year,
    specifications.mpg,
    ratings_main.fake_ratings,
    ratings_dim.ratings
FROM specifications
	INNER JOIN ratings_main 
		ON specifications.vehicle_id = ratings_main.vehicle_id
	INNER JOIN ratings_dim
		ON ratings_main.ratings_id = ratings_dim.ratings_ID
        AND ratings_dim.ratings_ID >= 4;
 
-- 8. Extract the number of cars and their average weight per location
SELECT
	f_location,
    specifications.cylinders AS mumber_of_cylinders,
    COUNT(specifications.vehicle_id) AS number_of_cars,
    AVG(specifications.weight) AS average_weight
FROM specifications
	LEFT JOIN locations_main
		ON specifications.vehicle_id = locations_main.vehicle_id
    -- LEFT JOIN locations_main
    LEFT JOIN ratings_main
		ON locations_main.vehicle_id = ratings_main.vehicle_id
	LEFT JOIN ratings_dim
		ON ratings_main.ratings_id = ratings_dim.ratings_ID
GROUP BY
	f_location,
    specifications.cylinders
ORDER BY specifications.cylinders;
 
 -- 9. CONCAT 
SELECT 
	CONCAT(cylinders,'--', model_name) AS cylinders_model_name
FROM specifications;
 
-- 10. UPPER    
-- convert the vehicle names which names begin with 'chevrolet' to upper case
SELECT 
	model_name,
    mpg,
    CASE
		WHEN model_name LIKE 'chevrolet%' THEN UPPER(model_name)
        ELSE model_name 
	END AS 'lower_and_upper_mix'
FROM specifications;
 
-- 11. LENGTH 
-- extract vehicle names where model name contains Ford and count the length
SELECT 
	model_name,
    mpg,
    LENGTH(model_name) AS string_length
FROM specifications
WHERE model_name LIKE '%mazda%'; 
 

-- 12. SUBSTRING extract a sub-string of length 3 starting from position 2
SELECT 
	model_name,
    SUBSTRING(model_name, 2, 3) AS sub_name
FROM specifications;
 

-- 13. SUB-QUERIES EXISTS  
-- extract all vehicles with rating 1. 
SELECT 
	vehicle_id,
    model_name,
    mpg,
    cylinders,
    weight,
    model_year
FROM specifications 
WHERE EXISTS ( 
	SELECT 1 
	FROM ratings_main 
	WHERE ratings_main.vehicle_id = specifications.vehicle_id
    AND fake_ratings = 1);   
 
 