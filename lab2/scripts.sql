-- 1. Отримати перелік і загальне число клієнтів із розбивкою за регіонами, віком та
-- категоріями покупців.
-- Розбивка за регіонами:
SELECT
    R.NAME as region_name,
    COUNT(C.ID) as client_count
FROM
    CLIENTS C
LEFT OUTER JOIN
    REGIONS R ON C.REGION_ID = R.ID
GROUP BY R.NAME
ORDER BY client_count DESC;


-- Розбивка за віком:
WITH Age_Calculation AS (
    SELECT
        ID,
        NAME,
        EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM BIRTHDAY) AS AGE
    FROM
        CLIENTS
),
     Client_Age_Category AS (
         SELECT
             A.*,
             CASE
                 WHEN A.AGE < 18 THEN 'Школярик'
                 WHEN A.AGE BETWEEN 18 AND 25 THEN 'Студент'
                 WHEN A.AGE BETWEEN 25 AND 60 THEN 'До мобілізації готовий'
                 ELSE 'Най спочиває'
                 END AS age_group
         FROM
             Age_Calculation A
     )
SELECT
    COUNT(AG.age_group) as client_count,
    AG.age_group

FROM Client_Age_Category AG
GROUP BY AG.age_group
;

-- 2. Отримати статистику замовлень для кожного клієнта (кількість, суму
-- замовлень, середнє значення покупки).

WITH Order_Prices
AS (
    SELECT O.ID,
        SUM(IO.ITEM_AMOUNT * I.PRICE_PER_ITEM) as order_price
        FROM ORDERS O
        LEFT JOIN ITEM_ORDERS IO ON O.ID = IO.ORDER_ID
        LEFT JOIN ITEMS I ON IO.ITEM_ID = I.ID
        GROUP BY O.ID
)

SELECT
    C.NAME,
    COUNT(O.ID),
    SUM(OP.order_price) as total_order_price,
    AVG(OP.order_price) as avg_order_price,
    MIN(OP.order_price) as min_order_price,
    MAX(OP.order_price) as max_order_price
    FROM CLIENTS C
LEFT JOIN ORDERS O ON C.ID = O.CLIENT_ID
LEFT JOIN Order_Prices OP ON O.ID = OP.ID
GROUP BY C.NAME;




-- 4. Отримати детальну інформацію про замовлення за вибраний період із
-- зазначенням дати, статусу та суми.
WITH Order_Prices
         AS (
        SELECT O.ID,
               SUM(IO.ITEM_AMOUNT * I.PRICE_PER_ITEM) as order_price
        FROM ORDERS O
                 LEFT JOIN ITEM_ORDERS IO ON O.ID = IO.ORDER_ID
                 LEFT JOIN ITEMS I ON IO.ITEM_ID = I.ID
        GROUP BY O.ID
    )

SELECT
    O.CLIENT_MESSAGE,
    O.STATUS,
    O.CREATED_AT,
    OP.order_price
    FROM ORDERS O
    LEFT JOIN Order_Prices OP ON OP.ID = O.ID
WHERE
    O.CREATED_AT BETWEEN TIMESTAMP '2020-03-13 22:25:31.260259' AND TIMESTAMP '2025-03-13 22:25:31.286285'



-- 5. Отримати перелік товарів із інформацією про повернення (кількість повернень,
-- причини, частота).
SELECT
    O.CLIENT_MESSAGE,
    O.STATUS,
    C.NAME as client_name
FROM ORDERS O
LEFT JOIN CLIENTS C ON O.CLIENT_ID = C.ID
WHERE
    O.STATUS = 'returned_by_client'





-- 6. Отримати дані про постачальників із зазначенням загальної суми поставок,
-- рейтингом за швидкістю доставки та якістю.
WITH Item_Orders_Prices
AS (
        SELECT IO.ORDER_ID,
               I.SUPPLIER_ID,
               SUM(IO.ITEM_AMOUNT * I.PRICE_PER_ITEM) as item_order_price
        FROM ITEM_ORDERS IO
                 LEFT JOIN ITEMS I ON IO.ITEM_ID = I.ID
        GROUP BY IO.ORDER_ID, SUPPLIER_ID
    )
SELECT
    S.NAME,
    AVG(O.RATE_QUALITY) avg_quality,
    AVG(O.RATE_SPEED) avg_speed,
    SUM(IOP.item_order_price)

