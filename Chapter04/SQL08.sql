USE market_db;

-- 동적 SQL
PREPARE myQuery FROM '
	SELECT * FROM member
  WHERE mem_id = "BLK"
';

EXECUTE myQuery;
DEALLOCATE PREPARE myQuery;

-- 예제
DROP TABLE IF EXISTS gate_table;

CREATE TABLE gate_table (
	id INT AUTO_INCREMENT,
  entry_time DATETIME,
  PRIMARY KEY (id)
);

SET @curDate = CURRENT_TIMESTAMP();

PREPARE gateQuery FROM '
	INSERT INTO gate_table
  VALUE (NULL, ?)
';

EXECUTE gateQuery USING @curDate;

DEALLOCATE PREPARE gateQuery;

SELECT * FROM gate_table;