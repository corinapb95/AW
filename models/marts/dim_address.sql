with address as (
    select *
    from {{ ref('stg_aw_postgres__address') }}
),

stateprovince as (
    select *
    from {{ ref('stg_aw_postgres__stateprovince') }}
),

countryregion as (
    select *
    from {{ ref('stg_aw_postgres__countryregion') }}
),

join_address_stateprovince_and_countryregion as (
    select 
        {{ dbt_utils.generate_surrogate_key(['addr.address_id']) }} AS address_key,
        addr.address_id,
        addr.address_line_1,
        addr.address_line_2,
        addr.city,
        sp.state_province_id,
        sp.state_province_code,
        sp.name AS state_province_name,
        cr.country_region_code,
        cr.name AS country_region_name,
        addr.postal_code
    FROM address addr
    LEFT JOIN stateprovince sp
        ON addr.state_province_id = sp.state_province_id
    LEFT JOIN countryregion cr
        ON sp.country_region_code = cr.country_region_code
)

select * from join_address_stateprovince_and_countryregion

