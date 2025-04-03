

## WORLD LIFE EXPECTANCY PROJECT ##

## Exploratory Data Analysis ##

SELECT * 
FROM world_life_expectancy;


# Explore trends relating to each country's min and max life expectancies
SELECT country, 
	MIN(`life expectancy`) AS min_life_expectancy, 
    MAX(`life expectancy`) AS max_life_expectancy
FROM world_life_expectancy
GROUP BY country
HAVING MIN(`life expectancy`) != 0
AND MAX(`life expectancy`) != 0
ORDER BY country ASC
;

# Check difference between min and max for each country
SELECT country, 
	MIN(`life expectancy`) AS min_life_expectancy, 
    MAX(`life expectancy`) AS max_life_expectancy,
    ROUND(MAX(`life expectancy`)-MIN(`life expectancy`), 1) AS difference
FROM world_life_expectancy
GROUP BY country
HAVING MIN(`life expectancy`) != 0 
AND MAX(`life expectancy`) != 0
ORDER BY difference DESC
;





# Explore average life expectancy by year
SELECT year, 
	ROUND(AVG(`life expectancy`), 2) AS year_avg
FROM world_life_expectancy
GROUP BY year
;





# Explore relationship between a country's GDP and their life expectancy
SELECT country, 
	ROUND(AVG(`life expectancy`), 1) AS avg_life_expectancy,
    ROUND(AVG(GDP), 1) AS avg_GDP
FROM world_life_expectancy
GROUP BY country
;

# Exclude rows with 0 values in their GDP, and put in descending order by GDP
SELECT country, 
	ROUND(AVG(`life expectancy`), 1) AS avg_life_expectancy,
    ROUND(AVG(GDP), 1) AS avg_GDP
FROM world_life_expectancy
GROUP BY country
HAVING avg_GDP != 0
ORDER BY avg_GDP DESC
;





# Identify high GDP vs low GDP, and high life expectancy vs low life expectancy

# Count high GDP and low GDP countries, exclude 0 value GDP's
SELECT
SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) AS high_GDP_count
FROM world_life_expectancy
;

SELECT
SUM(CASE WHEN GDP < 1500 AND GDP > 0 THEN 1 ELSE 0 END) AS low_GDP_count
FROM world_life_expectancy
;

# Compare with high life expectancy vs low life expectancy
SELECT
SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) AS high_GDP_count,
ROUND(AVG(CASE WHEN GDP >= 1500 THEN `life expectancy` ELSE NULL END), 1) AS high_GDP_life_expectancy,
SUM(CASE WHEN GDP < 1500 AND GDP > 0 THEN 1 ELSE 0 END) AS low_GDP_count,
ROUND(AVG(CASE WHEN GDP < 1500 AND GDP > 0 THEN `life expectancy` ELSE NULL END), 1) AS low_GDP_life_expectancy
FROM world_life_expectancy
;





