use sakila;
SELECT * FROM actor;
# 4 columns. 200 rows. Observation: first and last name of actors is mixed up
# actord_id - first_name - last_name - last_update
SELECT * FROM address;
# 9 columns. 603 rows. Observation: adress 2 has only NaNs. Location column includes 'BLOB'
# adress_id - adress - adress2 - district - city_id - postal_code - phone - location - last_update
SELECT * FROM category;
# 3 x 16.
# category_id - name - last_update
SELECT * FROM city;
# 4 x 600
# city_id - city - country_id - last_update
SELECT * FROM country;
# 3 x 109
# country_id - country - last_update
SELECT * FROM customer;
# 9 x 599
# customer_id, store_id, first_name, last_name, email, address_id, active, create_date, last_update
SELECT * FROM film_actor;
# 3 x 5462
# actor_id, film_id, last_update
SELECT * FROM category;
# 3 x 1000
# film_id, category_id, last_update
SELECT * FROM film_text;
# 3 x 1000
# film_id, title, description
SELECT * FROM inventory;
# 4 x 1000
# inventory_id, film_id, store_id, last_update
SELECT * FROM language;
# 3 x 6
# language_id, name, last_update
SELECT * FROM payment;
# 4 x 200
# payment_id, customer_id, staff_id, rental_id, amount, payment_date, last_update
SELECT * FROM rental;
# 7 x 16012
# rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update
SELECT * FROM staff;
# 11 x 2
# staff_id, first_name, last_name, address_id, picture, picture, email, store_id, active, username, password, last_update
SELECT * FROM store;
# 4 x 2
# store_id, manager_staff_id, address_id, last_update

SELECT title FROM sakila.film;
# To get the film Titles

SELECT name AS language FROM sakila.language;
# Table language

SELECT DISTINCT(store_id) FROM sakila.store;
# There are 2 stores

SELECT DISTINCT(staff_id) FROM sakila.staff;
# There are 2 employees

SELECT first_name FROM sakila.staff;
# First names of employees: Mike and Jon
