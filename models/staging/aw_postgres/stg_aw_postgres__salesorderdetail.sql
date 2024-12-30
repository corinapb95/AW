with 

source as (

    select * from {{ source('aw_postgres', 'salesorderdetail') }}

),

renamed as (

    select
        carriertrackingnumber as carrier_tracking_number,
        modifieddate as modified_date,
        orderqty as order_qty,
        productid as product_id,
        rowguid,
        salesorderdetailid as sales_order_detail_id,
        salesorderid as sales_order_id,
        specialofferid as special_offer_id,
        unitprice as unit_price,
        unitpricediscount as unit_price_discount
    from source

)

select * from renamed
