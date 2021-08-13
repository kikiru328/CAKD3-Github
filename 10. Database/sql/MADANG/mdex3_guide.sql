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

--ID,name 의 자료 크기 단위를 글자수 기준으로 변경하세요
--NCHAR, NVARCHAR2 크기의 단위가 bytes 가 아닌 글자수를 나타냄
alter table member1 modify ID NCHAR(10);
alter table member1 modify name NVARCHAR2(40);

--PWD에 제약조건 NOT NULL을 추가하고 제약조건 이름은 MEMBER1_NN으로 변경하세요
alter table member1 add CONSTRAINT NOT_NULL MEMBER1_NN(ID);

--BIRTHDAY 컬럼 이름을 BD로 변경하세요
alter table member1 rename column BIRTHDAY to BD;

--AGE 컬럼을 삭제하세요
alter table member1 drop column age;
--TEXT 컬럼을 추가하세요. 단 자료 형태는 NCLUB

--ID에 제약조건 이름 MEMBER_PK로 기본키를 설정하세요

--ID에 설정된 기본키 제약조건을 삭제하세요.

drop table users;
create table users
(   id  NUMBER,
    name VARCHAR2(20),
    age NUMBER );

insert into users values (1, 'HONG GILDONG',30);
select * from users;
delete from users where id=1; 
rollback;
commit;
