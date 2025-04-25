
/*
2.1. Створити таблицю з первинним ключем та автоматично генерованим
значенням первинного ключа
*/

-- TASK1 -- START
create table ORDER_COMMENTS
(
    ID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    MESSAGE           VARCHAR2(100),
    CREATED_AT        TIMESTAMP(6) default CURRENT_TIMESTAMP,
    PARENT_COMMENT_ID NUMBER
        constraint ORDER_COMMENTS_ORDER_COMMENTS_ID_FK
            references ORDER_COMMENTS
);
-- TASK1 -- END


-- TASK2 -- START
/*
    Додати тестові дані
*/
insert into ORDER_COMMENTS (MESSAGE)
select 'Comment ' || to_char (rownum)
from dual
connect by level <= 1000;
-- TASK2 -- END


/*
    Додати батьківські ключі
*/
-- TASK3 -- START
update ORDER_COMMENTS
set PARENT_COMMENT_ID = trunc(dbms_random.value (1, 100))
where id < 1000;
-- TASK3 -- END


/*

Виконайте будь-яке завдання на створення ієрархічного запиту.
Завдання виконайте для двох конструкцій SELF JOIN та CONNECT BY.
Дослідить час виконання запитів – яка конструкція буде виконуватись швидше?

*/

-- TASK4 -- START
SELECT
    SYS_CONNECT_BY_PATH(C.MESSAGE || '(' || C.ID || ')', ' -> ') as comment_hierarchy
FROM
    ORDER_COMMENTS C
START WITH
    C.PARENT_COMMENT_ID = 1
CONNECT BY
    PRIOR C.ID = C.PARENT_COMMENT_ID
--

SELECT
    LEVEL_1.MESSAGE || '(' || LEVEL_1.ID || ')' AS parent_comment,
    LEVEL_2.MESSAGE || '(' || LEVEL_2.ID || ')' AS child_comment
FROM
    ORDER_COMMENTS LEVEL_1
INNER JOIN
    ORDER_COMMENTS LEVEL_2 ON LEVEL_1.ID = LEVEL_2.PARENT_COMMENT_ID
WHERE
    LEVEL_1.PARENT_COMMENT_ID = 1;
 -- TASK4 -- END
