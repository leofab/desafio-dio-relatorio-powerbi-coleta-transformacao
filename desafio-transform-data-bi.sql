show databases;
create database if not exists azure_company;
use azure_company;
show tables;
CREATE TABLE employee(
	Fname varchar (15) not null,
	Minit char,
	Lmame varchar (15) not null,
	Ssn char (9) not null,
	Bdate date,
	Address varchar (30),
	Sex char,
	Salary decimal (10,2),
	Super_ssn char(9),
	Dno int not null,
	constraint chk_salary_employee check (Salary> 2000.0),
	constraint pk_employee primary key (Ssn)
);
desc employee;
ALTER TABLE employee add constraint fk_employee foreign key(Super_ssn) references employee(Ssn) on delete set null on update cascade;
ALTER TABLE employee modify Dno int not null default 1;
create table departament(
	Dname varchar(15) not null,
	Dnumber int not null,
	Mgr_ssn char(9) not null,
	Mgr_start_date date,
	Dept_create_date date,
	constraint chk_date_dept check (Dept_create_date < Mgr_start_date),
	constraint pk_dept primary key (Dnumber),
	constraint unique_name_dept unique(Dname),
	foreign key (Mgr_ssn) references employee(Ssn)
);
desc departament;
alter table departament drop departament_ibfk_1;
alter table departament
	add constraint fk_dept foreign key(Mgr_ssn) references employee(Ssn)
	on update cascade;
desc departament;
create table dept_locations(
	Dnumber int not null,
	Dlocation varchar(15) not null,
	constraint pk_dept_locations primary key (Dnumber, Dlocation),
	constraint fk_dept_locations foreign key (Dnumber) references departament (Dnumber)
);
alter table dept_locations drop fk_dept_locations;
alter table dept_locations
	add constraint fk_dept_locations foreign key (Dnumber) references departament(Dnumber)
	on delete cascade
	on update cascade;
desc dept_locations;
create table project(
	Pname varchar(15) not null,
	Pnumber int not null,
	Plocation varchar(15),
	Dnum int not null,
	primary key (Pnumber),
	constraint unique_project unique (Pname),
	constraint fk_project foreign key (Dnum) references departament(Dnumber)
);
desc project;
create table works_on(
	Essn char(9) not null,
	Pno int not null,
	Hours decimal (3,1) not null,
	primary key (Essn, Pno),
	constraint fk_employee_works_on foreign key (Essn) references employee(Ssn),
	constraint fk_project_works_on foreign key (Pno) references project(Pnumber)
);
desc works_on;
create table dependent(
Essn char(9) not null,
Dependent_name varchar(15) not null,
Sex char,
Bdate date,
Relationship varchar(8),
primary key (Essn, Dependent_name),
constraint fk_dependent foreign key (Essn) references employee(Ssn)
);
show tables;
desc dependent;
INSERT INTO employee (Fname, Minit, Lmame, Ssn, Bdate, Address, Sex, Salary, Super_ssn, Dno)
VALUES
    ('John', 'D', 'Smith', '123456789', '1990-05-15', '123 Main St', 'M', 500000, NULL, 1),
    ('Jane', 'M', 'Doe', '987654321', '1985-07-20', '456 Elm St', 'F', 600000, '123456789', 2),
    ('Alice', 'A', 'Johnson', '456789123', '1995-02-10', '789 Oak St', 'F', 450000, '123456789', 1),
    ('Bob', 'C', 'Wilson', '111222333', '1988-10-05', '567 Pine St', 'M', 350000, NULL, 2),
    ('Emily', 'B', 'Jones', '444555666', '1992-03-25', '890 Cedar St', 'F', 520000, '111222333', 3),
    ('David', 'R', 'Brown', '777888999', '1987-12-15', '678 Elm St', 'M', 225600, NULL, 1),
    ('Ella', 'S', 'Lee', '999888777', '1993-08-30', '432 Oak St', 'F', 490000, '444555666', 2),
    ('George', 'L', 'Harris', '555666777', '1991-06-10', '765 Maple St', 'M', 520000, '123456789', 1),
    ('Grace', 'P', 'Clark', '333222111', '1986-04-18', '543 Birch St', 'F', 510000, '777888999', 3),
    ('Henry', 'W', 'Anderson', '222111333', '1994-02-28', '987 Walnut St', 'M', 20000, NULL, 2),
    ('Sam', 'K', 'Martin', '333333333', '1980-10-25', '333 Oak St', 'M', 2200.00, NULL, 3),
    ('Sophia', 'L', 'Brown', '444444444', '1996-01-10', '456 Pine St', 'F', 16000.00, '555666777', 1),
    ('Lucas', 'M', 'Smith', '555555555', '1989-07-05', '789 Elm St', 'M', 20000.00, NULL, 2),
    ('Olivia', 'N', 'Davis', '666666666', '1993-12-20', '123 Maple St', 'F', 5400.00, '123456789', 3),
    ('James', 'O', 'Johnson', '777777777', '1990-08-15', '654 Birch St', 'M', 5200.00, NULL, 1),
    ('Ava', 'P', 'Taylor', '888888888', '1985-05-30', '234 Cedar St', 'F', 4900.00, '333222111', 2),
    ('Benjamin', 'Q', 'Brown', '999999999', '1987-03-10', '345 Oak St', 'M', 5600.00, NULL, 3),
    ('Charlotte', 'R', 'Harris', '101010101', '1992-02-28', '456 Pine St', 'F', 4800.00, '123456789', 1),
    ('Daniel', 'S', 'Lee', '121212121', '1994-11-12', '678 Maple St', 'M', 30000.00, NULL, 2),
    ('Mia', 'T', 'Wright', '131313131', '1986-09-25', '987 Elm St', 'F', 5000.00, '555666777', 3),
    ('Ethan', 'U', 'Martin', '141414141', '1996-04-30', '543 Oak St', 'M', 20000.00, NULL, 1),
    ('Emma', 'V', 'Clark', '151515151', '1991-01-05', '765 Birch St', 'F', 5200.00, NULL, 2),
    ('Liam', 'W', 'Anderson', '161616161', '1988-06-20', '890 Cedar St', 'M', 4900.00, '123456789', 3),
    ('Aiden', 'X', 'Davis', '171717171', '1984-03-15', '123 Pine St', 'M', 2130.00, NULL, 1),
    ('Oliver', 'Y', 'Johnson', '181818181', '1987-02-05', '234 Birch St', 'M', 5100.00, '555666777', 2),
    ('Amelia', 'Z', 'Taylor', '191919191', '1993-10-10', '543 Elm St', 'F', 4800.00, '123456789', 3),
    ('Harper', 'A', 'Brown', '202020202', '1992-12-01', '765 Pine St', 'F', 5200.00, '333222111', 1),
    ('Lily', 'B', 'Wright', '212121212', '1989-05-18', '890 Maple St', 'F', 4900.00, NULL, 2),
    ('Logan', 'C', 'Martin', '222222222', '1985-09-30', '432 Cedar St', 'M', 2650.00, NULL, 3),
    ('Mason', 'D', 'Clark', '232323232', '1997-08-25', '654 Elm St', 'M', 5300.00, '777888999', 1);
