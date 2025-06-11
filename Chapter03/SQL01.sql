USE market_db;
SELECT * FROM member;

SELECT mem_name FROM member;

SELECT addr, debut_date, mem_name FROM member;

SELECT * FROM member
WHERE mem_name = '블랙핑크';

SELECT * FROM member
WHERE mem_number = 4;

SELECT mem_id, mem_name FROM member
WHERE height <= 162;

-- AND
SELECT mem_name, height, mem_number FROM member
WHERE height >= 165 AND mem_number > 6;

-- OR
SELECT mem_name, height, mem_number FROM member
WHERE height >= 165 OR mem_number > 6;

-- BETWEEN
SELECT mem_name, height FROM member
WHERE height >= 163 AND height <= 165; -- 지루하고 현학적임

SELECT mem_name, height FROM member
WHERE height BETWEEN 163 AND 165; -- 직관적!

-- IN
SELECT mem_name, addr FROM member
WHERE addr = '경기' OR addr = '전남' OR addr = '경남'; -- 더럽고 손이 아픔

SELECT mem_name, addr FROM member
WHERE addr IN('경기', '전남', '경남'); -- 직관적!

-- LIKE
SELECT * FROM member
WHERE mem_name LIKE '우%'; -- 맨 앞 글자가 우 이고 그 뒤로 아무거나 오는 단어 검색

SELECT * FROM member
WHERE mem_name LIKE '__핑크'; -- 핑크 로 끝나면서 앞에 딱 두 글자가(__) 있는 단어 검색

-- Sub Query
SELECT height FROM member
WHERE mem_name = '에이핑크';

SELECT mem_name, height FROM member
WHERE height > 164; -- 164 = 에이핑크의 평균 키

-- 164를 에이핑크의 평균 키를 구하는 쿼리로 대체 (서브쿼리)
SELECT mem_name, height FROM member
WHERE height > (
	SELECT height FROM member
  WHERE mem_name = '에이핑크');