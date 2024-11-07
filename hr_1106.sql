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

SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'My_customer';
SELECT * FROM USER_TABLES;
SELECT * FROM USER_CONS_COLUMNS;

SELECT * FROM CUSTOMER;

