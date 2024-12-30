with 

source as (

    select * from {{ source('aw_postgres', 'specialofferproduct') }}

),

renamed as (

    select
        specialofferid as special_offer_id,
        modifieddate as modified_date,
        rowguid,
        productid as product_id,
    from source

)

select * from renamed
