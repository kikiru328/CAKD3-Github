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

/* Book, Customer, Orders 데이터 생성 */
INSERT INTO Book VALUES(1, '축구의 역사', '굿스포츠', 7000);
INSERT INTO Book VALUES(2, '축구아는 여자', '나무수', 13000);
INSERT INTO Book VALUES(3, '축구의 이해', '대한미디어', 22000);
INSERT INTO Book VALUES(4, '골프 바이블', '대한미디어', 35000);
INSERT INTO Book VALUES(5, '피겨 교본', '굿스포츠', 8000);
INSERT INTO Book VALUES(6, '역도 단계별기술', '굿스포츠', 6000);
INSERT INTO Book VALUES(7, '야구의 추억', '이상미디어', 20000);
INSERT INTO Book VALUES(8, '야구를 부탁해', '이상미디어', 13000);
INSERT INTO Book VALUES(9, '올림픽 이야기', '삼성당', 7500);
INSERT INTO Book VALUES(10, 'Olympic Champions', 'Pearson', 13000);

INSERT INTO Customer VALUES (1, '박지성', '영국 맨체스타', '000-5000-0001');
INSERT INTO Customer VALUES (2, '김연아', '대한민국 서울', '000-6000-0001');
INSERT INTO Customer VALUES (3, '장미란', '대한민국 강원도', '000-7000-0001');
INSERT INTO Customer VALUES (4, '추신수', '미국 클리블랜드', '000-8000-0001');
INSERT INTO Customer VALUES (5, '박세리', '대한민국 대전', NULL);

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


-- madang db에 테이블 5개 생성하고 각 테이블에 5개의 데이터를 입력 후 모두 조회하세요.

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


 -- [질의 3-2] 모든 도서의 도서번호, 도서이름, 출판사, 가격을 검색하시오.
 
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
 
 --Q 출판사가 '굿스포츠' 혹은 '대한미디어' 인 도서를 검색하세요
  
 SELECT *
 FROM BOOK
 WHERE PUBLISHER NOT IN ('굿스포츠','대한미디어');
 
 
 
 SELECT BOOKNAME, PUBLISHER
 FROM BOOK
 WHERE BOOKNAME LIKE '%축구%';
 
 
 SELECT *
 FROM BOOK
 WHERE BOOKNAME LIKE '%축구%' AND PRICE >=20000;
 
 
SELECT *
FROM BOOK
order by price desc, bookname; 



SELECT * FROM ORDERS;

SELECT SUM(saleprice) AS "총 매출"
FROM ORDERS;

SELECT SUM(saleprice) AS "총 판매액"
FROM ORDERS
where custid=2;


select sum(saleprice) as total,
avg(saleprice) as average,
min(saleprice) as minimum,
max(saleprice) as maximum
from orders;




select custid, count(*) as 도서수량, sum(saleprice) as "총 판매액"
from orders
group by custid;


--Q. 가격이 8000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하시오.
select count(*) as "도서의 총 수량"
from orders
where saleprice >= 8000
group by custid;


select custid,count(*) as 도서수량
from orders
where saleprice >=8000
group by custid
having (count(*)) >=2;



select * 
from customer,orders
where customer.custid = orders.custid
order by customer.custid;


 -- Q 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하시오
 
 select name, saleprice
 from customer, orders
 where customer.custid = orders.custid;
 
 
 
 
 -------------------점심전 해보기---------------------------------------------
 
 -- Q. 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객별로 정렬하시오.
SELECT name, SUM(saleprice) "총 판매액"
FROM customer, orders
WHERE customer.custid = orders.custid
GROUP BY name;

-- Q. 고객의 이름과 고객이 주문한 도서의 이름을 구하시오.
SELECT name, bookname
FROM customer, book, orders
WHERE customer.custid = orders.custid and orders.bookid = book.bookid
ORDER BY name;

-- Q. 가격이 20000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오.
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
 
 
 
 -- 대한미디어에서 출판한 도서 구매한 고객이름

SELECT NAME
FROM CUSTOMER
WHERE CUSTID IN (select CUSTID
 from orders
 where BOOKID IN (SELECT BOOKID FROM BOOK WHERE PUBLISHER ='대한미디어'));
 

--Q, 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오

SELECT b1.bookname
from book b1
where b1.price > (select avg(b2.price) from book b2 where b2.publisher = b1.publisher);


--Q 도서를 주문하지 않은 고객의 이름을 보이시오

select name
from customer
minus 
select name from customer
where custid in (select custid from orders);

--Q  주문이 있는 고객의 이름과 주소를 보이시오


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


--[과제]
--Q. NewBook 테이블의 isbn 속성의 데이터 타입을 NUMBER형으로 변경하시오.

DESCRIBE NEWBOOK;

alter table newbook modify isbn number;

DESCRIBE NEWBOOK;


--Q.NewBook 테이블의 isbn 속성을 삭제하시오.
alter table newbook drop column isbn;
SELECT * FROM NEWBOOK;

--Q.NewBook 테이블의 bookid 속성에 NOT NULL 제약조건을 적용하시오.


DESCRIBE NEWBOOK;


alter table newbook modify bookid not null;

DESCRIBE NEWBOOK;

-- Q. newbook 테이블의 기본키를 삭제한 후 다시 bookid 속성을 기본키로 변경하시오

DESCRIBE NEWBOOK;


ALTER TABLE NEWBOOK DROP PRIMARY KEY;


DESCRIBE NEWBOOK;

ALTER TABLE NEWBOOK MODIFY BOOKID PRIMARY KEY;

--Q.NewBook 테이블을 삭제하시오.
drop table newbook;






COMMIT;