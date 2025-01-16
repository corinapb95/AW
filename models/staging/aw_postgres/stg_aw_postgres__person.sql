with 

source as (

    select * from {{ source('aw_postgres', 'person_person') }}

),

renamed as (

    select
        businessentityid as business_entity_id,
        firstname as first_name,
        COALESCE(middlename, '') as middle_name ,
        lastname as last_name,
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
