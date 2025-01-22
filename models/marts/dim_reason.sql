with sales_reason_bridge as (
    select
        order_id
        , sales_reason_id
    from {{ ref('stg_aw_postgres__sales_salesorderheadersalesreason') }}
)

, sales_reason as (
    select 
        reason_type
        , reason_name
        , sales_reason_id
    from {{ ref('stg_aw_postgres__salesreason') }}
)

, reason as (
    select 
        bridge.order_id 
        , bridge.sales_reason_id
        , reason.reason_name
        , reason.reason_type
    from sales_reason_bridge as bridge
    join sales_reason as reason 
        on reason.sales_reason_id = bridge.sales_reason_id
)

select * from reason 