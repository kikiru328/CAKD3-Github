-- [system �������� - Oracle 12c �̻��� ���] - hr ��Ű�� ����
-- ORACLE 12C �̻� CDB ȯ�濡�� ���
-- CDB user ���, ����� �̸��� c##�� ���̰�, GRANT UNLIMITED ����� �߰�
-- id: c##hr , password: hr
DROP USER C##HR CASCADE; 
CREATE USER C##HR IDENTIFIED BY HR DEFAULT TABLESPACE users TEMPORARY TABLESPACE temp PROFILE DEFAULT;
GRANT CONNECT, RESOURCE TO C##HR;
GRANT CREATE VIEW, CREATE SYNONYM TO C##HR;
GRANT UNLIMITED TABLESPACE TO C##HR;
ALTER USER C##HR ACCOUNT UNLOCK;
--------------------------------------------------------
-- ���⼭���� hr ����ڷ� ����
-- ��Ű�� ����
--------------------------------------------------------
connect C##HR/HR;
--------------------------------------------------------
SELECT * FROM EMPLOYEES;

