-- Create table
create table JOB_HISTORY
(
    employee_id   NUMBER(6),
    start_date    DATE,
    end_date      DATE,
    job_id        VARCHAR2(10),
    department_id NUMBER(4)
);
-- Add comments to the table
comment on table JOB_HISTORY
  is 'Table that stores job history of the employees. If an employee
changes departments within the job or changes jobs within the department,
new rows get inserted into this table with old job information of the
employee. Contains a complex primary key: employee_id+start_date.
Contains 25 rows. References with jobs, employees, and departments tables.';
-- Add comments to the columns
comment on column JOB_HISTORY.employee_id
  is 'A not null column in the complex primary key employee_id+start_date.
Foreign key to employee_id column of the employee table';
comment on column JOB_HISTORY.start_date
  is 'A not null column in the complex primary key employee_id+start_date.
Must be less than the end_date of the job_history table. (enforced by
constraint jhist_date_interval)';
comment on column JOB_HISTORY.end_date
  is 'Last day of the employee in this job role. A not null column. Must be
greater than the start_date of the job_history table.
(enforced by constraint jhist_date_interval)';
comment on column JOB_HISTORY.job_id
  is 'Job role in which the employee worked in the past; foreign key to
job_id column in the jobs table. A not null column.';
comment on column JOB_HISTORY.department_id
  is 'Department id in which the employee worked in the past; foreign key to deparment_id column in the departments table';
-- Create/Recreate indexes
create index JHIST_DEPARTMENT_IX on JOB_HISTORY (DEPARTMENT_ID);
create index JHIST_EMPLOYEE_IX on JOB_HISTORY (EMPLOYEE_ID);
create index JHIST_JOB_IX on JOB_HISTORY (JOB_ID);
-- Create/Recreate primary, unique and foreign key constraints
alter table JOB_HISTORY
    add constraint JHIST_EMP_ID_ST_DATE_PK primary key (EMPLOYEE_ID, START_DATE);
alter index JHIST_EMP_ID_ST_DATE_PK nologging;
alter table JOB_HISTORY
    add constraint JHIST_DEPT_FK foreign key (DEPARTMENT_ID)
        references DEPARTMENTS (DEPARTMENT_ID);
alter table JOB_HISTORY
    add constraint JHIST_EMP_FK foreign key (EMPLOYEE_ID)
        references EMPLOYEES (EMPLOYEE_ID);
alter table JOB_HISTORY
    add constraint JHIST_JOB_FK foreign key (JOB_ID)
        references JOBS (JOB_ID);
-- Create/Recreate check constraints
alter table JOB_HISTORY
    add constraint JHIST_DATE_INTERVAL
        check (end_date > start_date);
alter table JOB_HISTORY
    add constraint JHIST_EMPLOYEE_NN
        check ("EMPLOYEE_ID" IS NOT NULL);
alter table JOB_HISTORY
    add constraint JHIST_END_DATE_NN
        check ("END_DATE" IS NOT NULL);
alter table JOB_HISTORY
    add constraint JHIST_JOB_NN
        check ("JOB_ID" IS NOT NULL);
alter table JOB_HISTORY
    add constraint JHIST_START_DATE_NN
        check ("START_DATE" IS NOT NULL);
