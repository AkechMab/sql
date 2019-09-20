/*MySQL Create Table [20 exercises with solution]
https://www.w3resource.com/mysql-exercises/create-table-exercises/ */

--1. Write a SQL statement to create a simple table countries including columns country_id,country_name and region_id.
Create table countries
(country_id varchar(4), --column_id datatype will accept letters, numbers, and special characters with maximum 4 characters 
country_name varchar(30), --country_name datatype will accept letters, numbers, and special characters with maximum 30 characters
region_id decimal(10,0)) -- --region_id datatype will accept fixed-point number with maximum 10 characters and not digits after the decimal

--2. Write a SQL statement to create a simple table countries including columns country_id,country_name and region_id which is already exists.
If not exists (select * from sysobjects where name='countries' and xtype='U') --system objects check for table name Countries with which contains a user table
	Create table Countries( --If the table is not found then a table will be created
		country_id varchar(4) null,
		country_name varchar(30) null,
		region_id decimal(10,0) null
	);
--When executed here in the W3ResourcesExercise Database the table is not created since the Countries table already exists

--3. Write a SQL statement to create the structure of a table dup_countries similar to countries.
Select * into dup_countries --create a new table called dupcountries
from Countries -- create the new table from an existing table
where 1=0; -- this last statement ensures that no data will be transferred from old table to new table only the table schema, structure

-- 4. Write a SQL statement to create a duplicate copy of countries table including structure and data by name dup_countries.
select * into dup_countries --excluding the where clause from the statement will create a new table with the same structure and data
from Countries;

--5. Write a SQL statement to create a table countries set a constraint NULL.
if not exists (select * from sysobjects where name='countries' and xtype='U')
	Create table countries(
		country_id varchar(4) not null, --set the constraint to not allow null values
		country_name varchar(30) not null,
		region_id decimal(10,0) not null
	);

/* 6. Write a SQL statement to create a table named jobs including columns job_id, job_title, min_salary, max_salary
and check whether the max_salary amount exceeding the upper limit 25000.*/
if not exists(select * from sysobjects where name='jobs' and xtype='U')
	Create table jobs(
		job_id varchar(4) not null, --datatype allows letters, numbers, and special characters of up to four characters
		job_title varchar(40) null, --datatype allows letters, numbers, and special characters of up to 40 characters
		min_salary decimal(6,2) not null, --datatype allows numbers of up to six digits and two digits after the zero
		max_salary decimal(6,2) not null, --datatype allows numbers of up to six digits and two digits after the zero
		check(max_salary<=25000), --checks that the max salary does not exceed the limit of this value
	);

/*7. Write a SQL statement to create a table named countries including columns country_id, country_name and region_id and
make sure that no countries except Italy, India and China will be entered in the table.*/
if not exists(select * from sysobjects where name='countries' and xtype='U')
	create table countries(
		country_id varchar(4) not null,
		country_name varchar(40) not null,
		check (country_name in ('Italy','India','China')), --this also only the countries Italy, India, and China to be added as country_name
		region_id decimal(10,0) null,
	)

/*8. Write a SQL statement to create a table named job_histry including columns employee_id,
start_date, end_date, job_id and department_id and make sure that the value against column
end_date will be entered at the time of insertion to the format like '--/--/----'.*/
if not exists(select * from sysobjects where name='job_history' and xtype='U') --name job_histry corrected to job_history
	create table job_histry(
		[employee_id] varchar(4) not null,
		[start_date] date not null,
		[end_date] date not null,
		check([end_date] like '--/--/----'), --format of the end_date must be --/--/----
		job_id varchar(4) not null,
		department_id varchar(4) not null
	);

/*9. Write a SQL statement to create a table named countries including columns country_id,country_name and region_id
and make sure that no duplicate data against column country_id will be allowed at the time of insertion.*/
if not exists(select * from sysobjects where name='countries' and xtype='U')
	create table countries(
		country_id varchar(4) unique not null, --the unqiue constraints ensures that there will be not duplicate data in the country_id column
		country_name varchar(40) not null,
		region_id decimal(10,0)
	);

