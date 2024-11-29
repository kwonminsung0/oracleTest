-- 학과 (01-컴퓨터학과 / 02-교육학과 / 03-신문방송학과 / 04-인터넷비즈니스과 / 05-기술경영과)
create table subject(
    no number,                  -- pk, seq
    num varchar2(2) not null,   -- 학과번호 01, 02, 03, 04, 05
    name varchar2(24) not null  -- 학과이름
);
ALTER table subject add constraint subject_no_pk PRIMARY KEY(no);
ALTER table subject add constraint subject_num_uk UNIQUE(num);

create sequence subject_seq
start with 1
increment by 1;

insert into subject(no, num, name) values (subject_seq.nextval, ?, ?);
select * from subject;
DELETE FROM SUBJECT WHERE NUM = '05';
UPDATE SUBJECT SET NAME = '보안학과' WHERE NUM = '03';
SELECT * FROM SUBJECT ORDER BY NUM;

commit;
drop table subject;
-- 학생
drop table student;
create table student( 
    no number,                      -- PK, SEQ
    num varchar2(8) not null,       -- 학번(년도,학과번호)
    name varchar2(12) not null,     -- 이름
    id varchar2(12) not null,       -- 아이디
    passwd varchar2(12) not null,   -- 패스워드
    s_num varchar2(2),              -- 학과번호(FK)
    birthday varchar2(8) not null,  -- 생년월일
    phone varchar2(15) not null,    -- 전화번호
    address varchar2(80) not null,  -- 주소
    email varchar2(40) not null,    -- 이메일
    sdate date default sysdate      -- 등록일
);
ALTER table student add constraint student_no_pk PRIMARY KEY(no);
ALTER table student add constraint student_num_uk UNIQUE(num);
ALTER table student add constraint student_id_uk UNIQUE(id);
ALTER table student add constraint student_subject_num_fk 
    FOREIGN KEY(s_num) References subject(num) on delete set null;
ALTER table student drop constraint student_subject_num_fk;

create sequence student_seq
start with 1
increment by 1;

INSERT INTO STUDENT VALUES(student_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, sysdate);
insert into student values(student_seq.nextval, '00001', '권민성', 'kms12345', 'kms12345', '01','20000918','01012341234','aa','aa@naver.com',sysdate);
select * from student;
select COUNT(*) AS COUNT from student where id = 10;
-- 동일학과번호 총갯수
select LPAD(count(*)+1,4,'0') as total_count from student where s_num = 10;
select * from student;
-- SUBJECT STUDENT INNER JOIN
SELECT STU.NO, STU.NUM, STU.NAME, STU.ID, PASSWD, STU.S_NUM, SUB.NAME AS SUBJECT_NAME, BIRTHDAY, PHONE, ADDRESS, EMAIL, SDATE 
FROM STUDENT STU INNER JOIN SUBJECT SUB ON STU.S_NUM = SUB.NUM;
-- 학생검색
SELECT NUM, NAME, EMAIL FROM STUDENT WHERE NAME = 'KDJ';



-- lesson 과목
drop table lesson;
create table lesson( 
    no number,                  -- PK, SEQ
    abbre varchar2(2) not null, -- 과목요약
    name varchar2(40) not null  -- 과목이름
);
ALTER table lesson add constraint lesson_no_pk PRIMARY KEY(no);
ALTER table lesson add constraint lesson_abbre_uk UNIQUE(abbre);

create sequence lesson_seq 
start with 1
increment by 1;
-- 테스팅
SELECT * FROM LESSON;
DELETE FROM LESSON WHERE NO = 10;
UPDATE LESSON SET ABBRE = '01', NAME = '컴퓨터구조론' WHERE NO = 10;
INSERT INTO LESSON VALUES(lesson_seq.NEXTVAL, '', '');

drop table trainee;
-- trainee 수강신청
create table trainee( 
    no number ,                     -- PK, SEQ
    s_num varchar2(8),              -- student(FK) 학생번호
    abbre varchar2(2),              -- lesson(FK) 과목요약
    section varchar2(20) not null,  -- 전공, 부전공, 교양
    regdate date default sysdate    -- 수강신청일
);
SELECT T.no, T.section, T.regdate, S.num, S.name, L.abbre, L.name as abbreName FROM TRAINEE T INNER JOIN STUDENT S ON T.s_num = S.num 
INNER JOIN LESSON L ON T.abbre = L.abbre ORDER BY T.no;

ALTER table trainee add constraint trainee_no_pk PRIMARY KEY(no);
ALTER table trainee add constraint trainee_student_num_fk 
    FOREIGN KEY(s_num) References student(num) on delete set null;
ALTER table trainee add constraint trainee_lesson_abbre_fk 
    FOREIGN KEY(abbre) References lesson(abbre) on delete set null;
ALTER table trainee drop constraint trainee_lesson_abbre_fk;

create sequence trainee_seq 
start with 1
increment by 1;

-- 테스팅
UPDATE TRAINEE SET S_NUM = '', ABBRE = '', SECTION = '' WHERE NO = 10;
INSERT INTO TRAINEE VALUES(trainee_seq.NEXTVAL, '', '', '', SYSDATE);

commit;

-- 공공데이터 (전통시장 정보)
create table LANDPRICE(
    NODENO NUMBER,                  -- PK
    GPSLATI NUMBER,
    GPSLONG NUMBER,
    NODEID VARCHAR2(20) NOT NULL,
    NODENM VARCHAR2(50) NOT NULL
);
ALTER table LANDPRICE add constraint LANDPRICE_NODENO_PK PRIMARY KEY(NODENO);
ALTER table LANDPRICE add constraint LANDPRICE_NODEID_UK UNIQUE(NODEID);

select * from LANDPRICE;



