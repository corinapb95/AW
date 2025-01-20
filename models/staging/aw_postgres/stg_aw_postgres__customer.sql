with 

source as (

    select * from {{ source('aw_postgres', 'sales_customer') }}

),

renamed as (

    select
        personid as person_id,
        COALESCE(territoryid, -1) as territory_id,
        COALESCE(storeid, -1) as store_id,
        customerid as customer_id
    from source

)

select * from renamed
