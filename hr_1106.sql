-- INSERT INTO 테이블명(컬럼명,,) VALUES (컬럼값,,)
CREATE TABLE IT(
    NO1 NUMBER,
    NO2 NUMBER,
    NO3 NUMBER
);
DESC IT;
INSERT INTO IT VALUES(1,2,3);
INSERT INTO IT VALUES(1,2,NULL);
INSERT INTO IT(NO1, NO2) VALUES(11,22);
INSERT INTO IT(NO1, NO2) VALUES(11,'문자');
INSERT INTO IT(NO1, NO2) VALUES(111);
INSERT INTO IT(NO1, NO2) VALUES(111,222,333);
INSERT INTO IT(NO1, NO2) VALUES(1111,2222);
INSERT INTO IT VALUES(11111,NULL,22222);
SELECT * FROM IT;
-- NO3 NOT NULL 제약조건걸기
ALTER TABLE IT MODIFY NO3 NUMBER NOT NULL;
DELETE FROM IT WHERE NO3 IS NULL;

-- DEPT 테이블생성
CREATE TABLE DEPT
AS
SELECT DEPARTMENT_ID, DEPARTMENT_NAME, LOCATION_ID FROM DEPARTMENTS;
SELECT * FROM DEPT;
DELETE FROM DEPT;
TRUNCATE TABLE DEPT;
ROLLBACK;

-- employees 복사
create table emp03
as
select * from employees;

-- 모든 사원의 부서번호를 30번으로 수정하자
select * from emp03;
update emp03 set department_id = 30;
rollback;

-- 모든 사원의 급여를 10% 인상한다.
update emp03 set salary = salary * 1.1;
rollback;

-- 입사일을 오늘 날짜로 수정한다.
update emp03 set hire_date = sysdate;
rollback;

-- 부서번호가 10번인 사원의 부서번호를 30번으로 수정
update emp03 set department_id = 30 where department_id = 10;
rollback;

-- 급여가 3000이상인 사원만 급여을 10% 인상
update emp03 set salary = salary * 1.1 where salary >= 3000;
rollback;

-- 2007년에 입사한 사원의 입사일을 오늘로 수정한다.
update emp03 set hire_date = sysdate where substr(hire_date,1,2) = 07;
rollback;

-- 이름이 Susan인 사람의 부서번호는 20번으로 직급은 FI_MGR로 변경
update emp03 set department_id = 20, job_id = 'FI_MGR' where upper(first_name) = upper('Susan');
select * from emp03 where first_name = 'Susan';
rollback;

-- LAST_NAME이 Russell인 사원의 급여를 17000로, 커미션 비율 commission_pct를 0.45로 인상
update emp03 set salary = 17000, commission_pct = 0.45 where upper(last_name) = upper('Russell');
rollback;

-- 30번 부서를 삭제
delete from emp03 where department_id = 30;
select * from emp03 where department_id = 30;
rollback;

CREATE TABLE My_customer(
    code VARCHAR2(7),
    name VARCHAR2(10) CONSTRAINT My_customer_NAME_NN NOT NULL,
    gender CHAR(1) NOT NULL,
    birthday VARCHAR2(8) NOT NULL,
    phone VARCHAR2(16)
);

ALTER TABLE My_customer ADD CONSTRAINT My_customer_code_PK PRIMARY KEY(code);
ALTER TABLE My_customer ADD CONSTRAINT My_customer_gender_CK CHECK(gender IN('M','W'));
ALTER TABLE My_customer ADD CONSTRAINT My_customer_phone_UK UNIQUE(phone);
DESC My_customer;

INSERT INTO My_customer VALUES ('2017108','박승대','M','19711430','010-2580-9919');
INSERT INTO My_customer VALUES ('2019302','전미래','W','19740812','010-8864-0232');
SELECT * FROM My_customer;
SELECT * FROM CUSTOMER;
DESC CUSTOMER;

