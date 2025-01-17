with sales_order_header as (
    select 
        sales_order_id,
        customer_id,
        territory_id,
        ship_method_id,
        CAST(order_date as DATE) as order_date,
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
),

joined_data as (
    select
        d.sales_order_detail_id,
        d.sales_order_id,
        h.customer_id,
        h.territory_id,
        h.ship_method_id,
        h.order_date,
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
    LEFT JOIN sales_order_header h
        ON d.sales_order_id = h.sales_order_id
),

enriched_data as (
    select
        j.sales_order_detail_id,
        j.sales_order_id,
        c.customer_key as customer_key,
        p.product_key as product_key,
        d.date_key as order_date_key,
        a.address_key as ship_to_address_key,
        -- e.employee_key as sales_person_key, -- Removido ou descomentado se necessário
        j.territory_id,
        j.ship_method_id,
        j.product_id,
        j.special_offer_id,
        j.order_qty,
        j.unit_price,
        j.unit_price_discount,
        j.gross_sales,
        j.total_discount,
        j.net_sales,
        j.freight,
        j.tax_amt
    from joined_data j
    LEFT JOIN {{ ref('dim_customer') }} c
        ON j.customer_id = c.customer_id
    LEFT JOIN {{ ref('dim_product') }} p
        ON j.product_id = p.product_id
    LEFT JOIN {{ ref('dim_date') }} d
        ON CAST(j.order_date AS DATE) = CAST(d.date AS DATE)
    LEFT JOIN {{ ref('dim_address') }} a
        ON CAST(j.territory_id AS STRING) = a.address_key
)

select *
from enriched_data
