WITH distinct_dates AS (
    SELECT DISTINCT CAST(order_date AS DATE) AS date
    FROM {{ ref('stg_aw_postgres__salesorderheader') }}
),

dates AS (
    SELECT
        CAST(date AS DATE) AS date,                  
        CAST(FORMAT_DATE('%Y%m%d', date) AS INTEGER) AS date_key,
        EXTRACT(YEAR FROM date) AS year,            
        EXTRACT(MONTH FROM date) AS month,         
        FORMAT_DATE('%B', date) AS month_name,      
        EXTRACT(DAY FROM date) AS day,             
        EXTRACT(DAYOFWEEK FROM date) AS day_of_week,      
        FORMAT_DATE('%A', date) AS day_name,               
        EXTRACT(QUARTER FROM date) AS quarter,      
        EXTRACT(WEEK FROM date) AS week_of_year,   
        CASE 
            WHEN EXTRACT(DAYOFWEEK FROM date) IN (1, 7) THEN TRUE
            ELSE FALSE
        END AS is_weekend                          
    FROM distinct_dates
)

SELECT *
FROM dates
ORDER BY date