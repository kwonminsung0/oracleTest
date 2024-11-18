-- PL/SQL
-- EMPLOYEES 테이블에서 요구한 부서별로 사용자 정보(이름, 월급)를 CURSOR 저장하고 각 해당되는 부서별 요청시 
-- 해당되는 부서정보를 출력하시오.
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = 30;
SELECT SALARY FROM EMPLOYEES;

DECLARE
    VEMP_ROWTYPE EMPLOYEES%ROWTYPE;
    VSALARY VARCHAR2(10);
    VNO NUMBER(3);
    -- 부서별로 정보를 저장할 수 있는 커서생성
    CURSOR C1(VDEPTNO EMPLOYEES.DEPARTMENT_ID%TYPE)
    IS
    SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = VDEPTNO;
BEGIN
    -- 부서별정보를 생성을 시킨다. 랜덤값으로
    VNO := ROUND(DBMS_RANDOM.VALUE(10,110),-1);
    -- 부서번호 40번 종료해라.
    IF (VNO = 40) THEN
        DBMS_OUTPUT.PUT_LINE(VNO || '해당되지 않는 부서 번호입니다.');
        RETURN;
    END IF;
    -- 부서번호 정보를 가져와서 월급에 대해서 평가를 진행한다.(1~5000: 낮음,5001~10000: 중간,10001~20000: 높음, 상위)
    FOR VEMP_ROWTYPE IN C1(VNO) LOOP
        IF VEMP_ROWTYPE.SALARY BETWEEN 1 AND 5000 THEN
            VSALARY := '낮음';
        ELSIF VEMP_ROWTYPE.SALARY BETWEEN 5001 AND 10000 THEN
            VSALARY := '중간';
        ELSIF VEMP_ROWTYPE.SALARY BETWEEN 10001 AND 20000 THEN
            VSALARY := '높음';
        ELSE
            VSALARY := '눈물';
        END IF;
        DBMS_OUTPUT.PUT_LINE(VNO || ' / ' || VEMP_ROWTYPE.FIRST_NAME || ' / ' || VEMP_ROWTYPE.SALARY || ' / ' || VSALARY);
    END LOOP;
END;
/