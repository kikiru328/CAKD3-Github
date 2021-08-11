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

SELECT bookname, publiser
FROM book
WHERE bookname LIKE '%축구%';

SELECT bookname, publisher
FROM book
WHERE bookname LIKE '_구%';

SELECT *
FROM book
WHERE bookname LIKE '%축구%' AND price>=20000;

SELECT *
FROM book
ORDER BY bookname; 

-- 도서를 가격순으로 검색, 가격이 같은면 이름순으로 검색
SELECT *
FROM book
ORDER BY price,bookname DESC;

--도서를 가격의 내림차순으로 검색하세요. 만약 가격이 같다면 출판사의 오름차순으로 출력하세요


SELECT * FROM orders;

SELECT SUM(saleprice)
FROM orders;

SELECT * FROM orders;
SELECT SUM(saleprice) AS 총매출
FROM orders;

--2번 김연아 고객이 주문한 도서의 총 판매액을 구하시오
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

-- 가격이 8천원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하시오.
-- 단, 두 권 이상 구매한 구객만 구하시오.

SELECT custid, count(*) AS 도서수량
FROM orders
WHERE saleprice >= 8000
GROUP BY custid
HAVING COUNT(*) >= 2;

SELECT *
FROM customer, orders
WHERE customer.custid = orders.custid;
ORDER BY customer.custid;

--고객의 이름과 고객이 주문한 도서의 판매가격을 검색하세요
SELECT name,saleprice
FROM customer,orders
WHERE customer.custid=orders.custid;

--Q.고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객별로 정렬하시오
SELECT name, SUM(saleprice)
FROM customer, orders
WHERE customer.custid = orders.custid
GROUP BY customer.name
ORDER BY customer.name;

--SELECT custid, SUM(saleprice) "총 판매액"
--FROM orders
--GROUP BY custid
--ORDER bY custid;


-- SELECT name, SUM(saleprice) AS " 총 판매액"
-- FROM customer C, orders O
-- ''


--Q.고객의 이름과 고객이 주문한 도서의 이름을 구하시오.
SELECT customer.name, book.bookname
FROM customer, orders, book
WHERE customer.custid = orders.custid AND orders.bookid=book.bookid


--Q.가격이 20,000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오
--SELECT customer.name, book.bookname
--FROM customer, orders, book
--WHERE customer.custid = orders.custid AND orders.bookid=book.bookid AND book.price =20000;

SELECT customer.name, book.bookname
FROM customer, book, orders
WHERE customer.custid = orders.custid AND orders.bookid = book.bookid AND book.price = 20000;

--Q.도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도시의 판매가격을 구하시오
SELECT customer.name saleprice
FROM customer LEFT OUTER JOIN Orders ON customer.custid = orders.custid;


SELECT C.name, O.saleprice
FROM customer C, orders O
WHERE C.custid = O.custid(+);



--Q.가장 비싼 도서의 이름을 보이시오.

SELECT bookname
FROM book
WHERE price =(SELECT MAX(price) FROM book);


--Q. 도서를 구매한 적이 있는 고객의 이름을 검색하세요ㅕ

SELECT name
FROM customer
WHERE custid IN (SELECT custid FROM orders);

--Q .대한미디어에서 출판한 도서를 구매한 고객의 이름을 보이시오.
SELECT name
FROM customer, orders, book
WHERE book.publisher='대한미디어' AND orders.custid = customer.custid;



SELECT name
FROM customer
WHERE custid IN(SELECT custid FROM orders
WHERE bookid IN(SELECT custid FROM book
WHERE publisher='대한미디어'));



--Q 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오.
SELECT bookname
FROM book
WHERE price = (SELECT AGE(price) FROM book)
GROUP BY publisher;

SELECT b1.bookname
FROM book b1
WHERE b1.price > ( SELECT AVG(b2.price)
FROM book b2 WHERE b2.publisher=b1.publisher);

SELECT name
FROM customer
MINUS
SELECT name
FROM customer
WHERE custid IN (SELECT custid FROM orders);

SELECT name
FROM customer
WHERE custid NOT IN (SELECT custid FROM orders);

--주문이 있는 고객의 이름과 주소
SELECT name , address
while custid IN (SELECT custid FROM orders);

SELECT name, anddress
FROM customer 
WHERE EXISTS(SELECT * FROM orders
WHERE custid = orders cuatid;





COMMIT;