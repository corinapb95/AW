<!-- with sales as (
    select
        sod.sales_order_id,
        sod.product_id,
        soh.customer_id,
        soh.territory_id,
        soh.store_id,
        sod.order_qty,
        sod.unit_price,
        sod.unit_price_discount,
        sod.tax_amt,
        soh.freight,
        (sod.unit_price - sod.unit_price_discount) * sod.order_qty as total_amount,
        soh.order_date
    from {{ ref('stg_aw_postgres__salesorderdetail') }} sod
    join {{ ref('stg_aw_postgres__salesorderheader') }} soh
        on sod.sales_order_id = soh.sales_order_id
)
select * from sales; -->