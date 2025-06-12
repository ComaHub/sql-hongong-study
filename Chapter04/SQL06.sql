DROP PROCEDURE IF EXISTS ifProc1;

-- STORED PROCEDURE
DELIMITER ::
CREATE PROCEDURE ifProc1()
BEGIN
	IF 100 = 100 THEN
		SELECT '100은 100과 같습니다';
	END IF;
END ::

DELIMITER ;
CALL ifProc1();


-- IF-ELSE
DROP PROCEDURE IF EXISTS ifProc2;

DELIMITER ::
CREATE PROCEDURE ifProc2()
BEGIN
	DECLARE myNum INT; -- 예약어를 사용한 변수 선언
  SET myNum = 200; -- 변수에 값 대입
  IF myNum = 100 THEN
		SELECT '100입니다.';
	ELSE
		SELECT '100이 아닙니다.';
	END IF;
END ::

DELIMITER ;
CALL ifProc2();


-- IF문 활용
DROP PROCEDURE IF EXISTS ifProc3;

DELIMITER ::
CREATE PROCEDURE ifProc3()
BEGIN
	DECLARE debutDate DATE;
  DECLARE curDate DATE;
  DECLARE days INT;
  
  SELECT debut_date INTO debutDate FROM market_db.member
  WHERE mem_id = 'APN';
  
  SET curDate = CURRENT_DATE(); -- 현재 날짜를 DATE형으로 반환
  SET days = DATEDIFF(curDate, debutDate); -- 두 날짜의 차이를 정수로 반환 (일수)
  
  IF (days / 365) >= 5 THEN
		SELECT CONCAT('데뷔한 지 ', days, '일이나 지났습니다. 축하합니다!');
	ELSE
		SELECT '데뷔한 지 ' + days + '일밖에 안 됐네요.';
	END IF;
END ::

DELIMITER ;
CALL ifProc3();


-- CASE
DROP PROCEDURE IF EXISTS caseProc;

DELIMITER ::
CREATE PROCEDURE caseProc()
BEGIN
	DECLARE point INT;
  DECLARE credit CHAR(1);
  SET point = 88;
  
  CASE
		WHEN point >= 90 THEN
			SET credit = 'A';
		WHEN point >= 80 THEN
			SET credit = 'B';
		WHEN point >= 70 THEN
			SET credit = 'C';
		WHEN point >= 60 THEN
			SET credit = 'D';
		ELSE
			SET credit = 'F';
	END CASE;
  
  SELECT CONCAT("취득 점수 ==> ", point), CONCAT("학점 ==> ", credit);
END ::

DELIMITER ;
CALL caseProc();


-- CASE 활용
SELECT mem_id, SUM(price * amount) AS "총 구매액" FROM buy
GROUP BY mem_id;

SELECT mem_id, SUM(price * amount) AS "총 구매액" FROM buy
GROUP BY mem_id
ORDER BY SUM(price * amount) DESC;

SELECT B.mem_id, M.mem_name, SUM(B.price * B.amount) AS "총 구매액" FROM buy AS B
INNER JOIN member AS M ON B.mem_id = M.mem_id
GROUP BY B.mem_id
ORDER BY SUM(B.price * B.amount) DESC;

SELECT M.mem_id, M.mem_name, SUM(B.price * B.amount) AS "총 구매액" FROM buy AS B
RIGHT OUTER JOIN member AS M ON B.mem_id = M.mem_id
GROUP BY M.mem_id
ORDER BY SUM(B.price * B.amount) DESC;

SELECT
	M.mem_id,
	M.mem_name, 
  SUM(B.price * B.amount) AS "총 구매액",
  CASE
		WHEN (SUM(B.price * B.amount) >= 1500) THEN '최우수고객'
    WHEN (SUM(B.price * B.amount) >= 1000) THEN '우수고객'
    WHEN (SUM(B.price * B.amount) >= 1) THEN '일반고객'
    ELSE '유령고객'
	END AS "회원등급"
FROM buy AS B
	RIGHT OUTER JOIN member AS M 
  ON B.mem_id = M.mem_id
GROUP BY M.mem_id
ORDER BY SUM(B.price * B.amount) DESC;