with 

source as (

    select * from {{ source('aw_postgres', 'salesorderdetail') }}

),

renamed as (

    select
        orderqty,
        salesorderid,
        salesorderdetailid,
        unitprice,
        specialofferid,
        modifieddate,
        rowguid,
        _sdc_table_version,
        productid,
        _sdc_received_at,
        _sdc_sequence,
        _sdc_batched_at,
        carriertrackingnumber,
        unitpricediscount

    from source

)

select * from renamed
