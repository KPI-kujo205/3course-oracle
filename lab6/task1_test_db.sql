/*

Завдання 1.

Написати тригери для кожної таблиці тестової бази даних,
з 1-ї лабораторної,
яку студенти створювали по варіантах.

Тригер на автогенерацію
Тригер на оновлення рядка
Тригер на видалення рядків
*/

/*
COUNTRIES
*/

alter table COUNTRIES
    add UPDATED_AT TIMESTAMP(6);

alter table COUNTRIES
    add CREATED_AT TIMESTAMP(6);

COMMIT;

--create
CREATE OR REPLACE TRIGGER trg_categories_autogen
BEFORE INSERT ON COUNTRIES
FOR EACH ROW
BEGIN
    :NEW.CREATED_AT := SYSTIMESTAMP;
end;


--update
create trigger TRG_CATEGORIES_ONUPDATE
    before update
    on COUNTRIES
    for each row
BEGIN
    :NEW.UPDATED_AT := SYSTIMESTAMP;
end;
/

COMMIT;

--delete
CREATE OR REPLACE TRIGGER trg_countries_restrict_delete
    BEFORE DELETE ON COUNTRIES
    FOR EACH ROW
BEGIN
    IF (:OLD.COUNTRY_NAME = 'Ukraine') THEN
        RAISE_APPLICATION_ERROR(-20101, 'You cannot delete Ukraine');
    END IF;
END;
COMMIT;


/*
DEPARTMENTS
*/
-- modify table
alter table DEPARTMENTS
    add UPDATED_AT TIMESTAMP(6);

alter table DEPARTMENTS
    add CREATED_AT TIMESTAMP(6);

alter table DEPARTMENTS
    add DELETED_AT TIMESTAMP(6);

COMMIT;


--create
CREATE OR REPLACE TRIGGER trg_DEPARTMENTS_autogen
    BEFORE INSERT ON DEPARTMENTS
    FOR EACH ROW
BEGIN
    :NEW.CREATED_AT := SYSTIMESTAMP;
end;


--update
create trigger TRG_DEPARTMENTS_ONUPDATE
    before update
    on DEPARTMENTS
    for each row
BEGIN
    :NEW.UPDATED_AT := SYSTIMESTAMP;
end;
/

COMMIT;

--delete
CREATE OR REPLACE TRIGGER trg_departments_restrict_delete
    BEFORE DELETE ON DEPARTMENTS
    FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('Will delete department ' || :OLD.DEPARTMENT_NAME);
END;
COMMIT;



/*
EMPLOYEES
*/

-- modify table
alter table EMPLOYEES
    add UPDATED_AT TIMESTAMP(6);

alter table EMPLOYEES
    add CREATED_AT TIMESTAMP(6);


COMMIT;


--create
CREATE OR REPLACE TRIGGER trg_empl_oncreate
    BEFORE INSERT ON EMPLOYEES
    FOR EACH ROW
BEGIN
    :NEW.CREATED_AT := SYSTIMESTAMP;
end;


--update
create trigger TRG_empl_ONUPDATE
    before update
    on EMPLOYEES
    for each row
BEGIN
    :NEW.UPDATED_AT := SYSTIMESTAMP;
end;
/

COMMIT;

--delete
CREATE OR REPLACE TRIGGER trg_empl_delete
    BEFORE DELETE ON EMPLOYEES
    FOR EACH ROW
BEGIN
    DELETE FROM
        JOB_HISTORY
    WHERE EMPLOYEE_ID = :OLD.EMPLOYEE_ID;
END;
COMMIT;


/*
JOB_HISTORY
*/

-- modify table
alter table JOB_HISTORY
    add UPDATED_AT TIMESTAMP(6);

alter table JOB_HISTORY
    add CREATED_AT TIMESTAMP(6);


COMMIT;


--create
CREATE OR REPLACE TRIGGER trg_jh_oncreate
    BEFORE INSERT ON JOB_HISTORY
    FOR EACH ROW
