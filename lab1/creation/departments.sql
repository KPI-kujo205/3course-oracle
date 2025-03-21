-- Create table
create table DEPARTMENTS
(
    department_id   NUMBER(4) not null,
    department_name VARCHAR2(30),
    manager_id      NUMBER(6),
    location_id     NUMBER(4)
);
-- Add comments to the table
comment on table DEPARTMENTS
  is 'Departments table that shows details of departments where employees
work. Contains 27 rows; references with locations, employees, and job_history tables.';
-- Add comments to the columns
comment on column DEPARTMENTS.department_id
  is 'Primary key column of departments table.';
comment on column DEPARTMENTS.department_name
  is 'A not null column that shows name of a department. Administration,
Marketing, Purchasing, Human Resources, Shipping, IT, Executive, Public
Relations, Sales, Finance, and Accounting. ';
comment on column DEPARTMENTS.manager_id
  is 'Manager_id of a department. Foreign key to employee_id column of employees table. The manager_id column of the employee table references this column.';
comment on column DEPARTMENTS.location_id
  is 'Location id where a department is located. Foreign key to location_id column of locations table.';
-- Create/Recreate indexes
create index DEPT_LOCATION_IX on DEPARTMENTS (LOCATION_ID);
-- Create/Recreate primary, unique and foreign key constraints
alter table DEPARTMENTS
    add constraint DEPT_ID_PK primary key (DEPARTMENT_ID);
alter index DEPT_ID_PK nologging;
alter table DEPARTMENTS
    add constraint DEPT_LOC_FK foreign key (LOCATION_ID)
        references LOCATIONS (LOCATION_ID);
alter table DEPARTMENTS
    add constraint DEPT_MGR_FK foreign key (MANAGER_ID)
        references EMPLOYEES (EMPLOYEE_ID);
-- Create/Recreate check constraints
alter table DEPARTMENTS
    add constraint DEPT_NAME_NN
        check ("DEPARTMENT_NAME" IS NOT NULL);
