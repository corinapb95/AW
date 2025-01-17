with enriched_data as (
    select
        j.sales_order_detail_id,
        j.sales_order_id,
        c.customer_key as customer_key,
        p.product_key as product_key,
        d.date_key as order_date_key,
        a.address_key as ship_to_address_key,
        -- e.employee_key as sales_person_key, -- Descomentar se necessário
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
    from {{ ref('int_sales_order') }} j
    left join {{ ref('dim_customer') }} c
        on j.customer_id = c.customer_id
    left join {{ ref('dim_product') }} p
        on j.product_id = p.product_id
    left join {{ ref('dim_date') }} d
        on j.order_date = d.date
    left join {{ ref('dim_address') }} a
        on j.territory_id = a.address_key
)

select *
from enriched_data
