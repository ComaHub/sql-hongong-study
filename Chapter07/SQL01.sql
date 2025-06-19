USE market_db;

-- Stored Procedure
DROP PROCEDURE IF EXISTS user_proc;

-- proc 생성
DELIMITER ::
CREATE PROCEDURE user_proc()
BEGIN
	SELECT * FROM member;
END ::
DELIMITER ;

-- 저장된 procedure 호출
CALL user_proc();

-- proceduer 삭제
DROP PROCEDURE user_proc;

-- 입력 매개변수 활용 (IN)
DROP PROCEDURE IF EXISTS user_proc1;

DELIMITER ::
CREATE PROCEDURE user_proc1(IN userName VARCHAR(10)) -- 입력받을 매개변수 지정
BEGIN
	SELECT * FROM member
  WHERE mem_name = userName;
END ::
DELIMITER ;

CALL user_proc1('에이핑크'); -- 매개변수에 인자 전달

DROP PROCEDURE IF EXISTS user_proc2;

DELIMITER ::
CREATE PROCEDURE user_proc2(
	IN userNumber INT,
  IN userHeight INT) -- 여러 입력 매개변수 지정
BEGIN
	SELECT * FROM member
  WHERE mem_number > userNumber AND height > userHeight;
END ::
DELIMITER ;

CALL user_proc2(6, 165);

-- 출력 매개변수 활용(OUT)
DROP PROCEDURE IF EXISTS user_proc3;

-- procedure 만드는 시점에서는 해당 테이블이 존재하지 않아도 작동함
DELIMITER ::
CREATE PROCEDURE user_proc3(
	IN txtValue CHAR(10),
  OUT outValue INT) -- 출력 매개변수 지정
BEGIN
	INSERT INTO noTable
  VALUE (NULL, txtValue);
  
  SELECT MAX(id) INTO outValue FROM noTable;
END ::
DELIMITER ;

DESC noTable;

CREATE TABLE IF NOT EXISTS noTable (
	id INT AUTO_INCREMENT,
  txt CHAR(10),
  
  PRIMARY KEY (id)
);

-- 반환값을 받을 변수명을 포함해서 호출
CALL user_proc3 ('테스트1', @myValue);

-- 반환값이 담긴 변수명 호출
SELECT CONCAT('입력된 ID 값 ==> ', @myValue);


-- SQL 프로그래밍 활용: IF문
DROP PROCEDURE IF EXISTS ifelse_proc;

DELIMITER ::
CREATE PROCEDURE ifelse_proc (IN memName VARCHAR(10))
BEGIN
	DECLARE debutYear INT; -- 변수 선언(DECLARE)
	
  SELECT YEAR(debut_date) INTO debutYear FROM member
  WHERE mem_name = memName;
  
  IF (debutYear >= 2015) THEN
		SELECT "신인 가수네요. 파이팅 하세요!" AS "메시지";
	ELSE
		SELECT "고참 가수네요. 그동안 고생하셨습니다!" AS "메시지";
	END IF;
END ::
DELIMITER ;

CALL ifelse_proc ('오마이걸');


-- SQL 프로그래밍 활용: WHILE문
DROP PROCEDURE IF EXISTS while_proc;

DELIMITER ::
CREATE PROCEDURE while_proc()
BEGIN
	DECLARE hap INT;
  DECLARE num INT;
  
  SET hap = 0;
  SET num = 1;
  
  WHILE (num <= 100) DO
		SET hap = hap + num;
    SET num = num + 1;
	END WHILE;
  
  SELECT hap AS "1부터 100까지의 합계";
END ::
DELIMITER ;

CALL while_proc();


-- 동적 SQL 활용
DROP PROCEDURE IF EXISTS dynamic_proc;

DELIMITER ::
CREATE PROCEDURE dynamic_proc (IN tableName VARCHAR(20))
BEGIN
	SET @sqlQuery = CONCAT('SELECT * FROM ', tableName);
  PREPARE myQuery FROM @sqlQuery;
  
  EXECUTE myQuery;
  DEALLOCATE PREPARE myQuery;
END ::
DELIMITER ;

CALL dynamic_proc ('member');