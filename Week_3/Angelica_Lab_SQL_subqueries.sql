use sakila;

#Query 1: List all films whose length is longer than the average of all the films.
SELECT title
FROM film
WHERE length > (SELECT AVG(length)
				FROM film);
                
#Query 2: How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT count(film_id) AS film_copies
FROM inventory
WHERE film_id = (SELECT film_id
				FROM film
                WHERE title = 'Hunchback Impossible');
                
#Query 3: Use subqueries to display all actors who appear in the film Alone Trip.
SELECT first_name, last_name
FROM actor
WHERE actor_id IN (SELECT actor_id
					FROM film_actor
                    WHERE film_id = (SELECT film_id
										FROM film
                                        WHERE title = 'Alone Trip'));
                                        
#Query 4: Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
SELECT title
FROM film
WHERE film_id IN (SELECT film_id
					FROM film_category
                    WHERE category_id = (SELECT category_id
											FROM category
                                            WHERE name = 'family'));
                                            
#Query 5: Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.
SELECT first_name, last_name, email
FROM customer
WHERE address_id IN (SELECT address_id
						FROM address
                        WHERE city_id IN (SELECT city_id
											FROM city
                                            WHERE country_id = (SELECT country_id
																FROM country
                                                                WHERE country = 'Canada')));
                                                                
SELECT cu.first_name, cu.last_name, cu.email
FROM customer AS cu
INNER JOIN address AS ad ON ad.address_id = cu.address_id
INNER JOIN city AS ct ON ct.city_id = ad.city_id
INNER JOIN country AS co ON co.country_id = ct.country_id
WHERE co.country = 'Canada';

#OPTIONAL

#Query 6: Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.
SELECT title
FROM film
WHERE film_id IN (SELECT film_id
					FROM film_actor
                    WHERE actor_id = (SELECT actor_id
										FROM film_actor
										GROUP BY actor_id
                                        ORDER BY count(film_id) DESC
										LIMIT 1));
#actor_id of the most prolific actor                                        
SELECT actor_id, count(film_id)
FROM film_actor
GROUP BY actor_id
ORDER BY count(film_id) DESC
LIMIT 1;

#Query 7: Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments

SELECT title
FROM film
WHERE film_id IN (
				SELECT film_id
                FROM inventory
                WHERE inventory_id IN (
									SELECT inventory_id
                                    FROM rental
                                    WHERE customer_id = (
														SELECT customer_id
														FROM payment
														GROUP BY customer_id
														ORDER BY sum(amount) DESC
														LIMIT 1)));
# customer_id of the most profitable actor                                                        
SELECT customer_id
FROM payment
GROUP BY customer_id
ORDER BY sum(amount) DESC
LIMIT 1;

#Query 8: Customers who spent more than the average payments(this refers to the average of all amount spent per each customer).

SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id IN (
					SELECT customer_id
                    FROM payment
                    GROUP BY customer_id
                    HAVING sum(amount) > (SELECT (sum(amount)/count(DISTINCT(customer_id))) AS average_expenditure_per_customer
											FROM payment))
ORDER BY first_name, last_name;



SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id IN (
					SELECT customer_id
                    FROM payment
                    GROUP BY customer_id
                    HAVING sum(amount) > (SELECT AVG(total) FROM (SELECT sum(amount) AS total
																	FROM payment 
																	GROUP BY customer_id) AS total_customer))
ORDER BY first_name, last_name;                    