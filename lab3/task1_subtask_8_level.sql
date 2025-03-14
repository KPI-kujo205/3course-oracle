
-- 8. Вивести ієрархію робітників з таблиці EMPLOYEES за атрибутом
-- MANAGER_ID в двох варіантах:
--     a. Ієрархія до певного рівня N (наприклад, N=3):
-- Працівник1  Працівник 23  Працівник 67
--       Працівник1
--
--      Працівник1  Працівник23
-- Працівник23 Працівник67  Працівник 80
-- b. Повна ієрархія для кожного працівника:
-- Працівник1  Працівник 23  Працівник 67
-- Працівник1
-- Працівник1  Працівник23
-- Працівник23 Працівник67  Працівник 80
-- Працівник2  Працівник17  Працівник23  Працівник44

SELECT
    LEVEL,
    SYS_CONNECT_BY_PATH(E.FIRST_NAME || ' ' || E.LAST_NAME, ' -> ') AS EMPLOYEE_CHAIN,
    E.EMPLOYEE_ID,
    E.MANAGER_ID
FROM
    EMPLOYEES E
WHERE
    LEVEL = 3
START WITH
    E.MANAGER_ID IS NULL
CONNECT BY
    PRIOR E.EMPLOYEE_ID = E.MANAGER_ID
       AND LEVEL <= 3
ORDER BY
    LEVEL, E.MANAGER_ID, E.EMPLOYEE_ID;


-- завдання б
SELECT
    LEVEL,
    SYS_CONNECT_BY_PATH(E.FIRST_NAME || ' ' || E.LAST_NAME, ' -> ') AS EMPLOYEE_CHAIN,
    E.EMPLOYEE_ID,
    E.MANAGER_ID
FROM
    EMPLOYEES E
START WITH
    E.MANAGER_ID IS NULL
CONNECT BY
    PRIOR E.EMPLOYEE_ID = E.MANAGER_ID
       AND LEVEL <= 3
ORDER BY
    LEVEL, E.MANAGER_ID, E.EMPLOYEE_ID;
