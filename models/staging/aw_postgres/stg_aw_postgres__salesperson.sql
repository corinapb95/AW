with 

source as (

    select * from {{ source('aw_postgres', 'salesperson') }}

),

renamed as (

    select
        salesquota,
        modifieddate,
        rowguid,
        saleslastyear,
        commissionpct,
        _sdc_table_version,
        territoryid,
        bonus,
        _sdc_received_at,
        _sdc_sequence,
        businessentityid,
        _sdc_batched_at,
        salesytd

    from source

)

select * from renamed
