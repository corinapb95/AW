with 

source as (

    select * from {{ source('aw_postgres', 'sales_customer') }}

),

renamed as (

    select
        personid as person_id,
        modifieddate as modified_date,
        rowguid,
        territoryid as territory_id,
        storeid as store_id,
        customerid as customer_id,
    from source

)

select * from renamed
