with employee as (
    select *
    from {{ ref('stg_aw_postgres__employee') }}
),

person as (
    select *
    from {{ ref('stg_aw_postgres__person') }}
),

department_history as (
    select *
    from {{ ref('stg_aw_postgres__employeedepartmenthistory') }}
),

department as (
    select *
    from {{ ref('stg_aw_postgres__department') }}
),

joined_data as (
    select 
        employee.business_entity_id AS employee_id
        , CONCAT(person.first_name, ' ', person.last_name) AS full_name
        , person.first_name
        , person.last_name
        , employee.job_title
        , employee.birth_date
        , employee.hire_date
        , dep_his.start_date
        , dep_his.end_date
        , COALESCE(dept.department_name, 'Unknown') AS department_name
        , dep_his.shift_id
    from employee 
    LEFT JOIN person
        ON employee.business_entity_id = person.business_entity_id
    LEFT JOIN department_history dep_his
        ON employee.business_entity_id = dep_his.business_entity_id
    LEFT JOIN department dept
        ON dep_his.department_id = dept.department_id
)

select * from joined_data