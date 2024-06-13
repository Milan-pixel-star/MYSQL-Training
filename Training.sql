use sakila;

select * from actor where actor_id=2;

-- functions and logical operators 

select actor_id,first_name from actor where actor_id  in (2,4);

select * from actor  where first_name="NICK" and actor_id=44;

-- get actor id and first name where first name ED or NICK and actorid >=3

select actor_id,first_name from actor where first_name='ED' or first_name='NICK' and actor_id>=3;

select actor_id,first_name from actor where first_name in ('ED','NICK') and actor_id>=3;

select actor_id,first_name from actor where first_name='NICK' or first_name='ED' and actor_id>=3;  -- first priorty to and

-- functions string --> output

-- single row function? input amount = output amount

select first_name from actor;

select first_name,lower(first_name) from actor;

-- dual table ( dummy table )

select upper("abc") from dual;

select first_name,last_name,concat(first_name,' ',last_name) from actor;

select first_name,last_name,concat_ws(' ','MR',first_name,last_name) from actor;

-- ED CHASE

select * from actor where concat(first_name,' ',last_name)="ED CHASE";

select * from actor where first_name like concat("J","%");

-- sub-string 

select first_name,substr(first_name,5) from actor;

select first_name,substr(first_name,2,3) from actor;

select first_name,substr(first_name,-5) from actor;

select first_name,substr(first_name,-2,2) from actor;

-- instr

select first_name,instr(first_name,"A") from actor; 

select first_name,locate("E",first_name,3) from actor;  

-- length -- returns total no of bytes

select length("आ") from dual;

select char_length("आ") from dual; # returns total no of characters

-- trim 
select trim(trailing 'x' from '     abcxxxx') from dual;

select trim(leading 'x' from 'xxxxxxabcxxxx') from dual;

select trim(both '9l' from '9l9labc9l9l') from dual;

-- Lpad and Rpad -- to combine

select rpad(12348,10,'#') from dual;

-- date time functions
-- year month quatar weekofyear

select curdate() from dual;

select current_date() from dual;

select curtime() from dual;

select current_timestamp() from dual;

select current_user() from dual;

select now() from dual;

select adddate(now(),15) from dual;

-- avbbervation for month  year

select adddate(now(),interval 15 day) from dual;

select adddate(now(),interval 15 month) from dual;

select dayname(now()) from dual;



select date_format(now(),"%Y") from dual;

select date_format(now(),"%M") from dual;

select date_format(now(),"%d") from dual;

select date_format(now(),"%M--%Y") from dual;

-- -- numerial function

-- round,truncate, mode

select round(10.6) from dual;
select round(10.4) from dual;
select round(10.456,2) from dual;
select round(10.498,2) from dual;

select truncate(10.456,2) from dual;
select truncate(10.498,2) from dual;

select mod(10.456,2) from dual; -- remainder 

select mod(11,2) from dual;

-- conditional functions

select * from actor;


-- if(condition,True,False)
select if(True,10,20) from dual;

select actor_id,first_name, 
if(actor_id=2,actor_id+10,
		if(actor_id=4,actor_id+20,actor_id)) from actor;


-- case statement 
-- select col,case expression/col when condidtion then what_type_work
						-- end
						-- from table
                        
select actor_id,first_name,
		case actor_id
				when 2 then actor_id+10
		else actor_id
		end as new_col
        from actor;
        
select actor_id,first_name,
		case 
			when actor_id=2 then actor_id+10
		else actor_id
		end as new_col
        from actor;
        
-- if a person has a actor id more than 5 add 10 if actor id > 15 add 25 
-- if actor id > 30  add 30 else add 5

select actor_id,first_name,
		case 
			when actor_id>30 then actor_id+25
            when actor_id>15 then actor_id+15
            when actor_id>5 then actor_id+10
		else actor_id+5
		end as new_col
        from actor;


-- groupby 
-- difference bet distinct and group by  
-- difference bettween where and having clause

create database testing;
use testing;
create table product(
pid int,
pname varchar(20),
oid int
);

create table orders(
oid int,
city varchar(20)
);

insert into product
values
(1,"tv",100),
(2,"mobile",300);

