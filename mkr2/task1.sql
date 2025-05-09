
CREATE OR REPLACE PROCEDURE PRINT_USERS_ORDERED_BY(p_order_col IN VARCHAR2) AS
    v_sql       VARCHAR2(1000);           -- Змінна для збереження динамічного SQL-запиту
    v_cursor    SYS_REFCURSOR;            -- Курсор для виконання запиту
    v_id        Users.id%TYPE;            -- Змінна для збереження значення стовпця id
    v_login     Users.login%TYPE;         -- Змінна для збереження значення стовпця login
    v_password  Users.password%TYPE;      -- Змінна для збереження значення стовпця password
BEGIN
    -- Формуємо SQL-запит з динамічним ORDER BY
    v_sql := 'SELECT id, login, password FROM Users ORDER BY ' || p_order_col;

    -- Відкриваємо курсор на основі сформованого запиту
    OPEN v_cursor FOR v_sql;

    -- Опрацьовуємо результати запиту построково
    LOOP
        FETCH v_cursor INTO v_id, v_login, v_password;
        EXIT WHEN v_cursor%NOTFOUND;
        dbms_output.enable;
        -- Виводимо дані про користувача
        DBMS_OUTPUT.PUT_LINE('ID: ' || v_id || ', Login: ' || v_login || ', Password: ' || v_password);
    END LOOP;

    -- Закриваємо курсор
    CLOSE v_cursor;
EXCEPTION
    -- Обробка помилок: виводимо повідомлення про помилку
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Помилка: ' || SQLERRM);
END;
/

