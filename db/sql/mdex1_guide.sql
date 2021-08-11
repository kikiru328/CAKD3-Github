SELECT * FROM book;
SELECT bookname, price FROM book;

-- Q. ��� ������ ������ȣ, �����̸�, ���ǻ�, ������ �˻��Ͻÿ�.
SELECT	bookid, bookname, publisher, price
FROM	Book;

SELECT publisher FROM book;

SELECT DISTINCT publisher FROM book;

SELECT *
FROM book
WHERE price < 10000;

--Q. ������ 10,000�� �̻� 20,000 ������ ������ �˻��Ͻÿ�.
SELECT *
FROM book
WHERE price BETWEEN 10000 AND 20000;

SELECT *
FROM book
WHERE price >= 10000 AND price <= 20000;

--Q. ���ǻ簡 ���½������� Ȥ�� �����ѹ̵� �� ������ �˻��Ͻÿ�.
SELECT *
FROM book
WHERE (publisher ='�½�����') OR (publisher = '���ѹ̵��');

SELECT	*
FROM	Book
WHERE	publisher IN ('�½�����', '���ѹ̵��');

SELECT	*
FROM	Book
WHERE	publisher NOT IN ('�½�����', '���ѹ̵��');

SELECT bookname, publisher 
FROM book
WHERE bookname LIKE '�౸�� ����';

--Q. �����̸��� ���౸�� �� ���Ե� ���ǻ縦 �˻��Ͻÿ�.
SELECT bookname, publisher 
FROM book
WHERE bookname LIKE '%�౸%';

--Q. �����̸��� ���� �� ��° ��ġ�� ��������� ���ڿ��� ���� ������ �˻��Ͻÿ�.
SELECT bookname, publisher 
FROM book
WHERE bookname LIKE '_��%';

--Q. �౸�� ���� ���� �� ������ 20,000�� �̻��� ������ �˻��Ͻÿ�.
SELECT	*
FROM	Book
WHERE	bookname LIKE '%�౸%' AND price >= 20000;

SELECT *
FROM book
ORDER BY bookname;

SELECT *
FROM book
ORDER BY bookname DESC;

--Q. ������ ���ݼ����� �˻��ϰ�, ������ ������ �̸������� �˻��Ͻÿ�
SELECT	*
FROM	Book
ORDER BY	price, bookname;

--Q. ������ ������ ������������ �˻��Ͻÿ�. ���� ������ ���ٸ� ���ǻ��� ������������ ����Ͻÿ�.
SELECT * 
FROM book
ORDER BY price DESC, publisher;

SELECT * FROM orders;
SELECT SUM(saleprice)
FROM orders;

SELECT * FROM orders;
SELECT SUM(saleprice) AS "�� ����"
FROM orders;

--Q. 2�� �迬�� ���� �ֹ��� ������ �� �Ǹž��� ���Ͻÿ�.
SELECT SUM(saleprice) AS "�� �Ǹž�"
FROM orders
WHERE custid = 2;

SELECT SUM(saleprice) AS total,
    AVG(saleprice) AS average,
    MIN(saleprice) AS minimum,
    MAX(saleprice) AS maximum
FROM orders;

SELECT COUNT(*)
FROM orders;

SELECT custid, COUNT(*) AS ��������, SUM(saleprice) AS "�� �Ǹž�"
FROM orders
GROUP BY custid;

--Q. ������ 8,000�� �̻��� ������ ������ ���� ���Ͽ� ���� �ֹ� ������ �� ������ ���Ͻÿ�. 
--��, �� �� �̻� ������ ���� ���Ͻÿ�.
SELECT custid, COUNT(*) AS ��������
FROM orders
WHERE saleprice >= 8000
GROUP BY custid
HAVING COUNT(*) >= 2;

SELECT *
FROM customer, orders
WHERE customer.custid=orders.custid;

--Q. ���� ���� �ֹ��� ���� �����͸� ������ �����Ͽ� ���̽ÿ�
SELECT *
FROM customer, orders
WHERE customer.custid=orders.custid
ORDER BY customer.custid;

--Q. ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� �˻��Ͻÿ�.
SELECT name, saleprice
FROM customer, orders
WHERE customer.custid=orders.custid;

--Q. ������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ�, ������ �����Ͻÿ�.
SELECT custid, SUM(saleprice) "�� �Ǹž�"
FROM orders
GROUP BY custid
ORDER BY custid;

SELECT name, SUM (saleprice) AS "�� �Ǹž�"
FROM customer C, orders O
WHERE C.custid = O.custid
GROUP BY C.name
ORDER BY C.name;

--Q. ���� �̸��� ���� �ֹ��� ������ �̸��� ���Ͻÿ�.
SELECT C.name, B.bookname
FROM customer C, book B, orders O
WHERE C.custid=O.custid AND O.bookid = B.bookid;

--Q. ������ 20,000���� ������ �ֹ��� ���� �̸��� ������ �̸��� ���Ͻÿ�.
SELECT C.name, B.bookname
FROM book B, customer C, orders O
WHERE C.custid = O.custid AND O.bookid=B.bookid AND B.price = 20000; 

--Q. ������ �������� ���� ���� �����Ͽ� ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� ���Ͻÿ�.
SELECT C.name, O.saleprice
FROM customer C, orders O
WHERE C.custid = O.custid(+);

SELECT customer.name,orders.saleprice
FROM customer LEFT OUTER JOIN orders ON customer.custid=orders.custid;

--�μ�����
--Q. ���� ��� ������ �̸��� ���̽ÿ�.
SELECT bookname
FROM book
WHERE price=(SELECT MAX(price) FROM book);

--Q. ������ ������ ���� �ִ� ���� �̸��� �˻��Ͻÿ�.
SELECT name
FROM customer
WHERE custid IN (SELECT custid FROM orders);

--Q. �����ѹ̵����� ������ ������ ������ ���� �̸��� ���̽ÿ�.
SELECT name
FROM customer
WHERE custid IN(SELECT custid FROM orders
WHERE bookid IN(SELECT bookid FROM book 
WHERE publisher = '���ѹ̵��'));

--Q. ���ǻ纰�� ���ǻ��� ��� ���� ���ݺ��� ��� ������ ���Ͻÿ�.
SELECT b1.bookname
FROM book b1
WHERE b1.price > (SELECT avg(b2.price)
FROM book b2 WHERE b2.publisher=b1.publisher);

--Q. ������ �ֹ����� ���� ���� �̸��� ���̽ÿ�.
SELECT name
FROM customer
MINUS
SELECT name
FROM customer
WHERE custid IN(SELECT custid FROM orders);

SELECT name
FROM customer
WHERE custid NOT IN(SELECT custid FROM orders);

--Q. �ֹ��� �ִ� ���� �̸��� �ּҸ� ���̽ÿ�.
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

--[����]
--Q. NewBook ���̺��� isbn �Ӽ��� ������ Ÿ���� NUMBER������ �����Ͻÿ�.
--Q.NewBook ���̺��� isbn �Ӽ��� �����Ͻÿ�.
--Q.NewBook ���̺��� bookid �Ӽ��� NOT NULL ���������� �����Ͻÿ�.
--Q.NewBook ���̺��� bookid �Ӽ��� �⺻Ű�� �����Ͻÿ�.
--Q.NewBook ���̺��� �����Ͻÿ�.
