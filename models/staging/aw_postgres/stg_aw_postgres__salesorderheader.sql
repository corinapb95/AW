with 

source as (

    select * from {{ source('aw_postgres', 'sales_salesorderheader') }}

)

, renamed as (

    select
        accountnumber as account_number
        , billtoaddressid as bill_to_address_id
        , creditcardapprovalcode as credit_card_approval_code
        , creditcardid as credit_card_id
        , currencyrateid as currency_rate_id
        , customerid as customer_id
        , duedate as due_date
        , freight
        , onlineorderflag as online_order_flag
        , CAST(orderdate as DATE) as order_date
        , purchaseordernumber as purchase_order_number
        , revisionnumber as revision_number
        , salesorderid as sales_order_id
        , salespersonid as sales_person_id
        , shipdate as ship_date
        , shipmethodid as ship_method_id
        , shiptoaddressid as ship_address_id
        , status
        , subtotal
        , taxamt as tax_amt
        , territoryid as territory_id
        , totaldue as total_due
    from source

)

select * from renamed
