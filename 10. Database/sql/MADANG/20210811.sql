-- << 2021.08.11.WED>> -- 
-- DATA UPDATE

SELECT * FROM customer;
-- customer ���̺��� ����ȣ�� 5�� ���� �ּҸ� '���ѹα� �λ�'���� �����Ͻÿ�.
--* update ��� (feat. set )--
UPDATE customer
SET address = '���ѹα� �λ�'
WHERE custid = 5;

--Q. customer ���̺��� �ڼ��� ���� �ּҸ� �迬�� ���� �ּҷ� �����Ͻÿ�.
UPDATE customer
SET address = (SELECT address FROM customer WHERE name = '�迬��')
WHERE name = '�ڼ���';

--Ȯ��
SELECT * FROM customer;


--Q. Customer ���̺��� ����ȣ�� 5�� ���� ������ �� ����� Ȯ���Ͻÿ�.
DELETE customer
WHERE custid = 5;

SELECT * FROM customer;

