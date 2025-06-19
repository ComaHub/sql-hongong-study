-- Stored Function 권한 설정
SET GLOBAL log_bin_trust_function_creators = 1;

USE market_db;

-- Stored Function 생성
DROP FUNCTION IF EXISTS sumFunc;

DELIMITER ::
CREATE FUNCTION sumFunc(number1 INT, number2 INT)
	RETURNS INT
BEGIN
	RETURN number1 + number2;
END ::
DELIMITER ;

-- Function 호출
SELECT sumFunc(100, 200) AS "합계";

-- 실습
DROP FUNCTION IF EXISTS calcYearFunc;

DELIMITER ::
CREATE FUNCTION calcYearFunc(dYear INT)
	RETURNS INT
BEGIN
	DECLARE runYear INT;
  
  SET runYear = YEAR(CURDATE()) - dYear;
  RETURN runYear;
END ::
DELIMITER ;

SELECT calcYearFunc(2010) AS '활동 햇수';

-- 함수 반환값을 변수에 담아 활용하기
SELECT calcYearFunc(2007) INTO @debut2007;
SELECT calcYearFunc(2013) INTO @debut2013;

SELECT @debut2007 - @debut2013 AS "2007과 2013 차이";

-- 생성한 함수를 쿼리에 활용하기
SELECT mem_id "회원 아이디", mem_name "회원 이름", calcYearFunc(YEAR(debut_date)) "활동 햇수" FROM member;

-- 함수 삭제
DROP FUNCTION calcYearFunc;



-- Cursor 활용하기
DROP PROCEDURE IF EXISTS cursor_proc;

DELIMITER ::
CREATE PROCEDURE cursor_proc()
BEGIN
	DECLARE memNumber INT;
  DECLARE counter INT DEFAULT 0;
  DECLARE totalNumber INT DEFAULT 0;
  DECLARE endOfRow BOOLEAN DEFAULT FALSE;
  
  DECLARE memberCursor CURSOR FOR -- mem_number 속성에 커서 지정
		SELECT mem_number FROM member;
    
	DECLARE CONTINUE HANDLER FOR NOT FOUND -- 반복 종료 조건 지정 (더 이상 행이 없다면 다음 코드 실행)
		SET endOfRow = TRUE;
    
	OPEN memberCursor; -- 커서 오픈
  
  cursor_loop:
  LOOP
		FETCH memberCursor INTO memNumber;
    
    IF endOfRow THEN
			LEAVE cursor_loop;
		END IF;
    
    SET counter = counter + 1;
    SET totalNumber = totalNumber + memNumber;
	END LOOP cursor_loop;
  
  SELECT (totalNumber / counter) AS "회원의 평균 인원 수";
  
  CLOSE memberCursor;
END ::
DELIMITER ;

CALL cursor_proc();