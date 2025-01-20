with 

source as (

    select * from {{ source('aw_postgres', 'sales_store') }}

),

renamed as (

    select
        businessentityid as business_entity_id,
        name as store_name,
        salespersonid as sales_person_id,
        demographics
    from source

)

select * from renamed
