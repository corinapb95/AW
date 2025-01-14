with stg_product as (
    select *
    from {{ ref('stg_aw_postgres__product') }}
),

stg_product_category as (
    select *
    from {{ ref('productcategory') }}
),

stg_product_subcategory as (
    select *
    from {{ ref('productsubcategory') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['stg_product.productid']) }} as product_key, 
    stg_product.product_id,
    stg_product_category.prod
    stg_product_subcategory.product_subcategory_id
    stg_product.name as product_name,
    stg_product.productnumber,
    stg_product.color,
    stg_product.class,
    stg_product_subcategory.name as product_subcategory_name,
    stg_product_category.name as product_category_name
    ... 
from stg_product
left join stg_product_subcategory on stg_product.productsubcategoryid = stg_product_subcategory.productsubcategoryid
left join stg_product_category on stg_product_subcategory.productcategoryid = stg_product_category.productcategoryid
