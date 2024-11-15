-- PL/SQL
-- DEPARTMENTS 테이블에 전체내용을 CURSOR 저장하고 FETCH해서 전체정보를 출력하시오.
DECLARE
    VDEP DEPARTMENTS%ROWTYPE;
    -- CURSOR C1 IS SELECT * FROM DEPARTMENTS;
BEGIN
    FOR VDEP IN (SELECT * FROM DEPARTMENTS) LOOP
        DBMS_OUTPUT.PUT_LINE(VDEP.DEPARTMENT_ID || ' / ' || VDEP.DEPARTMENT_NAME);
    END LOOP;
    
    /********************************************
    OPEN C1;
    LOOP
        FETCH C1 INTO VDEP;
        EXIT WHEN C1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(VDEP.DEPARTMENT_ID || ' / ' || VDEP.DEPARTMENT_NAME);
    END LOOP;
    CLOSE C1;
    ********************************************/
END;
/