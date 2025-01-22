with 

source as (

    select * from {{ source('aw_postgres', 'sales_salesreason') }}

)

, renamed as (

    select
        salesreasonid as sales_reason_id
        , name as reason_name
        , reasontype as reason_type
        , modifieddate
    from source

)

select * from renamed
