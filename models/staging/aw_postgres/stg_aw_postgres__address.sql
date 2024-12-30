with 

source as (

    select * from {{ source('aw_postgres', 'address') }}

),

renamed as (

    select
        stateprovinceid,
        city,
        addressline2,
        modifieddate,
        rowguid,
        _sdc_table_version,
        postalcode,
        spatiallocation,
        _sdc_received_at,
        _sdc_sequence,
        addressline1,
        _sdc_batched_at,
        addressid

    from source

)

select * from renamed
