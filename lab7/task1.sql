-- Створення таблиці Persons
CREATE TABLE Persons (
    ID NUMBER(10) NOT NULL,
    FirstName VARCHAR2(50) NOT NULL,
    MiddleName VARCHAR2(50) NOT NULL,
    LastName VARCHAR2(50) NOT NULL,
    EmailAddress VARCHAR2(100) NOT NULL,
    PhoneNumber VARCHAR2(20) NOT NULL,
    CONSTRAINT PK_Persons PRIMARY KEY (ID)
);


COMMIT ;
-- Створення послідовності для автоматичної генерації ID
CREATE SEQUENCE seq_persons_id
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- ======================================================================
-- КРОК 2: Наповнення таблиці даними (20 рядків)
-- ======================================================================

INSERT INTO Persons (ID, FirstName, MiddleName, LastName, EmailAddress, PhoneNumber) VALUES
(seq_persons_id.NEXTVAL, 'Олександр', 'Іванович', 'Петренко', 'o.petrenko@email.com', '+380501234567');

INSERT INTO Persons (ID, FirstName, MiddleName, LastName, EmailAddress, PhoneNumber) VALUES
(seq_persons_id.NEXTVAL, 'Марія', 'Сергіївна', 'Коваленко', 'm.kovalenko@email.com', '+380671234568');

INSERT INTO Persons (ID, FirstName, MiddleName, LastName, EmailAddress, PhoneNumber) VALUES
(seq_persons_id.NEXTVAL, 'Дмитро', 'Олександрович', 'Шевченко', 'd.shevchenko@email.com', '+380931234569');

INSERT INTO Persons (ID, FirstName, MiddleName, LastName, EmailAddress, PhoneNumber) VALUES
(seq_persons_id.NEXTVAL, 'Анна', 'Володимирівна', 'Мельник', 'a.melnyk@email.com', '+380501234570');

INSERT INTO Persons (ID, FirstName, MiddleName, LastName, EmailAddress, PhoneNumber) VALUES
(seq_persons_id.NEXTVAL, 'Сергій', 'Миколайович', 'Бондаренко', 's.bondarenko@email.com', '+380671234571');

INSERT INTO Persons (ID, FirstName, MiddleName, LastName, EmailAddress, PhoneNumber) VALUES
(seq_persons_id.NEXTVAL, 'Тетяна', 'Олегівна', 'Лисенко', 't.lysenko@email.com', '+380931234572');

INSERT INTO Persons (ID, FirstName, MiddleName, LastName, EmailAddress, PhoneNumber) VALUES
(seq_persons_id.NEXTVAL, 'Володимир', 'Андрійович', 'Козлов', 'v.kozlov@email.com', '+380501234573');

INSERT INTO Persons (ID, FirstName, MiddleName, LastName, EmailAddress, PhoneNumber) VALUES
(seq_persons_id.NEXTVAL, 'Оксана', 'Василівна', 'Савченко', 'o.savchenko@email.com', '+380671234574');

INSERT INTO Persons (ID, FirstName, MiddleName, LastName, EmailAddress, PhoneNumber) VALUES
(seq_persons_id.NEXTVAL, 'Андрій', 'Петрович', 'Романенко', 'a.romanenko@email.com', '+380931234575');

INSERT INTO Persons (ID, FirstName, MiddleName, LastName, EmailAddress, PhoneNumber) VALUES
(seq_persons_id.NEXTVAL, 'Юлія', 'Ігорівна', 'Морозова', 'y.morozova@email.com', '+380501234576');

INSERT INTO Persons (ID, FirstName, MiddleName, LastName, EmailAddress, PhoneNumber) VALUES
(seq_persons_id.NEXTVAL, 'Максим', 'Русланович', 'Гончаренко', 'm.goncharenko@email.com', '+380671234577');

INSERT INTO Persons (ID, FirstName, MiddleName, LastName, EmailAddress, PhoneNumber) VALUES
(seq_persons_id.NEXTVAL, 'Світлана', 'Олександрівна', 'Павленко', 's.pavlenko@email.com', '+380931234578');

