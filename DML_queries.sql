#drop database if exists airbnb;
use airbnb;

SELECT 
    *
FROM
    amenities;


SELECT 
    l.id, b.booking_id
FROM
    listings l
        JOIN
    bookings b ON l.id = b.listing_id;

# Q1 Find the total revenue across years
SELECT 
    YEAR(b.checkin_date) AS year,
    SUM(DATEDIFF(b.checkout_date, b.checkin_date) * l.price) AS total_revenue
FROM
    bookings b
        JOIN
    listings l ON b.listing_id = l.id
GROUP BY year
ORDER BY year;

#Q2 Get the distribution of room types among all listings
SELECT
    roomtype,
    COUNT(*) AS number_of_listings,
    (COUNT(*) * 100.0) / SUM(COUNT(*)) OVER () AS percentage
FROM
    listings
GROUP BY
    roomtype
order by  percentage desc;


# Q3 popular neighbourhoods
SELECT 
    n.neighbourhood, COUNT(l.id) AS number_of_listings
FROM
    neighbourhood n
        JOIN
    listings l ON n.neighbourhood_id = l.neighbourhood_id
        LEFT JOIN
    bookings b ON l.id = b.listing_id
GROUP BY n.neighbourhood
ORDER BY number_of_listings DESC
LIMIT 10;

# Must have amenities
SELECT 
    a.name AS amenity_name, COUNT(la.id) AS occurences
FROM
    amenities a
        LEFT JOIN
    listings_amenities la ON a.amenity_id = la.amenity_id
GROUP BY a.amenity_id
ORDER BY occurences DESC;

# Q5 Retrieve the percentage of short and long term rentals to see the customer preferences. Listings with minimum number of nights
# <=30 are short and others are long
-- with rental_mapping (listing_id, type_of_rental) as
-- (select id, (case when minimum_nights>=28
-- 					then "long-term"
--                     else "short-term"
-- 					end) 
-- from listings)

-- select type_of_rental, count(listing_id) as number_of_listings
-- from rental_mapping
-- group by type_of_rental;

WITH rental_mapping (listing_id, type_of_rental) AS
(
    SELECT id,
           CASE 
               WHEN minimum_nights >= 30 THEN "long-term"
               ELSE "short-term"
           END
    FROM listings
)
SELECT
    type_of_rental,
    round(COUNT(listing_id) * 100.0 / SUM(COUNT(listing_id)) OVER (),0) AS listing_percentage
FROM rental_mapping
GROUP BY type_of_rental;


# Q6 find the customers who have made top 5 highest number of bookings
SELECT
    customer_id,
    customer_name
FROM (
    SELECT
        g.customer_id,
        g.customer_name,
        COUNT(b.booking_id) AS number_of_bookings,
        DENSE_RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
    FROM
        guests g
    LEFT JOIN
        bookings b ON g.customer_id = b.customer_id
    GROUP BY
        g.customer_id, g.customer_name
) ranked_bookings
WHERE
    booking_rank <= 5
order by number_of_bookings desc;

# Q7 Costly listings and their neighbourhood
SELECT 
    l.id AS listing_id,
    l.price AS listing_price,
    n.neighbourhood
FROM
    listings l
        JOIN
    neighbourhood n ON l.neighbourhood_id = n.neighbourhood_id
WHERE
    l.price > (SELECT 
            AVG(l2.price)
        FROM
            listings l2
        WHERE
            l2.neighbourhood_id = l.neighbourhood_id);


# Q8  Find the top 5 hosts with the highest number of listings and also the type of listing they own
WITH HostListings AS (
    SELECT
        host_id,
        COUNT(*) AS total_listings,
        DENSE_RANK() OVER (ORDER BY COUNT(*) desc) AS rank_,
        SUM(roomtype = 'Entire home/apt') AS entire_home_listings,
        SUM(roomtype = 'Private room') AS private_room_listings,
        SUM(roomtype = 'Shared room') AS shared_room_listings
    FROM
        listings
    GROUP BY
        host_id
)

SELECT
    hl.host_id as host_id, h.host_name,
    total_listings,
    rank_,
    entire_home_listings,
    private_room_listings,
    shared_room_listings
FROM
    HostListings hl
JOIN hosts h 
ON hl.host_id=h.host_id
WHERE
    hl.rank_ <= 5
ORDER BY hl.rank_;

# Q9
SELECT 
    n.neighbourhood AS neighbourhood, 
    COUNT(l.id) AS count_listings 
FROM 
    listings l 
JOIN 
    neighbourhood n ON l.neighbourhood_id = n.neighbourhood_id 
WHERE 
    l.review_score_rating < 4.5 
GROUP BY 
    n.neighbourhood 
ORDER BY count_listings desc; 

###extra#####

USE airbnbbackup;
select month(checkin_date), avg(count(booking_id)) over(partition by year(checkin_date)) as avg_val
from bookings
group by month(checkin_date);


USE airbnbbackup;
select month(checkin_date), count(booking_id)
from bookings
group by month(checkin_date);

# property type popularity
WITH PropertyPopularity AS (
    SELECT
        n.neighbourhood,
        l.roomtype,
        COUNT(b.booking_id) AS num_bookings,
        AVG(l.review_score_rating) AS avg_rating
    FROM
        listings l
    JOIN
        neighbourhood n ON l.neighbourhood_id = n.neighbourhood_id
    LEFT JOIN
        bookings b ON l.id = b.listing_id
    WHERE
        l.roomtype IS NOT NULL
        AND l.review_score_rating IS NOT NULL
    GROUP BY
        n.neighbourhood, l.roomtype
)

SELECT
    neighbourhood,
    roomtype,
    RANK() OVER (PARTITION BY neighbourhood ORDER BY num_bookings DESC) AS booking_rank,
    RANK() OVER (PARTITION BY neighbourhood ORDER BY avg_rating DESC) AS rating_rank,
    num_bookings,
    avg_rating
FROM
    PropertyPopularity
ORDER BY
    neighbourhood, booking_rank;


select distinct property_type from listings;
