-- DROP 기존 테이블 및 시퀀스
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE REVIEW CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE RESERVATION CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE PACKAGE CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE GUIDE CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE CUSTOMER CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP SEQUENCE CUSTOMER_SEQ';
    EXECUTE IMMEDIATE 'DROP SEQUENCE GUIDE_SEQ';
    EXECUTE IMMEDIATE 'DROP SEQUENCE PACKAGE_SEQ';
    EXECUTE IMMEDIATE 'DROP SEQUENCE RESERVATION_SEQ';
    EXECUTE IMMEDIATE 'DROP SEQUENCE REVIEW_SEQ';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

-- 고객 테이블
CREATE TABLE CUSTOMER (
    NO NUMBER, --PK
    ID VARCHAR2(30), --UK
    NAME VARCHAR2(50) NOT NULL,
    BIRTH NUMBER NOT NULL,
    NATIONAL VARCHAR2(20) NOT NULL,
    GENDER VARCHAR2(10) NOT NULL,
    EMAIL VARCHAR2(50) NOT NULL,
    PHONE VARCHAR2(14) NOT NULL
);
Alter table CUSTOMER add constraint CUSTOMER_NO_PK primary key(NO);
Alter table CUSTOMER add constraint CUSTOMER_ID_UK UNIQUE(ID); 

CREATE SEQUENCE CUSTOMER_SEQ
START WITH 1
INCREMENT BY 1;

-- 가이드 테이블
CREATE TABLE GUIDE (
    NO NUMBER, --PK
    ID VARCHAR2(30), --UK
    NAME VARCHAR(50) NOT NULL,
    PHONE VARCHAR(15) NOT NULL,
    LANGUAGES VARCHAR(100) NOT NULL
);
Alter table GUIDE add constraint GUIDE_NO_PK primary key(NO);
Alter table GUIDE add constraint GUIDE_ID_UK UNIQUE(ID); 

CREATE SEQUENCE GUIDE_SEQ
START WITH 1
INCREMENT BY 1;

-- 여행상품 테이블
CREATE TABLE PACKAGE (
    NO NUMBER, --PK
    ID VARCHAR2(30),--UK
    NAME VARCHAR2(50) NOT NULL,
--    PCAPACITY NUMBER,
    NATIONAL VARCHAR2(20) NOT NULL,
    PRICE NUMBER NOT NULL,
    GUIDE_ID VARCHAR2(30), --FK
    SDATE DATE DEFAULT SYSDATE,
    EDATE DATE DEFAULT SYSDATE
);
Alter table PACKAGE add constraint PACKAGE_NO_PK primary key(NO);
Alter table PACKAGE add constraint PACKAGE_ID_UK UNIQUE(ID);   
Alter table PACKAGE add constraint PACKAGE_GUIDE_ID_FK 
    FOREIGN key(GUIDE_ID) References GUIDE(ID) on delete set null;
 

CREATE SEQUENCE PACKAGE_SEQ
START WITH 1
INCREMENT BY 1;

--drop table reservation;
--drop table review;
-- 예약 테이블
CREATE TABLE RESERVATION(
    NO NUMBER, --PK
    ID VARCHAR2(30), --UK
    CUST_ID VARCHAR2(30), --FK
    PACK_ID VARCHAR2(30), --FK
--    RCAPACITY NUMBER NOT NULL,
    METHOD VARCHAR2(20) NOT NULL,
    RDATE DATE DEFAULT SYSDATE
);
Alter table RESERVATION add constraint RESERVATION_NO_PK primary key(NO);
Alter table RESERVATION add constraint RESERVATION_ID_UK UNIQUE(ID);  
Alter table RESERVATION add constraint RESERVATION_CUST_ID_FK 
    FOREIGN key(CUST_ID) References CUSTOMER(ID) on delete set null;
Alter table RESERVATION add constraint RESERVATION_PACK_ID_FK 
    FOREIGN key(PACK_ID) References PACKAGE(ID) on delete set null;   
ALTER TABLE RESERVATION MODIFY RDATE DEFAULT SYSDATE;  
       
CREATE SEQUENCE RESERVATION_SEQ
START WITH 1
INCREMENT BY 1;

-- 리뷰 테이블
CREATE TABLE REVIEW(
    NO NUMBER, --PK
    RESERV_ID VARCHAR2(30), --FK
    GUIDE_REVIEW NUMBER(2) NOT NULL,
    SCHE_REVIEW NUMBER(2) NOT NULL,
    AVG_REVIEW NUMBER(3, 1)
);
Alter table REVIEW add constraint REVIEW_NO_PK primary key(NO);
Alter table REVIEW add constraint REVIEW_RESERV_ID_FK 
    FOREIGN key(RESERV_ID) References RESERVATION(ID) on delete set null;
  
--  drop sequence review_seq;    
CREATE SEQUENCE REVIEW_SEQ
START WITH 1
INCREMENT BY 1;

COMMIT;


--=============================================================================================
-- 리뷰의 평균값 구하는 트리거
CREATE OR REPLACE TRIGGER REVIEW_TRIGGER
BEFORE INSERT OR UPDATE ON REVIEW
FOR EACH ROW
BEGIN
    IF :NEW.GUIDE_REVIEW IS NOT NULL AND :NEW.SCHE_REVIEW IS NOT NULL THEN
        :NEW.AVG_REVIEW := (:NEW.GUIDE_REVIEW + :NEW.SCHE_REVIEW) / 2;
    ELSE
        -- 기본값 설정
        :NEW.AVG_REVIEW := 0;
    END IF;
END;
/