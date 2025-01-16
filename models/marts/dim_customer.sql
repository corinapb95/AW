with customer as (
    select *
    from {{ ref('stg_aw_postgres__customer') }}
),

person as (
    select *
    from {{ ref('stg_aw_postgres__person') }}
),

join_customer_data as (
    select    
    -- ?? faz sentido a customer_key ??
        TO_HEX(MD5(CAST(COALESCE(CAST(customer.customer_id AS STRING), '_dbt_utils_surrogate_key_null_') AS STRING))) AS customer_key,
        customer.customer_id,
        CONCAT(person.first_name, ' ', person.middle_name, ' ', person.last_name) AS full_name,
        person.email_promotion,
        customer.modified_date,
        customer.territory_id,
        customer.store_id,
    from customer 
    left join person 
        on customer.person_id = person.business_entity_id
)

select * from join_customer_data
