with 

source as (

    select * from {{ source('aw_postgres', 'production_productsubcategory') }}

)

, renamed as (

    select
        productsubcategoryid as product_subcategory_id
        , productcategoryid as product_category_id
        , name as subcategory_name
    from source

)

select * from renamed
