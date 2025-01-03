with 

source as (

    select * from {{ source('aw_postgres', 'countryregion') }}

),

renamed as (

    select
        countryregioncode as country_region_code,
        modifieddate as modified_date,
        name
    from source

)

select * from renamed
