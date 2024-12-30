with 

source as (

    select * from {{ source('aw_postgres', 'countryregion') }}

),

renamed as (

    select
        countryregioncode as country_region_code,
        date(modifieddate) as modified_date, --converte para yyyy-mm-dd
        name
    from source

)

select * from renamed
