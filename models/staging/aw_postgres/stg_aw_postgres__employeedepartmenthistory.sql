with 

source as (

    select * from {{ source('aw_postgres', 'humanresources_employeedepartmenthistory') }}

),

renamed AS (
    SELECT
        businessentityid AS business_entity_id,
        startdate AS start_date,
        enddate AS end_date,
        departmentid AS department_id,
        shiftid AS shift_id
    FROM source
)

SELECT *
FROM renamed