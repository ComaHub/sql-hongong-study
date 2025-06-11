-- 데이터 수정
SET SQL_SAFE_UPDATES = 0;

USE market_db;
UPDATE city_popul SET city_name = '서울'
WHERE city_name = 'Seoul';

SELECT * FROM city_popul
WHERE city_name = '서울';

UPDATE city_popul SET city_name = '뉴욕', population = 0
WHERE city_name = 'New York';

SELECT * FROM city_popul
WHERE city_name = '뉴욕';

UPDATE city_popul SET population = population / 10000;

SELECT * FROM city_popul
LIMIT 5;

-- 데이터 삭제
DELETE FROM city_popul
WHERE city_name LIKE 'New%';

-- LIMIT 혼용 시 상위 n개만 삭제 가능
DELETE FROM city_popul
WHERE city_name LIKE 'New%'
LIMIT 5;