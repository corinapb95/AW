with 

source as (

    select * from {{ source('aw_postgres', 'customer') }}

),

renamed as (

    select
        personid,
        modifieddate,
        rowguid,
        _sdc_table_version,
        territoryid,
        _sdc_received_at,
        _sdc_sequence,
        storeid,
        customerid,
        _sdc_batched_at

    from source

)

select * from renamed
