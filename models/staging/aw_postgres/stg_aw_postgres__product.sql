with 

source as (

    select * from {{ source('aw_postgres', 'production_product') }}

),

renamed as (

    select
        class,
        COALESCE(color, 'Unknown') as color,
        daystomanufacture as days_to_smanufacture,
        finishedgoodsflag as finished_goods_flag,
        listprice as list_price,
        makeflag as make_flag,
        name as product_name,
        productid as product_id,
        productline as product_line,
        productmodelid as product_model_id,
        productnumber as product_number,
        productsubcategoryid as product_subcategory_id,
        reorderpoint as reorder_point,
        safetystocklevel as safety_stock_level,
        sellenddate as sell_end_date,
        sellstartdate as sell_start_date,
        size,
        sizeunitmeasurecode as size_unit_measure_code,
        standardcost as standard_cost,
        style,
        weight,
        weightunitmeasurecode as weight_unit_measure_code
    from source

)

select * from renamed
