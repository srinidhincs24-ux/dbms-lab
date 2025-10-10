use mysql;
create user "srinidhi" identified by "sriiinidhi";
grant all privileges on *.* to "srinidhi";
flush privileges; 
show databases;
create database INSURANCE1;
use INSURANCE1;
 
create table person (driver_id varchar(10),
name varchar(20),
address varchar(30),
primary key(driver_id));

create table car (reg_number varchar (30) primary key,
model varchar(30),
years int);

create table accident(report_num int primary key,
accident_date date,
location varchar(30));

create table owns(driver_id varchar(30),
reg_number varchar(30),
primary key(driver_id,reg_number),
foreign key(driver_id) references person(driver_id),
foreign key(reg_number) references car(reg_number));

create table participated(driver_id varchar(10), reg_number varchar(10),
report_num int, damage_amount int,
primary key(driver_id, reg_number, report_num),
foreign key(driver_id) references person(driver_id),
foreign key(reg_number) references car(reg_number),
foreign key(report_num) references accident(report_num));

insert into person values('A01','Richard','Srinivas Nagar'),
('A02','Pradeep','Rajajinagar'),
('A03','Smith','Ashoknagar'),
('A04','Venu','N R Colony'),
('A05','John','Hanumanth nagar');

 insert into car values('KA052250','Indica', 1990),
 ('KA031181','Lancer', 1957),
 ('KA095477','Toyota',1998),
 ('KA053408','Honda',2008),
 ('KA041702','Audi',2005);
 
  insert into accident values(11,'2001-01-03','Mysore Road'),
 (12,'2008-02-04','Southend Circle'),
 (13,'2003-01-03','Bulltemple Road'),
 (14,'2009-01-08','Mysore Road'),
 (15,'2007-03-05','Kanakpura Road');

 insert into owns values('A01','KA052250'),
('A02','KA053408'),
('A04','KA031181'),
('A03','KA095477'),
('A05','KA041702');

 insert into participated values('A01','KA052250',11,10000),
('A02','KA053408',12,5000),
('A04','KA031181',13,25000),
('A03','KA095477',14,3000),
('A05','KA041702',15,5000);

select* from person;
select* from car;
select* from owns;
select* from accident;
select* from participated;

select accident_date,location
from accident;

select p.name
from person p, participated pa 
where (p.driver_id = pa.driver_id)and (damage_amount>=25000);

select p.name, c.model
from person p, car c, owns o
where (p.driver_id=o.driver_id) and (c.reg_number=o.reg_number);

select p.name, a.accident_date,  pa.damage_amount
from person p , accident a, participated pa
where p.driver_id=pa.driver_id and a.report_num=pa.report_num;

select p.name 
from person p, participated pa
where p.driver_id=pa.driver_id 
group by pa.driver_id 
having count(*)>1;

select c.model 
from car c
where reg_number not in ( select pa.reg_number
							from participated pa);

select *
from accident
where accident_date >= all (select accident_date
							from accident);

select p.name, avg(pa.damage_amount) as average
from person p, participated pa
where p.driver_id=pa.driver_id 
group by pa.driver_id;

update participated
set damage_amount = 25000
where driver_id='A02';
select* from participated;

select driver_id
from participated
where damage_amount >= all (select damage_amount
                         from participated);



