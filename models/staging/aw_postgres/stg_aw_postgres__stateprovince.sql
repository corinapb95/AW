with 

source as (

    select * from {{ source('aw_postgres', 'stateprovince') }}

),

renamed as (

    select
        stateprovinceid,
        countryregioncode,
        modifieddate,
        rowguid,
        name,
        _sdc_table_version,
        territoryid,
        _sdc_received_at,
        _sdc_sequence,
        isonlystateprovinceflag,
        _sdc_batched_at,
        stateprovincecode

    from source

)

select * from renamed
