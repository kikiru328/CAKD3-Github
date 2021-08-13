--����� ���� TEST
create user C##TEST
identified by test
default tablespace users
temporary tablespace temp;

--���� �ο�
grant connect, resource to C##TEST;
grant create session, create table, create view, create synonym to C##TEST;
grant unlimited tablespace to C##TEST;

--��й�ȣ ����
alter user C##TEST
identified by TEST1;

--���� ȸ��
revoke create synonym from C##TEST;
revoke create session, create table, create view from C##TEST;

--����
drop user C##TEST;

drop user C##TEST cascade;
create user C##TEST identified by test default TABLESPACE users
temporary tablespace temp profile default;
grant connect, resource to C##TEST;
grant create view, create synonym to C##TEST;
grant unlimited tablespace to C##TEST;
alter user C##TEST account unlock;
--profile�� default�� �����ϰ� �Ǹ� ��� �ڿ��� ������ ����� �� �ְ� �ȴ�.
--�� ����Ŭ ��ġ �� DBA� ���Ͽ� DEFAULT PROFILE�� ������ ����
--������ RPOFILE�� ����ǰ� �ȴ�. 

select username
,account_status
,lock_date
,expiry_date
,default_tablespace
from DBA_USERS
where username = 'C##TEST';

drop user C##TEST cascade;
--cascade�� ����ϰ� �Ǹ� ����� �̸��� ���õ� ��� �����ͺ��̽� ��Ű���� ������ �������κ��� �����Ǹ�
--��� ��Ű�� ��ü�� ���� ���������� ���� �ȴ�.

drop table member;
CREATE TABLE MEMBER(
ID VARCHAR2(50) NOT NULL,
PWD VARCHAR2(50),
NAME VARCHAR2(50),
GENDER NCHAR(2),
AGE NUMBER,
BIRTHDAY CHAR(10),
PHONE CHAR(13),
REGDATE DATE);


insert into MEMBER(ID,PWD,NAME) values (200901,'111','DANIEL');
insert into MEMBER values('200901','111','shin','m',24,'1998-01-01','010-0000-0000', SYSDATE);
select * FROM MEMBER;

-- MEMBER ���̺��� �����ؼ� MEMBER1 ���̺��� ���� �� ����ϼ���
drop table member1;
create table member1 as select * from member;
select * from member1;

select * from tabs;

insert into member1 (ID,PWD,NAME) values('200901','111','kevin');
insert into member1 (ID,PWD,NAME,gender)values ('200902','123','dragon','����');