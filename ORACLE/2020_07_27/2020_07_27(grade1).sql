CREATE TABLE tbl_student
(
    st_num	 CHAR(5) PRIMARY KEY,
    st_name	 nVARCHAR2(20) NOT NULL,		
    st_tel	 nVARCHAR2(20) NOT NULL,	
    st_addr	 nVARCHAR2(40),			
    st_grade NUMBER(1)	NOT NULL,		
    st_dcode CHAR(3)	NOT NULL
);

CREATE TABLE tbl_dept
(
    d_code CHAR(3) PRIMARY KEY,
    d_name nVARCHAR2(20) UNIQUE NOT NULL,
    d_pname nVARCHAR2(20)
);

CREATE TABLE tbl_score 
(
    sc_num CHAR(5) NOT NULL,
    sc_name nVARCHAR2(20) NOT NULL,
    sc_score NUMBER(3) NOT NULL
);
DROP TABLE tbl_score;
ALTER TABLE tbl_score
    ADD CONSTRAINT UQ_ORDER 
        UNIQUE (sc_num, sc_name);


INSERT INTO tbl_student(st_num,  st_name,  st_tel, st_addr, st_grade, st_dcode) 
     VALUES('20001', '갈한수', '010-2217-7851', '경남 김해시 어방동 1088-7', 3, '008');

INSERT INTO tbl_student(st_num,  st_name,  st_tel, st_addr, st_grade, st_dcode) 
     VALUES('20002', '강이찬', '010-4311-1533', '강원도 속초시 대포동 956-5', 1, '006');

INSERT INTO tbl_student(st_num,  st_name,  st_tel, st_addr, st_grade, st_dcode) 
     VALUES('20003', '개원훈', '010-6262-7441', '서울시 구로구 구로동 3-35번지', 1, '009');

INSERT INTO tbl_student(st_num,  st_name,  st_tel, st_addr, st_grade, st_dcode) 
     VALUES('20004', '경시현', '010-9794-9856', '서울시 구로구 구로동 3-35번지', 1, '006');

INSERT INTO tbl_student(st_num,  st_name,  st_tel, st_addr, st_grade, st_dcode) 
     VALUES('20005', '공동영', '010-8811-7761', '강원도 동해시 천공동 1077-3', 2, '010');


INSERT INTO tbl_dept(d_code, d_name, d_pname) VALUES ('001', '컴퓨터공학', '토발즈');
INSERT INTO tbl_dept(d_code, d_name, d_pname) VALUES ('002', '전자공학', '이철기');
INSERT INTO tbl_dept(d_code, d_name, d_pname) VALUES ('003', '법학', '킹스필드');


INSERT INTO tbl_score(sc_num, sc_name, sc_score) VALUES('20001', '데이터베이스', 71);
INSERT INTO tbl_score(sc_num, sc_name, sc_score) VALUES('20001', '수학', 63);
INSERT INTO tbl_score(sc_num, sc_name, sc_score) VALUES('20001', '미술', 50);

INSERT INTO tbl_score(sc_num, sc_name, sc_score) VALUES('20002', '데이터베이스', 84);
INSERT INTO tbl_score(sc_num, sc_name, sc_score) VALUES('20002', '수학', 75);
INSERT INTO tbl_score(sc_num, sc_name, sc_score) VALUES('20002', '미술', 52);

INSERT INTO tbl_score(sc_num, sc_name, sc_score) VALUES('20003', '데이터베이스', 89);
INSERT INTO tbl_score(sc_num, sc_name, sc_score) VALUES('20003', '수학', 63);
INSERT INTO tbl_score(sc_num, sc_name, sc_score) VALUES('20003', '미술', 70);


drop table tbl_student;
drop table tbl_score;
drop table tbl_dept;

SELECT * FROM tbl_student;
SELECT sc_num, sc_score  FROM tbl_score WHERE sc_score < 60;
UPDATE tbl_student SET st_addr = '광주광역시 북구 중흥동 경양로 170번' WHERE st_name = '공동영';
DELETE tbl_student WHERE st_name = '개원훈';


SELECT * FROM tbl_student LEFT JOIN tbl_dept ON st_dcode = d_code;

SELECT 
    sc_num AS  학번,
    SUM(sc_score) AS 총점,
    ROUND(AVG(sc_score) / 1,2) AS 평균
FROM tbl_score
GROUP BY sc_num
ORDER BY sc_num;



SELECT 
    ST.st_num AS 학번, ST.st_name AS 이름, ST.st_tel AS 전화번호,
    SUM(sc_score) AS 총점,
    ROUND(AVG(sc_score) / 1,2) AS 평균
FROM tbl_score SC
    LEFT JOIN tbl_student ST
        ON ST.st_num = SC.sc_num
GROUP BY (ST.st_num, ST.st_name, ST.st_tel) 
ORDER BY ST.st_num;


SELECT sc_num AS 학번,
    SUM(DECODE(sc_name, '국어', sc_score, 0)) AS 국어,
    SUM(DECODE(sc_name, '영어', sc_score, 0)) AS 영어,
    SUM(DECODE(sc_name, '수학', sc_score, 0)) AS 수학,
    SUM(DECODE(sc_name, '소프트웨어공학', sc_score, 0)) AS 소프트웨어공학,
    SUM(DECODE(sc_name, '데이터베이스', sc_score, 0)) AS 데이터베이스,
    SUM(sc_score) AS 총점,
    ROUND(AVG(sc_score) / 1,2) AS 평균
FROM tbl_score
GROUP BY sc_num
ORDER BY sc_num; 



SELECT sc_num AS 학번, st_name AS 이름, st_tel AS 전화번호, st_dcode AS 학과코드,
    SUM(DECODE(sc_name, '국어', sc_score, 0)) AS 국어,
    SUM(DECODE(sc_name, '영어', sc_score, 0)) AS 영어,
    SUM(DECODE(sc_name, '수학', sc_score, 0)) AS 수학,
    SUM(DECODE(sc_name, '소프트웨어공학', sc_score, 0)) AS 소프트웨어공학,
    SUM(DECODE(sc_name, '데이터베이스', sc_score, 0)) AS 데이터베이스,
    SUM(sc_score) AS 총점,
    ROUND(AVG(sc_score) / 1,2) AS 평균
FROM tbl_score
    LEFT JOIN tbl_student
        ON sc_num = st_num
    LEFT JOIN tbl_dept
        ON d_code = st_dcode
GROUP BY sc_num, st_name, st_tel, st_dcode, d_name
ORDER BY sc_num; 




SELECT sc_num AS 학번, st_name AS 이름, st_tel AS 전화번호, st_dcode AS 학과코드, d_name AS 학과명,
    SUM(DECODE(sc_name, '국어', sc_score, 0)) AS 국어,
    SUM(DECODE(sc_name, '영어', sc_score, 0)) AS 영어,
    SUM(DECODE(sc_name, '수학', sc_score, 0)) AS 수학,
    SUM(DECODE(sc_name, '소프트웨어공학', sc_score, 0)) AS 소프트웨어공학,
    SUM(DECODE(sc_name, '데이터베이스', sc_score, 0)) AS 데이터베이스,
    SUM(sc_score) AS 총점,
    ROUND(AVG(sc_score) / 1,2) AS 평균
FROM tbl_score
    LEFT JOIN tbl_student
        ON sc_num = st_num
    LEFT JOIN tbl_dept
        ON d_code = st_dcode
GROUP BY sc_num, st_name, st_tel, st_dcode, d_name
ORDER BY sc_num; 


