-- Generate a report that shows the percentage distribution of repeat passengers by the number of trips they have taken in each city.
-- Calculate the percentage of repeat passengers who took 2 trips, 3 trips, and so on, up to 10 trips.
-- Each column should represent a trip count category, displaying the percentage of repeat passengers who fall into that category out of the total repeat passengers for that city.
-- This report will help identify cities with high repeat trip frequency, which can indicate strong customer loyalty or frequent usage patterns.


SELECT 
    c.city_name,
    ROUND(
        SUM(CASE WHEN t.trip_count = '2-Trips' THEN t.repeat_passenger_count ELSE 0 END) * 100.0 
        / SUM(t.repeat_passenger_count), 2
    ) AS pct_2_trips,
    ROUND(
        SUM(CASE WHEN t.trip_count = '3-Trips' THEN t.repeat_passenger_count ELSE 0 END) * 100.0 
        / SUM(t.repeat_passenger_count), 2
    ) AS pct_3_trips,
    ROUND(
        SUM(CASE WHEN t.trip_count = '4-Trips' THEN t.repeat_passenger_count ELSE 0 END) * 100.0 
        / SUM(t.repeat_passenger_count), 2
    ) AS pct_4_trips,
    ROUND(
        SUM(CASE WHEN t.trip_count = '5-Trips' THEN t.repeat_passenger_count ELSE 0 END) * 100.0 
        / SUM(t.repeat_passenger_count), 2
    ) AS pct_5_trips,
    ROUND(
        SUM(CASE WHEN t.trip_count = '6-Trips' THEN t.repeat_passenger_count ELSE 0 END) * 100.0 
        / SUM(t.repeat_passenger_count), 2
    ) AS pct_6_trips,
    ROUND(
        SUM(CASE WHEN t.trip_count = '7-Trips' THEN t.repeat_passenger_count ELSE 0 END) * 100.0 
        / SUM(t.repeat_passenger_count), 2
    ) AS pct_7_trips,
    ROUND(
        SUM(CASE WHEN t.trip_count = '8-Trips' THEN t.repeat_passenger_count ELSE 0 END) * 100.0 
        / SUM(t.repeat_passenger_count), 2
    ) AS pct_8_trips,
    ROUND(
        SUM(CASE WHEN t.trip_count = '9-Trips' THEN t.repeat_passenger_count ELSE 0 END) * 100.0 
        / SUM(t.repeat_passenger_count), 2
    ) AS pct_9_trips,
    ROUND(
        SUM(CASE WHEN t.trip_count = '10-Trips' THEN t.repeat_passenger_count ELSE 0 END) * 100.0 
        / SUM(t.repeat_passenger_count), 2
    ) AS pct_10_trips
FROM 
    dim_repeat_trip_distribution t
JOIN 
    dim_city c
ON 
    t.city_id = c.city_id
GROUP BY 
    c.city_name;
