CREATE TABLE tbl_성적
(
    학번 CHAR(5),
    과목명 nVARCHAR2(20),
    점수 NUMBER
);

/*
    표준 SQL 이용한 PIVOT
    1. 어떤 칼럼을 기준칼럼으로 할것인가 : 학번칼럼을 기준으로 삼는다.
        기준칼럼에 대해서 GROUP BY를 설정
    2. 어떤칼럼을 GROUP BY로 설정을 하게 되면 나머지 칼럼은
        통계함수로 감싸거나, 아니면 GROUP  BY에 칼럼을 포함 해주어야 한다.
        
    점수를 SUM 함수로 묶어주는 이유와 결과
    학번을 GROUP BY로 묶어서 여러개 저장된 학번을 1개만 보이도록 하기 위해
    현재 테이블 구조에서 학번+과목의 점수는 전체 데이터에서 1개의 레코드만 존재한다.
    따라서 SUM() 함수는 무언가 합산을 하는 용도가 아니라
    단순히 GROUP BY를 사용할수 있도록 하는 용도일 뿐이다.
*/

SELECT 학번,
    SUM(CASE WHEN 과목명 = '국어' THEN 점수 ELSE 0 END) AS 국어,
    SUM(CASE WHEN 과목명 = '영어' THEN 점수 ELSE 0 END) AS 영어,
    SUM(CASE WHEN 과목명 = '수학' THEN 점수 ELSE 0 END) AS 수학
FROM  tbl_성적
GROUP BY 학번
ORDER BY 학번;


