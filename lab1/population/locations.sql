BEGIN


insert into Locations (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID)
values (1000, '1297 Via Cola di Rie', '00989', 'Roma', null, 'IT');

insert into Locations (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID)
values (1100, '93091 Calle della Testa', '10934', 'Venice', null, 'IT');

insert into Locations (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID)
values (1200, '2017 Shinjuku-ku', '1689', 'Tokyo', 'Tokyo Prefecture', 'JP');

insert into Locations (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID)
values (1300, '9450 Kamiya-cho', '6823', 'Hiroshima', null, 'JP');

insert into Locations (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID)
values (1400, '2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 'US');

insert into Locations (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID)
values (1500, '2011 Interiors Blvd', '99236', 'South San Francisco', 'California', 'US');

insert into Locations (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID)
values (1600, '2007 Zagora St', '50090', 'South Brunswick', 'New Jersey', 'US');

insert into Locations (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID)
values (1700, '2004 Charade Rd', '98199', 'Seattle', 'Washington', 'US');

insert into Locations (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID)
values (1800, '147 Spadina Ave', 'M5V 2L7', 'Toronto', 'Ontario', 'CA');

insert into Locations (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID)
values (1900, '6092 Boxwood St', 'YSW 9T2', 'Whitehorse', 'Yukon', 'CA');

insert into Locations (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID)
values (2000, '40-5-12 Laogianggen', '190518', 'Beijing', null, 'CN');

insert into Locations (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID)
values (2100, '1298 Vileparle (E)', '490231', 'Bombay', 'Maharashtra', 'IN');

insert into Locations (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID)
values (2200, '12-98 Victoria Street', '2901', 'Sydney', 'New South Wales', 'AU');

insert into Locations (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID)
values (2300, '198 Clementi North', '540198', 'Singapore', null, 'SG');

insert into Locations (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID)
values (2400, '8204 Arthur St', null, 'London', null, 'UK');

insert into Locations (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID)
values (2500, 'Magdalen Centre, The Oxford Science Park', 'OX9 9ZB', 'Oxford', 'Oxford', 'UK');

insert into Locations (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID)
values (2600, '9702 Chester Road', '09629850293', 'Stretford', 'Manchester', 'UK');

insert into Locations (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID)
values (2700, 'Schwanthalerstr. 7031', '80925', 'Munich', 'Bavaria', 'DE');

insert into Locations (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID)
values (2800, 'Rua Frei Caneca 1360 ', '01307-002', 'Sao Paulo', 'Sao Paulo', 'BR');

insert into Locations (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID)
values (2900, '20 Rue des Corps-Saints', '1730', 'Geneva', 'Geneve', 'CH');

insert into Locations (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID)
values (3000, 'Murtenstrasse 921', '3095', 'Bern', 'BE', 'CH');

insert into Locations (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID)
values (3100, 'Pieter Breughelstraat 837', '3029SK', 'Utrecht', 'Utrecht', 'NL');

insert into Locations (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID)
values (3200, 'Mariano Escobedo 9991', '11932', 'Mexico City', 'Distrito Federal,', 'MX');
COMMIT;

EXCEPTION
WHEN OTHERS THEN
ROLLBACK;
DBMS_OUTPUT.PUT_LINE('Помилка: ' || SQLERRM);
END;
