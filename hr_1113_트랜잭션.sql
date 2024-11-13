-- Transaction
DROP TABLE DEP02;

-- 테이블복사 (구조만 복사)
CREATE TABLE DEP02
AS
SELECT * FROM DEPARTMENTS WHERE 1 = 0;

-- 내용복사
INSERT INTO DEP02 SELECT * FROM DEPARTMENTS;

SELECT * FROM DEP02;

SAVEPOINT C1;

DELETE FROM DEP02 WHERE DEPARTMENT_ID = 90;

SELECT * FROM DEP02;

ROLLBACK TO C1;