-- 1. Вивести середню ЗП по департаменту «ДЕПАРТАМЕНТ1». (Агрегатна
-- функція AVG)
SELECT
    D.DEPARTMENT_NAME,
    CASE
        WHEN AVG(E.SALARY) IS NULL THEN 0
        ELSE AVG(E.SALARY)
    END as avg_salary
    FROM
DEPARTMENTS D
LEFT JOIN LAB1_USER.EMPLOYEES E on D.DEPARTMENT_ID = E.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_NAME
ORDER BY avg_salary desc ;


-- 2. Знайдіть дату останнього прийнятого на роботу працівника з регіону
-- «РЕГІОН1». (Агрегатна функція MAX)
SELECT
    MAX(E.HIRE_DATE) as hire_data
    FROM
REGIONS R
LEFT JOIN COUNTRIES C ON R.REGION_ID = C.REGION_ID
LEFT JOIN LOCATIONS L ON C.COUNTRY_ID = L.COUNTRY_ID
LEFT JOIN DEPARTMENTS D ON L.LOCATION_ID = D.LOCATION_ID
LEFT JOIN EMPLOYEES E ON D.DEPARTMENT_ID = E.DEPARTMENT_ID

-- 3. Знайдіть загальну суму комісії по робітникам, які займають посаду
-- «ПОСАДА1». (Агрегатна функція SUM)
SELECT
    J.JOB_TITLE,
    CASE
        WHEN SUM(E.COMMISSION_PCT) IS NULL THEN 0
        ELSE SUM(E.COMMISSION_PCT)
    END AS commission_sum
    FROM JOBS J
LEFT JOIN EMPLOYEES E ON J.JOB_ID = E.JOB_ID
GROUP BY J.JOB_TITLE
ORDER BY commission_sum desc ;



-- 4. Скільки працівників зайняті на посадах, в яких максимальна ЗП більше 1234. (Агрегатна функція COUNT)
SELECT
    COUNT(E.EMPLOYEE_ID) AS employee_count
FROM EMPLOYEES E
LEFT JOIN JOBS J ON E.JOB_ID = J.JOB_ID
WHERE J.MAX_SALARY > 1234;


-- 5. Знайдіть мінімальну ЗП працівників з країни «КРАЇНА1». (Агрегатна
-- функція MIN)
SELECT
    C.COUNTRY_NAME,
    MIN(E.SALARY) as min_salary

FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
LEFT JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
LEFT JOIN COUNTRIES C ON L.COUNTRY_ID = C.COUNTRY_ID
GROUP BY C.COUNTRY_NAME
HAVING COUNTRY_NAME IS NOT NULL
ORDER BY min_salary desc



-- 6. Відобразіть кожен департамент з середньою кількістю днів роботи
-- співробітників в компанії (кількість днів вираховуйте від дня прийняття
-- до поточної дати)
WITH Employess_Work_For  AS (
    SELECT
        E.*,
        TRUNC(SYSDATE - E.HIRE_DATE) AS days_worked
            FROM
            EMPLOYEES E

)
SELECT
    D.DEPARTMENT_NAME,
    CASE
        WHEN AVG(EW.days_worked) IS NULL THEN 0
        ELSE AVG(EW.days_worked)
    END as avg_days_worked
FROM
    DEPARTMENTS D
LEFT JOIN Employess_Work_For EW ON D.DEPARTMENT_ID = EW.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_NAME
ORDER BY avg_days_worked  DESC



-- 7. Вивести кількість співробітників за департаментами та посадами.
SELECT
    D.DEPARTMENT_NAME,
    J.JOB_TITLE,
    COUNT(E.EMPLOYEE_ID) as employee_count
    FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
LEFT JOIN JOBS J on E.JOB_ID = J.JOB_ID
GROUP BY D.DEPARTMENT_NAME, J.JOB_TITLE
ORDER BY employee_count DESC


-- 8. Вивести перелік співробітників, згрупованих за департаментом,
-- посадою та датою прийому.
SELECT
    D.DEPARTMENT_NAME,
    J.JOB_TITLE,
    E.HIRE_DATE,
    CONCAT(E.FIRST_NAME, ' ', E.LAST_NAME) AS EMPLOYEE_NAME
FROM EMPLOYEES E
         LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
         LEFT JOIN JOBS J ON E.JOB_ID = J.JOB_ID
GROUP BY D.DEPARTMENT_NAME, J.JOB_TITLE, E.HIRE_DATE, E.FIRST_NAME, E.LAST_NAME
ORDER BY E.HIRE_DATE DESC ;

-- 9. Вивести перелік департаментів, посад та дат прийому співробітників (з
-- підрахунком кількості робітників по однаковій даті прийому).
SELECT
    D.DEPARTMENT_NAME,
    J.JOB_TITLE,
    E.HIRE_DATE,
    COUNT(E.EMPLOYEE_ID) as employee_count
FROM EMPLOYEES E
         LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
         LEFT JOIN JOBS J ON E.JOB_ID = J.JOB_ID
GROUP BY D.DEPARTMENT_NAME, J.JOB_TITLE, E.HIRE_DATE
ORDER BY E.HIRE_DATE DESC ;


-- 10. Вивести перелік співробітників, які займали посаду більше двох разів
-- по всім відділам (застосовуйте HAVING).
SELECT
    CONCAT(E.FIRST_NAME, ' ', E.LAST_NAME) AS EMPLOYEE_NAME,
    COUNT(JH.EMPLOYEE_ID) as took_job_count
FROM EMPLOYEES E
LEFT JOIN JOBS J ON E.JOB_ID = J.JOB_ID
LEFT JOIN JOB_HISTORY JH on E.EMPLOYEE_ID = JH.EMPLOYEE_ID
GROUP BY E.FIRST_NAME, E.LAST_NAME
HAVING took_job_count >= 2
ORDER BY took_job_count DESC

