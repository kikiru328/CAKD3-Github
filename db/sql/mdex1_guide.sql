SELECT * FROM book;
SELECT bookname, price FROM book;

-- Q. 모든 도서의 도서번호, 도서이름, 출판사, 가격을 검색하시오.
SELECT	bookid, bookname, publisher, price
FROM	Book;

SELECT publisher FROM book;

SELECT DISTINCT publisher FROM book;

SELECT *
FROM book
WHERE price < 10000;

--Q. 가격이 10,000원 이상 20,000 이하인 도서를 검색하시오.
SELECT *
FROM book
WHERE price BETWEEN 10000 AND 20000;

SELECT *
FROM book
WHERE price >= 10000 AND price <= 20000;

--Q. 출판사가 ‘굿스포츠’ 혹은 ‘대한미디어’ 인 도서를 검색하시오.
SELECT *
FROM book
WHERE (publisher ='굿스포츠') OR (publisher = '대한미디어');

SELECT	*
FROM	Book
WHERE	publisher IN ('굿스포츠', '대한미디어');

SELECT	*
FROM	Book
WHERE	publisher NOT IN ('굿스포츠', '대한미디어');

SELECT bookname, publisher 
FROM book
WHERE bookname LIKE '축구의 역사';

--Q. 도서이름에 ‘축구’ 가 포함된 출판사를 검색하시오.
SELECT bookname, publisher 
FROM book
WHERE bookname LIKE '%축구%';

--Q. 도서이름의 왼쪽 두 번째 위치에 ‘구’라는 문자열을 갖는 도서를 검색하시오.
SELECT bookname, publisher 
FROM book
WHERE bookname LIKE '_구%';

--Q. 축구에 관한 도서 중 가격이 20,000원 이상인 도서를 검색하시오.
SELECT	*
FROM	Book
WHERE	bookname LIKE '%축구%' AND price >= 20000;

SELECT *
FROM book
ORDER BY bookname;

SELECT *
FROM book
ORDER BY bookname DESC;

--Q. 도서를 가격순으로 검색하고, 가격이 같으면 이름순으로 검색하시오
SELECT	*
FROM	Book
ORDER BY	price, bookname;

--Q. 도서를 가격의 내림차순으로 검색하시오. 만약 가격이 같다면 출판사의 오름차순으로 출력하시오.
SELECT * 
FROM book
ORDER BY price DESC, publisher;

SELECT * FROM orders;
SELECT SUM(saleprice)
FROM orders;

SELECT * FROM orders;
SELECT SUM(saleprice) AS "총 매출"
FROM orders;

--Q. 2번 김연아 고객이 주문한 도서의 총 판매액을 구하시오.
SELECT SUM(saleprice) AS "총 판매액"
FROM orders
WHERE custid = 2;

SELECT SUM(saleprice) AS total,
    AVG(saleprice) AS average,
    MIN(saleprice) AS minimum,
    MAX(saleprice) AS maximum
FROM orders;

SELECT COUNT(*)
FROM orders;

SELECT custid, COUNT(*) AS 도서수량, SUM(saleprice) AS "총 판매액"
FROM orders
GROUP BY custid;

--Q. 가격이 8,000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하시오. 
--단, 두 권 이상 구매한 고객만 구하시오.
SELECT custid, COUNT(*) AS 도서수량
FROM orders
WHERE saleprice >= 8000
GROUP BY custid
HAVING COUNT(*) >= 2;

SELECT *
FROM customer, orders
WHERE customer.custid=orders.custid;

--Q. 고객과 고객의 주문에 관한 데이터를 고객별로 정렬하여 보이시오
SELECT *
FROM customer, orders
WHERE customer.custid=orders.custid
ORDER BY customer.custid;

--Q. 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하시오.
SELECT name, saleprice
FROM customer, orders
WHERE customer.custid=orders.custid;

--Q. 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객별로 정렬하시오.
SELECT custid, SUM(saleprice) "총 판매액"
FROM orders
GROUP BY custid
ORDER BY custid;

SELECT name, SUM (saleprice) AS "총 판매액"
FROM customer C, orders O
WHERE C.custid = O.custid
GROUP BY C.name
ORDER BY C.name;

--Q. 고객의 이름과 고객이 주문한 도서의 이름을 구하시오.
SELECT C.name, B.bookname
FROM customer C, book B, orders O
WHERE C.custid=O.custid AND O.bookid = B.bookid;

--Q. 가격이 20,000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오.
SELECT C.name, B.bookname
FROM book B, customer C, orders O
WHERE C.custid = O.custid AND O.bookid=B.bookid AND B.price = 20000; 

--Q. 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을 구하시오.
SELECT C.name, O.saleprice
FROM customer C, orders O
WHERE C.custid = O.custid(+);

SELECT customer.name,orders.saleprice
FROM customer LEFT OUTER JOIN orders ON customer.custid=orders.custid;

--부속질의
--Q. 가장 비싼 도서의 이름을 보이시오.
SELECT bookname
FROM book
WHERE price=(SELECT MAX(price) FROM book);

--Q. 도서를 구매한 적이 있는 고객의 이름을 검색하시오.
SELECT name
FROM customer
WHERE custid IN (SELECT custid FROM orders);

--Q. ‘대한미디어’에서 출판한 도서를 구매한 고객의 이름을 보이시오.
SELECT name
FROM customer
WHERE custid IN(SELECT custid FROM orders
WHERE bookid IN(SELECT bookid FROM book 
WHERE publisher = '대한미디어'));

--Q. 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오.
SELECT b1.bookname
FROM book b1
WHERE b1.price > (SELECT avg(b2.price)
FROM book b2 WHERE b2.publisher=b1.publisher);

--Q. 도서를 주문하지 않은 고객의 이름을 보이시오.
SELECT name
FROM customer
MINUS
SELECT name
FROM customer
WHERE custid IN(SELECT custid FROM orders);

SELECT name
FROM customer
WHERE custid NOT IN(SELECT custid FROM orders);

--Q. 주문이 있는 고객의 이름과 주소를 보이시오.
SELECT name, address
FROM customer
WHERE custid IN (SELECT custid FROM orders);

SELECT name, address
FROM customer cs
WHERE EXISTS(SELECT * FROM orders od 
WHERE cs.custid = od.custid);

CREATE TABLE newbook(
bookid      NUMBER, 
bookname    VARCHAR2(20) NOT NULL,
publisher   VARCHAR2(20) UNIQUE,
price       NUMBER DEFAULT 10000 CHECK(price>1000),
PRIMARY KEY (bookid));

DROP TABLE newbook;

CREATE TABLE newcustomer(
custid NUMBER PRIMARY KEY,
name VARCHAR2(40),
address VARCHAR2(40),
phone VARCHAR2(30));

CREATE TABLE neworders(
orderid NUMBER,
custid NUMBER NOT NULL,
bookid NUMBER NOT NULL,
saleprice NUMBER,
orderdate DATE,
PRIMARY KEY(orderid),
FOREIGN KEY(custid) REFERENCES newcustomer(custid) ON DELETE CASCADE);

ALTER TABLE newbook ADD isbn VARCHAR2(15);

--[과제]
--Q. NewBook 테이블의 isbn 속성의 데이터 타입을 NUMBER형으로 변경하시오.
--Q.NewBook 테이블의 isbn 속성을 삭제하시오.
--Q.NewBook 테이블의 bookid 속성에 NOT NULL 제약조건을 적용하시오.
--Q.NewBook 테이블의 bookid 속성을 기본키로 변경하시오.
--Q.NewBook 테이블을 삭제하시오.
