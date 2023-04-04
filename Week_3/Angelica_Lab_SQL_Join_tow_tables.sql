use sakila;

#Query 1: Which actor has appeared in the most films?
SELECT ac.first_name, ac.last_name, count(fa.actor_id) AS total_movies
FROM actor AS ac INNER JOIN film_actor AS fa
ON ac.actor_id = fa.actor_id
GROUP BY ac.actor_id
ORDER BY total_movies DESC
LIMIT 1;
#Result: FGina Degeneres 42

#Query 2: Most active customer (the customer that has rented the most number of films)
SELECT cu.first_name, cu.last_name, count(re.rental_id) AS total_rented_movies
FROM customer AS cu INNER JOIN rental AS re
ON cu.customer_id = re.customer_id
GROUP BY cu.customer_id
ORDER BY total_rented_movies DESC
LIMIT 1;
#Result: Eleanor Hunt 46

#Query 3: List number of films per category.
SELECT ca.name, count(fc.film_id) AS films_per_category
FROM category AS ca
INNER JOIN film_category AS fc
ON ca.category_id = fc.category_id
GROUP BY ca.name;

#Query 4: Display the first and last names, as well as the address, of each staff member.
SELECT st.first_name, st.last_name, ad.address
FROM address AS ad
INNER JOIN staff AS st
ON st.address_id = ad.address_id;

#Query 5: get films titles where the film language is either English or italian, and whose titles starts with letter "M" , sorted by title descending.
SELECT fi.title, lan.name
FROM language AS lan
INNER JOIN film AS fi
ON fi.language_id = lan.language_id
WHERE fi.title REGEXP "^M" AND (fi.language_id = "1" OR fi.language_id = "2");

#Query 6: Display the total amount rung up by each staff member in August of 2005.
SELECT st.first_name, st.last_name, sum(pay.amount) AS total_amount
FROM staff AS st
INNER JOIN payment AS pay
ON st.staff_id = pay.staff_id
WHERE pay.payment_date LIKE "2005-08%"
GROUP BY st.first_name, st.last_name;

#Query 7: List each film and the number of actors who are listed for that film.
SELECT fi.title, count(fa.film_id) AS total_actors
FROM film AS fi INNER JOIN film_actor AS fa
ON fi.film_id = fa.film_id
GROUP BY fi.film_id
ORDER BY total_actors DESC;

#Query 8:Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name.
SELECT cu.first_name, cu.last_name, sum(pay.amount) AS total_paid
FROM customer AS cu INNER JOIN payment AS pay
ON cu.customer_id = pay.customer_id
GROUP BY cu.first_name, cu.last_name
ORDER BY cu.last_name asc;

#Query 9: Write sql statement to check if you can find any actor who never particiapted in any film.
SELECT ac.first_name, ac.last_name, fa.film_id
FROM actor AS ac LEFT JOIN film_actor AS fa
ON ac.actor_id = fa.actor_id
WHERE fa.actor_id IS NULL;

#Query 10: get the addresses that have NO customers, and ends with the letter "e"
SELECT ad.address, cu.customer_id
FROM address AS ad LEFT JOIN customer AS cu
ON ad.address_id = cu.address_id
WHERE cu.address_id IS NULL AND ad.address regexp "e$";