FROM ORDERS O
LEFT JOIN Item_Orders_Prices IOP ON O.ID = IOP.ORDER_ID
LEFT JOIN SUPPLIERS S ON S.ID = IOP.SUPPLIER_ID
GROUP BY S.ID, S.NAME


-- 7. Сформувати звіт продажів за місяць, квартал, рік із розбиттям за категоріями
-- товарів.
WITH sales_by_category_month AS (
    SELECT
        c.name AS category_name,
        CASE
            WHEN SUM(io.item_amount * i.price_per_item) IS NULL THEN 0
            ELSE SUM(io.item_amount * i.price_per_item)
            END AS sum
    FROM
        categories c
            LEFT JOIN
        item_categories ic ON ic.category_id = c.id
            LEFT JOIN
        items i ON i.id = ic.item_id
            LEFT JOIN
        item_orders io ON io.item_id = i.id AND io.created_at >= SYSDATE - INTERVAL '30' DAY(2)
    GROUP BY
        c.name
    ORDER BY
        sum DESC
),
     sales_by_category_quartal AS (
         SELECT
             c.name AS category_name,
             CASE
                 WHEN SUM(io.item_amount * i.price_per_item) IS NULL THEN 0
                 ELSE SUM(io.item_amount * i.price_per_item)
                 END AS sum
         FROM
             categories c
                 LEFT JOIN
             item_categories ic ON ic.category_id = c.id
                 LEFT JOIN
             items i ON i.id = ic.item_id
                 LEFT JOIN
             item_orders io ON io.item_id = i.id AND io.created_at >= SYSDATE - INTERVAL '90' DAY(3)
         GROUP BY
             c.name
         ORDER BY
             sum DESC
     ),
     sales_by_category_year AS (
         SELECT
             c.name AS category_name,
             CASE
                 WHEN SUM(io.item_amount * i.price_per_item) IS NULL THEN 0
                 ELSE SUM(io.item_amount * i.price_per_item)
                 END AS sum
         FROM
             categories c
                 LEFT JOIN
             item_categories ic ON ic.category_id = c.id
                 LEFT JOIN
             items i ON i.id = ic.item_id
                 LEFT JOIN
             item_orders io ON io.item_id = i.id AND io.created_at >= SYSDATE - INTERVAL '365' DAY(3)
         GROUP BY
             c.name
         ORDER BY
             sum DESC
     )
SELECT
    sales_by_category_year.category_name,
    sales_by_category_year.sum AS year_sum,
    sales_by_category_quartal.sum AS quartal_sum,
    sales_by_category_month.sum AS month_sum
FROM
    sales_by_category_month
        LEFT JOIN
    sales_by_category_quartal ON sales_by_category_month.category_name = sales_by_category_quartal.category_name
        LEFT JOIN
    sales_by_category_year ON sales_by_category_month.category_name = sales_by_category_year.category_name;


-- 8. Отримати список замовлень зі статусом «відкладено» із зазначенням причин
-- відкладення.
SELECT
        O.ID,
        O.REASON_CANCELED
    FROM
        ORDERS O
WHERE REASON_CANCELED IS NOT NULL AND STATUS = 'canceled'



-- 9. Провести аналіз лояльності клієнтів: перелік клієнтів з найбільшою кількістю
-- замовлень та витраченими сумами.

WITH Order_Prices
         AS (
        SELECT O.ID,
               SUM(IO.ITEM_AMOUNT * I.PRICE_PER_ITEM) as order_price
        FROM ORDERS O
                 LEFT JOIN ITEM_ORDERS IO ON O.ID = IO.ORDER_ID
                 LEFT JOIN ITEMS I ON IO.ITEM_ID = I.ID
        GROUP BY O.ID
    )

SELECT
    C.NAME,
    COUNT(O.ID),
    SUM(OP.order_price) as total_client_order_price

    FROM
ORDERS O
LEFT JOIN Order_Prices OP ON OP.ID = O.ID
LEFT JOIN CLIENTS C ON O.CLIENT_ID = C.ID
GROUP BY C.NAME
ORDER BY total_client_order_price DESC


-- 10. Отримати звіт по доставках: статус замовлення, середній час доставки,
-- проблемні випадки.
SELECT
    O.ID,
    O.STATUS,
    (SELECT
         AVG(
                 (O.DELIVERED_AT - O.ORDERED_AT) * 24
         )
     FROM ORDERS O
     WHERE O.DELIVERED_AT IS NOT NULL
    ) as average_delivery_time_hours
FROM ORDERS O;
