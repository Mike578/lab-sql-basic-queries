#LAB 1 : SQL Basic Queries
# To ensure the default selected data will be the sakile one, we should first run the USE function
USE sakila ;

-- 1. Display all available tables in the Sakila database.
SHOW TABLES;


-- 2. Retrieve all the data from the tables actor, film and customer.
 SELECT *
 FROM actor
 ;


SELECT *
FROM film 
;

SELECT *
FROM customer;


-- 3. Retrieve the following columns from their respective tables:
# 3.1 Titles of all films from the film table
# 3.2 List of languages used in films, with the column aliased as language from the language table
# 3.3 List of first names of all employees from the staff table

SELECT title FROM film;
SELECT name AS language FROM language;
SELECT first_name FROM staff;

-- 4 Retrieve unique release years.
SELECT DISTINCT release_year
FROM film;

-- 5. Counting records for database insights:
# 5.1 Determine the number of stores that the company has.
SELECT COUNT(DISTINCT store_id) AS nb_stores
FROM store;

# 5.2 Determine the number of employees that the company has.
SELECT COUNT(DISTINCT staff_id) AS nb_employees
FROM staff;

# 5.3 Determine how many films exist and how many have been rented at least once.
SELECT
  (SELECT COUNT(*) FROM film) AS total_films,
  (SELECT COUNT(*) FROM rental) AS rented_films;

# 5.4 Determine the number of distinct last names of the actors in the database.
SELECT COUNT(DISTINCT last_name)  AS nb_actors
FROM actor;

-- 6. Retrieve the 10 longest films.
SELECT film_id, title, length
FROM film
ORDER BY length DESC
LIMIT 10 ;

-- 7. Use filtering techniques in order to:
# 7.1 Retrieve all actors with the first name "SCARLETT".
SELECT DISTINCT *
FROM actor
WHERE first_name IN ("SCARLETT");

# 7.2 Retrieve all movies that have ARMAGEDDON in their title and have a duration longer than 100 minutes.
SELECT *
FROM film
WHERE title LIKE '%ARMAGEDDON%' AND length > 100; 