select * from employee;
INSERT INTO departament (Dname, Dnumber, Mgr_ssn, Mgr_start_date, Dept_create_date)
VALUES
    ('HR', 1, '123456789', '2023-01-01', '2022-01-01'),
    ('IT', 2, '987654321', '2023-02-01', '2022-02-01'),
    ('Finance', 3, '456789123', '2023-03-01', '2022-03-01'),
    ('Sales', 4, '111222333', '2023-04-01', '2022-04-01'),
    ('Marketing', 5, '444555666', '2023-05-01', '2022-05-01');
INSERT INTO dept_locations (Dnumber, Dlocation)
VALUES
    (1, 'New York'),
    (2, 'San Francisco'),
    (3, 'Los Angeles'),
    (4, 'Chicago'),
    (5, 'Miami');
INSERT INTO project (Pname, Pnumber, Plocation, Dnum)
VALUES
    ('Project A', 1, 'New York', 2),
    ('Project B', 2, 'San Francisco', 3),
    ('Project C', 3, 'Los Angeles', 1),
    ('Project D', 4, 'Chicago', 4),
    ('Project E', 5, 'Miami', 5);
INSERT INTO works_on (Essn, Pno, Hours)
VALUES
    ('123456789', 1, 40.0),
    ('987654321', 2, 35.5),
    ('456789123', 3, 42.0),
    ('111222333', 4, 38.5),
    ('444555666', 5, 41.0),
    ('777888999', 1, 39.0),
    ('999888777', 2, 37.5),
    ('555666777', 3, 40.5),
    ('333222111', 4, 36.0),
    ('222111333', 5, 43.0);
INSERT INTO dependent (Essn, Dependent_name, Sex, Bdate, Relationship)
VALUES
    ('123456789', 'Sarah Smith', 'F', '2010-03-15', 'Child'),
    ('987654321', 'Michael Doe', 'M', '2012-07-20', 'Child'),
    ('456789123', 'Sophia Johnson', 'F', '2015-01-10', 'Child'),
    ('111222333', 'Daniel Wilson', 'M', '2008-12-05', 'Child'),
    ('444555666', 'Olivia Jones', 'F', '2013-05-25', 'Child'),
    ('777888999', 'Liam Brown', 'M', '2011-08-15', 'Child'),
    ('999888777', 'Ava Lee', 'F', '2014-02-20', 'Child'),
    ('555666777', 'Noah Harris', 'M', '2009-06-30', 'Child'),
    ('333222111', 'Emma Clark', 'F', '2016-04-08', 'Child'),
    ('222111333', 'Will Anderson', 'M', '2018-02-28', 'Child');