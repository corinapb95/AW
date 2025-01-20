with 

source as (

    select * from {{ source('aw_postgres', 'sales_salesperson') }}

),

renamed as (

    select
        salesquota as sales_quota,
        saleslastyear as sales_last_year,
        commissionpct as comission_pct,
        territoryid as territory_id,
        bonus,
        businessentityid as business_entity_id,
        salesytd as sales_ytd
    from source

)

select * from renamed
