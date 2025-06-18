USE market_db;
SELECT mem_id, mem_name, addr FROM member;

-- View 생성
CREATE VIEW v_member AS
	SELECT mem_id, mem_name, addr FROM member;
  
-- View 접근
SELECT * FROM v_member;

SELECT mem_name, addr FROM v_member
WHERE addr IN ('서울', '경기');

-- SQL 단순화
SELECT
	B.mem_id, M.mem_name, B.prod_name, M.addr, CONCAT(M.phone1, M.phone2)
FROM buy B
INNER JOIN member M ON B.mem_id = M.mem_id;

CREATE VIEW v_memberbuy AS
	SELECT
		B.mem_id, M.mem_name, B.prod_name, M.addr, CONCAT(M.phone1, M.phone2) "연락처"
	FROM buy B
	INNER JOIN member M ON B.mem_id = M.mem_id;
  
SELECT * FROM v_memberbuy
WHERE mem_name = '블랙핑크';

-- View의 실제 작동
CREATE VIEW v_viewtest1 AS
	SELECT
		B.mem_id "Member ID",
    M.mem_name "Member Name",
    B.prod_name "Product Name",
    CONCAT(M.phone1, M.phone2) "Office Phone"
	FROM buy B
	INNER JOIN member M ON B.mem_id = M.mem_id;

-- View 조회 시 열에 띄어쓰기가 있으면 백틱으로 묶어주기
SELECT DISTINCT `Member ID`, `Member Name` FROM v_viewtest1;

-- View 수정: ALTER
ALTER VIEW v_viewtest1 AS
	SELECT
		B.mem_id "회원 아이디",
    M.mem_name "회원 이름",
    B.prod_name "제품 이름",
    CONCAT(M.phone1, M.phone2) "연락처"
	FROM buy B
	INNER JOIN member M ON B.mem_id = M.mem_id;
  
SELECT DISTINCT `회원 아이디`, `회원 이름` FROM v_viewtest1;

-- View 삭제: DROP
DROP VIEW v_viewtest1;

-- 기존 View 덮어쓰기: OR REPLACE
CREATE OR REPLACE VIEW v_viewtest2 AS
	SELECT mem_id, mem_name, addr FROM member;
  
-- View 정보 확인: DESC
DESC v_viewtest2;

-- View의 소스 코드 확인
SHOW CREATE VIEW v_viewtest2;

-- View를 통한 수정 및 삭제
SELECT * FROM v_member;

UPDATE v_member
SET addr = '부산'
WHERE mem_id = 'BLK';

INSERT INTO v_member (mem_id, mem_name, addr)
VALUE ('BTS', '방탄소년단', '경기');

-- 조건을 건 View
CREATE VIEW v_height167 AS
	SELECT * FROM member WHERE height >= 167;
  
SELECT * FROM v_height167;

-- View에서의 조건을 건 삭제
SET SQL_SAFE_UPDATES = 0;

DELETE FROM v_height167
WHERE height < 167;

SET SQL_SAFE_UPDATES = 1;

-- View를 통한 데이터 입력
INSERT INTO v_height167
VALUE ('TRA', '티아라', 6, '서울', NULL, NULL, 159, '2005-01-01');

SELECT * FROM v_height167;

-- View의 조건을 만족한 값만 입력되도록 설정하기: WITH CHECK OPTION
ALTER VIEW v_height167 AS
	SELECT * FROM member WHERE height >= 167 WITH CHECK OPTION;
  
INSERT INTO v_height167
VALUE ('TOB', '텔레토비', 4, '영국', NULL, NULL, 140, '1995-01-01'); -- 조건에 맞지 않아 입력되지 않음!

-- 복합 뷰 (데이터 입력/수정/삭제 불가)
CREATE VIEW v_complex AS
	SELECT B.mem_id, M.mem_name, B.prod_name, M.addr FROM buy B
  INNER JOIN member M ON B.mem_id = M.mem_id; -- 주로 조인해서 만듦
  
-- View가 참조하는 테이블의 삭제
DROP TABLE IF EXISTS buy, member;

SELECT * FROM v_height167; -- 참조하는 테이블이 삭제되어 더 이상 조회 불가

CHECK TABLE v_height167; -- View의 상태 확인