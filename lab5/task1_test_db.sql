
-- TASK1 -- START
/*
1.1. Вибрати прізвища, імена, посади всіх робітників та прізвища, імена,
посади їхніх менеджерів (MANAGER_ID). Відсортувати окремо по:
*/

/*
a. по посадам менеджера (перший запит)
*/

SELECT
    W.LAST_NAME as employee_last_name,
    W.FIRST_NAME as employee_first_name,
    EJ.JOB_TITLE as employee_job,

    M.LAST_NAME as manager_last_name,
    M.FIRST_NAME as manager_first_name,
    MJ.JOB_TITLE as manager_job

    FROM EMPLOYEES W

LEFT JOIN EMPLOYEES M ON W.MANAGER_ID = M.EMPLOYEE_ID
LEFT JOIN JOBS EJ ON W.JOB_ID = EJ.JOB_ID
LEFT JOIN JOBS MJ ON M.JOB_ID = MJ.JOB_ID

ORDER BY manager_job;

/*
b. по прізвищам, іменам робітників (другий запит)
*/

SELECT
    W.LAST_NAME as employee_last_name,
    W.FIRST_NAME as employee_first_name,
    EJ.JOB_TITLE as employee_job,

    M.LAST_NAME as manager_last_name,
    M.FIRST_NAME as manager_first_name,
    MJ.JOB_TITLE as manager_job

FROM EMPLOYEES W

         LEFT JOIN EMPLOYEES M ON W.MANAGER_ID = M.EMPLOYEE_ID
         LEFT JOIN JOBS EJ ON W.JOB_ID = EJ.JOB_ID
         LEFT JOIN JOBS MJ ON M.JOB_ID = MJ.JOB_ID

ORDER BY employee_last_name, employee_first_name

-- TASK1 -- END


-- TASK2 -- START
/*
Вибрати по-парно прізвища, імена, дати прийняття на посаду
робітників,
які були прийняті в одну і ту саму дату (HIRE_DATE).

Відсортувати
по даті, прізвищам, іменам.
*/

SELECT
    EM1.FIRST_NAME as e1_name,
    EM1.LAST_NAME as e1_surname,
    EM2.FIRST_NAME as e2_name,
    EM2.LAST_NAME as e2_surname,
    EM2.HIRE_DATE as hire

    FROM EMPLOYEES EM1
LEFT JOIN EMPLOYEES EM2 ON EM1.HIRE_DATE = EM2.HIRE_DATE
ORDER BY
    e1_name ,e1_surname , hire DESC

-- TASK2 -- END

-- TASK3 -- START
/*
1.3. Навести ієрархію
співробітників з прорахованою
середньої зарплатнею
по посадам, які займав співробітник.
В результаті запиту повинні бути прізвища
та імена співробітників,
середня зарплатня.
Відсортувати:
a. по середній зарплатні
b. по прізвищам співробітників
*/

-- a. по середній зарплатні
SELECT
    DISTINCT E.FIRST_NAME,E.LAST_NAME,
    J.JOB_TITLE,

    ((J.MAX_SALARY + J.MIN_SALARY) / 2) as avg_salary

    FROM EMPLOYEES E

INNER JOIN JOB_HISTORY JH1 ON E.EMPLOYEE_ID = JH1.EMPLOYEE_ID
INNER JOIN JOB_HISTORY JH2 ON
        E.EMPLOYEE_ID = JH2.EMPLOYEE_ID

LEFT JOIN JOBS J ON
    (JH1.JOB_ID = J.JOB_ID OR JH2.JOB_ID = J.JOB_ID)
ORDER BY avg_salary DESC


-- по прізвищам співробітників
SELECT
    DISTINCT E.FIRST_NAME,E.LAST_NAME,
             J.JOB_TITLE,

             ((J.MAX_SALARY + J.MIN_SALARY) / 2) as avg_salary

FROM EMPLOYEES E

         INNER JOIN JOB_HISTORY JH1 ON E.EMPLOYEE_ID = JH1.EMPLOYEE_ID
         INNER JOIN JOB_HISTORY JH2 ON
    E.EMPLOYEE_ID = JH2.EMPLOYEE_ID

         LEFT JOIN JOBS J ON
    (JH1.JOB_ID = J.JOB_ID OR JH2.JOB_ID = J.JOB_ID)
ORDER BY E.LAST_NAME

-- TASK4 -- START
/*
1.4. Вивести по-парно співробітників з однаковими іменами.
В результаті
запиту повинні бути прізвища та імена співробітників,
та департаменти де вони
працюють
(1 атрибут – ПІ першого співробітника та відділ, де він працює;
2 атрибут – ПІ тезки та відділ, де він працює).
*/

SELECT

    EM1.FIRST_NAME ||' '||EM1.LAST_NAME as e1,
    D1.DEPARTMENT_NAME as d1,
    EM2.FIRST_NAME ||' '||EM2.LAST_NAME as e2,
    D2.DEPARTMENT_NAME as d2
FROM EMPLOYEES EM1
         INNER JOIN EMPLOYEES EM2 ON
             (EM1.FIRST_NAME = EM2.FIRST_NAME
                 AND EM1.EMPLOYEE_ID != EM2.EMPLOYEE_ID
                 )
         LEFT JOIN DEPARTMENTS D1 ON (D1.DEPARTMENT_ID = EM1.DEPARTMENT_ID )
         LEFT JOIN DEPARTMENTS D2 ON (D2.DEPARTMENT_ID = EM2.DEPARTMENT_ID )

-- TASK4 -- END

-- TASK5 -- START
/*
1.5. Створити запити зі змінною/змінними підстановки для наступних
завдань:
a. Вивести ієрархію співробітників конкретного відділу
b. Вивести ієрархію співробітників, які були прийняті на роботу в
певний проміжок часу (з…по…)
c. Вивести ієрархію співробітників певної конкретної посади
*/

-- a. Вивести ієрархію співробітників конкретного відділу
SELECT
    SYS_CONNECT_BY_PATH(E.FIRST_NAME || ' ' || E.LAST_NAME, ' -> ') AS hierarchy
FROM
    EMPLOYEES E
LEFT JOIN JOBS J ON E.JOB_ID = J.JOB_ID
WHERE
    J.JOB_ID = :job_id
START WITH
    E.MANAGER_ID IS NULL
CONNECT BY
    PRIOR E.EMPLOYEE_ID = E.MANAGER_ID
ORDER BY
    LEVEL, E.MANAGER_ID, E.EMPLOYEE_ID;

-- nr
-- b. Вивести ієрархію співробітників, які були прийняті на роботу в
-- певний проміжок часу (з…по…)

SELECT
    SYS_CONNECT_BY_PATH(E.FIRST_NAME || ' ' || E.LAST_NAME, ' -> ') AS hierarchy
FROM
    EMPLOYEES E
WHERE
    E.HIRE_DATE BETWEEN :start_date AND :end_date
START WITH
    E.MANAGER_ID IS NULL
CONNECT BY
    PRIOR E.EMPLOYEE_ID = E.MANAGER_ID
ORDER BY
    LEVEL, E.MANAGER_ID, E.EMPLOYEE_ID;