BEGIN
    :NEW.CREATED_AT := SYSTIMESTAMP;
end;


--update
create trigger TRG_jh_ONUPDATE
    before update
    on JOB_HISTORY
    for each row
BEGIN
    :NEW.UPDATED_AT := SYSTIMESTAMP;
end;
/

COMMIT;

--delete
CREATE OR REPLACE TRIGGER trg_jh_delete
    BEFORE DELETE ON JOB_HISTORY
    FOR EACH ROW
BEGIN
    DELETE FROM
        EMPLOYEES
    WHERE EMPLOYEE_ID = :OLD.EMPLOYEE_ID;
END;
COMMIT;


/*
JOBS
*/

-- modify table
alter table JOBS
    add UPDATED_AT TIMESTAMP(6);

alter table JOBS
    add CREATED_AT TIMESTAMP(6);


COMMIT;


--create
CREATE OR REPLACE TRIGGER trg_jobs_oncreate
    BEFORE INSERT ON JOBS
    FOR EACH ROW
BEGIN
    :NEW.CREATED_AT := SYSTIMESTAMP;
end;


--update
create trigger TRG_jobs_ONUPDATE
    before update
    on JOBS
    for each row
BEGIN
    :NEW.UPDATED_AT := SYSTIMESTAMP;
end;
/

COMMIT;

--delete
CREATE OR REPLACE TRIGGER trg_jh_delete
    BEFORE DELETE ON JOB_HISTORY
    FOR EACH ROW
BEGIN
    IF (:OLD.JOB_ID = 'AD_PRES') THEN
        RAISE_APPLICATION_ERROR(-20101, 'You cannot delete the president, the company will collapse');
    END IF;
END;
/
COMMIT;

/*
LOCATIONS
*/

-- modify table
alter table LOCATIONS
    add UPDATED_AT TIMESTAMP(6);

alter table LOCATIONS
    add CREATED_AT TIMESTAMP(6);


COMMIT;


--create
CREATE OR REPLACE TRIGGER trg_locs_oncreate
    BEFORE INSERT ON LOCATIONS
    FOR EACH ROW
BEGIN
    :NEW.CREATED_AT := SYSTIMESTAMP;
end;


--update
create trigger TRG_locs_ONUPDATE
    before update
    on LOCATIONS
    for each row
BEGIN
    :NEW.UPDATED_AT := SYSTIMESTAMP;
end;
/

COMMIT;

--delete
CREATE OR REPLACE TRIGGER trg_locs_delete
    BEFORE DELETE ON LOCATIONS
    FOR EACH ROW
BEGIN
    IF (:OLD.LOCATION_ID = 1) THEN
        RAISE_APPLICATION_ERROR(-20101, 'This is a protected location, you cannot delete it');
    END IF;
END;
/
COMMIT;


/*
REGIONS
*/

-- modify table
alter table REGIONS
    add UPDATED_AT TIMESTAMP(6);

alter table REGIONS
    add CREATED_AT TIMESTAMP(6);


COMMIT;


--create
CREATE OR REPLACE TRIGGER trg_regions_oncreate
    BEFORE INSERT ON REGIONS
    FOR EACH ROW
BEGIN
    :NEW.CREATED_AT := SYSTIMESTAMP;
end;


--update
create trigger TRG_regions_ONUPDATE
    before update
    on REGIONS
    for each row
BEGIN
    :NEW.UPDATED_AT := SYSTIMESTAMP;
end;
/

COMMIT;

--delete
CREATE OR REPLACE TRIGGER trg_regions_delete
    BEFORE DELETE ON REGIONS
    FOR EACH ROW
BEGIN
    IF (:OLD.REGION_ID = 1) THEN
        RAISE_APPLICATION_ERROR(-20101, 'This is a protected region, you cannot delete it');
    END IF;
END;
/
COMMIT;

