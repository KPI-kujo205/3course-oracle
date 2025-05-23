-- 1. Функція для визначення JobStatus
CREATE OR REPLACE FUNCTION GET_JOB_STATUS(
    p_employee_id IN NUMBER,
    p_hire_date IN DATE
) RETURN NUMBER
IS
    v_job_history_count NUMBER;
    v_job_status NUMBER;
BEGIN
    -- Перевіряємо чи є записи в JOB_HISTORY для цього працівника
    SELECT COUNT(*)
    INTO v_job_history_count
    FROM LAB1_USER.JOB_HISTORY
    WHERE EMPLOYEE_ID = p_employee_id;

    -- Якщо є записи в JobHistory, повертаємо статус 2
    IF v_job_history_count > 0 THEN
        v_job_status := 2;
    -- Якщо працівник працює з 2004 року
    ELSIF EXTRACT(YEAR FROM p_hire_date) = 2004 THEN
        v_job_status := 0;
    -- Якщо працівник працює з 2006 року
    ELSIF EXTRACT(YEAR FROM p_hire_date) = 2006 THEN
        v_job_status := 1;
    -- В інших випадках
    ELSE
        v_job_status := 3; -- Додатковий статус для інших років
    END IF;

    RETURN v_job_status;
END GET_JOB_STATUS;
/

COMMIT ;

-- 2. Функція для визначення RegionStatus
CREATE OR REPLACE FUNCTION GET_REGION_STATUS(
    p_region_name IN VARCHAR2,
    p_salary IN NUMBER,
    p_number1 IN NUMBER DEFAULT 5000,  -- Значення для Європи
    p_number2 IN NUMBER DEFAULT 8000   -- Значення для Азії
) RETURN NUMBER
IS
    v_region_status NUMBER;
BEGIN
    -- Статус 1: Європа та зарплата < Число1
    IF UPPER(p_region_name) = 'EUROPE' AND p_salary < p_number1 THEN
        v_region_status := 1;
    -- Статус 2: Азія та зарплата > Число2
    ELSIF UPPER(p_region_name) = 'ASIA' AND p_salary > p_number2 THEN
        v_region_status := 2;
    -- Статус 3: всі інші випадки
    ELSE
        v_region_status := 3;
    END IF;

    RETURN v_region_status;
END GET_REGION_STATUS;
/
COMMIT ;

-- 3. Основний запит для створення звіту
SELECT
    e.FIRST_NAME,
    e.LAST_NAME,
    e.EMAIL,
    e.PHONE_NUMBER,
    d.DEPARTMENT_NAME,
    r.REGION_NAME,
    e.SALARY,
    e.HIRE_DATE,
    -- Використовуємо функцію для JobStatus
    GET_JOB_STATUS(e.EMPLOYEE_ID, e.HIRE_DATE) as JOB_STATUS,
    -- Використовуємо функцію для RegionStatus
    GET_REGION_STATUS(r.REGION_NAME, e.SALARY, 5000, 8000) as REGION_STATUS
FROM
    LAB1_USER.EMPLOYEES e
    LEFT JOIN LAB1_USER.DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
    LEFT JOIN LAB1_USER.LOCATIONS l ON d.LOCATION_ID = l.LOCATION_ID
    LEFT JOIN LAB1_USER.COUNTRIES c ON l.COUNTRY_ID = c.COUNTRY_ID
    LEFT JOIN LAB1_USER.REGIONS r ON c.REGION_ID = r.REGION_ID
ORDER BY
    e.LAST_NAME, e.FIRST_NAME;
COMMIT ;
