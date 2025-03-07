BEGIN



insert into Job_History (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID)
values (102, to_date('13-01-2001', 'dd-mm-yyyy'), to_date('24-07-2006', 'dd-mm-yyyy'), 'IT_PROG', 60);

insert into Job_History (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID)
values (101, to_date('21-09-1997', 'dd-mm-yyyy'), to_date('27-10-2001', 'dd-mm-yyyy'), 'AC_ACCOUNT', 110);

insert into Job_History (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID)
values (101, to_date('28-10-2001', 'dd-mm-yyyy'), to_date('15-03-2005', 'dd-mm-yyyy'), 'AC_MGR', 110);

insert into Job_History (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID)
values (201, to_date('17-02-2004', 'dd-mm-yyyy'), to_date('19-12-2007', 'dd-mm-yyyy'), 'MK_REP', 20);

insert into Job_History (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID)
values (114, to_date('24-03-2006', 'dd-mm-yyyy'), to_date('31-12-2007', 'dd-mm-yyyy'), 'ST_CLERK', 50);

insert into Job_History (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID)
values (122, to_date('01-01-2007', 'dd-mm-yyyy'), to_date('31-12-2007', 'dd-mm-yyyy'), 'ST_CLERK', 50);

insert into Job_History (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID)
values (200, to_date('17-09-1995', 'dd-mm-yyyy'), to_date('17-06-2001', 'dd-mm-yyyy'), 'AD_ASST', 90);

insert into Job_History (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID)
values (176, to_date('24-03-2006', 'dd-mm-yyyy'), to_date('31-12-2006', 'dd-mm-yyyy'), 'SA_REP', 80);

insert into Job_History (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID)
values (176, to_date('01-01-2007', 'dd-mm-yyyy'), to_date('31-12-2007', 'dd-mm-yyyy'), 'SA_MAN', 80);

insert into Job_History (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID)
values (200, to_date('01-07-2002', 'dd-mm-yyyy'), to_date('31-12-2006', 'dd-mm-yyyy'), 'AC_ACCOUNT', 90);

COMMIT ;
EXCEPTION
WHEN OTHERS THEN
ROLLBACK;
DBMS_OUTPUT.PUT_LINE('Помилка при популяції jobs: ' || SQLERRM);
END;
