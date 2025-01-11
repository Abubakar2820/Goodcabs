-- Generate a report that calculates two metrics:
-- 1. Monthly Repeat Passenger Rate: Calculate the repeat passenger rate for each city and month by comparing the
-- number of repeat passengers to the total passengers.
-- 2. City-wide Repeat Passenger Rate: Calculate the overall repeat passenger rate for each city, considering all passengers across months.

-- These metrics will provide insights into monthly repeat trends as well as the overall repeat behaviour for each city.


WITH passenger_counts AS (
    SELECT 
        c.city_name,
        MONTHNAME(s.month) AS month,
        SUM(s.total_passengers) AS total_passengers,
        SUM(s.repeat_passengers) AS repeat_passengers
    FROM fact_passenger_summary s
    JOIN dim_city c
        ON s.city_id = c.city_id
    GROUP BY c.city_name, MONTHNAME(s.month)
),
monthly_repeat_rate AS (
    SELECT 
        city_name,
        month,
        total_passengers,
        repeat_passengers,
        ROUND((repeat_passengers * 100.0) / total_passengers, 2) AS monthly_repeat_passenger_rate
    FROM passenger_counts
),
city_wide_repeat_rate AS (
    SELECT 
        city_name,
        SUM(total_passengers) AS total_city_passengers,
        SUM(repeat_passengers) AS total_city_repeat_passengers,
        ROUND((SUM(repeat_passengers) * 100.0) / SUM(total_passengers), 2) AS city_repeat_passenger_rate
    FROM passenger_counts
    GROUP BY city_name
)
SELECT 
    m.city_name,
    m.month,
    m.total_passengers,
    m.repeat_passengers,
    m.monthly_repeat_passenger_rate,
    c.city_repeat_passenger_rate
FROM monthly_repeat_rate m
JOIN city_wide_repeat_rate c
    ON m.city_name = c.city_name;
 
