with 

source as (

    select * from {{ source('aw_postgres', 'humanresources_department') }}

),

renamed as (

    select
        departmentid as department_id,
        name as department_name,
        groupname as group_name,
        modifieddate as modified_date,
    from source

)

select * from renamed
