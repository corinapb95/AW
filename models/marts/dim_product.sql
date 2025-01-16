WITH stg_product AS (
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
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['stg_product.product_id']) }} AS product_key, -- Gera chave substituta
    pro.product_id,
    sub.product_subcategory_id,
    pro.name AS product_name,
    pro.productnumber AS product_number,
    pro.color,
    pro.class,
    sub.name AS product_subcategory_name,
    cat.name AS product_category_name
FROM stg_product as pro
LEFT JOIN stg_product_subcategory as sub
    ON pro .product_subcategory_id = sub.product_subcategory_id
LEFT JOIN stg_product_category as cat
    ON sub.product_category_id = cat.product_category_id
