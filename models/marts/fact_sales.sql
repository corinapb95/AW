 with sales_order_header as (
    select 
        sales_order_id
        , customer_id
        , territory_id
        , ship_method_id
        , order_date
        , total_due
        , freight
        , tax_amt
    from {{ ref('stg_aw_postgres__salesorderheader') }}
)
    , sales_order_detail as (
    select 
        sales_order_detail_id
        , sales_order_id
        , product_id
        , special_offer_id
        , order_qty
        , unit_price
        , unit_price_discount
    from {{ ref('stg_aw_postgres__salesorderdetail') }}
)
    , joined_data as (
    select
        d.sales_order_detail_id
        , h.sales_order_id
        , h.customer_id -- fk para a customer
        , CAST(h.territory_id AS STRING) as territory_id 
        , h.ship_method_id
        , h.order_date 
        , to_varchar(date(h.order_date), 'YYYYMMDD') AS date_sk -- fk para date
        , d.product_id -- fk para product
        , h.bill_to_address_id -- fk para address
        , d.special_offer_id
        , d.order_qty
        , d.unit_price
        , d.unit_price_discount
        , h.freight
        , h.tax_amt
        , (d.order_qty * d.unit_price) as gross_sales
        , (d.order_qty * d.unit_price * d.unit_price_discount) as total_discount
        , ((d.order_qty * d.unit_price) - (d.order_qty * d.unit_price * d.unit_price_discount)) as net_sales
    from sales_order_detail d
    left join sales_order_header h
        on d.sales_order_id = h.sales_order_id
)

select *
from joined_data

-- fk para employee