insert into orders 
values
(100,"jaipur"),
(200,"goa"),
(300,"hp");

	select * from product;
    select * from orders;
    
    select pid,pname from
    product join orders; -- cross join cartein join
    -- 1st method
    select pid,pname ,city , orders.oid from
    product join orders
    where (product.oid=orders.oid); -- inner join
    
    
  -- 2nd method
  select pid,pname ,city , orders.oid from
    product join orders
   using(oid);
   
   
 -- 3rd method
 select pid,pname ,city , orders.oid from
    product inner join orders on (product.oid=orders.oid); 
   
   
select pid,pname ,city , orders.oid from
    product right join orders on (product.oid=orders.oid); 
   
-- natural join (bakwas join) interview

select pid,pname,city
from product natural join orders;   

-- self join interview important
create table employee(eid int,ename varchar(20), mid int);
insert  into employee values (10,"tushar",null), (20,"aman",30),
(30,"mayank",10),(40,"ujjwal",20);
select * from employee;

select  emp.eid ,emp.ename,emp.mid ,
 mgr.eid ,mgr.ename as manager_id
from employee as emp join employee as mgr
where emp.mid=mgr.eid;

create table employee1(eid int, ename varchar(20), mid int, sal int);
insert into employee1 values(10,"tushar", null, 52000),(20,"aman",30, 33000),(30,"mayank",10,20000),(40,"ujwal",20, 8000);

select * from employee1;

-- I need to get eid ename mname only for those user where the salary of a emp should be greater than the salary of manager.

select emp1.eid, emp1.ename, mgr1.ename as mname 
from employee1 as emp1 
join employee1 mgr1 
where emp1.sal > mgr1.sal and emp1.mid = mgr1.eid;



use sakila;
select * from actor;
select * from film_actor;
select * from film;
select a.actor_id,a.first_name , a.last_name ,fa.film_id
  from actor as a join film_actor as fa
    where (a.actor_id=fa.actor_id);
    
select a.actor_id,a.first_name , a.last_name ,fa.film_id, f.title
  from actor as a join film_actor as fa join film as f
    where (a.actor_id=fa.actor_id)and (fa.film_id=f.film_id);   
    
/*select actor_id , first_name ,
       case 
            when actor_id>30 then  actor_id+50
            when actor_id>20 then actor_id+20
             when actor_id>10 then actor_id+10
           else actor_id+5 
            
        end "newcol" from actor
  select customer_id,count(*) as total 
from payment group by customer_id order by total*/

select  count(film.title) from actor as a
inner join  film_actor as fa inner join film as f
on(a.actor_id)and(fa.film_id=f.film_id) group by actor.actor_id  ;
  
select * from payment;

-- sub query --> Query within a query

select amount from payment where payment_id =1;

select * from payment where amount=(select amount from payment where payment_id =4);

select * from payment where amount=(select amount from payment where rental_id=573);

--  Get those user whose staff_id is equal to the staff id of payment id

select * from payment where staff_id=(select staff_id from payment where payment_id =10);

-- Get the payment id, staff id , amount ,payment date where the month of payment date should be equal to payment id 5

select payment_id,staff_id,amount,payment_date from payment where month(payment_date)=(select month(payment_date) from payment where payment_id =5);


-- multi row sub query using in, any, all

select payment_id,amount from payment where amount in (select amount from payment where payment_id in (2,3));

select payment_id,amount from payment where amount=any(select amount from payment where payment_id in (2,3));


select payment_id,amount from payment where amount>any(select amount from payment where payment_id in (2,3));  -- amount graeater then minimum value of reault set


select payment_id,amount from payment where amount<any(select amount from payment where payment_id in (2,3));  -- amount less then maximum value of reault set

select payment_id,amount from payment where amount<all(select amount from payment where payment_id in (2,3));  -- no query like (=all) unavailable

create table ut1(id int);

insert into ut1 value(10),(20),(30),(40),(50);

select * from ut1 order by id desc;

select * from ut1 where id < (select max(id) from ut1);


select * from ut1 where id < (select max(id) from ut1) order by id desc limit 2,1;

select * from ut1 where id > (select min(id) from ut1) order by id desc limit 2,1;

-- DDL command


create table r1( name varchar(20));

insert into r1 values("aman           ");

select name,length(name) from r1;

create table r2( name char(3));

insert into r2 values("a                           ");

select name,length(name) from r2;

create table u1(dob date);

insert into u1 values('2024-05-24');

