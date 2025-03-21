
-- 1. Створення таблиць (DDL)
CREATE TABLE Agency (
                        id NUMBER PRIMARY KEY,
                        name VARCHAR2(255) NOT NULL,
                        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Agency_member (
                               id NUMBER PRIMARY KEY,
                               agency_id NUMBER REFERENCES Agency(id),
                               name VARCHAR2(255) NOT NULL,
                               email VARCHAR2(255) UNIQUE NOT NULL,
                               post_index VARCHAR2(20) NOT NULL,
                               type VARCHAR2(10) CHECK (type IN ('agent', 'artist')),
                               created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMIT;
