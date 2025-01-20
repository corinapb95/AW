with 

source as (

    select * from {{ source('aw_postgres', 'production_productcategory') }}

),

renamed as (

    select
        productcategoryid as product_category_id,
        name as category_name
    from source

)

select * from renamed