select * from u1;

-- User making
create user bob12 identified by 'bob';

-- information saves at
select* from mysql.user;

-- current user 
select current_user();

show grants for bob12;

-- create user 'bob12'@'192.16.10.%' identified by 'password'; -- to make user access data from a specific IP range


-- grant permissions
grant all privileges on sakila.* to bob12; -- giving access of all the tables of database

-- change password of local 

alter user 'bob12' identified by 'regex';

-- lock account

alter user 'bob12' account lock;
alter user 'bob12' account unlock;

-- Roles -- is a group -- why group  

-- group is a collection of user i which we share required information

-- group == role

-- creating role

create role sales;

grant select on sakila.* to sales;

-- add users in group

create user 'aman' identified by 'aman';

show grants for 'aman';

grant sales to aman;

show grants for aman;

-- assigning role 

set default role all to aman;

create table user1(first_name char(20), last_name char(20));

insert into user1 values('Milan','Kachhawaha');


grant update (first_name) on user1 to aman;


grant select (last_name) on user1 to bob12;

create table employ(id int primary key auto_increment, dept varchar(20),salary int);

insert into employ(dept,salary) values
('hr',300),
('hr',200),('hr',100),
('marketing',70),('marketing',50),
('marketing',100),('marketing',80),
('dsa',156),('dsa',200),
('dsa',60),('dsa',900);

select * from employ;

select avg(salary) from employ;

select id,dept,salary,(select avg(salary) from employ) from employ;


 -- windows function
select id,dept, salary, avg(salary) over() from employ;


select id,dept, salary, avg(salary) over(), avg(salary) over(partition by dept) from employ;

select id,dept, salary, sum(salary) over(), sum(salary) over(partition by dept) from employ;

select id,dept, salary, sum(salary) over(partition by dept), sum(salary) over(order by dept) from employ;

select id,dept, salary, sum(salary) over(), sum(salary) over(partition by dept order by salary) from employ;


-- rank , sense_rank

select id,dept,salary,
rank() over(order by salary) from employ;   -- rank function distribute the ranks and skips that rank	


select id,dept,salary,
dense_rank() over(order by salary) from employ;   -- rank does not skip on same ranks

select id,dept,salary,
rank() over(partition by dept order by salary) from employ;

select id,dept,salary,
dense_rank() over(partition by dept order by salary) from employ;

-- using windos function n highest salary from the data -- ntile

select id,dept,salary,
dense_rank() over(order by salary) from employ;


-- Views --> virtual table 
-- views --> not physically --> give restriction 
-- store complex query into a table i.e virtual

select * from payment;
create view v_payment as select payment_id, customer_id from payment;
 select * from v_payment;
 
 create table raj123(id int, salary int);
 
 insert into raj123 values(1,200),(2,200);
 
 create view virtual_raj as select id from raj123;
 
 insert into virtual_raj value(30);

select * from virtual_raj;

select * from raj123;

-- it is simple view which makes changes into the original data also

create or replace view virtual_raj as
select sum(salary) from raj123;

select * from virtual_raj;

insert into virtual_raj values(800);
-- we can't update the complex view which are made from the aggeregerate and joins 



-- Indxes --> it is a mechaniuse through which we can access the data faster 

-- Indexes are of two types Inbuilt indexes or clustered indexes

drop database test;
create database test;

use test;

create table regex(id int primary key auto_increment,
name varchar(20), salary int);

insert into regex values(1,"Milan",10),(2,"Rana",20);

select * from regex;

desc regex;
insert into regex(name,salary) values("Rana",20);

show indexes from regex;

-- b-tree is a default index

explain select * from regex;

create index regex_name_ind on regex(name);

show indexes from regex;


explain select * from regex where salary=20;

explain select * from regex where name="Rana";

drop index regex_name_ind on regex;

-- making index on two values of a table

select * from regex;
insert into regex(name,salary) values("shivam",500),("tushar",600);

create index regex_name on regex(name(2));

show indexes from regex;
 
explain select * from regex where name="tus%";

explain select * from regex where name="isha%";

explain select * from regex where name="Ra%";

explain select * from regex where name like "Ra";

explain select * from regex where name like "__%";


show databases;




-- Group by ,join, self join, inner join, natural join, subquery, views, why virtual table, windos function or analytical function
-- find n highest salary
