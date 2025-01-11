WITH TotalPassengersSummary AS (
    SELECT 
        c.city_name,
        SUM(p.new_passengers) AS total_new_passengers
    FROM 
        fact_passenger_summary p
    JOIN 
        dim_city c 
    ON 
        p.city_id = c.city_id
    GROUP BY 
        c.city_name
), 
RankCities AS (
    SELECT 
        city_name,
        total_new_passengers,
        RANK() OVER(ORDER BY total_new_passengers DESC) AS rank_high,
        RANK() OVER(ORDER BY total_new_passengers ASC) AS rank_low
    FROM 
        TotalPassengersSummary
)
SELECT 
    city_name,
    total_new_passengers,
    CASE
        WHEN rank_high <= 3 THEN 'Top 3'
        WHEN rank_low <= 3 THEN 'Bottom 3'
        ELSE NULL
    END AS city_category
FROM 
    RankCities
WHERE 
    rank_high <= 3 OR rank_low <= 3
ORDER BY 
	total_new_passengers DESC;
