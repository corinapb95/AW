with 

source as (

    select * from {{ source('aw_postgres', 'customer') }}

),

renamed as (

    select
        personid as person_id,
        date(modifieddate) as modified_date, --converte para yyyy-mm-dd
        rowguid,
        territoryid as territory_id,
        storeid as store_id,
        customerid as customer_id,
    from source

)

select * from renamed
