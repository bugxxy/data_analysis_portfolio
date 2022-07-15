Context

This dataset contains 119390 observations for a City Hotel and a Resort Hotel. Each observation represents a hotel booking between the 1st of July 2015 and 31st of August 2017, including booking that effectively arrived and booking that were canceled.
Content

Since this is hotel real data, all data elements pertaining hotel or costumer identification were deleted.
Four Columns, 'name', 'email', 'phone number' and 'credit_card' have been artificially created and added to the dataset.
Acknowledgements

The data is originally from the article Hotel Booking Demand Datasets, written by Nuno Antonio, Ana Almeida, and Luis Nunes for Data in Brief, Volume 22, February 2019.


SELECT *
FROM hotel_bookings_csv hbc ;

-- query to returns needed columns

SELECT hotel, arrival_date_year, arrival_date_month, arrival_date_week_number,
arrival_date_day_of_month, stays_in_weekend_nights, stays_in_week_nights, adr
from hotel_bookings_csv hbc ;

-- create a new table

create table hotel_details as
SELECT hotel, arrival_date_year, arrival_date_month, arrival_date_week_number,
arrival_date_day_of_month, stays_in_weekend_nights, stays_in_week_nights, adr
from hotel_bookings_csv hbc ;

-- query to view new table

select *
FROM hotel_details hd ;

-- query that returns the details of resort hotel

SELECT *
FROM hotel_bookings_csv hbc 
where hotel = 'Resort Hotel';

-- query to find total revenue for hotel

SELECT hotel, arrival_date_year, arrival_date_month, arrival_date_week_number,
arrival_date_day_of_month, (stays_in_weekend_nights + stays_in_week_nights)* adr as hotel_revenue
from hotel_details hd;

--query to find total revenue for each hotels from 2015 to 2017

SELECT hotel, arrival_date_year, sum((stays_in_weekend_nights + stays_in_week_nights)* adr) as hotel_revenue
from hotel_details hd
group by hotel,arrival_date_year 
order by hotel,arrival_date_year ;

-- query on parking SPACE 

SELECT hotel, arrival_date_year,arrival_date_month, sum(required_car_parking_spaces)
from hotel_bookings_csv hbc
group by hotel, arrival_date_year,arrival_date_month
order by hotel, arrival_date_year,arrival_date_month;

SELECT hotel, arrival_date_year, sum(required_car_parking_spaces)
from hotel_bookings_csv hbc
group by hotel, arrival_date_year
order by hotel, arrival_date_year;




