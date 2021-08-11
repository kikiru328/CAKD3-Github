DROP TABLE Orders cascade constraints purge;
DROP TABLE Book cascade constraints purge;
DROP TABLE Customer cascade constraints purge;
DROP TABLE Imported_Book cascade constraints purge;

CREATE TABLE Book (
bookid NUMBER(2) PRIMARY KEY,
bookname VARCHAR2(40),
publisher VARCHAR2(40),
price NUMBER(8)
);

CREATE TABLE Customer (
custid NUMBER(2) PRIMARY KEY,
name VARCHAR2(40),
address VARCHAR2(50),
phone VARCHAR2(20)
);

CREATE TABLE Orders (
orderid NUMBER(2) PRIMARY KEY,
custid NUMBER(2) REFERENCES Customer(custid),
bookid NUMBER(2) REFERENCES Book(bookid),
saleprice NUMBER(8),
orderdate DATE
);

/* Book, Customer, Orders ������ ���� */
INSERT INTO Book VALUES(1, '�౸�� ����', '�½�����', 7000);
INSERT INTO Book VALUES(2, '�౸�ƴ� ����', '������', 13000);
INSERT INTO Book VALUES(3, '�౸�� ����', '���ѹ̵��', 22000);
INSERT INTO Book VALUES(4, '���� ���̺�', '���ѹ̵��', 35000);
INSERT INTO Book VALUES(5, '�ǰ� ����', '�½�����', 8000);
INSERT INTO Book VALUES(6, '���� �ܰ躰���', '�½�����', 6000);
INSERT INTO Book VALUES(7, '�߱��� �߾�', '�̻�̵��', 20000);
INSERT INTO Book VALUES(8, '�߱��� ��Ź��', '�̻�̵��', 13000);
INSERT INTO Book VALUES(9, '�ø��� �̾߱�', '�Ｚ��', 7500);
INSERT INTO Book VALUES(10, 'Olympic Champions', 'Pearson', 13000);

INSERT INTO Customer VALUES (1, '������', '���� ��ü��Ÿ', '000-5000-0001');
INSERT INTO Customer VALUES (2, '�迬��', '���ѹα� ����', '000-6000-0001');
INSERT INTO Customer VALUES (3, '��̶�', '���ѹα� ������', '000-7000-0001');
INSERT INTO Customer VALUES (4, '�߽ż�', '�̱� Ŭ������', '000-8000-0001');
INSERT INTO Customer VALUES (5, '�ڼ���', '���ѹα� ����', NULL);

INSERT INTO Orders VALUES (1, 1, 1, 6000, TO_DATE('2020-07-01','yyyy-mm-dd'));
INSERT INTO Orders VALUES (2, 1, 3, 21000, TO_DATE('2020-07-03','yyyy-mm-dd'));
INSERT INTO Orders VALUES (3, 2, 5, 8000, TO_DATE('2020-07-03','yyyy-mm-dd'));
INSERT INTO Orders VALUES (4, 3, 6, 6000, TO_DATE('2020-07-04','yyyy-mm-dd'));
INSERT INTO Orders VALUES (5, 4, 7, 20000, TO_DATE('2020-07-05','yyyy-mm-dd'));
INSERT INTO Orders VALUES (6, 1, 2, 12000, TO_DATE('2020-07-07','yyyy-mm-dd'));
INSERT INTO Orders VALUES (7, 4, 8, 13000, TO_DATE('2020-07-07','yyyy-mm-dd'));
INSERT INTO Orders VALUES (8, 3, 10, 12000, TO_DATE('2020-07-08','yyyy-mm-dd'));
INSERT INTO Orders VALUES (9, 2, 10, 7000, TO_DATE('2020-07-09','yyyy-mm-dd'));
INSERT INTO Orders VALUES (10, 3, 8, 13000, TO_DATE('2020-07-10','yyyy-mm-dd'));

CREATE TABLE Imported_Book (
bookid NUMBER,
bookname VARCHAR(40),
publisher VARCHAR(40),
price NUMBER(8)
);

INSERT INTO Imported_Book VALUES(21, 'Zen Golf', 'Pearson', 12000);
INSERT INTO Imported_Book VALUES(22, 'Soccer Skills', 'Human Kinetics', 15000);


-- madang db�� ���̺� 5�� �����ϰ� �� ���̺� 5���� �����͸� �Է� �� ��� ��ȸ�ϼ���.

CREATE TABLE Electronics (
electronics_id NUMBER,
electronics_name VARCHAR2(40),
made_by VARCHAR2(40),
price NUMBER(8)
);

INSERT INTO Electronics VALUES(1001, 'Desktop', 'HP', 500000);
INSERT INTO Electronics VALUES(1002, 'Monitor', 'Samsung', 210000);
INSERT INTO Electronics VALUES(1003, 'Speaker', 'Harmon', 100000);
INSERT INTO Electronics VALUES(1004, 'Keyboard', 'Keychrone', 130000);


CREATE TABLE Suppliers(
suppliers_id NUMBER,
suppliers_name VARCHAR2(40),
made_by VARCHAR2(40),
price NUMBER
);

INSERT INTO Suppliers Values(2001, 'Notebook', 'Morning_Glory', 1500);
INSERT INTO Suppliers Values(2002, 'Auto_pencil', 'Pental', 10000);
INSERT INTO Suppliers Values(2003, 'Eraser', 'Dragon_fly', 500);
INSERT INTO Suppliers Values(2004, 'Fountain_Pen' , 'Parker', 30000);


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
WHERE customer.custid = orders.custid and orders.bookid = 
book.bookid and book.price = 20000;
 
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






COMMIT;