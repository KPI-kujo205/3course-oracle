BEGIN

insert into JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
values ('AD_PRES', 'President', 20080, 40000);

insert into JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
values ('AD_VP', 'Administration Vice President', 15000, 30000);

insert into JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
values ('AD_ASST', 'Administration Assistant', 3000, 6000);

insert into JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
values ('FI_MGR', 'Finance Manager', 8200, 16000);

insert into JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
values ('FI_ACCOUNT', 'Accountant', 4200, 9000);

insert into JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
values ('AC_MGR', 'Accounting Manager', 8200, 16000);

insert into JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
values ('AC_ACCOUNT', 'Public Accountant', 4200, 9000);

insert into JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
values ('SA_MAN', 'Sales Manager', 10000, 20080);

insert into JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
values ('SA_REP', 'Sales Representative', 6000, 12008);

insert into JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
values ('PU_MAN', 'Purchasing Manager', 8000, 15000);

insert into JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
values ('PU_CLERK', 'Purchasing Clerk', 2500, 5500);

insert into JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
values ('ST_MAN', 'Stock Manager', 5500, 8500);

insert into JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
values ('ST_CLERK', 'Stock Clerk', 2008, 5000);

insert into JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
values ('SH_CLERK', 'Shipping Clerk', 2500, 5500);

insert into JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
values ('IT_PROG', 'Programmer', 4000, 10000);

insert into JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
values ('MK_MAN', 'Marketing Manager', 9000, 15000);

insert into JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
values ('MK_REP', 'Marketing Representative', 4000, 9000);

insert into JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
values ('HR_REP', 'Human Resources Representative', 4000, 9000);

insert into JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
values ('PR_REP', 'Public Relations Representative', 4500, 10500);

COMMIT ;
EXCEPTION
WHEN OTHERS THEN
ROLLBACK;
DBMS_OUTPUT.PUT_LINE('Помилка при популяції jobs: ' || SQLERRM);
END;
