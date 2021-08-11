SELECT ABS(-78), ABS(+78)
FROM dual;

SELECT ROUND(4.875,1)
FROM dual;

--Q . 고객별 평균 주문 금액을 백원 단위로 반올림한 값을 구하시오.
SELECT * FROM orders;
SELECT ROUND(SUM(saleprice) / COUNT(*) ,-2) AS 평균금액
FROM orders
GROUP BY custid;

--Q. 도서 제목에 '야구'가 포함된 도서를 '농구'로 변경한 후 도섬 목록, 가격을 보이시오.
SELECT * FROM book;

SELECT bookid, REPLACE(bookname, '야구','농구') bookname, publisher, price
FROM book;

--Q. '굿스포츠'에서 출판한 도서의 제목과 제목의 글자 수, 바이트 수를 보이시오.
SELECT bookname 제목, publisher 출판사, LENGTH(bookname) "제목의 글자 수",
LENGTHB(bookname) "제목의 바이트 수"
FROM book
WHERE publisher ='굿스포츠';

--Q. 마당서점의 고객 중에서 같은 성(姓)을 가진 사람이 몇 명이나 되는지 성별 인원수를 구하시오.
SELECT * FROM customer;
INSERT INTO customer VALUES (5, '박세리', '대한민국 부산', NULL);

SELECT SUBSTR(name,1,1) 성, COUNT(*) 인원
FROM customer
GROUP BY SUBSTR(name,1,1);

--Q. 마당서점은 주문일로부터 10일 후 매출을 확정한다. 각 주문의 확정일자를 구하시오.
SELECT * FROM orders;

SELECT orderdate 주문일, orderdate + 10 
FROM orders;
--SELECT a.*, a.orderdate + 10 확정일자
--FROM orders a;

--Q. 마당서점이 2020년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호를 모두 보이시오.
--단 주문일은 'yyyy-mm-dd 요일' 형태로 표시한다.

SELECT orderid 주문번호 ,TO_CHAR(orderdate,'yyyy-mm-dd day') 주문일,
custid 고객번호, bookid 도서번호
FROM orders
WHERE orderdate = TO_DATE('2020-07-07');

--Q. DBMS 서버에 설정된 현재 날짜와 식간, 요일을 확인하시오.
SELECT SYSDATE
FROM dual;

SELECT SYSDATE, TO_CHAR(SYSDATE,'yyyy-mm-dd hh:mi:ss') SYSDATE1
FROM dual;

--Q. 이름, 전화번호가 포함된 고객목록을 보이시오. 단, 전화번호가 없는 고객은 '연락처없음'으로 표시하시오.
SELECT * FROM customer;

SELECT name 이름, coalesce(phone,'연락처없음')
FROM customer;

--SELECT name 이름, NVL(phone '연락처없음') 전화번호
--FROM customer;

--SELECT custid,name, phone
--FROM customer
--WHERE TRIM(phone) IS NULL;

--Q. 고객목록에서 고객번호, 이름, 전화번호를 앞의 두 명만 보이시오.
SELECT custid, name, phone
FROM customer
WHERE ROWNUM <=2;

--Q. 평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 보이시오.
SELECT orderid, saleprice
FROM orders
WHERE saleprice <= (SELECT AVG(saleprice) FROM orders);

--Q. 각 고객의  평균 주문금액보다 큰 금액의 주문 내역에 대해서 주문번호, 고객번호, 금액을 보이시오.
SELECT orderid, custid, saleprice
FROM orders 
WHERE saleprice > (SELECT AVG (o1.saleprice) FROM orders o1
WHERE o1.custid=o1.custid );

SELECT o1.orderid 주문번호, o1.custid 고객번호, o1.saleprice 금액
FROM orders o1
WHERE o1.saleprice > (SELECT AVG(o2.saleprice) 
                      FROM orders o2
                      WHERE o1.custid = o2.custid
                      GROUP BY o2.custid);
                      
SELECT * FROM customer;
--Q. '대한민국'에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오.
SELECT SUM(saleprice)
FROM orders
WHERE custid IN (SELECT custid FROM customer WHERE address LIKE '%대한민국%');

--Q. 3번 고객이 주문한 최고 금액보다 더 비싼 도서를 구입한 주문의 주문번호와 금액을 보이시오.
SELECT orderid, saleprice
FROM orders
WHERE saleprice > ALL(SELECT saleprice FROM orders WHERE custid=3);

--Q. EXISTS 연산자를 사용하여 '대한민국'에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오.
SELECT SUM(saleprice)
FROM orders
WHERE EXISTS(SELECT * FROM customer WHERE address LIKE '%대한민국%' AND
orders.custid=customer.custid);

--Q. 마당서점의 고객별 판매액을 보이시오. (고객이름과 고객별 판매액 출력)
SELECT (SELECT name FROM customer WHERE customer.custid = orders.custid) name,
SUM(saleprice) 
FROM orders
GROUP BY orders.custid;


SELECT * FROM orders;
ALTER TABLE orders ADD bookname VARCHAR2(40);

UPDATE orders
SET bookname = (SELECT bookname FROM book WHERE book.bookid = orders.bookid);

SELECT *  FROM orders;

-- VIEW

CREATE VIEW vw_customer
AS SELECT *
FROM customer
WHERE address LIKE '%대한민국%';

.--Q orders 테이블에서 고객이름과 도서이름을 바로 확인 할 수 있는 view를 생성한 후 
--'김연아' 고객이 구입한 도서의 주문번호, 도서이름, 주문액을 보이시오.
CREATE VIEW vw_orders(orderid, custid, name, bookid, bookname, saleprice, orderdate)
AS SELECT orders.orderid,orders.custid,customer.name,orders.bookid,book.bookname,
orders.saleprice,orders.orderdate
FROM orders,customer,book
WHERE orders.custid = custid AND orders.bookid=book.bookid;

SELECT * FROM vw_orders;
