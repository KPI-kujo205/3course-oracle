-- Create table
create table LOCATIONS
(
    location_id    NUMBER(4) not null,
    street_address VARCHAR2(40),
    postal_code    VARCHAR2(12),
    city           VARCHAR2(30),
    state_province VARCHAR2(25),
    country_id     CHAR(2)
);
-- Add comments to the table
comment on table LOCATIONS
  is 'Locations table that contains specific address of a specific office,
warehouse, and/or production site of a company. Does not store addresses /
locations of customers. Contains 23 rows; references with the
departments and countries tables. ';
-- Add comments to the columns
comment on column LOCATIONS.location_id
  is 'Primary key of locations table';
comment on column LOCATIONS.street_address
  is 'Street address of an office, warehouse, or production site of a company.
Contains building number and street name';
comment on column LOCATIONS.postal_code
  is 'Postal code of the location of an office, warehouse, or production site
of a company. ';
comment on column LOCATIONS.city
  is 'A not null column that shows city where an office, warehouse, or
production site of a company is located. ';
comment on column LOCATIONS.state_province
  is 'State or Province where an office, warehouse, or production site of a
company is located.';
comment on column LOCATIONS.country_id
  is 'Country where an office, warehouse, or production site of a company is
located. Foreign key to country_id column of the countries table.';
-- Create/Recreate indexes
create index LOC_CITY_IX on LOCATIONS (CITY);
create index LOC_COUNTRY_IX on LOCATIONS (COUNTRY_ID);
create index LOC_STATE_PROVINCE_IX on LOCATIONS (STATE_PROVINCE);
-- Create/Recreate primary, unique and foreign key constraints
alter table LOCATIONS
    add constraint LOC_ID_PK primary key (LOCATION_ID);
alter index LOC_ID_PK nologging;
alter table LOCATIONS
    add constraint LOC_C_ID_FK foreign key (COUNTRY_ID)
        references COUNTRIES (COUNTRY_ID);
-- Create/Recreate check constraints
alter table LOCATIONS
    add constraint LOC_CITY_NN
        check ("CITY" IS NOT NULL);
