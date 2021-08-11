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

SELECT bookname, publiser
FROM book
WHERE bookname LIKE '%�౸%';

SELECT bookname, publisher
FROM book
WHERE bookname LIKE '_��%';

SELECT *
FROM book
WHERE bookname LIKE '%�౸%' AND price>=20000;

SELECT *
FROM book
ORDER BY bookname; 

-- ������ ���ݼ����� �˻�, ������ ������ �̸������� �˻�
SELECT *
FROM book
ORDER BY price,bookname DESC;

--������ ������ ������������ �˻��ϼ���. ���� ������ ���ٸ� ���ǻ��� ������������ ����ϼ���


SELECT * FROM orders;

SELECT SUM(saleprice)
FROM orders;

SELECT * FROM orders;
SELECT SUM(saleprice) AS �Ѹ���
FROM orders;

--2�� �迬�� ���� �ֹ��� ������ �� �Ǹž��� ���Ͻÿ�
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

-- ������ 8õ�� �̻��� ������ ������ ���� ���Ͽ� ���� �ֹ� ������ �� ������ ���Ͻÿ�.
-- ��, �� �� �̻� ������ ������ ���Ͻÿ�.

SELECT custid, count(*) AS ��������
FROM orders
WHERE saleprice >= 8000
GROUP BY custid
HAVING COUNT(*) >= 2;

SELECT *
FROM customer, orders
WHERE customer.custid = orders.custid;
ORDER BY customer.custid;

--���� �̸��� ���� �ֹ��� ������ �ǸŰ����� �˻��ϼ���
SELECT name,saleprice
FROM customer,orders
WHERE customer.custid=orders.custid;

--Q.������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ�, ������ �����Ͻÿ�
SELECT name, SUM(saleprice)
FROM customer, orders
WHERE customer.custid = orders.custid
GROUP BY customer.name
ORDER BY customer.name;

--SELECT custid, SUM(saleprice) "�� �Ǹž�"
--FROM orders
--GROUP BY custid
--ORDER bY custid;


-- SELECT name, SUM(saleprice) AS " �� �Ǹž�"
-- FROM customer C, orders O
-- ''


--Q.���� �̸��� ���� �ֹ��� ������ �̸��� ���Ͻÿ�.
SELECT customer.name, book.bookname
FROM customer, orders, book
WHERE customer.custid = orders.custid AND orders.bookid=book.bookid


--Q.������ 20,000���� ������ �ֹ��� ���� �̸��� ������ �̸��� ���Ͻÿ�
--SELECT customer.name, book.bookname
--FROM customer, orders, book
--WHERE customer.custid = orders.custid AND orders.bookid=book.bookid AND book.price =20000;

SELECT customer.name, book.bookname
FROM customer, book, orders
WHERE customer.custid = orders.custid AND orders.bookid = book.bookid AND book.price = 20000;

--Q.������ �������� ���� ���� �����Ͽ� ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� ���Ͻÿ�
SELECT customer.name saleprice
FROM customer LEFT OUTER JOIN Orders ON customer.custid = orders.custid;


SELECT C.name, O.saleprice
FROM customer C, orders O
WHERE C.custid = O.custid(+);



--Q.���� ��� ������ �̸��� ���̽ÿ�.

SELECT bookname
FROM book
WHERE price =(SELECT MAX(price) FROM book);


--Q. ������ ������ ���� �ִ� ���� �̸��� �˻��ϼ����

SELECT name
FROM customer
WHERE custid IN (SELECT custid FROM orders);

--Q .���ѹ̵��� ������ ������ ������ ���� �̸��� ���̽ÿ�.
SELECT name
FROM customer, orders, book
WHERE book.publisher='���ѹ̵��' AND orders.custid = customer.custid;



SELECT name
FROM customer
WHERE custid IN(SELECT custid FROM orders
WHERE bookid IN(SELECT custid FROM book
WHERE publisher='���ѹ̵��'));



--Q ���ǻ纰�� ���ǻ��� ��� ���� ���ݺ��� ��� ������ ���Ͻÿ�.
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

--�ֹ��� �ִ� ���� �̸��� �ּ�
SELECT name , address
while custid IN (SELECT custid FROM orders);

SELECT name, anddress
FROM customer 
WHERE EXISTS(SELECT * FROM orders
WHERE custid = orders cuatid;





COMMIT;