/*10. Write a SQL statement to create a table named jobs including columns job_id, job_title, min_salary and max_salary,
and make sure that, the default value for job_title is blank and min_salary is 8000 and max_salary is NULL will be entered
automatically at the time of insertion if no value assigned for the specified columns.*/
if not exists (select * from sysobjects where name='jobs' and xtype='U')
	create table jobs(
		job_id varchar(4) primary key not null,
		job_title varchar(30) default ' ', -- the default here is blank
		min_salary decimal(6,2) default 8000, -- default here is 8000
		max_salary decimal(6,2) default NULL, -- default here is NULL
		check(max_salary<=25000),
	)

/*11. Write a SQL statement to create a table named countries including columns country_id, country_name and region_id and
make sure that the country_id column will be a key field which will not contain any duplicate data at the time of insertion.*/
if not exists(select * from sysobjects where name='countries' and xtype='U')
	create table countries(
		country_id varchar(4) not null primary key, --primary key does not allow duplicate values
		country_name varchar(40) not null,
		check(country_name in ('Italy','India','China')),
		region_id decimal(10,0) null
	)

/*12. Write a SQL statement to create a table countries including columns country_id, country_name and region_id and make sure
that the column country_id will be unique and store an auto incremented value.*/
if not exists (select * from sysobjects where name='Countries' and xtype='U')
	create table countries(
		country_id int primary key identity(1,1), -- autoincrement the country_id
		country_name varchar(40) not null default ' ',
		region_id decimal(10,0)
	);

/*13. Write a SQL statement to create a table countries including columns country_id, country_name and region_id and make sure
that the combination of columns country_id and region_id will be unique.*/
if not exists (select * from sysobjects where name='countries' and xtype='U')
	create table countries(
		country_id int,
		country_name varchar(40) not null default ' ',
		region_id decimal(10,0) not null,
		constraint countriesId unique (country_id,region_id) -- set contraint so that the combination of country_id and region_id are unique 
	);

/*14. Write a SQL statement to create a table job_history including columns employee_id, start_date, end_date, job_id and department_id
and make sure that, the employee_id column does not contain any duplicate value at the time of insertion and the foreign key column
job_id contain only those values which are exists in the jobs table.*/
if not exists (select * from sysobjects where name='job_history' and xtype='U')
	create table job_history(
		employee_id int not null identity(0001,1) primary key,
		[start_date] date not null,
		[end_date] date not null,
		job_id varchar(4) not null,
		department_id decimal(4,0) default null,
		foreign key (job_id) references jobs(job_id) --add foreign key which values exist in the jobs table
	);

/*15. Write a SQL statement to create a table employees including columns employee_id, first_name, last_name, email, phone_number hire_date,
job_id, salary, commission, manager_id and department_id and make sure that, the employee_id column does not contain any duplicate value at
the time of insertion and the foreign key columns combined by department_id and manager_id columns contain only those unique combination
values, which combinations are exists in the departments table.*/
if not exists (select * from sysobjects where name='departments' and xtype='U')
	create table departments(
		department_id decimal(4,0) not null primary key default 0,
		department_name varchar(30) not null default null,
		manager_id decimal(6,0) not null unique default 0,
		location_id decimal(4,0) null default NULL,
		constraint departmentPair unique(department_id,manager_id) -- set contraint so that the combination of department_id and manager_id are unique
	);

if not exists (select * from sysobjects where name='employees' and xtype='U')
	create table employees(
		employee_id varchar(4) not null primary key, 
		first_name varchar(40) not null,
		last_name varchar(40) not null,
		email varchar(40) not null,
		phone_number varchar(40) null,
		hire_date date,
		job_id varchar(4) not null,
		salary decimal(5,2) not null,
		check(salary<25000),
		commission decimal(5,2) not null,
		manager_id varchar(40) not null,
		department_id decimal(4,0) not null,
		foreign key(department_id) references departments(department_id) -- add foreign key references to the departments table
	);