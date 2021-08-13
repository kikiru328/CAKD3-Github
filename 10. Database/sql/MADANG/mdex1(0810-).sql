SELECT * FROM BOOK;
SELECT BOOKNAME, PRICE FROM BOOK;


 -- [���� 3-2] ��� ������ ������ȣ, �����̸�, ���ǻ�, ������ �˻��Ͻÿ�.
 
 SELECT BOOKID, BOOKNAME, PUBLISHER, PRICE FROM BOOK;
 
 
 SELECT *
 FROM BOOK
 WHERE PRICE>10000;
 
 
 SELECT *
 FROM BOOK
 WHERE PRICE BETWEEN 10000 AND 20000;
 
 
 
 
 SELECT *
 FROM BOOK
 WHERE  10000<=PRICE AND PRICE<=  20000;
 
 --Q ���ǻ簡 '�½�����' Ȥ�� '���ѹ̵��' �� ������ �˻��ϼ���
  
 SELECT *
 FROM BOOK
 WHERE PUBLISHER NOT IN ('�½�����','���ѹ̵��');
 
 
 
 SELECT BOOKNAME, PUBLISHER
 FROM BOOK
 WHERE BOOKNAME LIKE '%�౸%';
 
 
 SELECT *
 FROM BOOK
 WHERE BOOKNAME LIKE '%�౸%' AND PRICE >=20000;
 
 
SELECT *
FROM BOOK
order by price desc, bookname; 



SELECT * FROM ORDERS;

SELECT SUM(saleprice) AS "�� ����"
FROM ORDERS;

SELECT SUM(saleprice) AS "�� �Ǹž�"
FROM ORDERS
where custid=2;


select sum(saleprice) as total,
avg(saleprice) as average,
min(saleprice) as minimum,
max(saleprice) as maximum
from orders;




select custid, count(*) as ��������, sum(saleprice) as "�� �Ǹž�"
from orders
group by custid;


--Q. ������ 8000�� �̻��� ������ ������ ���� ���Ͽ� ���� �ֹ� ������ �� ������ ���Ͻÿ�.
select count(*) as "������ �� ����"
from orders
where saleprice >= 8000
group by custid;


select custid,count(*) as ��������
from orders
where saleprice >=8000
group by custid
having (count(*)) >=2;



select * 
from customer,orders
where customer.custid = orders.custid
order by customer.custid;


 -- Q ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� �˻��Ͻÿ�
 
 select name, saleprice
 from customer, orders
 where customer.custid = orders.custid;
 
 
 
 
 -------------------������ �غ���---------------------------------------------
 
 -- Q. ������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ�, ������ �����Ͻÿ�.
SELECT name, SUM(saleprice) "�� �Ǹž�"
FROM customer, orders
WHERE customer.custid = orders.custid
GROUP BY name;

-- Q. ���� �̸��� ���� �ֹ��� ������ �̸��� ���Ͻÿ�.
SELECT name, bookname
FROM customer, book, orders
WHERE customer.custid = orders.custid and orders.bookid = book.bookid
ORDER BY name;

-- Q. ������ 20000���� ������ �ֹ��� ���� �̸��� ������ �̸��� ���Ͻÿ�.
SELECT name, bookname
FROM customer, book, orders
WHERE customer.custid = orders.custid and orders.bookid = book.bookid and book.price = 20000;
 
 select * from orders;
 
 select * from customer;
 
 
 --
 select C.name, O.saleprice
 from customer C, orders O
 where C.custid = O.custid(+);
 
 
 select customer.name, orders.saleprice
 from customer left outer join orders on customer.custid=orders.custid;
 
 
 
 
 select max(price) from book;
 
 select *
 from book
 where price=(select max(price) from book);
 
 
 
 select *
 from orders;
 select *
 from customer; 
 
 select C.name
 from orders O,customer C
 where C.custid = O.custid
 group by C.NAME;
 
 
 
 -- ���ѹ̵��� ������ ���� ������ ���̸�

SELECT NAME
FROM CUSTOMER
WHERE CUSTID IN (select CUSTID
 from orders
 where BOOKID IN (SELECT BOOKID FROM BOOK WHERE PUBLISHER ='���ѹ̵��'));
 

--Q, ���ǻ纰�� ���ǻ��� ��� ���� ���ݺ��� ��� ������ ���Ͻÿ�

SELECT b1.bookname
from book b1
where b1.price > (select avg(b2.price) from book b2 where b2.publisher = b1.publisher);


--Q ������ �ֹ����� ���� ���� �̸��� ���̽ÿ�

select name
from customer
minus 
select name from customer
where custid in (select custid from orders);

--Q  �ֹ��� �ִ� ���� �̸��� �ּҸ� ���̽ÿ�


select name, address
from customer C, orders O
where c.custid = o.custid;


select*
from customer cs
where exists (select * from orders od
where cs.custid=od.custid);

drop table newbook;

create table Newbook(
bookid number,
bookname varchar2(20) Not null,
publisher varchar2(20) unique,
price number default 10000 check(price>1000),
primary key (bookid));


create table newcustomer(
custid Number primary key,
name varchar2(40),
address varchar2(40),
phone varchar2(30)
);

create table neworders(
orderid number,
custid number not null,
bookid number not null,
saleprice number,
orderdate date,
primary key(orderid),
foreign key(custid) references newcustomer(custid)on delete cascade);


alter table newbook add isbn varchar2(15);

select* from newbook;


--[����]
--Q. NewBook ���̺��� isbn �Ӽ��� ������ Ÿ���� NUMBER������ �����Ͻÿ�.

DESCRIBE NEWBOOK;

alter table newbook modify isbn number;

DESCRIBE NEWBOOK;


--Q.NewBook ���̺��� isbn �Ӽ��� �����Ͻÿ�.
alter table newbook drop column isbn;
SELECT * FROM NEWBOOK;

--Q.NewBook ���̺��� bookid �Ӽ��� NOT NULL ���������� �����Ͻÿ�.


DESCRIBE NEWBOOK;


alter table newbook modify bookid not null;

DESCRIBE NEWBOOK;

-- Q. newbook ���̺��� �⺻Ű�� ������ �� �ٽ� bookid �Ӽ��� �⺻Ű�� �����Ͻÿ�

DESCRIBE NEWBOOK;


ALTER TABLE NEWBOOK DROP PRIMARY KEY;


DESCRIBE NEWBOOK;

ALTER TABLE NEWBOOK MODIFY BOOKID PRIMARY KEY;

--Q.NewBook ���̺��� �����Ͻÿ�.
drop table newbook;


