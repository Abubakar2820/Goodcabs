-- Generate a report that displays the total trips, average fare per km, average fare per trip
-- and the percentage contribution of each city's trips  to the overall trips. 
-- This report will help in assessing trip volume, pricing efficiency, and each city's contribution to the overall trip count.

WITH TotalTrips AS (
    SELECT 
        c.city_name AS city_name,
        t.city_id AS city_id,
        COUNT(t.trip_id) AS total_trips_count,
        SUM(t.fare_amount) AS total_fare_amount,
        SUM(t.distance_travelled_km) AS total_distance_travelled
    FROM 
        fact_trips t
    JOIN 
        dim_city c
    ON 
        t.city_id = c.city_id
    GROUP BY 
        t.city_id, c.city_name
), 
TripFare AS (
    SELECT 
        city_name,
        total_trips_count,
        ROUND((total_fare_amount / total_distance_travelled),2) AS avg_fare_per_km,
        ROUND((total_fare_amount / total_trips_count),2) AS avg_fare_per_trip
    FROM 
        TotalTrips
)
SELECT 
    *,
    ROUND((total_trips_count * 100.0 / SUM(total_trips_count) OVER ()),2) AS pct_contribution_to_total_trips
FROM 
    TripFare;
