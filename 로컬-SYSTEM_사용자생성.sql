-- 사용자 계정 생성
ALTER SESSION SET "_ORACLE_SCRIPT"=true;
DROP USER PRODUCTDB CASCADE; -- 기존 사용자 삭제
CREATE USER PRODUCTDB IDENTIFIED BY 123456 -- 사용자 이름: Model, 비밀번호 : 1234
    DEFAULT TABLESPACE javadata  -- 데이터 저장소
    TEMPORARY TABLESPACE TEMP;  -- 임시저장장소
GRANT connect, resource, dba TO PRODUCTDB; -- 권한 부여