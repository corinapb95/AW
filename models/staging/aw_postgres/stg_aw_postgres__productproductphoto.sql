with 

source as (

    select * from {{ source('aw_postgres', 'productproductphoto') }}

),

renamed as (

    select
        modifieddate as modified_date,
        productphotoid as product_photo_id,
        productid as product_id,
        primary,
    from source

)

select * from renamed
