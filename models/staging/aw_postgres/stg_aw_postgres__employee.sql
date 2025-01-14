with 

source as (

    select * from {{ source('aw_postgres', 'humanresources_employee') }}

),

renamed as (

    select
        businessentityid as business_entity_id,
        rowguid,
        loginid as login_id,
        nationalidnumber as national_id_number,
        birthdate as birth_date,
        hiredate as hire_date,
        modifieddate as modified_date,
        currentflag as current_flag,
        salariedflag as salaried_flag,
        maritalstatus as marital_status,
        gender,
        jobtitle as job_title,
        organizationnode as organization_node,
        sickleavehours as sick_leave_hours,
        vacationhours as vacation_hours
    from source

)

select * from renamed
