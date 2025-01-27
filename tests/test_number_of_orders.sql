with 
    orderline as (
        select *
        from {{ ref('fact_sales') }}
    )
, query_test as (
    select 
        count(distinct sales_order_id) as num_orders
    from orderline
)
, test as (
    select 
        *
    from query_test  
    where num_orders != 31465
)

select * from test