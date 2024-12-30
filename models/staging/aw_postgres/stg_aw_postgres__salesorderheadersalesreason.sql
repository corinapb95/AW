with 

source as (

    select * from {{ source('aw_postgres', 'salesorderheadersalesreason') }}

),

renamed as (

    select
        salesorderid as sales_order_id,
        modifieddate as modified_date,
        salesreasonid as sales_reason_id,
    from source

)

select * from renamed
