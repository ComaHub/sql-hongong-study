-- 대용량 테이블 삭제

CREATE TABLE big_table1 (
	SELECT * FROM world.city, sakila.country
);

CREATE TABLE big_table2 (
	SELECT * FROM world.city, sakila.country
);

CREATE TABLE big_table3 (
	SELECT * FROM world.city, sakila.country
);


-- DELETE를 사용한 삭제
DELETE FROM big_table1; -- 3초 가까이 소요, 느리고 지루하고 구시대적이며 현학적임

-- DROP을 사용한 삭제
DROP TABLE big_table2; -- 0.015초 소요, 매우 빠르고 편리함, 테이블까지 먹어치움

-- TRUNCATE를 사용한 삭제
TRUNCATE TABLE big_table3; -- DROP과 동일하지만 빈 테이블을 남김, WHERE 조건 사용 불가

-- 결론: 테이블 필요 없으면 DROP, 빈 테이블은 필요하면 TRUNCATE