SELECT ABS(-78), ABS(+78)
FROM dual;

SELECT ROUND(4.875,1)
FROM dual;

--Q . ���� ��� �ֹ� �ݾ��� ��� ������ �ݿø��� ���� ���Ͻÿ�.
SELECT * FROM orders;
SELECT ROUND(SUM(saleprice) / COUNT(*) ,-2) AS ��ձݾ�
FROM orders
GROUP BY custid;

--Q. ���� ���� '�߱�'�� ���Ե� ������ '��'�� ������ �� ���� ���, ������ ���̽ÿ�.
SELECT * FROM book;

SELECT bookid, REPLACE(bookname, '�߱�','��') bookname, publisher, price
FROM book;

--Q. '�½�����'���� ������ ������ ����� ������ ���� ��, ����Ʈ ���� ���̽ÿ�.
SELECT bookname ����, publisher ���ǻ�, LENGTH(bookname) "������ ���� ��",
LENGTHB(bookname) "������ ����Ʈ ��"
FROM book
WHERE publisher ='�½�����';

--Q. ���缭���� �� �߿��� ���� ��(��)�� ���� ����� �� ���̳� �Ǵ��� ���� �ο����� ���Ͻÿ�.
SELECT * FROM customer;
INSERT INTO customer VALUES (5, '�ڼ���', '���ѹα� �λ�', NULL);

SELECT SUBSTR(name,1,1) ��, COUNT(*) �ο�
FROM customer
GROUP BY SUBSTR(name,1,1);

--Q. ���缭���� �ֹ��Ϸκ��� 10�� �� ������ Ȯ���Ѵ�. �� �ֹ��� Ȯ�����ڸ� ���Ͻÿ�.
SELECT * FROM orders;

SELECT orderdate �ֹ���, orderdate + 10 
FROM orders;
--SELECT a.*, a.orderdate + 10 Ȯ������
--FROM orders a;

--Q. ���缭���� 2020�� 7�� 7�Ͽ� �ֹ����� ������ �ֹ���ȣ, �ֹ���, ����ȣ, ������ȣ�� ��� ���̽ÿ�.
--�� �ֹ����� 'yyyy-mm-dd ����' ���·� ǥ���Ѵ�.

SELECT orderid �ֹ���ȣ ,TO_CHAR(orderdate,'yyyy-mm-dd day') �ֹ���,
custid ����ȣ, bookid ������ȣ
FROM orders
WHERE orderdate = TO_DATE('2020-07-07');

--Q. DBMS ������ ������ ���� ��¥�� �İ�, ������ Ȯ���Ͻÿ�.
SELECT SYSDATE
FROM dual;

SELECT SYSDATE, TO_CHAR(SYSDATE,'yyyy-mm-dd hh:mi:ss') SYSDATE1
FROM dual;

--Q. �̸�, ��ȭ��ȣ�� ���Ե� ������� ���̽ÿ�. ��, ��ȭ��ȣ�� ���� ���� '����ó����'���� ǥ���Ͻÿ�.
SELECT * FROM customer;

SELECT name �̸�, coalesce(phone,'����ó����')
FROM customer;

--SELECT name �̸�, NVL(phone '����ó����') ��ȭ��ȣ
--FROM customer;

--SELECT custid,name, phone
--FROM customer
--WHERE TRIM(phone) IS NULL;

--Q. ����Ͽ��� ����ȣ, �̸�, ��ȭ��ȣ�� ���� �� �� ���̽ÿ�.
SELECT custid, name, phone
FROM customer
WHERE ROWNUM <=2;

--Q. ��� �ֹ��ݾ� ������ �ֹ��� ���ؼ� �ֹ���ȣ�� �ݾ��� ���̽ÿ�.
SELECT orderid, saleprice
FROM orders
WHERE saleprice <= (SELECT AVG(saleprice) FROM orders);

--Q. �� ����  ��� �ֹ��ݾ׺��� ū �ݾ��� �ֹ� ������ ���ؼ� �ֹ���ȣ, ����ȣ, �ݾ��� ���̽ÿ�.
SELECT orderid, custid, saleprice
FROM orders 
WHERE saleprice > (SELECT AVG (o1.saleprice) FROM orders o1
WHERE o1.custid=o1.custid );

SELECT o1.orderid �ֹ���ȣ, o1.custid ����ȣ, o1.saleprice �ݾ�
FROM orders o1
WHERE o1.saleprice > (SELECT AVG(o2.saleprice) 
                      FROM orders o2
                      WHERE o1.custid = o2.custid
                      GROUP BY o2.custid);
                      
SELECT * FROM customer;
--Q. '���ѹα�'�� �����ϴ� ������ �Ǹ��� ������ �� �Ǹž��� ���Ͻÿ�.
SELECT SUM(saleprice)
FROM orders
WHERE custid IN (SELECT custid FROM customer WHERE address LIKE '%���ѹα�%');

--Q. 3�� ���� �ֹ��� �ְ� �ݾ׺��� �� ��� ������ ������ �ֹ��� �ֹ���ȣ�� �ݾ��� ���̽ÿ�.
SELECT orderid, saleprice
FROM orders
WHERE saleprice > ALL(SELECT saleprice FROM orders WHERE custid=3);

--Q. EXISTS �����ڸ� ����Ͽ� '���ѹα�'�� �����ϴ� ������ �Ǹ��� ������ �� �Ǹž��� ���Ͻÿ�.
SELECT SUM(saleprice)
FROM orders
WHERE EXISTS(SELECT * FROM customer WHERE address LIKE '%���ѹα�%' AND
orders.custid=customer.custid);

--Q. ���缭���� ���� �Ǹž��� ���̽ÿ�. (���̸��� ���� �Ǹž� ���)
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
WHERE address LIKE '%���ѹα�%';

.--Q orders ���̺��� ���̸��� �����̸��� �ٷ� Ȯ�� �� �� �ִ� view�� ������ �� 
--'�迬��' ���� ������ ������ �ֹ���ȣ, �����̸�, �ֹ����� ���̽ÿ�.
CREATE VIEW vw_orders(orderid, custid, name, bookid, bookname, saleprice, orderdate)
AS SELECT orders.orderid,orders.custid,customer.name,orders.bookid,book.bookname,
orders.saleprice,orders.orderdate
FROM orders,customer,book
WHERE orders.custid = custid AND orders.bookid=book.bookid;

SELECT * FROM vw_orders;
