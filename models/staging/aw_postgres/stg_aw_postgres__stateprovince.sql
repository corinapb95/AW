with 

source as (

    select * from {{ source('aw_postgres', 'stateprovince') }}

),

renamed as (

    select
        stateprovinceid as state_province_id,
        countryregioncode as country_region_code,
        modifieddate as modified_date,
        rowguid,
        name,
        territoryid as territory_id,
        isonlystateprovinceflag as is_only_state_province_flag,
        stateprovincecode as state_province_code
    from source

)

select * from renamed
