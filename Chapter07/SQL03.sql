USE market_db;

-- Trigger
CREATE TABLE IF NOT EXISTS trigger_table (
	id INT,
  txt VARCHAR(10)
);

INSERT INTO trigger_table
VALUE
	(1, '레드벨벳'),
  (2, '잇지'),
  (3, '블랙핑크');
  
-- Trigger 생성 후 부착
DROP TRIGGER IF EXISTS myTrigger;

DELIMITER ::
CREATE TRIGGER myTrigger AFTER DELETE
	ON trigger_table FOR EACH ROW
BEGIN
	SET @msg = '가수 그룹이 삭제됨';
END ::
DELIMITER ;

SET @msg = '';

INSERT INTO trigger_table
VALUE (4, '마마무');

SELECT @msg;

SET SQL_SAFE_UPDATES = 0;

UPDATE trigger_table
SET txt = '블핑'
WHERE id = 3;

SELECT @msg;

DELETE FROM trigger_table -- DELETE에 트리거 부착된 상태
WHERE id = 4;

SELECT @msg; -- 트리거 실행됨!


-- 트리거 실습 (백업)
USE market_db;
CREATE TABLE singer
	(SELECT mem_id, mem_name, mem_number, addr FROM member);
  
CREATE TABLE backup_singer (
	mem_id CHAR(8) NOT NULL,
  mem_name VARCHAR(10) NOT NULL,
  mem_number INT NOT NULL,
  addr CHAR(2) NOT NULL,
  mod_type CHAR(2),
  mod_date DATE,
  mod_user VARCHAR(30)
);

-- UPDATE 시 작동하는 트리거
DROP TRIGGER IF EXISTS singer_updateTrg;

DELIMITER ::
CREATE TRIGGER singer_updateTrg AFTER UPDATE
	ON singer FOR EACH ROW
BEGIN
	INSERT INTO backup_singer
  VALUE (OLD.mem_id, OLD.mem_name, OLD.mem_number, OLD.addr, '수정', CURDATE(), CURRENT_USER()); -- OLD <- 대상 테이블이 수정되기 전의 데이터가 잠깐 저장되는 임시 테이블
END ::
DELIMITER ;

-- DELETE 시 작동하는 트리거
DROP TRIGGER IF EXISTS singer_deleteTrg;

DELIMITER ::
CREATE TRIGGER singer_deleteTrg AFTER DELETE
	ON singer FOR EACH ROW
BEGIN
	INSERT INTO backup_singer
  VALUE (OLD.mem_id, OLD.mem_name, OLD.mem_number, OLD.addr, '삭제', CURDATE(), CURRENT_USER());
END ::
DELIMITER ;

UPDATE singer
SET addr = '영국'
WHERE mem_id = 'BLK';

DELETE FROM singer
WHERE mem_number >= 7;

SELECT * FROM backup_singer;

-- TRUNCATE로 삭제하는 경우
TRUNCATE TABLE singer;

SELECT * FROM backup_singer; -- DELETE로 삭제한 것이 아니기 때문에 트리거가 작동하지 않음