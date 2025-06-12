USE market_db;

-- OUTER JOIN
SELECT M.mem_id, M.mem_name, B.prod_name, M.addr FROM member AS M
LEFT OUTER JOIN buy AS B ON M.mem_id = B.mem_id
ORDER BY M.mem_id;

SELECT M.mem_id, M.mem_name, B.prod_name, M.addr FROM member AS M
LEFT OUTER JOIN buy AS B ON M.mem_id = B.mem_id
ORDER BY M.mem_id;

SELECT DISTINCT M.mem_id, B.prod_name, M.mem_name, M.addr FROM member AS M
LEFT OUTER JOIN buy AS B ON M.mem_id = B.mem_id
WHERE B.prod_name IS NULL -- 값이 Null인 레코드만 찾기
ORDER BY M.mem_id;


-- CROSS JOIN
SELECT * FROM buy
CROSS JOIN member;
-- 의미없는 결과물 => 테스트를 위한 대용량 데이터 생성할 때 사용

SELECT COUNT(*) AS "데이터 개수" FROM sakila.inventory
CROSS JOIN world.city;

CREATE TABLE corss_table
	SELECT * FROM sakila.actor
  CROSS JOIN world.country;
  
SELECT * FROM corss_table
LIMIT 5;


-- SELF JOIN
CREATE TABLE emp_table (
	emp CHAR(4),
  manager CHAR(4),
  phone VARCHAR(8)
);

INSERT INTO emp_table
VALUE
	('대표', NULL, '0000'),
	('영업이사', '대표', '1111'),
	('관리이사', '대표', '2222'),
	('정보이사', '대표', '3333'),
	('영업과장', '영업이사', '1111-1'),
	('경리부장', '관리이사', '2222-1'),
	('인사부장', '관리이사', '2222-2'),
	('개발팀장', '정보이사', '3333-1'),
	('개발주임', '정보이사', '3333-1-1');
  
-- 같은 테이블에 서로 다른 별칭을 붙여 2개의 테이블인 것처럼 조인
SELECT A.emp AS "직원", B.emp AS "직속상관", B.phone AS "직속상관연락처" FROM emp_table AS A
INNER JOIN emp_table AS B ON A.manager = B.emp
WHERE A.emp = '경리부장';