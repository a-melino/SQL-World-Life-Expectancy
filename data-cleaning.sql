
## WORLD LIFE EXPECTANCY PROJECT ##

## Data Cleaning ##

# Import table and then import again as a backup
SELECT * 
FROM world_life_expectancy.world_life_expectancy;

SELECT * 
FROM world_life_expectancy.world_life_expectancy_backup;

# Explore the table and look for missing data, duplicates, and other issues





# Identifying and removing duplicate rows
SELECT country, 
	year, 
	CONCAT(country, year), 
	COUNT(CONCAT(country, year))
FROM world_life_expectancy
GROUP BY country, 
	year, 
	CONCAT(country, year)
HAVING COUNT(CONCAT(country, year)) > 1
;

# Obtain the associated row_id for each duplicate
SELECT *
FROM (
	SELECT row_id,
		CONCAT(country, year),
		ROW_NUMBER() OVER(PARTITION BY CONCAT(country, year) ORDER BY CONCAT(country, year)) AS row_num
	FROM world_life_expectancy
    ) AS row_table
WHERE row_num > 1
;

# Use the above query to delete the appropriate duplicate rows
DELETE FROM world_life_expectancy
WHERE 
	row_id IN (
    SELECT row_id
	FROM (
		SELECT row_id,
			CONCAT(country, year),
			ROW_NUMBER() OVER(PARTITION BY CONCAT(country, year) ORDER BY CONCAT(country, year)) AS row_num
		FROM world_life_expectancy
		) AS row_table
	WHERE row_num > 1
    )
;





# Identify rows with missing data for 'status' column (blanks or nulls)
SELECT *
FROM world_life_expectancy
WHERE status = ''
;
SELECT *
FROM world_life_expectancy
WHERE status IS NULL
;

# Blanks exist, so now identify distinct values used for 'status' column
SELECT DISTINCT(status)
FROM world_life_expectancy
WHERE status != ''
;

# Identify countries that have 'developing' as their 'status' column
SELECT DISTINCT(country)
FROM world_life_expectancy
WHERE status = 'Developing'
;

# Update balnk values for those countries with 'developing', use a SELF JOIN as a workaround
UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.country = t2.country
SET t1.status = 'Developing'
WHERE t1.status = ''
AND t2.status != ''
AND t2.status = 'Developing'
;

# Do the same with 'developed' countries
UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.country = t2.country
SET t1.status = 'Developed'
WHERE t1.status = ''
AND t2.status != ''
AND t2.status = 'Developed'
;





# Identify rows with missing data for 'life expectancy' column (blanks or nulls)
SELECT *
FROM world_life_expectancy
WHERE `life expectancy` = ''
;
SELECT *
FROM world_life_expectancy
WHERE `life expectancy` IS NULL
;

# To populate balnk values, take the average life expectancy from the previous year 
# and the following year
SELECT country, 
	year, 
    `life expectancy`
FROM world_life_expectancy
;

# Use another SELF JOIN, two of them
SELECT t1.country, 
	t1.year, 
    t1.`life expectancy`,
    t2.country, 
	t2.year, 
    t2.`life expectancy`,
	t3.country, 
	t3.year, 
    t3.`life expectancy`
FROM world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.country = t2.country
    AND t1.year = t2.year-1
JOIN world_life_expectancy t3
	ON t1.country = t3.country
    AND t1.year = t3.year+1
WHERE t1.`life expectancy` = ''
;

# Now use same query but also include the calculation for the desired average
SELECT t1.country, 
	t1.year, 
    t1.`life expectancy`,
    t2.country, 
	t2.year, 
    t2.`life expectancy`,
	t3.country, 
	t3.year, 
    t3.`life expectancy`,
    ROUND((t2.`life expectancy` + t3.`life expectancy`)/2, 1)
FROM world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.country = t2.country
    AND t1.year = t2.year - 1
JOIN world_life_expectancy t3
	ON t1.country = t3.country
    AND t1.year = t3.year + 1
WHERE t1.`life expectancy` = ''
;

# Update the correct values in the table
UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.country = t2.country
    AND t1.year = t2.year - 1
JOIN world_life_expectancy t3
	ON t1.country = t3.country
    AND t1.year = t3.year + 1
SET t1.`life expectancy` = ROUND((t2.`life expectancy` + t3.`life expectancy`)/2, 1)
WHERE t1.`life expectancy` = ''
;





# Identify countries that have 0's for life expectancy (no data)
SELECT *
FROM world_life_expectancy
WHERE `life expectancy` = 0
;

# Delete those rows from the data as they are small countries with no data
DELETE FROM world_life_expectancy
WHERE `life expectancy` = 0
;






