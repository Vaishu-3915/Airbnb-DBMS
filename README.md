# Airbnb Database Management System

# Executive Summary:
## Project Goal:
The project aimed to:
- Build a robust database for Airbnb to consolidate all essential data in one place
- Enable efficient data querying for Airbnb's internal teams, facilitating in-depth analysis 
of the company's performance and growth

# Data Requirements:
A key requirement is the acquisition of all relevant transactional data and metadata, with an 
emphasis on ensuring the accuracy and correctness of this data. The required data includes: 
- Airbnb listings data
- Host details
- Neighbourhood details
- Reviews data
- Booking data

# Software and Database Technology Requirements:
For this project, MySQL was utilized to build and manage the relational databases, providing a 
range of querying facilities through SQL. MongoDB was also employed to construct a NoSQL 
database, suitable for data structures and sizes that were not adequately managed by a relational 
database and for scenarios where querying requirements were less complex.

# Data modeling and Implementation:
The initial step involved meticulous data cleaning to address any null or missing values, 
carefully done to maintain the integrity of data variance and other critical factors that could 
influence analytical outcomes. This was done to ensure high data quality, which is paramount for 
any level of data processing aimed at deriving insights. 
The database was designed to include detailed information on listings, hosts, properties, 
customers, bookings, and customer reviews. It was implemented in both SQL and NoSQL 
environments and crafted analytical queries yielding insights into revenue trends, room type 
popularity, neighborhood demand, and customer preferences. Besides the basic database 
functionality, we have enhanced our analytical capability by integrating the SQL database with 
Jupyter Notebook. Through this integration, we have been able to perform more advanced data 
visualizations as well as complex queries, further enhancing our insights into market trends and 
customer behavior

# Key Achievements:
- Identification of Revenue trends
- Understand popular customer choices in neighbourhoods, room types and amenities
- Identified the opportunities for growth of revenue and customer satisfaction in current 
listings
- Developed the tools necessary to establish benchmarks for future listings

# Recommendations:
- Tailor amenities to align with customer preferences
- Focus on most preferred neighbourhoods, price points, room types
- Implement custom strategies for short-term and long-term rentals
- Set listings standards for each neighbourhood and city to align with the preferences of 
customers in that area
- Improve low-rated listings to match with other similar listings in the neighbourhood to 
boost overall customer satisfaction
