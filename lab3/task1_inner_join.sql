--  INNER
-- 1. Вибрати усіх робітників, локація департаменту яких знаходиться у
-- Seattle.
SELECT E.* FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
INNER JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
WHERE L.CITY = 'Seattle';


-- 2. Вибрати всі країни, робітники з яких працюють на посаді «Stock
-- Clerk».
SELECT
    COUNTRIES.COUNTRY_NAME
    FROM COUNTRIES
    INNER JOIN LOCATIONS ON COUNTRIES.COUNTRY_ID = LOCATIONS.COUNTRY_ID
    INNER JOIN DEPARTMENTS ON LOCATIONS.LOCATION_ID = DEPARTMENTS.LOCATION_ID
    INNER JOIN EMPLOYEES ON DEPARTMENTS.DEPARTMENT_ID = EMPLOYEES.DEPARTMENT_ID
    INNER JOIN JOBS ON EMPLOYEES.JOB_ID = JOBS.JOB_ID
WHERE JOBS.JOB_TITLE = 'Stock Clerk'
GROUP BY COUNTRIES.COUNTRY_NAME;

-- 3. Вибрати всіх робітників з регіону Europe, в яких ЗП не менше 9000 і
-- менше або дорівнює 17000.
SELECT
    E.*
    FROM EMPLOYEES E
    INNER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    INNER JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
    INNER JOIN COUNTRIES C ON L.COUNTRY_ID = C.COUNTRY_ID
    INNER JOIN REGIONS R ON C.REGION_ID = R.REGION_ID
    WHERE R.REGION_NAME = 'Europe' AND E.SALARY <= 17000 AND E.SALARY >= 9000;

-- 4. Вивести всі роботи, робітники на яких отримують заробітну плату
-- вище мінімальної згідно атрибуту MIN_SALARY таблиці JOBS.
SELECT
    JOBS.JOB_TITLE
    FROM
JOBS
    LEFT JOIN EMPLOYEES ON JOBS.JOB_ID = EMPLOYEES.JOB_ID
    WHERE EMPLOYEES.SALARY > JOBS.MIN_SALARY
GROUP BY JOBS.JOB_TITLE

-- 5. Вивести департаменти, робітники яких працюють на посадах з
-- максимальною заробітною платою вище 15000.
SELECT
    D.DEPARTMENT_NAME
    FROM DEPARTMENTS D
    INNER JOIN EMPLOYEES E ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
    INNER JOIN JOBS J ON J.JOB_ID = E.JOB_ID
    WHERE J.MAX_SALARY > 15000
GROUP BY D.DEPARTMENT_NAME

-- 6. Вивести всі департаменти та працівників, що в них працюють з їхньою
-- заробітною платою.
SELECT
    CONCAT(E.FIRST_NAME, ' ', E.LAST_NAME) AS EMPLOYEE_NAME,
    D.DEPARTMENT_NAME,
    E.SALARY
FROM DEPARTMENTS D
         INNER JOIN EMPLOYEES E ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
         INNER JOIN JOBS J ON J.JOB_ID = E.JOB_ID
ORDER BY D.DEPARTMENT_NAME;


-- 7. Вивести всіх працівників, їх посади та країни (COUNTRIES), де вони
-- працюють.
SELECT
    CONCAT(E.FIRST_NAME, ' ', E.LAST_NAME) AS EMPLOYEE_NAME,
    J.JOB_TITLE,
    C.COUNTRY_NAME
FROM DEPARTMENTS D
         INNER JOIN EMPLOYEES E ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
         INNER JOIN JOBS J ON J.JOB_ID = E.JOB_ID
         INNER JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
         INNER JOIN COUNTRIES C ON L.COUNTRY_ID = C.COUNTRY_ID
