-- Максимальна кількість товарів у кожному замовленні
SELECT
    o.id AS order_id,
    I.NAME,

    MAX(io.item_amount) AS max_item_amount
FROM
    orders o
        JOIN
    item_orders io ON o.id = io.order_id
    LEFT JOIN ITEMS I ON IO.ITEM_ID = I.ID

GROUP BY
    o.id, I.NAME
ORDER BY max_item_amount DESC;

-- Клієнт з і кількість замовлень
SELECT
    CL.NAME,
    COUNT(O.ID) as order_count
    FROM CLIENTS CL
LEFT JOIN ORDERS O ON CL.ID = O.CLIENT_ID
GROUP BY CL.NAME


-- Середня ціна кожного замовлення клієнтів
WITH Order_Prices
         AS (
        SELECT O.ID, O.CLIENT_ID,
               SUM(IO.ITEM_AMOUNT * I.PRICE_PER_ITEM) as order_price
        FROM ORDERS O
                 LEFT JOIN ITEM_ORDERS IO ON O.ID = IO.ORDER_ID
                 LEFT JOIN ITEMS I ON IO.ITEM_ID = I.ID
        GROUP BY O.ID, CLIENT_ID
    )
SELECT
    C.NAME,
    AVG(OP.order_price)
FROM Order_Prices OP
LEFT JOIN CLIENTS C ON OP.CLIENT_ID = C.ID
GROUP BY C.NAME

ORDER BY AVG(OP.order_price) DESC;


-- Мінімальна ціна замовлення для кожного клієнта
WITH Order_Prices
         AS (
        SELECT O.ID, O.CLIENT_ID,
               SUM(IO.ITEM_AMOUNT * I.PRICE_PER_ITEM) as order_price
        FROM ORDERS O
                 LEFT JOIN ITEM_ORDERS IO ON O.ID = IO.ORDER_ID
                 LEFT JOIN ITEMS I ON IO.ITEM_ID = I.ID
        GROUP BY O.ID, CLIENT_ID
    )
SELECT
    C.NAME,
    MIN(OP.order_price)
FROM Order_Prices OP
         LEFT JOIN CLIENTS C ON OP.CLIENT_ID = C.ID
GROUP BY C.NAME

ORDER BY MIN(OP.order_price) DESC;
