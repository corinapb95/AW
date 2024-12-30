with 

source as (

    select * from {{ source('aw_postgres', 'salesreason') }}

),

renamed as (

    select
        reasontype,
        modifieddate,
        name,
        salesreasonid,
        _sdc_sequence,
        _sdc_table_version,
        _sdc_received_at,
        _sdc_batched_at

    from source

)

select * from renamed
