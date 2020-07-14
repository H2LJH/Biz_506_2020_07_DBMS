--Comment : 주석
/*
    SQL 명령을 입력할때 명령이 끝났다라는 것을 알리기 위해 ; 붙여준다.   
    Ctrl + Enter : 현재 커서가 있는 곳의 명령문을 DBMS로 보내고 결과를 받기
*/

-------------------------------------------------------------------------------
-- select(대소문자 상관없음) 키워드는 from 절을 포함하는 명령문 형태로 작성을 하며
-- DBMS가 보관하고 있는 데이터를 table형식으로 보여달라 라는 명령
-- DBMS의 DML(Database Manuplation Lang)중에서 Read(조회)를 수행하는 명령
-- CRUD 중에서 R : Read, Retrive를 수행하는 명령문
-------------------------------------------------------------------------------

-- 현재 오라클에 접속된 사용자(sys)가 관리하는 table들이 있는데 
-- 그중에서 tab이라는 이름의 table정보를 가져와서 나에게 보여달라
-- 오라클의 tab table은 현재 접속된 사용자가 관리하는 
--          DB Object(객체)들의 정보를 보관하고 있는 table

SELECT * FROM tab; 
-------------------------------------------------------------------------------

-- 오라클 system 데이터 사전의 자세한 정보를 보관하는 table 

select * from all_all_tables;

-------------------------------------------------------------------------------
-- SQL 명령문을 통해서 DB 객체를 만들고 삭제하고, 데이터를 추가, 변경, 삭제를 수행할텐데
-- sys사용자로 접속을 하게 되면 중요한 정보를 잘못 삭제, 변경할 우려가 있기 때문에
-- 실습을 위해서 사용자를 생성하여 수행을 할것이다.
-- 사용자를 추가하는 순서 
-- 1. table Space : 데이터를 저장할 물리적 공간을 설정
-- 2. User : 사용자를 생성하고, 물리적 저장공간과 연결
-------------------------------------------------------------------------------

-- TABLE SPACE  생성(CREATE)
-- TABLE SPACE는 오라클에서 DATA를 저장할 물리적 공간을 설정하는 것
-- myTs : 앞으로 SQL을 통해서 사용할 TableSpace의 Alias(이름)
-- '../myTs.dbf' : 저장할 파일이름
-- size : 오라클에서는 성능의 효율성을 주기 위해 일단 빈 공간을 일정부분 설정한다.
-- 크기는 최초에 저장할 데이터의 크기등을 계산하여 설계하고 설정 한다.
-- 너무 작으면, 효율성이 떨어지고, 너무 크면 불필요한 공간을 낭비한다.
-- 오라클 xe(Express Edition)에서는 table Space의 최대 크기를 11G 제한한다.

-- 만약 Size 10G로 지정하고, 용량이 초과되어 AUTO NEXT로 추가가 되는 경우
-- 전체 Size가 11G를 넘어서면 오류가 나면서 더이상 데이터를 저장할수 없게 된다.

-- AUTO.. NEXT : 만약 초기에 지정한 SIZE 공간에 데이터가 가득하면 자동으로
-- 용량을 늘려서 저장할수 있도록 만들어라

-- SIZE의 1M : 기본크기를 1024 * 1024 BYTE 크기로 지정하라    // SIZE를 지정할때 1MB라고 하지않는다.
-- NEXT 500K : 자동으로 확장(늘리기)를 1024 * 500 크기로 설정 // "

-- CREATE로 시작되는 명령문 : DDL(Data definition Lang) : 데이터 선언, 생성(추가와는 다름)

CREATE TABLESPACE myTS 
DATAFILE 'C:/bizwork/workspace/Oracle_Data/myTS.dbf'
SIZE 1m AUTOEXTEND ON NEXT 500K;
-------------------------------------------------------------------------------

-- 질의작성기에서 코드를 작성할때 약속
-- DBMS의 SQL문은 특별한 일부 경우를 제외하고 대소문자 구별을 하지 않는다.
-- DBMS, SQL, 오라클과 관련된 키워드는 모두 대문자로 작성할것
-- 변수, 값, 내용은 소문자로 사용하며 특별히 대소문자를 구분해야하는 경우는 별도로 공지
-------------------------------------------------------------------------------

-- DROP : DDL 명령의 CREATE와 반대되는 개념의 명령문
-- DROP 명령은 데이터를 물리적으로 완전 삭제하는 개념이므로 매우 신중하게 사용해야 한다.

DROP TABLESPACE myTs             -- myTs tableSpace를 삭제하면서 
INCLUDING CONTENTS AND DATAFILES -- 연관된 정보와 data file도 같이 삭제하고
CASCADE CONSTRAINTS;             -- 그리고 설정된 권한, 역할 등이 있으면 그들도 같이 삭제하라
-------------------------------------------------------------------------------

-- 위에서 생성한 TableSpace를 관리하며, 데이터를 조작할 사용하자를 생성

CREATE USER user1 IDENTIFIED BY 1234 -- 사용자 ID를 user1으로 설정하고 초기 비번을 1234로 설정
DEFAULT TABLESPACE myTs;
-------------------------------------------------------------------------------

-- DCL : Data control Lang.
-- 새로 생성된 user1에게 권한을 부여하기

GRANT CONNECT TO user1; -- user1이 로그인만 할수 있도록 권한(역할) 부여
REVOKE CONNECT FROM user1; -- user1이 로그인할수 있는 권한을 제거
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
--user1이 로그인을 수행하고, 최소한으로 데이터들을 관리할수 있도록 권한을 부여
-- Resource : 오라클에서 User에게 줄수 있는 권한중 상당히 많은 일을 수행할수 있는 권한
-- 현재 시스템에 설치된 모든 TableSpace를 대상으로 무제한(TableSpace가 허용하는 범위) 저장
-- Resource 권하는 Standard, Enterprice DBMS에서는 함부로 부여해서는 안된다.
-- CONNECT 와 RESOURCE 권한을 부여하게 되면 거의 DBA 수준의 권한을 갖게 된다.

GRANT CONNECT,RESOURCE TO user1; 
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- 권한을 세부적으로 부여하는 것은 실무상에서 매우 필요하며 중요한 일이다.
-- 하지만 학습하는 입장에서 GRANT 부여하는데 너무 많은 노력을 쏟으면 피곤하니
-- xe 버전에서는 사용자에게 DBA 권한을 부여하고, 실습을 진행한다.

-- Login 권한과 table 생성할수 있는 권한
GRANT CONNECT,CREATE TABLE TO user1; 

-- Login권한, table 생성권한, 학생정보 테이블에 데이터를 추가할수 있는 권한
GRANT CONNECT, CREATE TABLE, INSERT TABLE 학생정보 TO user1; 

-- Login, table 생성, 학생정보 추가, 학생정보 조회
GRANT CONNECT, CREATE TABLE, INSERT TABLE 학생정보, SELECT TABLE 학생정보 TO user1; 


-------------------------------------------------------------------------------
-- DBA 권한(Roll)은 sysDBA보다 한단계 낮은 권한 등급을 가지며
-- 일반적으로 자신이 생선한 Table등 DB Object에만 접근하여 명령을 수행한다.

GRANT DBA to USER1;
-------------------------------------------------------------------------------
