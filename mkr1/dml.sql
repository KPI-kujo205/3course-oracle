

-- 2. Наповнення тестовими даними (DML)
INSERT INTO Agency VALUES (1, 'Star Talent',SYSTIMESTAMP);
INSERT INTO Agency VALUES (2, 'Super Agency',SYSTIMESTAMP);
INSERT INTO Agency VALUES (4, 'Star Talent 3',SYSTIMESTAMP);
INSERT INTO Agency VALUES (5, 'Star Talent 4',SYSTIMESTAMP);
INSERT INTO Agency VALUES (6, 'Star Talent 5',SYSTIMESTAMP);
INSERT INTO Agency VALUES (6, 'Super Agency 6',SYSTIMESTAMP);
INSERT INTO Agency VALUES (7, 'Super Agency 7',SYSTIMESTAMP);
INSERT INTO Agency VALUES (8, 'Super Agency 8',SYSTIMESTAMP);
COMMIT;

INSERT INTO Agency_member VALUES (1, 1, 'John Doe', 'john@example.com', '12345', 'agent', SYSTIMESTAMP);
INSERT INTO Agency_member VALUES (2, 1, 'Alice Smith', 'alice@example.com', '12345', 'artist', SYSTIMESTAMP);
INSERT INTO Agency_member VALUES (3, 1, 'Bob Brown', 'bob@example.com', '54321', 'agent', SYSTIMESTAMP);
INSERT INTO Agency_member VALUES (4, 2, 'Eve Adams', 'eve@example.com', '54321', 'artist', SYSTIMESTAMP);
INSERT INTO Agency_member VALUES (5, 2, 'Charlie White', 'charlie@example.com', '67890', 'agent', SYSTIMESTAMP);
INSERT INTO Agency_member VALUES (6, 2, 'David Green', 'david@example.com', '67890', 'artist', SYSTIMESTAMP);
INSERT INTO Agency_member VALUES (7, 1, 'Sarah Connor', 'sarah@example.com', '12345', 'artist', SYSTIMESTAMP);
INSERT INTO Agency_member VALUES (8, 1, 'Michael Fox', 'michael@example.com', '54321', 'artist', SYSTIMESTAMP);
INSERT INTO Agency_member VALUES (9, 2, 'Sophia Blue', 'sophia@example.com', '67890', 'artist', SYSTIMESTAMP);
INSERT INTO Agency_member VALUES (10, 2, 'Greg Johnson', 'greg@example.com', '12345', 'agent', SYSTIMESTAMP);

COMMIT;
