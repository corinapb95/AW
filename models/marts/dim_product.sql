with stg_product as (
    select *
    from {{ ref('stg_aw_postgres__product') }}
)
, stg_product_category as (
    select *
    from {{ ref('stg_aw_postgres__productcategory') }}
)
, stg_product_subcategory as (
    select *
    from {{ ref('stg_aw_postgres__productsubcategory') }}
)
, join_product_data as (
    select
        pro.product_id
        , pro.product_name
        , sub.product_subcategory_id
        , pro.product_number
        , pro.make_flag
        , pro.finished_goods_flag
        , pro.safety_stock_level
        , pro.reorder_point
        , pro.standard_cost
        , pro.list_price
        , pro.product_model_id
        , pro.days_to_smanufacture
        , pro.sell_start_date
        , pro.color
        , pro.class
        , sub.subcategory_name as product_subcategory_name
        , cat.category_name as product_category_name
    from stg_product as pro
    left join stg_product_subcategory as sub
        on pro.product_subcategory_id = sub.product_subcategory_id
    left join stg_product_category as cat
        on sub.product_category_id = cat.product_category_id
)

select * from join_product_data
