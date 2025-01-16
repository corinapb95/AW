WITH 

employee AS (
    SELECT *
    FROM {{ ref('stg_aw_postgres__employee') }}
),

person AS (
    SELECT
        business_entity_id AS person_id, -- Certifique-se de que "person_id" corresponde à coluna correta
        first_name,
        last_name
    FROM {{ ref('stg_aw_postgres__person') }}
),

department AS (
    SELECT
        department_id,
        department_name AS department_name
    FROM {{ ref('stg_aw_postgres__department') }}
),

join_employee_data AS (
    SELECT
        TO_HEX(MD5(CAST(COALESCE(CAST(e.business_entity_id AS STRING), '_dbt_utils_surrogate_key_null_') AS STRING))) AS employee_key,
        e.business_entity_id AS employee_id,
        e.job_title,
        p.first_name,
        p.last_name,
        CONCAT(p.first_name, ' ', p.last_name) AS full_name,
        e.birth_date,
        e.hire_date,
        d.department_name
    FROM employee e
    LEFT JOIN person p
        ON e.business_entity_id = p.person_id -- Garantir que person_id está correto
    LEFT JOIN department d
        ON e.department_id = d.department_id -- Certificar-se de que "department_id" existe em employee
)

SELECT 
    employee_key,
    employee_id,
    full_name,
    first_name,
    last_name,
    job_title,
    birth_date,
    hire_date,
    department_name
FROM join_employee_data
