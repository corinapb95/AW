 with sales_order_header as (
    select 
        sales_order_id
        , bill_to_address_id
        , credit_card_id
        , customer_id
        , territory_id
        , sales_person_id
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
    , card as (
        select 
            credit_card_id
            , card_type
        from {{ ref('stg_aw_postgres__sales_creditcard') }}
)
    , joined_data as (
    select
        detail.sales_order_detail_id
        , header.sales_order_id
        , header.customer_id -- fk para a customer
        , CAST(header.territory_id AS STRING) as territory_id 
        , header.ship_method_id
        , header.order_date 
        , format_date('%Y%m%d', header.order_date) AS date_sk -- fk para date
        , detail.product_id -- fk para product
        , header.bill_to_address_id -- fk para address
        , card.card_type
        , header.sales_person_id
        , detail.special_offer_id
        , detail.order_qty
        , detail.unit_price
        , detail.unit_price_discount
        , header.freight
        , header.tax_amt
        , (detail.order_qty * detail.unit_price) as gross_sales
        , (detail.order_qty * detail.unit_price * detail.unit_price_discount) as total_discount
        , ((detail.order_qty * detail.unit_price) - (detail.order_qty * detail.unit_price * detail.unit_price_discount)) as net_sales
    from sales_order_detail detail
    left join sales_order_header header
        on detail.sales_order_id = header.sales_order_id
    left join card on header.credit_card_id = card.credit_card_id
)

select *
from joined_data
