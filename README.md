# SQL Project: World Life Expectancy

### Data Cleaning and Exploratory Analysis

#### by Alex Melino

#

### Background and Data Information

This is a sample project done with world life expectancy data. The data can be populated into a table using an SQL script called 'WorldLifeExpectancyScript', which can be found in the 'Resources' folder within this repo. The data was downloaded as a .csv file (also located in the 'Resources' folder under the name 'WorldLifeExpectancy.csv'). The script and the data itself was provided by [AnalystBuilder.com](https://www.analystbuilder.com/).

The project is intended to showcase SQL skills regarding data cleaning and some exploratory data analysis.

The original data consists of 2941 rows of data broken down for each country dating from 2007 to 2022. The table columns consist of a variety of information realting to each country's life expectancy, BMI, adult mortality, GDP and much more (18 columns in total).
#

### Data Cleaning

The data required a series of data cleaning steps to ensure that the exploratory data analysis would yield accurate results. The end result can be found in the main directory of this repo under the name 'world_life_expectancy_cleaned.csv'.

The main steps taken in this data cleaning example are as follows:

- Identifying and removing duplicate rows

- Identifying rows with blank data for the 'status' column (developed vs developing) and populating those with the appropriate designation

- Identifying rows with blank or null data for the crucial 'life expectancy' column and populating those rows with a value that is the average of the preceding and following years.

- Lastly, countries that had a value of '0' for life expectancy were removed as they all corresponded with tiny countries with which no other data was availble.

The resulting table was now ready for exploratory data analysis to gain some more valuable insights from this data.
#

### Exploratory Data Analysis

In this phase of the project, various information was gleamed using a variety of SQL queries. Some samples of the outputs from these queries can be found within this ReadMe below. Additionally, the full table results for the various queries used can be found in the 'eda_outputs' folder of this repo.

1. The first analysis was to identify the magnitude of improvement in life expectancy over the 15 year period that the data covers. This query returned the maximum and minimum life expectancy for each country and the difference between them which represents the improvement from 2007 to 2022. A sample of the results can be seen in table below which shows the countries which saw the greatest increase in life expectancy.
![Page 1](Images/life_expectancy_min_max_difference.png)



2. 











