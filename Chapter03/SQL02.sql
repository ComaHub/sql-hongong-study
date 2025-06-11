-- ORDER BY
SELECT mem_id, mem_name, debut_date FROM member
ORDER BY debut_date;

-- Ascending / Descending
SELECT mem_id, mem_name, debut_date FROM member
ORDER BY debut_date DESC;

-- WHERE (First) -> ORDER BY
SELECT mem_id, mem_name, debut_date, height FROM member
WHERE height >= 164
ORDER BY height DESC;

-- Multi Order
SELECT mem_id, mem_name, debut_date, height FROM member
WHERE height >= 164
ORDER BY height DESC, debut_date ASC;

-- LIMIT
SELECT * FROM member
LIMIT 3;

SELECT mem_name, debut_date FROM member
ORDER BY debut_date
LIMIT 3;

SELECT mem_name, height FROM member
ORDER BY height DESC
LIMIT 3, 2; -- 3번째부터 2건 (0부터 시작)

-- DISTINCT
SELECT addr FROM member;

SELECT addr FROM member
ORDER BY addr;

SELECT DISTINCT addr FROM member;

-- GROUP BY
SELECT mem_id, amount FROM buy
ORDER BY mem_id;

SELECT mem_id, SUM(amount) FROM buy
GROUP BY mem_id;

SELECT mem_id AS "회원 아이디", SUM(price * amount) AS "총 구매 금액" FROM buy
GROUP BY mem_id;

SELECT AVG(amount) AS "평균 구매 개수" FROM buy;

SELECT mem_id, AVG(amount) AS "평균 구매 개수" FROM buy
GROUP BY mem_id;

SELECT COUNT(*) FROM member;

SELECT COUNT(phone1) AS "연락처가 있는 회원" FROM member;

-- Having
SELECT mem_id AS "회원 아이디", SUM(price * amount) AS "총 구매 금액" FROM buy
GROUP BY mem_id;

SELECT mem_id AS "회원 아이디", SUM(price * amount) AS "총 구매 금액" FROM buy
GROUP BY mem_id
HAVING SUM(price * amount) > 1000;

SELECT mem_id AS "회원 아이디", SUM(price * amount) AS "총 구매 금액" FROM buy
GROUP BY mem_id
HAVING SUM(price * amount) > 1000
ORDER BY SUM(price * amount) DESC;