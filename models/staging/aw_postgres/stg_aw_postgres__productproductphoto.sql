with 

source as (

    select * from {{ source('aw_postgres', 'productproductphoto') }}

),

renamed as (

    select
        modifieddate,
        productphotoid,
        productid,
        primary,
        _sdc_sequence,
        _sdc_table_version,
        _sdc_received_at,
        _sdc_batched_at

    from source

)

select * from renamed
