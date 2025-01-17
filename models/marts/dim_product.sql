WITH 
stg_product AS (
    SELECT *
    FROM {{ ref('stg_aw_postgres__product') }}
),

stg_product_category AS (
    SELECT *
    FROM {{ ref('stg_aw_postgres__productcategory') }}
),

stg_product_subcategory AS (
    SELECT *
    FROM {{ ref('stg_aw_postgres__productsubcategory') }}
),

join_product_data AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['pro.product_id']) }} AS product_key,
        pro.product_id,
        sub.product_subcategory_id,
        pro.name AS product_name,
        pro.product_number,
        pro.color,
        pro.class,
        sub.subcategory_name AS product_subcategory_name,
        cat.category_name AS product_category_name
    FROM stg_product AS pro
    LEFT JOIN stg_product_subcategory AS sub
        ON pro.product_subcategory_id = sub.product_subcategory_id
    LEFT JOIN stg_product_category AS cat
        ON sub.product_category_id = cat.product_category_id
)

SELECT 
    product_key,
    product_id,
    product_name,
    product_number,
    color,
    class,
    product_subcategory_name,
    product_category_name
FROM join_product_data
