USE sakila;

-- EJERCICIO 1:
SELECT DISTINCT 
title
FROM film;

-- EJERCICIO 2:
SELECT 
title
FROM film
WHERE rating = 'PG-13';

-- EJERCICIO 3:
SELECT
title,
description
FROM film
WHERE description LIKE '%amazing%';

-- EJERCICIO 4:
SELECT
title,
length
FROM film
WHERE length > 120
ORDER BY length ASC;

-- EJERCICIO 5:
SELECT
first_name,
last_name
FROM actor;

-- EJERCICIO 6:
SELECT
first_name,
last_name
FROM actor
WHERE last_name LIKE '%Gibson%';

-- EJERCICIO 7:
SELECT
actor_id,
first_name,
last_name
FROM actor
WHERE actor_id BETWEEN 10 AND 20
ORDER BY actor_id ASC;

-- EJERCICIO 8:
SELECT 
title,
rating
FROM film
WHERE rating NOT IN ('R', 'PG-13');

-- EJERCICIO 9:
SELECT
rating,
COUNT(rating) AS total_películas
FROM film
GROUP BY rating
ORDER BY total_películas ASC;

-- EJERCICIO 10:
SELECT
customer.customer_id,
customer.first_name,
customer.last_name,
COUNT(rental_id) AS cantidad_películas_alquiladas
FROM customer
INNER JOIN rental
ON customer.customer_id = rental.customer_id
GROUP BY customer_id
ORDER BY customer_id ASC;

-- COMPRUEBO QUE ES REAL LA INFORMACIÓN MOSTRADA ARRIBA, PUES NO ME COINCIDIA EL RESULTADO DADO CON LA INFO MOSTRADA EN RENTAL, PERO CON ESTA CONSULTA VEO QUE ES CORRECTO LO ANTERIOR.
SELECT *
FROM rental
WHERE customer_id = 1; 

-- EJERCICIO 11:
SELECT
category.name AS nombre_categoria,
COUNT(rental.rental_id) AS recuento_alquileres
FROM rental
INNER JOIN inventory
ON rental.inventory_id = inventory.inventory_id
INNER JOIN film
ON inventory.film_id = film.film_id
INNER JOIN film_category
ON film.film_id = film_category.film_id
INNER JOIN category
ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY recueNto_alquileres DESC;

-- EJERCICIO 12:
SELECT
rating,
AVG(length) AS promedio_duracion
FROM film
GROUP BY rating
ORDER BY promedio_duracion ASC;

-- EJERCICIO 13:
SELECT
first_name,
last_name
FROM actor
INNER JOIN film_actor
ON actor.actor_id = film_actor.actor_id
INNER JOIN film
ON film_actor.film_id = film.film_id
WHERE film.title = 'Indian Love';

-- EJERCICIO 14:
SELECT
title,
description
FROM film
WHERE description LIKE '%dog%' OR description LIKE '%cat%';

-- EJERCICIO 15:
SELECT
title,
release_year
FROM film
WHERE release_year BETWEEN 2005 AND 2010
ORDER BY release_year ASC;

-- EJERCICIO 16:
SELECT
title,
category.name
FROM film
INNER JOIN film_category
ON film.film_id = film_category.film_id
INNER JOIN category
ON film_category.category_id = category.category_id
WHERE category.name = 'Family';

-- EJERCICIO 17:
SELECT 
title,
rating,
length
FROM film
WHERE rating = 'R' AND length > 120
ORDER BY length ASC;

-- EJERCICIO 18: 
SELECT
actor.first_name,
actor.last_name,
COUNT(film_actor.film_id) AS cantidad_actores
FROM film_actor
INNER JOIN actor
ON actor.actor_id = film_actor.actor_id
GROUP BY actor.first_name, actor.last_name
HAVING COUNT(film_actor.film_id) > 10
ORDER BY cantidad_actores ASC;

-- EJERCICIO 19:
SELECT
actor.actor_id AS actor,
actor.first_name AS nombre,
actor.last_name AS apellido
FROM actor
LEFT JOIN film_actor
ON actor.actor_id = film_actor.actor_id
WHERE film_actor.actor_id IS NULL;

-- EJERCICIO 20:
SELECT
category.name AS nombre_categoría,
AVG(length) AS promedio_duracion
FROM film
INNER JOIN film_category
ON film.film_id = film_category.film_id
INNER JOIN category
ON category.category_id = category.category_id
GROUP BY category.name
HAVING AVG(length) > 120
ORDER BY promedio_duracion ASC;

-- EJERCICIO 21:
SELECT
actor.actor_id AS ID,
first_name AS nombre,
last_name AS apellido,
COUNT(film_actor.film_id) AS total_peliculas
FROM actor
INNER JOIN film_actor
ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id, first_name, last_name
HAVING COUNT(film_actor.film_id) >= 5
ORDER BY actor.actor_id ASC;

-- EJERCICIO 22:
SELECT DISTINCT
title,
DATEDIFF(return_date, rental_date) AS días_alquilados
FROM rental
INNER JOIN inventory
ON rental.inventory_id = inventory.inventory_id
INNER JOIN film
ON inventory.film_id = film.film_id
WHERE rental.rental_id IN (
	SELECT 
    rental_id
    FROM
    rental
    WHERE DATEDIFF(return_date, rental_date) > 5
    )
ORDER BY días_alquilados ASC;

-- EJERCICIO 23:
SELECT DISTINCT
actor_id,
first_name,
last_name
FROM actor
WHERE actor_id NOT IN (
	SELECT
    film_actor.actor_id
    FROM film_actor
    INNER JOIN film
    ON film_actor.film_id = film.film_id
    INNER JOIN film_category
    ON film.film_id = film_category.film_id
    INNER JOIN category
    ON film_category.category_id = category.category_id
    WHERE category.name = 'Horror'
    );
    
-- EJERCICIO 24:
SELECT 
title,
category.name,
length
FROM film
INNER JOIN film_category
ON film.film_id = film_category.film_id
INNER JOIN category
ON film_category.category_id = category.category_id
WHERE category.name = 'COMEDY' AND length > 180; 
