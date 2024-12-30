with 

source as (

    select * from {{ source('aw_postgres', 'employee') }}

),

renamed as (

    select
        nationalidnumber,
        sickleavehours,
        loginid,
        currentflag,
        modifieddate,
        rowguid,
        gender,
        hiredate,
        _sdc_table_version,
        _sdc_received_at,
        _sdc_sequence,
        salariedflag,
        birthdate,
        maritalstatus,
        organizationnode,
        businessentityid,
        vacationhours,
        _sdc_batched_at,
        jobtitle

    from source

)

select * from renamed
