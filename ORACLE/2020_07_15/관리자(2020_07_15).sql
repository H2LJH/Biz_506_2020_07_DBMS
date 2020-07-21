-- 여기는 sys 계정으로 접속한 화면 입니다.
-- TableSpac와 사용자 계정을 등록하고 사용자 계정에 권한을 부여하는 실습

-- 오라클에서는 공식적으로 Data를 저장하기 앞서 TableSpace를 생성하라
-- TableSpace를 생성하지 않고 Table 등을 만들고 Data를 저장하면
-- 오라클 System 폴더, System TableSpace에 데이터가 저장되어서
-- 보안적인 측면, 관리적인 측면에서 별로 좋지 않다.

-- 실무에서 TableSpace는 데이터를 저장하는데
-- 저장하는 기간, 기본적으로 필요한 용량, 등 여러가지 환경적인 요소들을 분석해서
-- 용량을 산정하고, 설계해서 생성을 한다.
-- 생성된 TableSpace는 용량을 변경하거 하는일이 매우 어렵다.

-- 이러한 이유로 DBA(데이터베이스 관리자) 들도
-- 실무경험이 많은 사람들이 다루는 분야이다.
-- 그러다 보니, 초급(시작하는 DBA)은 별로 다루지 않게 된다.
-- 보통 교재에서는 TableSpace 다루지 않는 경우가 많습니다.

-- TableSpace 생성에서 고려할 사항
-- 이름, 저장파일, 초기용량, 자동증가 옵션
-- 오라클 11gXE는 MaxSize를 지정하지 않아도 기본값으로 11G로 설정이 된다.
-- 따라서 11gXE를 사용할때는 최대 저장공간을 11G 사용할 수 없다.


CREATE TABLESPACE gradeTs
DATAFILE 'C:/bizwork/workspace/Oracle_Data/gradeTs.dbf'
SIZE 1M AUTOEXTEND ON NEXT 500K;

-- 생성한 TableSpace를 관리하고 Data를 조작할 User를 생성
-- 사용자ID, 초기비밀번호, Default TableSpace

CREATE USER grade IDENTIFIED BY grade DEFAULT TABLESPACE gradeTs;


-- grade 사용자가 DB 조작할수 있도록 권한을 부여한다.
-- 권한은 세부적으로 부여하는 것이 좋지만
-- 실습의 편의성을 위해서 DBA 권한을 부여한다.
-- GRANT : 권한을 부여하겠다.
-- DBA : ~~한 일들을 수행할수 있다 라는 policy
-- TO : ~~에게
-- grade : grade user에게

GRANT DBA TO grade;

