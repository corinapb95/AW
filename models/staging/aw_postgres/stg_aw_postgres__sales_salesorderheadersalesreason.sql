with 

source as (

    select * from {{ source('aw_postgres', 'sales_salesorderheadersalesreason') }}

)

, renamed as (

    select
        salesorderid as order_id
        , salesreasonid as sales_reason_id
    from source

)

select * from renamed