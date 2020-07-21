-- 여기는 grade 사용자 화면 입니다.
-- excel 파일에서 학생 데이터를 IMPORT 한 후 SELECT 실습하기

-- 모든 데이터를 다 보여달라
SELECT * FROM tbl_student;

--SELECTION
-- 데이터중에서 조건을 부여하여 조건에 맞는 리스트만 보이기
-- Recored의 제한 (전체 데이터개수 > 조건에 맞는 데이터 개수)
-- WHERE 절에 조건을 설정하여 데이터를 조회
-- PK, UNIQUE 칼럼으로 설정된 칼럼을 단일 조건으로 SECTION 할때는 이 데이터는 1개의 객체로 취급한다.(VO에 담는다.)
SELECT * FROM tbl_student WHERE st_num = '20001';


-- st_num에 저장된 값이 '20001' 이상이고 (AND) '20010' 이하인 조건에 맞는
-- 데이터리스트(Record)만 보여달라
-- PK, UNIQUE로 설정된 칼럼을 복합 조건절로 SELECTION할때는 레코드가 1개만 나타날 지라도
-- 이 데이터는 리스트로 취급한다.
SELECT * FROM tbl_student WHERE st_num >= '20001' AND st_num <= '20010';


-- st_name에 저장된 값이 독고예준인 리스트만 보여라
-- PK, UNIQUE로 설정된 칼럼이 아닌경우
-- SELECTION을 수행했을떄 나타나는 레코드가 1개 일지라도
-- 이 데이터는 리스트로 취급한다.
SELECT * FROM tbl_student WHERE st_name = '독고예준';


-- PROJECTION
-- SELECTION된 레코드의 개수와 무관하게, 특정 칼럼만 리스트에 포함하는 조회
-- 레코드 개수와 관계 없이 보이는 칼럼을 제한하는 조회
SELECT st_num, st_name, st_dept, st_grade FROM tbl_student;


-- SELECTION & PROJECTION
-- WHERE 조건절을 사용해서 레코드를 제한하고,
-- 칼럼명을 나열하여 필요한 항목(필드)만 보고자 할때
-- 칼럼리스트를 제한하기
SELECT st_num, st_name, st_dept, st_grade FROM tbl_student WHERE st_name = '남동예';


-- BETWEEN 연산을 사용하여 범위를 제한하는 SELECTION 구현하기
SELECT st_num, st_name, st_dept, st_grade FROM tbl_student WHERE st_num >= '20001' AND st_num <= '20010';
SELECT st_num, st_name, st_dept, st_grade FROM tbl_student WHERE st_num BETWEEN '20001' AND '20010';


-- 비교 연산자(=) 관계연산자 OR를 조합하여 SELECTION 구현하기
SELECT st_num, st_name, st_dept, st_grade FROM tbl_student WHERE st_num = '20001' OR st_num = '20003' OR st_num = '20006';


-- 한개의 칼럼에 다수의 OR 조건을 부여하여 SECTION을 수행할떄는 IN 연산자를 사용하여 구현할수 있다.
SELECT st_num, st_name, st_dept, st_grade FROM tbl_student WHERE st_num IN ('20001', '20003', '20006');


-- 문자열(VARCHAR2, nVARCHAR2) 칼럼일 경우 문자열 전체가 아닌 부분만 일치하는 조건을 부여하여 SELECTION 구현하기
SELECT st_num, st_name, st_dept, st_grade FROM tbl_student WHERE st_num LIKE '%7';

-- LIKE : Full Text Search
SELECT st_num, st_name FROM tbl_student WHERE st_name LIKE '독%'; -- 시작 부분
SELECT st_num, st_name FROM tbl_student WHERE st_name LIKE '%준'; -- 끝나는 부분
SELECT st_num, st_name FROM tbl_student WHERE st_name LIKE '%독%'; -- 포함된 부분











