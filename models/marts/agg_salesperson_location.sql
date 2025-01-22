with fact_sales as (
    select *
    from {{ ref('fact_sales') }}
),
address_data as (
    select 
        address_id,
        state_province_name,
        country_region_name
    from {{ ref('dim_address') }}
),
employee_data as (
    select 
       employee_id,
       full_name as employee_name,
       department_name
    from {{ ref('dim_employee') }}
),
joined_agg_data as (
    select 
        f.territory_id,
        a.state_province_name as region,
        a.country_region_name as country,
        e.employee_name,
        e.department_name,
        sum(f.net_sales) as total_sales,
        sum(f.gross_sales) as total_gross_sales,
        sum(f.total_discount) as total_discounts,
        count(distinct f.sales_order_id) as total_orders
    from fact_sales f
    left join address_data a
        on f.bill_to_address_id = a.address_id
    left join employee_data e
        on f.sales_person_id = e.employee_id
    group by 
        f.territory_id,
        a.state_province_name,
        a.country_region_name,
        e.employee_name,
        e.department_name
)

select * 
from joined_agg_data
