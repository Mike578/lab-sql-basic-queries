#LAB 2 : SQL Data Aggregation and Transformation
# To ensure the default selected data will be the sakile one, we should first run the USE function
USE sakila;

# [Challenge 1]

# 1 You need to use SQL built-in functions to gain insights relating to the duration of movies:

-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.

# Shortest
SELECT title, length
FROM film
ORDER BY length ASC
LIMIT 1;

-- Query to determine the longest movie duration
SELECT MAX(length) AS max_duration
FROM film;

-- Query to determine the shortest movie duration
SELECT MIN(length) AS min_duration
FROM film;


# Longest
SELECT title, length
FROM film
ORDER BY length DESC
LIMIT 1;


-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
-- Hint: Look for floor and round functions.
SELECT
    CONCAT(
        FLOOR(AVG(length) / 60), "h ",
        ROUND(AVG(length) % 60), "min"
    ) AS avg_duration
FROM film;

# 2. You need to gain insights related to rental dates:

-- 2.1 Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract 
-- the earliest date in the rental_date column from the latest date.
SELECT
	DATEDIFF(MAX(rental_date), MIN(rental_date)) AS rental_duration_days
FROM rental;



-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday 
-- of the rental. Return 20 rows of results.
SELECT 
    rental_id
    , rental_date
    , MONTHNAME(rental_date) AS rental_month
	, DAYNAME(rental_date) AS rental_weekday
FROM 
    rental
LIMIT 20;


-- -2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', 
-- depending on the day of the week.
-- Hint: use a conditional expression.

SELECT 
    rental_id
    , rental_date
    , CASE 
		WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
	END AS day_type
FROM 
    rental;
    
    
    
# 3. You need to ensure that customers can easily access information about the movie collection. 
-- To achieve this, retrieve the film titles and their rental duration. 
-- If any rental duration value is NULL, replace it with the string 'Not Available'. 
-- Sort the results of the film title in ascending order.

SELECT 
    title AS film_title,
    COALESCE(DATEDIFF(return_date, rental_date), 'Not Available') AS rental_duration
FROM 
    film
ORDER BY 
    title ASC;

# 	Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
#	Hint: Look for the IFNULL() function.

# 4. Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. 
# To achieve this, you need to retrieve the concatenated first and last names of customers, 
# along with the first 3 characters of their email address, so that you can address them by their first name 
# and use their email address to send personalized recommendations. 
# The results should be ordered by last name in ascending order to make it easier to use the data.








# [Challenge 2]

# Next, you need to analyze the films in the collection to gain some more insights. 

# 1. Using the film table, determine:

-- 1.1 The total number of films that have been released.
SELECT COUNT(*) AS total_films
FROM film;

-- 1.2 The number of films for each rating.
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

# 2. Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
SELECT 
    rating, 
    ROUND(AVG(length), 2) AS mean_duration
FROM 
    film
GROUP BY 
    rating
ORDER BY 
    mean_duration DESC;


-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT 
    rating, 
    ROUND(AVG(length), 2) AS mean_duration
FROM 
    film
GROUP BY 
    rating
HAVING 
    mean_duration > 120;

# 3. Bonus: determine which last names are not repeated in the table actor.

SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;