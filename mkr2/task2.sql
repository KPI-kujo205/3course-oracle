/*
TASK A
*/

-- sequence
CREATE SEQUENCE seq_global_id
    START WITH 100
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
commit;

-- тригери для додавання id
CREATE OR REPLACE TRIGGER trg_users_bi
    BEFORE INSERT ON Users
    FOR EACH ROW
BEGIN
    IF :NEW.id IS NULL THEN
        :NEW.id := seq_global_id.NEXTVAL;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_individuals_bi
    BEFORE INSERT ON Individuals
    FOR EACH ROW
BEGIN
    IF :NEW.id IS NULL THEN
        :NEW.id := seq_global_id.NEXTVAL;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_tasks_bi
    BEFORE INSERT ON Tasks
    FOR EACH ROW
BEGIN
    IF :NEW.id IS NULL THEN
        :NEW.id := seq_global_id.NEXTVAL;
    END IF;
END;
/
commit ;

/*
TASK B
Створити функцію ТА процедуру (FUNCTION, PROCEDURE)
та інтегрувати в них запит за завданням.

Вивести всіх фізичних осіб, користувачі яких мають більше 5 завдань.
Результат відсортувати.
*/

create PROCEDURE GET_USER_INDIVIDUALS AS
    CURSOR user_individuals_cursor IS
        SELECT
            DISTINCT I.NAME AS physical_person_name,
                     COUNT(UT.TASK_ID) AS task_count
        FROM
            USERS
                LEFT JOIN USER_TASK UT ON USERS.ID = UT.USER_ID
                LEFT JOIN USER_INDIVIDUAL UI ON USERS.ID = UI.USER_ID
                LEFT JOIN INDIVIDUALS I ON I.ID = UI.INDIVIDUAL_ID
        GROUP BY
            USERS.LOGIN, UI.INDIVIDUAL_ID, I.NAME
        HAVING
            COUNT(UT.TASK_ID) > 5
        ORDER BY
            task_count DESC;
BEGIN
    FOR record IN user_individuals_cursor LOOP
            DBMS_OUTPUT.PUT_LINE('Name: ' || record.physical_person_name || ', Task Count: ' || record.task_count);
        END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END GET_USER_INDIVIDUALS;
/




CREATE OR REPLACE FUNCTION GET_USER_INDIVIDUALS_FUNC
    RETURN SYS_REFCURSOR AS
    result_cursor SYS_REFCURSOR;
BEGIN
    OPEN result_cursor FOR
        SELECT
            DISTINCT I.NAME AS physical_person_name,
                     COUNT(UT.TASK_ID) AS task_count
        FROM
            USERS
                LEFT JOIN USER_TASK UT ON USERS.ID = UT.USER_ID
                LEFT JOIN USER_INDIVIDUAL UI ON USERS.ID = UI.USER_ID
                LEFT JOIN INDIVIDUALS I ON I.ID = UI.INDIVIDUAL_ID
        GROUP BY
            USERS.LOGIN, UI.INDIVIDUAL_ID, I.NAME
        HAVING
            COUNT(UT.TASK_ID) > 5
        ORDER BY
            task_count DESC;
    RETURN result_cursor;
END GET_USER_INDIVIDUALS_FUNC;
/


-- тестуємо саму функцію
BEGIN
    -- Declare a cursor to hold the result set
    DECLARE
        user_individuals SYS_REFCURSOR;
        physical_person_name VARCHAR2(100);
        task_count NUMBER;
    BEGIN
        -- Call the function and assign the result to the cursor
        user_individuals := GET_USER_INDIVIDUALS_FUNC;

        -- Loop through the result set
        LOOP
            FETCH user_individuals INTO physical_person_name, task_count;
            EXIT WHEN user_individuals%NOTFOUND;

            -- Output the results
            DBMS_OUTPUT.PUT_LINE('Name: ' || physical_person_name || ', Task Count: ' || task_count);
        END LOOP;

        -- Close the cursor
        CLOSE user_individuals;
    END;
END;
/
