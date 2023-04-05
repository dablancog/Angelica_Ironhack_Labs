use sakila;

#Query 1: Write a query to display for each store its store ID, city, and country.
SELECT st.store_id, ct.city, co.country
FROM store AS st
INNER JOIN address AS ad ON ad.address_id = st.address_id
INNER JOIN city AS ct ON ct.city_id = ad.city_id
INNER JOIN country AS co ON co.country_id = ct.country_id;

#Query 2: Write a query to display how much business, in dollars, each store brought in.
SELECT st.store_id, sum(pay.amount) AS revenue
FROM store AS st
INNER JOIN staff AS sa ON st.store_id = sa.store_id
INNER JOIN payment AS pay ON pay.staff_id = sa.staff_id
GROUP BY st.store_id;
