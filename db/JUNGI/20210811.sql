-- << 2021.08.11.WED>> -- 
-- DATA UPDATE

SELECT * FROM customer;
-- customer 테이블에서 고객번호가 5인 고객의 주소를 '대한민국 부산'으로 변경하시오.
--* update 사용 (feat. set )--
UPDATE customer
SET address = '대한민국 부산'
WHERE custid = 5;

--Q. customer 테이블에서 박세리 고객의 주소를 김연아 고객의 주소로 변경하시오.
UPDATE customer
SET address = (SELECT address FROM customer WHERE name = '김연아')
WHERE name = '박세리';

--확인
SELECT * FROM customer;


--Q. Customer 테이블에서 고객번호가 5인 고객을 삭제한 후 결과를 확인하시오.
DELETE customer
WHERE custid = 5;

SELECT * FROM customer;