-- 제약조건 검색기능 (반드시 알아둘것)
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'CUSTOMER';
SELECT * FROM USER_TABLES;
SELECT * FROM USER_CONS_COLUMNS WHERE TABLE_NAME = 'CUSTOMER';
ALTER TABLE CUSTOMER DROP CONSTRAINT CUSTOMER_EMAIL_UK;
ALTER TABLE CUSTOMER DROP CONSTRAINT CUSTOMER_GENDER_CK;

-- MERGE MYCUSTOMER -> CUSTOMER 병합을 진행하는데 없으면 INSERT, 있으면 UPDATE
MERGE INTO CUSTOMER C
    USING My_customer M
    ON (C.CODE = M.CODE)
    WHEN MATCHED THEN
        UPDATE SET C.NAME = M.NAME, C.GENDER = M.GENDER, C.BIRTHDAY = M.BIRTHDAY, C.PHONE = M.PHONE
    WHEN NOT MATCHED THEN
        INSERT (C.CODE, C.NAME, C.GENDER, C.BIRTHDAY, C.PHONE) VALUES(M.CODE, M.NAME, M.GENDER, M.BIRTHDAY, M.PHONE);
        
SELECT * FROM CUSTOMER;
SELECT * FROM My_customer;
UPDATE My_customer SET NAME = '박승우' WHERE CODE = '2017108';

CREATE TABLE DEPT02(
    DEPT_NO NUMBER,
    DEPT_NAME VARCHAR2(10),
    LOCATION VARCHAR2(10)
);

ALTER TABLE DEPT02 ADD CONSTRAINT DEPT02_NO_PK PRIMARY KEY(DEPT_NO);

