--사용자 생성 TEST
create user C##TEST
identified by test
default tablespace users
temporary tablespace temp;

--권한 부여
grant connect, resource to C##TEST;
grant create session, create table, create view, create synonym to C##TEST;
grant unlimited tablespace to C##TEST;

--비밀번호 변경
alter user C##TEST
identified by TEST1;

--권한 회수
revoke create synonym from C##TEST;
revoke create session, create table, create view from C##TEST;

--삭제
drop user C##TEST;

drop user C##TEST cascade;
create user C##TEST identified by test default TABLESPACE users
temporary tablespace temp profile default;
grant connect, resource to C##TEST;
grant create view, create synonym to C##TEST;
grant unlimited tablespace to C##TEST;
alter user C##TEST account unlock;
--profile을 default로 지정하게 되면 모든 자원을 무한정 사용할 수 있게 된다.
--단 오라클 설치 후 DBA등에 의하여 DEFAULT PROFILE이 수정된 경우는
--수정된 RPOFILE이 적용되게 된다. 

select username
,account_status
,lock_date
,expiry_date
,default_tablespace
from DBA_USERS
where username = 'C##TEST';

drop user C##TEST cascade;
--cascade를 사용하게 되면 사용자 이름과 관련된 모든 데이터베이스 스키마가 데이터 시전으로부터 삭제되며
--모든 스키마 객체를 또한 물리적으로 삭제 된다.

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

-- MEMBER 테이블을 복사해서 MEMBER1 테이블을 생성 후 출력하세요
drop table member1;
create table member1 as select * from member;
select * from member1;

select * from tabs;

insert into member1 (ID,PWD,NAME) values('200901','111','kevin');
insert into member1 (ID,PWD,NAME,gender)values ('200902','123','dragon','남성');