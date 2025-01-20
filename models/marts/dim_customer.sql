with customer as (
    select *
    from {{ ref('stg_aw_postgres__customer') }}
)

    , person as (
        select *
        from {{ ref('stg_aw_postgres__person') }}
)
    , store as ( 
        select *
        from {{ ref('stg_aw_postgres__sales_store') }}
    
)
    , join_customer_data as (
    select    
        customer.customer_id
        , customer.person_id
        , CONCAT(person.first_name, ' ', person.middle_name, ' ', person.last_name) AS full_name
        , person.email_promotion
        , customer.territory_id
        , customer.store_id
        , store.store_name
    from customer 
    left join person 
        on customer.person_id = person.business_entity_id
    left join store 
        on customer.customer_id = store.business_entity_id

)

select * from join_customer_data