INSERT INTO DEPT02 VALUES(10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT02 VALUES(20,'RESEARCH','DALLAS');
INSERT INTO DEPT02 VALUES(30,'SALES','CHICAGO');
INSERT INTO DEPT02 VALUES(40,'OPERATIONS','BOSTON');

SELECT * FROM DEPT02;

CREATE TABLE MEMBER01(
    MEMBER_NO NUMBER,
    MEMBER_NAME VARCHAR(10),
    JOB_ID VARCHAR(10),
    DEPT_NO NUMBER
);

ALTER TABLE MEMBER01 ADD CONSTRAINT MEMBER01_MEMBER_NO_PK PRIMARY KEY(MEMBER_NO);
ALTER TABLE MEMBER01 ADD CONSTRAINT MEMBER01_DEPT_NO_FK FOREIGN KEY(DEPT_NO) REFERENCES DEPT02(DEPT_NO);

INSERT INTO MEMBER01 VALUES(7499,'ALLEN','SALESMAN',30);
INSERT INTO MEMBER01 VALUES(7566,'JONES','MANAGER',40);

SELECT * FROM MEMBER01;

DELETE FROM MEMBER01 WHERE DEPT_NO = 40;
DELETE FROM DEPT02 WHERE DEPT_NO = 40;

ALTER TABLE MEMBER01 DROP CONSTRAINT MEMBER01_NO_FK;
ALTER TABLE MEMBER01 ADD CONSTRAINT MEMBER01_DEPT_NO_FK FOREIGN KEY(DEPT_NO) REFERENCES DEPT02(DEPT_NO)ON DELETE CASCADE;

CREATE TABLE EMP01(
    NO NUMBER(4) NOT NULL,
    NAME VARCHAR2(10) NOT NULL,
    JOB VARCHAR2(9),
    MGR NUMBER(4),
    HIREDATE DATE NOT NULL,
    SALARY NUMBER(7,2) NOT NULL,
    COMMISSION NUMBER(7,2) DEFAULT 0.0,
    DEPTNO NUMBER(2) NOT NULL
);

ALTER TABLE EMP01 ADD CONSTRAINT EMP01_NO_PK PRIMARY KEY(NO);

INSERT INTO EMP01(NO, NAME, JOB, MGR, HIREDATE, SALARY, DEPTNO) VALUES(7369,'SMITH','CLEAK',7836,'80/12/17',800,20);
INSERT INTO EMP01 VALUES(7499,'ALLEN','SALESMAN',7369,'87/12/20',1600,300,30);
INSERT INTO EMP01(NO, NAME, JOB, HIREDATE, SALARY, DEPTNO) VALUES(7839,'KING','PRESIDENT','81/02/08',5000,10);

SELECT * FROM EMP01;
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'EMP01';

CREATE TABLE MEMBERS(
    ID VARCHAR2(20) NOT NULL,
    NAME VARCHAR2(20) NOT NULL,
    REGNO VARCHAR2(13) NOT NULL,
    PHONE VARCHAR2(13) NOT NULL,
    ADDRESS VARCHAR2(100) NOT NULL
);
ALTER TABLE MEMBERS ADD CONSTRAINT MEMBERS_ID_PK PRIMARY KEY(ID);
ALTER TABLE MEMBERS ADD CONSTRAINT MEMBERS_REGNO_UK UNIQUE(REGNO);
ALTER TABLE MEMBERS ADD CONSTRAINT MEMBERS_PHONE_UK UNIQUE(PHONE);

INSERT INTO MEMBERS VALUES('ABC','Daniel','1234','010-1234-5678','SEOUL');
INSERT INTO MEMBERS VALUES('DEF','John','5678','010-9876-5432','BUSAN');

SELECT * FROM MEMBERS;
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'MEMBERS';

CREATE TABLE BOOKS(
    CODE NUMBER(4) NOT NULL,
    TITLE VARCHAR2(50) NOT NULL,
    COUNT NUMBER(6) NOT NULL,
    PRICE NUMBER(10) NOT NULL,
    PUBLISH VARCHAR2(50) NOT NULL
);
ALTER TABLE BOOKS ADD CONSTRAINT BOOKS_CODE_PK PRIMARY KEY(CODE);

INSERT INTO BOOKS VALUES(1111,'어린 왕자',101,10000,'뜻밖');
INSERT INTO BOOKS VALUES(2222,'해리포터',102,15000,'문학수첩');

SELECT * FROM BOOKS;
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'BOOKS';

CREATE TABLE CLIENT(
    NO NUMBER(5) NOT NULL,
    NAME VARCHAR2(20) NOT NULL,
    AGE NUMBER(3),
    ADDR VARCHAR2(50),
    PHONE VARCHAR2(20)
);

ALTER TABLE CLIENT ADD CONSTRAINT CLIENT_NO_PK PRIMARY KEY(NO);

CREATE TABLE VIDEO(
    CODE NUMBER(5) NOT NULL,
    TITLE VARCHAR2(50) NOT NULL,
    GENRE VARCHAR2(30),
    PAY NUMBER(7) NOT NULL,
    LEND_STATE NUMBER(1),
    COMPANY VARCHAR2(50),
    MAKE_DATE DATE,
    VIEW_AGE NUMBER(1)
);
ALTER TABLE VIDEO ADD CONSTRAINT VIDEO_CODE_PK PRIMARY KEY(CODE);

CREATE TABLE LEND_RETURN(
    CODE NUMBER(5) NOT NULL,
    C_CODE NUMBER(5) NOT NULL,
    V_CODE NUMBER(5) NOT NULL,
    LENDDATE DATE,
    PLANDATE DATE,
    TOTALPAY NUMBER(7)
);
ALTER TABLE LEND_RETURN ADD CONSTRAINT LEND_RETURN_CODE_PK PRIMARY KEY(CODE);
ALTER TABLE LEND_RETURN ADD CONSTRAINT LEND_RETURN_C_CODE_FK FOREIGN KEY(C_CODE) REFERENCES CLIENT(NO);
ALTER TABLE LEND_RETURN ADD CONSTRAINT LEND_RETURN_V_CODE_FK FOREIGN KEY(V_CODE) REFERENCES VIDEO(CODE);

SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'LEND_RETURN';
