-- Create an audit table for logging
CREATE TABLE ORDER_AUDIT (
    AUDIT_ID      NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ORDER_ID      RAW(16),
    ACTION        VARCHAR2(50),
    ACTION_DATE   TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    DETAILS       VARCHAR2(255)
);
COMMIT;

-- Combined trigger for the ORDERS table
CREATE OR REPLACE TRIGGER trg_orders_combined
    BEFORE INSERT OR UPDATE
    ON ORDERS
    FOR EACH ROW
BEGIN
    -- BEFORE INSERT: Set CREATED_AT timestamp
    IF INSERTING THEN
        :NEW.CREATED_AT := SYSTIMESTAMP;
    END IF;

    -- BEFORE UPDATE: Set UPDATED_AT timestamp
    IF UPDATING THEN
        :NEW.UPDATED_AT := SYSTIMESTAMP;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_orders_after
    AFTER UPDATE OR DELETE OR INSERT
    ON ORDERS
    FOR EACH ROW
BEGIN
    -- AFTER INSERT: Log insert action
    IF INSERTING THEN
        INSERT INTO ORDER_AUDIT (ORDER_ID, ACTION, DETAILS)
        VALUES (:NEW.ID, 'INSERTED', 'New order placed');
    END IF;

    -- AFTER UPDATE: Log update action
    IF UPDATING THEN
        INSERT INTO ORDER_AUDIT (ORDER_ID, ACTION, DETAILS)
        VALUES (:OLD.ID, 'UPDATED', 'Order updated with new details');
    END IF;

    -- AFTER DELETE: Log delete action
    IF DELETING THEN
        INSERT INTO ORDER_AUDIT (ORDER_ID, ACTION, DETAILS)
        VALUES (:OLD.ID, 'DELETED', 'Order deleted');
    END IF;
END;
/

COMMIT ;


DECLARE
    CLIENT_ID RAW(16) := '3041BCBD45B10D28E063020014ACDDA6';
BEGIN
    -- Insert statement or further processing
    INSERT INTO ORDERS (
        CLIENT_ID,
        STATUS
    )
    VALUES (
        CLIENT_ID,
        'ordered' -- Assuming a default status
    );
END;
COMMIT ;
