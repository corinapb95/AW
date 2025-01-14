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
        {{ dbt_utils.generate_surrogate_key(['customer.customer_id']) }} as product_key, 
        customer.customer_id,
        person.first_name,
        person.middle_name,
        person.last_name,
        person.email_promotion,
        customer.modified_date
    from customer 
    left join person 
        on customer.person_id = person.person_id
)

select * from join_customer_data
