drop table students;
-- 학생테이블
CREATE TABLE students (
    stuId NUMBER(4),
    name VARCHAR2(20) NOT NULL,
    kor NUMBER(4)NOT NULL,
    math NUMBER(4) NOT NULL,
    eng NUMBER(4) NOT NULL,
    total NUMBER(4),
    avg NUMBER(5,1)
);
ALTER TABLE students ADD CONSTRAINT students_stuId_pk primary key(stuId);
select * from user_cons_columns where table_name = 'students';

CREATE SEQUENCE students_SEQ
START WITH 1
INCREMENT BY 1;

-- 합, 평균 계산 트리거 생성
CREATE OR REPLACE TRIGGER STU_TRIGGER
BEFORE INSERT ON students
FOR EACH ROW
BEGIN
    :NEW.total := :NEW.kor+:NEW.math+:NEW.eng;
    :NEW.avg := ROUND((:NEW.kor+:NEW.math+:NEW.eng) / 3, 1);
END;
/
INSERT INTO students (stuId,name,kor,math,eng) VALUES (2,'김희진',95,84,79);
SELECT * FROM students;
insert into students (stuId,name,kor,math,eng) values (students_seq.nextval,'권민성',80,70,90);

-- update 트리거 생성
CREATE OR REPLACE TRIGGER STU_TRIGGER2
BEFORE UPDATE ON students
FOR EACH ROW
BEGIN
    :NEW.total := :NEW.kor+:NEW.math+:NEW.eng;
    :NEW.avg := ROUND((:NEW.kor+:NEW.math+:NEW.eng) / 3, 1);
END;
/
UPDATE students SET kor=90 WHERE stuId=2;
