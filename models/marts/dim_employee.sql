WITH 

employee AS (
    SELECT *
    FROM {{ ref('stg_aw_postgres__employee') }}
),

person AS (
    SELECT
        person_id,
        first_name,
        last_name,
        email_address
    FROM {{ ref('stg_aw_postgres__person') }}
),

department AS (
    SELECT
        department_id,
        name AS department_name
    FROM {{ ref('stg_aw_postgres__department') }}
),

join_employee_data AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['e.business_entity_id']) }} AS employee_key,
        e.business_entity_id AS employee_id,
        e.job_title,
        CONCAT(p.first_name, ' ', p.last_name) AS full_name,
        p.email_address,
        e.birth_date,
        e.hire_date,
        d.department_name
    FROM employee e
    LEFT JOIN person p
        ON e.business_entity_id = p.person_id
    LEFT JOIN department d
        ON dh.department_id = d.department_id
)

SELECT 
    employee_key,
    employee_id,
    full_name,
    first_name,
    last_name,
    email_address,
    job_title,
    birth_date,
    hire_date,
    department_name
FROM join_employee_data;
