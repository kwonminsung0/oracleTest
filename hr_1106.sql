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
