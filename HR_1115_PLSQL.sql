-- PL/SQL
-- FOR IN LOOP 구구단 작성하기
DECLARE
    VDAN NUMBER;
    VNUM NUMBER;
BEGIN
    FOR I IN 1..9 LOOP
        VDAN := I;
        DBMS_OUTPUT.PUT_LINE('*****구구단 '||VDAN||'단*****');
        FOR I IN 1..9 LOOP
            VNUM := I;
            DBMS_OUTPUT.PUT_LINE(VDAN || ' * ' || VNUM || ' = ' || VDAN*VNUM);
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('');
    END LOOP;
END;
/