with distinct_dates as (
    select distinct cast(order_date AS date) as date
    from {{ ref('stg_aw_postgres__salesorderheader') }}
)
    , dates as (
    select
        cast(date as date) as date,                  
        cast(format_date('%Y%m%d', date) as integer) as date_key,
        extract(year from date) as year,            
        extract(month from date) as month,         
        format_date('%B', date) as month_name,      
        extract(DAY from date) as day,             
        extract(dayofweek from date) as day_of_week,      
        format_date('%A', date) as day_name,               
        extract(quarter from date) as quarter,      
        extract(week from date) as week_of_year,   
        case 
            when extract(dayofweek from date) in (1, 7) then true
            else false
        end as is_weekend                          
    from distinct_dates
)

select *
from dates
order by date