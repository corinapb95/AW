with 

source as (

    select * from {{ source('aw_postgres', 'sales_salesterritory') }}

)

, renamed as (

    select
        territoryid as territory_id
        , name as territory_name
        , countryregioncode as country_region_code
        , `group` AS continent
        , salesytd as sales_ytd
        , saleslastyear as sales_last_year
        , costytd as cost_ytd
        , costlastyear as cost_last_year
    from source

)

select * from renamed
