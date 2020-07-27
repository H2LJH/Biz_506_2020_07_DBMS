-- 여기는 user2 화면입니다.

-- 주문번호, 고객번호, 상품코드, 상품명, 판매가격, 수량, 합계

SELECT * FROM TBL_주문서원장;

/*
    현재 tbl_주문서원장 table 리스트 
 
    O00001	2019-01-02	C0032	김권수	010-2401-3866	P00049,P00050,P00060	P00049	P00050	P00060
    O00002	2019-01-03	C0038	이희근	010-5861-5613	P00001,P00027	P00001	P00027	
    O00003	2019-01-03	C0026	남종숙	010-2767-0420	P00069,P00026,P00083	P00069	P00026	P00083

*/

CREATE TABLE tbl_order
(
    O_SEQ	NUMBER	 PRIMARY KEY,
    O_NUM	CHAR(6)	 NOT NULL,
    O_DATE	CHAR(10) NOT NULL,		
    O_CNUM	CHAR(5)	 NOT NULL,		
    O_PCODE	CHAR(6)	 NOT NULL,		
    O_PNAME	nVARCHAR2(125),			
    O_PRICE	NUMBER,			
    O_QTY	NUMBER,			
    O_TOTAL	NUMBER			
);

-- tbl_order Table을 만들면서 여기에 추가될 데이터들 중에 1개의 칼럼으로는 pk를 만들수 없어서
-- 임의의 일련번호 칼럼을 하나 추가하고 이 칼럼을 pk 선언했다.
-- 이상황이 되면 데이터를 추가할때 일일히 O_seq 칼럼에 저장된 데이터들을 살펴보고
-- 등록되지 않은 숫자를 만든다음 그 값으로 SEQ을 정하고 INSERT를 수행해야 한다.
-- 이런방식은 코드를 매우 불편하게 만드는 결과를 낳게된다.

-- 이러한 불편을 방지하기 위해 SEQUENCE 라는 객체를 사용하여, 자동으로 일련번호를 만드는 방법을 사용한다.

CREATE SEQUENCE seq_order
START WITH 1 INCREMENT BY 1;

-- 표준 SQL에서 간단한 게산을 할때
-- SELECT 3 + 4; 라고 코딩을 하면 3+4의 결과를 확인 할 수 있다.
-- 그런데 오라클에서는 SELECT 명령문에 FROM [TABLE] 절이 없으면 문법오류가 난다.
-- 이러한 코드가 필요할때 시스템에 이미 준비되어 있는 DUAL이라는 DUMMY 테이블을 사용해서 코딩을 한다.
SELECT 3 + 4 FROM DUAL;

-- seq_order 객체의 NEXTVAL 이라는 모듈(함수역활)을 호출하여
-- 변화되는 일련번호를 보여달라 라는 코드
SELECT seq_order.NEXTVAL FROM DUAL;

-- 지금 tbl_order 테이블에 아래와 같은 데이터가 있을때

-- 주문번호,   고객번호,   상품코드,  상품명,    판매가격,   수량, 합계
-- O00001      C032       P00001
-- O00001      C032       P00002
-- O00001      C032       P00003

-- 지금 tbl_order 테이블에 위와 같은 데이터가 있을때
--  O00001      C032       P00001 이러한 데이터를 추가한다면 아무런 제약없이 값이 추가되 버릴 것이다.

INSERT INTO tbl_order(o_seq, o_date, o_num, o_cnum, o_pcode) VALUES (seq_order.NEXTVAL, '2020-07-22', 'O00001', 'C0032', 'P00001');
INSERT INTO tbl_order(o_seq, o_date, o_num, o_cnum, o_pcode) VALUES (seq_order.NEXTVAL, '2020-07-22', 'O00001', 'C0032', 'P00002');
INSERT INTO tbl_order(o_seq, o_date, o_num, o_cnum, o_pcode) VALUES (seq_order.NEXTVAL, '2020-07-22', 'O00001', 'C0032', 'P00003');
INSERT INTO tbl_order(o_seq, o_date, o_num, o_cnum, o_pcode) VALUES (seq_order.NEXTVAL, '2020-07-22', 'O00001', 'C0032', 'P00003');

-- UNIQUE를 추가하는데 이미 UNIQUE 조건에 위배되는 값이 있으면 제약조건이 추가되지 않는다
-- duplicate keys found : pk, unique로 설정된 칼럼에 값을 추가하거나, 이미 중복된 값이 있는데 pk, unique를 설정하려 할때 나옴

-- 주문번호,고객번호, 상품코드 이 3개의 칼럼 묶음의 값이 중복되면 INSERT가 되지 않도록 제약조건을 설정해야 한다.
-- UNIQUE : 칼럼에 값이 중복되어서 INSERT가 되는 것을 방지하는 제약조건
-- 주문테이블에 UNIQUE 제약조건을 추가하자
ALTER TABLE tbl_order 
    ADD CONSTRAINT UQ_ORDER 
        UNIQUE(o_num, o_cnum, o_pcode);

DELETE FROM tbl_order WHERE o_seq = 10;

-- 후보키중에 단일칼럼으로 pk를 설정할 수 없는 상황이 발생을 하면
-- 복수의 칼럼으로 pk를 설정하는데
-- update, delete 수행할때, where 칼럼1 = 값 and 칼럼2 = 값 and 칼럼3 = 값 ... 과 같은 조건을 부여해야 한다.
-- 이것은 데이터 무결성을 유지하는데 매우 좋지않은 환경이다
-- 이럴때 데이터와 상관없는 seq 칼럼을 만들어 pk로 설정하자


SELECT * FROM tbl_order;








