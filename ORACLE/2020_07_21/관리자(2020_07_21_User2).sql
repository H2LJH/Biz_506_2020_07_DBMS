-- 여기는 관리자 화면 입니다.
-- 새로운 TableSpace 와 사용자 등록하기

-- C:\bizwork\workspace\Oracle_Data


CREATE TABLESPACE user2Ts
DATAFILE 'C:/bizwork/workspace/Oracle_Data/User2.dbf'
SIZE 1M AUTOEXTEND ON NEXT 10K;

CREATE USER user_2 IDENTIFIED BY user2 DEFAULT TABLESPACE user2Ts;

GRANT DBA to user_2;

SELECT * FROM ALL_USERS;