with 

source as (

    select * from {{ source('aw_postgres', 'specialofferproduct') }}

),

renamed as (

    select
        specialofferid,
        modifieddate,
        rowguid,
        productid,
        _sdc_sequence,
        _sdc_table_version,
        _sdc_received_at,
        _sdc_batched_at

    from source

)

select * from renamed
