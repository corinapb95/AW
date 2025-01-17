with sales_order_header as (
    select 
        sales_order_id,
        customer_id,
        territory_id,
        ship_method_id,
        order_date,
        total_due,
        freight,
        tax_amt
    from {{ ref('stg_aw_postgres__salesorderheader') }}
),

sales_order_detail as (
    select 
        sales_order_detail_id,
        sales_order_id,
        product_id,
        special_offer_id,
        order_qty,
        unit_price,
        unit_price_discount,
        (order_qty * unit_price) as gross_sales, 
        (order_qty * unit_price * unit_price_discount) as total_discount, 
        ((order_qty * unit_price) - (order_qty * unit_price * unit_price_discount)) as net_sales
    from {{ ref('stg_aw_postgres__salesorderdetail') }}
)

select
    d.sales_order_detail_id,
    d.sales_order_id,
    h.customer_id,
    CAST(h.territory_id AS STRING) as territory_id,
    h.ship_method_id,
    order_date,
    d.product_id,
    d.special_offer_id,
    d.order_qty,
    d.unit_price,
    d.unit_price_discount,
    d.gross_sales,
    d.total_discount,
    d.net_sales,
    h.freight,
    h.tax_amt
from sales_order_detail d
left join sales_order_header h
    on d.sales_order_id = h.sales_order_id
