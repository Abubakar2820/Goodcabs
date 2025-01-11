WITH Target AS (
    SELECT 
        city_id,
        MONTHNAME(month) AS month_name,
        total_target_trips AS target_trips
    FROM 
        targets_db.monthly_target_trips
), 
Actual AS (
    SELECT 
        city_id,
        MONTHNAME(date) AS month_name,
        COUNT(trip_id) AS actual_trips
    FROM 
        trips_db.fact_trips
    GROUP BY 
        city_id, month_name
)
SELECT 
    c.city_name,
    t.month_name,
    a.actual_trips,
    t.target_trips,
    CASE
        WHEN a.actual_trips > t.target_trips THEN 'Above_Target'
        ELSE 'Below_Target'
    END AS performance_status,
    ROUND((a.actual_trips - t.target_trips) * 100.0 / t.target_trips, 2) AS pct_difference
FROM 
    Target t
JOIN 
    Actual a 
ON 
    t.city_id = a.city_id 
    AND t.month_name = a.month_name
JOIN 
    dim_city c 
ON 
    t.city_id = c.city_id;
