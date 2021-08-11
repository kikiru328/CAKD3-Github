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
--Q.Newbook 테이블의 isbn속성의 데이터 타입을 number형으로 변경하시오.
ALTER TABLE newbook ADD isbn NUMBER;
--Q.NEWBOOK 테이블의 isbn 속성을 삭제하세요
ALTER TABLE newbook drop COLUMN isbn;
--Q. NEWBOOK테이블의 bookid 속성에 NOT NULL 제약조건을 적용하세요
ALTER TABLE newbook MODIFY bookid NUMBER NOT NULL;
--Q. NEWBOOK 테이블의 bookid속성을 기본키로 변경하시오
ALTER TABLE newbook DROP PRIMARY KEY;
ALTER TABLE newbook ADD PRIMARY KEY(bookid);
--Q. NEWBOOK 테이블을 삭제하세요
DROP TABLE newbook;