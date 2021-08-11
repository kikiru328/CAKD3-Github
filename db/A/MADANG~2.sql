CREATE TABLE newbook(
bookid NUMBER,
bookname VARCHAR2(20) NOT NULL,
publishe VARCHAR2(20) UNIQUE,
price NUMBER DEFAULT 10000 CHECK(price>1000),
PRIMARY KEY (bookid));

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
--Q.Newbook ���̺��� isbn�Ӽ��� ������ Ÿ���� number������ �����Ͻÿ�.
ALTER TABLE newbook ADD isbn NUMBER;
--Q.NEWBOOK ���̺��� isbn �Ӽ��� �����ϼ���
ALTER TABLE newbook drop COLUMN isbn;
--Q. NEWBOOK���̺��� bookid �Ӽ��� NOT NULL ���������� �����ϼ���
ALTER TABLE newbook MODIFY bookid NUMBER NOT NULL;
--Q. NEWBOOK ���̺��� bookid�Ӽ��� �⺻Ű�� �����Ͻÿ�
ALTER TABLE newbook DROP PRIMARY KEY;
ALTER TABLE newbook ADD PRIMARY KEY(bookid);
--Q. NEWBOOK ���̺��� �����ϼ���
DROP TABLE newbook;