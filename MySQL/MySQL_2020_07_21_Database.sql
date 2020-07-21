-- MySQL에서 사용자는 기본적으로 root시작을 한다.
----------------------------------------------
# 구분  			Oracle			MySQL 
# 저장소 			TableSpace		Database
# Schema		User			Database
# 데이터 저장		User,Table 형식	Table
# User의 개념 	Schema			Login 하는 Account
----------------------------------------------

-- 1. MySQL 데이터를 저장하기 위해서 최초로 DataBase를 생성
-- 2. 생성된 DataBase를 사용가능 하도록 Open 절차 필요
-- 3. 사용자 Login 권한과 접속하는 용도의 Account

# MySQL CHARACTER SET
-- 저장하는 문자열의 코드길이(Byte)관련한 설정
-- MySQL 5.x(5.7)에서는 문자 Locale 설정이 기본값이 Lathin이어서 
-- 한글과 같은 UNICODE 저장에 상당히 문제가 되었던 적이 있다.
-- 최근에는 기본 문자 Locale UTF8M4 라는 방식으로 거의 통일되었다
-- 따라서 별도로 CHARACTER SET을 지정하지 않아도 큰 문제가 없다.
-- 오래된 MySQL 버전에서는 DATABASE를 생성할때 CHARACTER SET을
-- 명시해 주었으나 최근 버전에서는 오히려 경고를 내고 있다.

-- MySQL 칼럼 Type
# 문자열
-- CHAR		: 고정된 문자열을 저장하는 COLUMN		  : 255까지 가능
-- VARCHAR 	: 한글을 포함한 가변형 문자열을 저장하는 칼럼 : 655365까지 가능

# 정수형		
-- INT(4byte, 2의 32승) 
-- BIGINT(8byte, 무제한) 
-- TINYINT(1byte, -128~127, 0~255) 
-- SMALLINT(0~65535)
-- MIDEUM(0~1677215)
-- 정수형의 경우 자릿수를 명시하지 않으면 최대지원 크기까지 저장 가능
-- 실제 저장을 해보면 INT형은 정수 11자리를 넘어가면 저장이 안된다.

# 실수형
-- FLOAT(길이, 소수점, 4byte)
-- DECIMAL(길이, 소수점, 8byte)
-- DOUBLE(길이, 소수점)

-- 현재 PC에 설치된 MySQL myDB라고 하는 Scema(DataBase)를 생성
CREATE DATABASE myDB; -- DEFAULT CHARACTER SET UTF8;

-- myDB Open
USE myDB;

CREATE TABLE tbl_student
(
	st_num	 CHAR(5)	 PRIMARY KEY,
	st_name	 VARCHAR(20) NOT NULL,		
	st_dept	 VARCHAR(10),	
	st_grade INT,		
	st_tel	 VARCHAR(20),			
	st_addr	 VARCHAR(125),			
	st_age	 INT	
);
DESC tbl_student;


CREATE TABLE tbl_score
(
	sc_num	 CHAR(5),
	sc_scode CHAR(4) NOT NULL,
	sc_sname VARCHAR(30),
	sc_score INT	
);
DROP TABLE tbl_score;
SELECT * FROM tbl_student;


# PROJECTION
SELECT st_num, st_name, st_tel FROM tbl_student;

# SELECTION
SELECT st_num, st_name 
FROM tbl_student
WHERE st_num BETWEEN '20001' AND '20010';

SELECT st_num, st_name, st_dept, d_name, d_prof
FROM tbl_student ST
	LEFT JOIN tbl_dept D
		ON ST.st_dept = D.d_code;
                
SELECT COUNT(*) FROM tbl_iolist;

SELECT io_bcode, 
	SUM(CASE WHEN io_inout = '매입' THEN io_amt ELSE 0 END) AS '매입합계',
	SUM(CASE WHEN io_inout = '매출' THEN io_amt ELSE 0 END) AS '매출합계'
FROM tbl_iolist
GROUP BY io_bcode;
    
