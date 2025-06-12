-- 명시적 형변환
SELECT CAST(AVG(price) AS SIGNED) AS "평균 가격" FROM buy;

SELECT CAST('2022$12$12' AS DATE);
SELECT CAST('2022/12/12' AS DATE);
SELECT CAST('2022%12%12' AS DATE);
SELECT CAST('2022@12@12' AS DATE);

SELECT 
	num,
  CONCAT(CAST(price AS CHAR), ' X ', CAST(amount AS CHAR), ' = ') AS "가격 X 수량",
  (price * amount) AS "구매액"
FROM buy;

-- 암시적 형변환
SELECT '100' + '200'; -- 문자열 결합이 아니라 정수로 변환해 덧셈을 수행

-- 문자열 결합을 하려면 CONCAT 사용
SELECT CONCAT('100', '200');

-- CONCAT에서는 숫자가 문자로 변환
SELECT CONCAT(100, '200');

-- 덧셈에서는 문자가 숫자로 변환
SELECT 100 + '200';