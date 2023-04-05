use sakila;

#Name of actors that starred in the film with film_id = 1
SELECT first_name
FROM actor
JOIN film_actor
USING (actor_id)
WHERE film_id = 1;

#Same to the previous one
SELECT first_name
FROM actor
WHERE actor_id IN (SELECT actor_id
					FROM film_actor
                    WHERE film_id = 1);

#Name of actors that starred in the film 'Bucket Brotherhood'
SELECT first_name
FROM actor
WHERE actor_id IN (SELECT actor_id
					FROM film_actor
                    WHERE film_id = (SELECT film_id
										FROM film
                                        WHERE title = 'Bucket Brotherhood'));
                                        
#Name of actors that starred in films that belonged to the action category
SELECT first_name
FROM actor
WHERE actor_id IN (SELECT actor_id
					FROM film_actor
                    WHERE film_id IN (SELECT film_id
										FROM film_category
                                        WHERE category_id = (SELECT category_id
																FROM category
                                                                WHERE name = 'Action')));