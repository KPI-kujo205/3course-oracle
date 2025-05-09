
-- 1. Створення таблиць (DDL)
CREATE TABLE Users (
                       id NUMBER PRIMARY KEY,
                       login VARCHAR2(50) NOT NULL UNIQUE,
                       password VARCHAR2(255) NOT NULL
);

CREATE TABLE Individuals (
                             id NUMBER PRIMARY KEY,
                             name VARCHAR2(100) NOT NULL,
                             info CLOB
);

CREATE TABLE Tasks (
                       id NUMBER PRIMARY KEY,
                       description CLOB NOT NULL
);

CREATE TABLE User_Individual (
                                 user_id NUMBER,
                                 individual_id NUMBER,
                                 CONSTRAINT pk_user_individual PRIMARY KEY (user_id, individual_id),
                                 CONSTRAINT fk_user_individual_user FOREIGN KEY (user_id) REFERENCES Users(id),
                                 CONSTRAINT fk_user_individual_ind FOREIGN KEY (individual_id) REFERENCES Individuals(id)
);

CREATE TABLE User_Task (
                           user_id NUMBER,
                           task_id NUMBER,
                           CONSTRAINT pk_user_task PRIMARY KEY (user_id, task_id),
                           CONSTRAINT fk_user_task_user FOREIGN KEY (user_id) REFERENCES Users(id),
                           CONSTRAINT fk_user_task_task FOREIGN KEY (task_id) REFERENCES Tasks(id)
);

COMMIT;
