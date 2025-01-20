with 

source as (

    select * from {{ source('aw_postgres', 'person_address') }}

),

renamed as (

    select
        stateprovinceid as state_province_id,
        city,
        postalcode as postal_code,
        spatiallocation as spatial_location,
        addressline1 as address_line_1,
        COALESCE(addressline2, '')  as address_line_2,
        addressid as address_id
    from source

)

select * from renamed
