WITH sales_order_header AS (
    SELECT 
        sales_order_id,
        customer_id,
        territory_id,
        ship_method_id,
        CAST(order_date AS DATE) AS order_date,
        total_due,
        freight,
        tax_amt
    FROM {{ ref('stg_aw_postgres__salesorderheader') }}
),

sales_order_detail AS (
    SELECT 
        sales_order_detail_id,
        sales_order_id,
        product_id,
        special_offer_id,
        order_qty,
        unit_price,
        unit_price_discount,
        (order_qty * unit_price) AS gross_sales, 
        (order_qty * unit_price * unit_price_discount) AS total_discount, 
        ((order_qty * unit_price) - (order_qty * unit_price * unit_price_discount)) AS net_sales
    FROM {{ ref('stg_aw_postgres__salesorderdetail') }}
),

joined_data AS (
    SELECT
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
    FROM sales_order_detail d
    LEFT JOIN sales_order_header h
        ON d.sales_order_id = h.sales_order_id
),

enriched_data AS (
    -- Adiciona chaves para dimensões
    SELECT
        j.sales_order_detail_id,
        j.sales_order_id,
        {{ ref('dim_customer') }}.customer_key AS customer_key,
        {{ ref('dim_product') }}.product_key AS product_key,
        {{ ref('dim_date') }}.date_key AS order_date_key,
        {{ ref('dim_address') }}.address_key AS ship_to_address_key,
        {{ ref('dim_employee') }}.employee_key AS sales_person_key,
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
        j.tax_amt,
        CURRENT_TIMESTAMP() AS load_date
    FROM joined_data j
    LEFT JOIN {{ ref('dim_customer') }} c
        ON j.customer_id = c.customer_id
    LEFT JOIN {{ ref('dim_product') }} p
        ON j.product_id = p.product_id
    LEFT JOIN {{ ref('dim_date') }} d
        ON CAST(j.order_date AS DATE) = d.date
)

SELECT *
FROM enriched_data;