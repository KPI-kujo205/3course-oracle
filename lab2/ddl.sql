CREATE TABLE regions (
    id RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE suppliers (
    id RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categories (
    id RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE clients (
    id RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) NOT NULL,
    phone VARCHAR2(100) NOT NULL,
    birthday DATE NOT NULL,
    region_id RAW(16) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_region
        FOREIGN KEY (region_id)
        REFERENCES regions(id)
);

CREATE OR REPLACE TRIGGER update_clients_timestamp
BEFORE UPDATE ON clients
FOR EACH ROW
BEGIN
    :NEW.updated_at := CURRENT_TIMESTAMP;
END;
/

CREATE TABLE items (
    id RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    description VARCHAR2(255),
    price_per_item NUMBER(10, 2) NOT NULL,
    supplier_id RAW(16) NOT NULL,
    amount_supplied NUMBER(10) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_supplier
        FOREIGN KEY (supplier_id)
        REFERENCES suppliers(id)
);

CREATE OR REPLACE TRIGGER update_items_timestamp
BEFORE UPDATE ON items
FOR EACH ROW
BEGIN
    :NEW.updated_at := CURRENT_TIMESTAMP;
END;
/

CREATE TABLE item_categories (
    category_id RAW(16) NOT NULL,
    item_id RAW(16) NOT NULL,
    PRIMARY KEY (category_id, item_id),
    CONSTRAINT fk_category
        FOREIGN KEY (category_id)
        REFERENCES categories(id),
    CONSTRAINT fk_item
        FOREIGN KEY (item_id)
        REFERENCES items(id)
);

CREATE TABLE orders (
    id RAW(16) DEFAULT SYS_GUID() PRIMARY KEY,
    client_message VARCHAR2(255),
    client_id RAW(16) NOT NULL,
    status VARCHAR2(20) CHECK (status IN ('canceled', 'ordered', 'processed', 'delivered', 'lost', 'returned_by_client')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ordered_at TIMESTAMP,
    delivered_at TIMESTAMP,
    cancelled_at TIMESTAMP,
    processed_at TIMESTAMP,
    RATE_SPEED INTEGER,
    RATE_QUALITY INTEGER,
    REASON_CANCELED VARCHAR2(256),


        CONSTRAINT fk_client
            FOREIGN KEY (client_id)
            REFERENCES clients(id)
    );

CREATE TABLE item_orders (
    item_id RAW(16) NOT NULL,
    order_id RAW(16) NOT NULL,
    item_amount NUMBER(10) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (item_id, order_id),
    CONSTRAINT fk_item_order_1
        FOREIGN KEY (item_id)
        REFERENCES items(id),
    CONSTRAINT fk_item_order_2
        FOREIGN KEY (order_id)
        REFERENCES orders(id)
);

CREATE OR REPLACE TRIGGER update_item_orders_timestamp
BEFORE UPDATE ON item_orders
FOR EACH ROW
BEGIN
    :NEW.updated_at := CURRENT_TIMESTAMP;
END;
/
