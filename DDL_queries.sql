create schema if not exists airbnb;

use airbnb;

# amenities 
drop table if exists amenities;
create table amenities 
(
amenity_id double,
name varchar(255)
);
select * from  amenities;

# bookings
drop table if exists bookings;
create table bookings 
(
listing_id double,
booking_id double,
customer_id double,
checkout_date datetime,
checkin_date datetime
);

# guests
drop table if exists guests;
create table guests 
(
customer_id double,
reviewer_name varchar(255),
gender varchar(6),
age integer,
rating decimal(5,2)
);

# hosts 
drop table if exists hosts;
create table hosts 
(
host_id double,
host_name varchar(255),
host_since datetime,
host_location varchar(255),
host_response_time varchar(50),
host_response_rate integer,
host_acceptance_rate integer,
host_is_superhost char(10),
host_neighbourhood varchar(255),
host_listing_count integer,
host_identity_verified char(10),
calculated_listings_count integer,
listings_count_entire_homes integer,
listings_count_private_rooms integer,
calculated_host_listings_count_shared_rooms integer
);

# listings
drop table if exists listings;
create table listings 
(
id double,
host_id double,
latitude float,
longitude float,# has negative values so decide type accordingly 
property_type varchar(255),
roomtype varchar(40), 
accomodates integer,
bathrooms float, # 0.5 bathrooms possible
bedrooms integer,
beds integer,
price double,
minimum_nights integer,
maximum_nights integer,
license varchar(255),
instant_bookable char(1),
bathroom_type varchar(40),
review_score_rating decimal(5,2),
reviews_per_month float,
neighbourhood_id double
);


# listings_amenities
drop table if exists listings_amenities;
create table listings_amenities 
(
id double,
amenity_id double
);
select * from listings_amenities;

# neighbourhood
drop table if exists neighbourhood;
create table neighbourhood 
(
neighbourhood_id double,
neighbourhood varchar(255),
neighbourhood_group varchar(255)
);

#reviews
drop table if exists reviews;
create table reviews
(
review_id double,
review_date datetime,
reviewer_id double,
reviewer_name varchar(255),
review_rating decimal(5,2),
listing_id double,
booking_id double
);


#adding primary and foreign keys
-- Assuming you have a table called 'your_table_name' with columns 'column1', 'column2', etc.
ALTER TABLE `airbnb`.`amenities`
ADD PRIMARY KEY (`amenity_id`);

select * from  amenities;

ALTER TABLE `airbnb`.`bookings`
ADD PRIMARY KEY (`booking_id`);

ALTER TABLE `airbnb`.`listings`
ADD PRIMARY KEY (`id`);

ALTER TABLE `airbnb`.`guests`
ADD PRIMARY KEY (`customer_id`);

ALTER TABLE `airbnb`.`hosts`
ADD PRIMARY KEY (`host_id`);


ALTER TABLE `airbnb`.`listings_amenities`
ADD PRIMARY KEY (`id`,`amenity_id`);

ALTER TABLE `airbnb`.`neighbourhood`
ADD PRIMARY KEY (`neighbourhood_id`);

ALTER TABLE `airbnb`.`reviews`
ADD PRIMARY KEY (`review_id`);

#foreign key constraints
ALTER TABLE `airbnb`.`bookings`
ADD CONSTRAINT `fk_constraint_listing`
FOREIGN KEY (`listing_id`)
REFERENCES `airbnb`.`listings` (`id`);

ALTER TABLE `airbnb`.`bookings`
ADD CONSTRAINT `booking_to_guest`
FOREIGN KEY (`customer_id`)
REFERENCES `airbnb`.`guests` (`customer_id`);

ALTER TABLE `airbnb`.`listings`
ADD CONSTRAINT `fk_listing_to_host`
FOREIGN KEY (`host_id`)
REFERENCES `airbnb`.`hosts` (`host_id`);

ALTER TABLE `airbnb`.`listings`
ADD CONSTRAINT `fk_listing_to_neigbour`
FOREIGN KEY (`neighbourhood_id`)
REFERENCES `airbnb`.`neighbourhood` (`neighbourhood_id`);

ALTER TABLE `airbnb`.`reviews`
ADD CONSTRAINT `fk_review_to_listing`
FOREIGN KEY (`listing_id`)
REFERENCES `airbnb`.`listings` (`id`);

ALTER TABLE `airbnb`.`reviews`
ADD CONSTRAINT `fk_review_to_booking`
FOREIGN KEY (`booking_id`)
REFERENCES `airbnb`.`bookings` (`booking_id`);

ALTER TABLE `airbnb`.`listings_amenities`
ADD CONSTRAINT `fk_to_listing`
FOREIGN KEY (`id`)
REFERENCES `airbnb`.`listings` (`id`);

#adds all 0 to the amenity_id column in listings_amenties
-- ALTER TABLE `airbnb`.`listings_amenities`
-- ADD CONSTRAINT `fk_to_amenities`
-- FOREIGN KEY (`amenity_id`)
-- REFERENCES `airbnb`.`amenities` (`amenity_id`);

