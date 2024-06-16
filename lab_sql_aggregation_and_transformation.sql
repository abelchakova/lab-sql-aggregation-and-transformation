# Challenge 1

# 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
USE sakila;

select length, title as max_duration
from sakila.film
order by length desc
limit 1;

select length, title as min_duration
from sakila.film
order by length asc
limit 1;

# 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
# Hint: Look for floor and round functions.
select floor(avg(length) / 60) as hours,
mod(round(avg(length)), 60) as minutes
from sakila.film;


-- 2.1 Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
select datediff(max(return_date), min(rental_date)) as operation_days
from sakila.rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
select *,
dayofweek(rental_date) as day_of_week,
month(rental_date) as months
from sakila.rental
limit 20;

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
-- Hint: use a conditional expression.
select rental_date,
case when weekday(rental_date)
between 0 and 4 then 'weekday'
else 'weekend'
end as day_type
from sakila.rental;
 
-- retrieve the film titles and their rental duration. 
-- If any rental duration value is NULL, replace it 
-- with the string 'Not Available'. Sort the results of the film title in ascending order.
-- Please note that even if there are currently no null values 
-- in the rental duration column, the query should still be 
-- written to handle such cases in the future.
-- Hint: Look for the IFNULL() function.
select title, rental_duration,
ifnull(rental_duration, 'Not Available')
from sakila.film
order by title asc;

use sakila;

select 
    concat(first_name, ' ', last_name) as full_name,
    substring(email, 1, 3) as email_prefix
from sakila.customer
order by last_name asc;


-- CHALLENGE 2

-- Using the film table, determine:
-- 1.1 The total number of films that have been released.
-- 1.2 The number of films for each rating.
-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.

SELECT COUNT(*) AS total_films_released
FROM film;

SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

-- Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;
    
-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_duration DESC;

