with 

source as (

    select * from {{ source('aw_postgres', 'sales_salesreason') }}

)

, renamed as (

    select
        reasontype as reason_type
        , name as reason_name
        , salesreasonid as sales_reason_id
    from source

)

select * from renamed
