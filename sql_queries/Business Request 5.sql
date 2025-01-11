-- Generate a report that identifies the month with the highest revenue for each city.
-- For each city, display the month_name, the revenue amount for that month, and the percentage contribution of that month's revenue to the city's total revenue.

WITH MonthlyRevenue AS (
    SELECT 
        c.city_name,
        MONTHNAME(t.date) AS month_name,
        SUM(t.fare_amount) AS total_revenue
    FROM 
        trips_db.fact_trips t
    INNER JOIN 
        trips_db.dim_city c 
    ON 
        t.city_id = c.city_id
    GROUP BY 
        c.city_name, MONTHNAME(t.date)
), 
CityMaxRevenue AS (
    SELECT 
        city_name,
        month_name AS highest_revenue_month,
        total_revenue AS revenue,
        MAX(total_revenue) OVER (PARTITION BY city_name) AS max_revenue,
        SUM(total_revenue) OVER (PARTITION BY city_name) AS all_revenue
    FROM 
        MonthlyRevenue
)
SELECT 
    city_name,
    highest_revenue_month,
    revenue,
    ROUND(revenue * 100.0 / all_revenue, 2) AS percentage_contribution
FROM 
    CityMaxRevenue
WHERE 
    revenue = max_revenue;
