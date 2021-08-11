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