INSERT INTO Persons (ID, FirstName, MiddleName, LastName, EmailAddress, PhoneNumber) VALUES
(seq_persons_id.NEXTVAL, 'Віктор', 'Михайлович', 'Кравченко', 'v.kravchenko@email.com', '+380501234579');

INSERT INTO Persons (ID, FirstName, MiddleName, LastName, EmailAddress, PhoneNumber) VALUES
(seq_persons_id.NEXTVAL, 'Наталія', 'Юріївна', 'Іваненко', 'n.ivanenko@email.com', '+380671234580');

INSERT INTO Persons (ID, FirstName, MiddleName, LastName, EmailAddress, PhoneNumber) VALUES
(seq_persons_id.NEXTVAL, 'Роман', 'Сергійович', 'Ткаченко', 'r.tkachenko@email.com', '+380931234581');

INSERT INTO Persons (ID, FirstName, MiddleName, LastName, EmailAddress, PhoneNumber) VALUES
(seq_persons_id.NEXTVAL, 'Катерина', 'Вікторівна', 'Білоус', 'k.bilous@email.com', '+380501234582');

INSERT INTO Persons (ID, FirstName, MiddleName, LastName, EmailAddress, PhoneNumber) VALUES
(seq_persons_id.NEXTVAL, 'Ігор', 'Валерійович', 'Семенов', 'i.semenov@email.com', '+380671234583');

INSERT INTO Persons (ID, FirstName, MiddleName, LastName, EmailAddress, PhoneNumber) VALUES
(seq_persons_id.NEXTVAL, 'Лідія', 'Станіславівна', 'Данилова', 'l.danylova@email.com', '+380931234584');

INSERT INTO Persons (ID, FirstName, MiddleName, LastName, EmailAddress, PhoneNumber) VALUES
(seq_persons_id.NEXTVAL, 'Валентин', 'Олексійович', 'Федоров', 'v.fedorov@email.com', '+380501234585');

INSERT INTO Persons (ID, FirstName, MiddleName, LastName, EmailAddress, PhoneNumber) VALUES
(seq_persons_id.NEXTVAL, 'Інна', 'Дмитрівна', 'Левченко', 'i.levchenko@email.com', '+380671234586');

-- Підтвердження вставки даних
COMMIT;

-- Створення послідовності для автоматичної генерації ID
CREATE SEQUENCE seq_persons_id
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

SELECT * FROM Persons ORDER BY ID;

-- ======================================================================
-- КРОК 3: Створення збереженої процедури для маскування даних
-- ======================================================================


CREATE OR REPLACE PROCEDURE MaskPersonsData AS
BEGIN
    -- Оновлення всіх записів з маскуванням даних (окрім ID)
    UPDATE Persons
    SET
        FirstName = RPAD('*', LENGTH(FirstName), '*'),
        MiddleName = RPAD('*', LENGTH(MiddleName), '*'),
        LastName = RPAD('*', LENGTH(LastName), '*'),
        EmailAddress = CONCAT('****', SUBSTR(EmailAddress, INSTR(EmailAddress, '@'))),
        PhoneNumber = CONCAT('+***', SUBSTR(PhoneNumber, -4));

    -- Підтвердження змін
    COMMIT;

    -- Повідомлення про успішне виконання
    DBMS_OUTPUT.PUT_LINE('Дані успішно замасковано. Оброблено ' || SQL%ROWCOUNT || ' записів.');

EXCEPTION
    WHEN OTHERS THEN
        -- У випадку помилки - відкат змін
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Помилка під час маскування даних: ' || SQLERRM);
        RAISE;
END MaskPersonsData;
/

COMMIT ;

-- Перед виконанням - показати оригінальні дані
SELECT ID, FirstName, MiddleName, LastName, EmailAddress, PhoneNumber
FROM Persons
ORDER BY ID;

-- Виконання процедури маскування
BEGIN
    MaskPersonsData();
END;
/

-- Після виконання - показати замасковані дані
SELECT ID, FirstName, MiddleName, LastName, EmailAddress, PhoneNumber
FROM Persons
ORDER BY ID;

COMMIT ;
