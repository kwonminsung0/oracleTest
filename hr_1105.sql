-- 테이블설계하기(사원번호, 사원명, 급여) :DDL
-- class EMP01{
--    public int no;
--    public String name;
--    public double salary;
-- }
create table EMP01(
    no NUMBER(4),
    name VARCHAR2(20) not null,
    salary NUMBER(10,2) default 1000.0,
    CONSTRAINT EMP01_no_PK primary key(no),
    CONSTRAINT EMP01_name_UK UNIQUE(name)
);
-- 테이블 정보구하기
select * from tab;
-- 테이블 삭제하기 DDL
drop table emp01;
-- 휴지통보기
select * from recyclebin;
purge recyclebin;
-- 휴지통 복원
FLASHBACK TABLE emp01 TO BEFORE DROP;
-- 테이블 복사하기(제약조건 복사 안됨)
desc employees;
select count(*) from employees;
create table emple02 as select * from employees;
desc emple02;
select count(*) from emple02;
-- 제약조건 걸기 primary key, unique
alter table emple02 add constraint emple02_id_pk primary key(employee_id);
alter table emple02 add constraint emple02_email_uk unique(email);
-- 제약조건 삭제하기 unique
alter table emple02 drop constraint emple02_email_uk;
select * from user_constraints;
select table_name, constraint_name, constraint_type from user_constraints where table_name = upper('emple02');
-- 컬럼추가 emp01
alter table emp01 add job varchar2(10) not null;
desc emp01;
-- 컬럼제거 emp01
alter table emp01 drop column job;
-- 컬럼변경(주의: 기존값이 존재할때 생각을 할것 -> 타입변경불가, 사이즈 큰것으로 변경가능)
alter table emp01 modify job number(10) default 0;
-- 컬럼이름변경
alter table emp01 rename column job to job2;
alter table emp01 rename column job2 to job;

-- 테이블명을 변경 emp01 -> emp02 DDL(create, alter, drop, rename, truncate)
rename emp01 to emp02;
select * from tab;

create table CUSTOMER(
    customer_id CHAR(7) not null,
    customer_name VARCHAR2(10) not null,
    gender CHAR(1) not null,
    birthday CHAR(8),
    phone VARCHAR2(16),
    email VARCHAR2(30),
    point number(10) default 0
);
alter table CUSTOMER add constraint CUSTOMER_customer_id_PK primary key(customer_id);
alter table CUSTOMER add constraint CUSTOMER_gender_CK check(gender in('M', 'W'));
alter table CUSTOMER add constraint CUSTOMER_email_UK unique(email);

drop table CUSTOMER;

create table DEPARTMENT(
    dept_code NUMBER NOT NULL,
    dept_name VARCHAR2(20) NOT NULL
);
ALTER TABLE DEPARTMENT ADD CONSTRAINT DEPARTMENT_dept_code_PK primary key(dept_code);
INSERT INTO DEPARTMENT VALUES(1111, '컴퓨터공학');
INSERT INTO DEPARTMENT VALUES(2222, '기계공학');
INSERT INTO DEPARTMENT VALUES(3333, '건축공학');
DESC DEPARTMENT;
SELECT * FROM DEPARTMENT;

CREATE TABLE SCORE(
    NO NUMBER NOT NULL,
    NAME VARCHAR2(5) NOT NULL,
    KOR NUMBER NOT NULL DEFAULT 0,
    ENG NUMBER NOT NULL DEFAULT 0,
    MATH NUMBER NOT NULL DEFAULT 0,
    
);






