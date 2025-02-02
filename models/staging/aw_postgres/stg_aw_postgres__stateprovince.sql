with 

source as (

    select * from {{ source('aw_postgres', 'person_stateprovince') }}

)

, renamed as (

    select
        stateprovinceid as state_province_id
        , countryregioncode as country_region_code
        , name
        , territoryid as territory_id
        , isonlystateprovinceflag as is_only_state_province_flag
        , stateprovincecode as state_province_code
    from source

)

select * from renamed
