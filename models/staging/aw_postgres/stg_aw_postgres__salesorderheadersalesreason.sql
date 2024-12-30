with 

source as (

    select * from {{ source('aw_postgres', 'salesorderheadersalesreason') }}

),

renamed as (

    select
        salesorderid,
        modifieddate,
        salesreasonid,
        _sdc_sequence,
        _sdc_table_version,
        _sdc_received_at,
        _sdc_batched_at

    from source

)

select * from renamed