SELECT 
	SUM(CASE WHEN io_inout = '매입' THEN io_amt ELSE 0 END) AS '매입합계',
	SUM(CASE WHEN io_inout = '매출' THEN io_amt ELSE 0 END) AS '매출합계',
    SUM(CASE WHEN io_inout = '매출' THEN io_amt ELSE 0 END) - SUM(CASE WHEN io_inout = '매입' THEN io_amt ELSE 0 END) AS '이익금'
FROM tbl_iolist;
    
-- 현재 스키마의 TABLE LIST
SHOW TABLES;

-- 현재 MySQL Server에 만들어진 스키마(DataBase) List
SHOW DATABASES;
        
-----------------------------------
# tbl_score 테이블에 데이터 추가하기    
-----------------------------------
-- 만약 학번 20001인 학생의 국어(D001), 영어(D002), 수학(D003) 점수를 입력한다 라고 하면
INSERT INTO tbl_score(sc_num, sc_scode, sc_sname, sc_score) VALUES ('20001', 'D001', '국어', 80);    
INSERT INTO tbl_score(sc_num, sc_scode, sc_sname, sc_score) VALUES ('20001', 'D002', '영어', 70);
INSERT INTO tbl_score(sc_num, sc_scode, sc_sname, sc_score) VALUES ('20001', 'D003', '수학', 60);

INSERT INTO tbl_score(sc_num, sc_scode, sc_sname, sc_score) VALUES ('20002', 'D001', '국어', 10);    
INSERT INTO tbl_score(sc_num, sc_scode, sc_sname, sc_score) VALUES ('20002', 'D002', '영어', 20);
INSERT INTO tbl_score(sc_num, sc_scode, sc_sname, sc_score) VALUES ('20002', 'D003', '수학', 30);

SELECT * FROM tbl_score;

-- 한개의 칼럼으로 PK를 만들때는 설계할때 고려를 하고
-- Table을 생성할때 만드는 것이 편리하다.

-- 두개이상의 복합키를 만들때는 보통 테이블 설계가 완료되고
-- Table을 만들고 데이터가 추가되는 과정에서 생성되는 경우가 많다.
-- 두개이상의 후보키를 묶어서 pk로 설정하는 복합키 pk
ALTER TABLE tbl_score ADD PRIMARY KEY(sc_num, sc_scode);
ALTER TABLE tbl_score DROP PRIMARY KEY;
DESC tbl_score;

-- 어떤 Table을 만들었는데, 이 테이블에 PK를 성정하려고 봤더니
-- 단일키로 pk를 설정하기가 매우 어렵게 되었다.
-- 복합키로 pk를 설정해야 하는데 왠지 그러기가 싫다.
-- 임의 실제 데이터와는 관계가 없이 별도의 pk만을 위한 칼럼을 만들고
-- 그 칼럼에 일련번호와 같은 값을 채워서 pk로 삼고 싶다.
-- INSERT 보다는 UPDATE, DELTE의 무결을 위한 설정

-- 이미 사용중인 테이블에 일련번호를 채울 PK만을 위한 칼럼을 생성하는 방법
ALTER TABLE tbl_score ADD sc_seq BIGINT PRIMARY KEY AUTO_INCREMENT;
DESC tbl_score;
SELECT * FROM tbl_score;

-- 설계를 하면서 일련번호를 채울 PK만을 위한 칼럼을 생성하는 방법
CREATE TABLE tbl_score
(
	sc_seq BIGINT PRIMARY KEY AUTO_INCREMENT,
	sc_num	 CHAR(5),
	sc_scode CHAR(4) NOT NULL,
	sc_sname VARCHAR(30),
	sc_score INT	
);

ALTER TABLE tbl_score ADD sc_seq BIGINT PRIMARY KEY;
SELECT * FROM tbl_score;
INSERT INTO tbl_score(sc_num, sc_scode, sc_sname, sc_score) VALUES('20003', 'D001', '국어', 90);
INSERT INTO tbl_score(sc_num, sc_scode, sc_sname, sc_score, sc_seq) VALUES('20003', 'D001', '국어', 90, 10);


















