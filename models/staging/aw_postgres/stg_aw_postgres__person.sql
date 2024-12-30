with 

source as (

    select * from {{ source('aw_postgres', 'person') }}

),

renamed as (

    select
        businessentityid as business_entity_id,
        first_name,
        middle_name,
        last_name,
        title,
        suffix,
        emailpromotion as email_promotion,
        persontype as person_type,
        namestyle as name_style,
        modifieddate as modified_date,
        rowguid
    from source

)

select * from renamed
