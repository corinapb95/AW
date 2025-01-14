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
        {{ dbt_utils.generate_surrogate_key(['customer.customer_id']) }} AS customer_key,
        customer.customer_id,
        CONCAT(person.first_name, ' ', COALESCE(person.middle_name, ''), ' ', person.last_name) AS full_name,
        person.email_promotion,
        customer.modified_date,
        customer.territory_id,
        customer.store_id,
        customer.person_id,
        COALESCE(customer.territory_id, -1) AS territory_id, -- faz sentido?
        COALESCE(customer.store_id, -1) AS store_id
    from customer 
    left join person 
        on customer.person_id = person.person_id
)

select * from join_customer_data
