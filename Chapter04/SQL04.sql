USE market_db;

-- INNER JOIN
SELECT * FROM buy
INNER JOIN member ON buy.mem_id = member.mem_id
WHERE buy.mem_id = 'GRL';

SELECT * FROM buy
INNER JOIN member ON buy.mem_id = member.mem_id;

-- 난잡한 속성들을 몇가지로 추려보기
SELECT buy.mem_id, mem_name, prod_name, addr, CONCAT(phone1, phone2) AS "연락처" FROM buy
INNER JOIN member ON buy.mem_id = member.mem_id;
-- mem_id가 양쪽 테이블 모두에게 있으니 하나를 명시해야 한다

-- 이왕 명시할 거 깔끔하게 모든 속성에 테이블을 명시하자!
SELECT buy.mem_id, member.mem_name, buy.prod_name, member.addr, CONCAT(member.phone1, member.phone2) AS "연락처" FROM buy
INNER JOIN member ON buy.mem_id = member.mem_id;
-- 작성하고 보니 코드가 좀 더럽다

-- 테이블에 간단한 별칭을 붙이자
SELECT B.mem_id, M.mem_name, B.prod_name, M.addr, CONCAT(M.phone1, M.phone2) AS "연락처" FROM buy AS B
INNER JOIN member AS M ON B.mem_id = M.mem_id;
-- 당신의 손목 수명이 조금 연장됐다


SELECT M.mem_id, M.mem_name, B.prod_name, M.addr FROM buy AS B
INNER JOIN member AS M ON B.mem_id = M.mem_id
ORDER BY M.mem_id;
-- 전체 회원에 대해 조회하려 했지만 결과는 구매한 기록이 있는 회원만 나옴
-- INNER JOIN은 양쪽에 모두 있는 데이터만 조인되기 때문
-- 어느 한쪽에만 있어도 조인되게 하려면 OUTER JOIN을 사용해야 함