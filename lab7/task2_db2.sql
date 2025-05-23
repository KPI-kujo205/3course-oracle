
-- 1. Функція для визначення ClientStatus (аналог JobStatus)
-- Базується на активності клієнта та кількості замовлень
CREATE OR REPLACE FUNCTION GET_CLIENT_STATUS(
    p_client_id IN RAW,
    p_birthday IN DATE
) RETURN NUMBER
    IS
    v_order_count NUMBER;
    v_client_status NUMBER;
    v_age NUMBER;
BEGIN
    -- Рахуємо кількість замовлень клієнта
    SELECT COUNT(*)
    INTO v_order_count
    FROM ORDERS
    WHERE CLIENT_ID = p_client_id;

    -- Рахуємо вік клієнта
    v_age := FLOOR(MONTHS_BETWEEN(SYSDATE, p_birthday) / 12);

    -- Логіка для статусів:
    -- 0 - молодий клієнт (< 25 років) без замовлень
    -- 1 - середній клієнт (25-50 років) з 1-3 замовленнями
    -- 2 - активний клієнт (> 3 замовлень незалежно від віку)
    IF v_order_count > 3 THEN
        v_client_status := 2; -- Активний клієнт
    ELSIF v_age < 25 AND v_order_count = 0 THEN
        v_client_status := 0; -- Молодий без замовлень
    ELSIF v_age BETWEEN 25 AND 50 AND v_order_count BETWEEN 1 AND 3 THEN
        v_client_status := 1; -- Середній з невеликою активністю
    ELSE
        v_client_status := 3; -- Інші випадки
    END IF;

    RETURN v_client_status;
END GET_CLIENT_STATUS;
/

-- 2. Функція для визначення OrderStatus (аналог RegionStatus)
-- Базується на статусі замовлення та загальній сумі
CREATE OR REPLACE FUNCTION GET_ORDER_STATUS(
    p_order_status IN VARCHAR2,
    p_total_amount IN NUMBER,
    p_threshold1 IN NUMBER DEFAULT 1000,  -- Мала сума
    p_threshold2 IN NUMBER DEFAULT 5000   -- Велика сума
) RETURN NUMBER
    IS
    v_order_status_code NUMBER;
BEGIN
    -- Логіка для статусів:
    -- 1 - доставлено та сума < threshold1 (маленьке замовлення)
    -- 2 - доставлено та сума > threshold2 (велике замовлення)
    -- 3 - інші випадки
    IF UPPER(p_order_status) = 'DELIVERED' AND p_total_amount < p_threshold1 THEN
        v_order_status_code := 1;
    ELSIF UPPER(p_order_status) = 'DELIVERED' AND p_total_amount > p_threshold2 THEN
        v_order_status_code := 2;
    ELSE
        v_order_status_code := 3;
    END IF;

    RETURN v_order_status_code;
END GET_ORDER_STATUS;
/

-- 3. Функція для розрахунку загальної суми замовлення
CREATE OR REPLACE FUNCTION GET_ORDER_TOTAL(
    p_order_id IN RAW
) RETURN NUMBER
    IS
    v_total NUMBER := 0;
BEGIN
    SELECT NVL(SUM(i.PRICE_PER_ITEM * io.ITEM_AMOUNT), 0)
    INTO v_total
    FROM ITEM_ORDERS io
             JOIN ITEMS i ON io.ITEM_ID = i.ID
    WHERE io.ORDER_ID = p_order_id;

    RETURN v_total;
END GET_ORDER_TOTAL;
/

-- 4. Основний звіт для електронної комерції
SELECT
    -- Інформація про клієнта
    c.NAME as CLIENT_NAME,
    c.EMAIL as CLIENT_EMAIL,
    c.PHONE as CLIENT_PHONE,
    c.BIRTHDAY,
    FLOOR(MONTHS_BETWEEN(SYSDATE, c.BIRTHDAY) / 12) as CLIENT_AGE,
    r.NAME as REGION_NAME,

    -- Інформація про замовлення
    o.ID as ORDER_ID,
    o.STATUS as ORDER_STATUS,
    o.CREATED_AT as ORDER_CREATED,
    o.DELIVERED_AT,
    o.CLIENT_MESSAGE,

    -- Розрахована загальна сума замовлення
    GET_ORDER_TOTAL(o.ID) as ORDER_TOTAL,

    -- Кількість позицій в замовленні
    (SELECT COUNT(*) FROM ITEM_ORDERS WHERE ORDER_ID = o.ID) as ITEMS_COUNT,

    -- Статуси з використанням функцій
    GET_CLIENT_STATUS(c.ID, c.BIRTHDAY) as CLIENT_STATUS,
    GET_ORDER_STATUS(o.STATUS, GET_ORDER_TOTAL(o.ID), 1000, 5000) as ORDER_STATUS_CODE


FROM
    CLIENTS c
        LEFT JOIN REGIONS r ON c.REGION_ID = r.ID
        LEFT JOIN ORDERS o ON c.ID = o.CLIENT_ID
ORDER BY
    c.NAME, o.CREATED_AT DESC;
COMMIT ;
