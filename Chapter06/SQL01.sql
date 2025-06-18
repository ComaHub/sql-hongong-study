USE market_db;

-- Index
CREATE TABLE table1 (
	col1 INT,
  col2 INT,
  col3 INT,
  
  PRIMARY KEY (col1) -- Primary Key로 지정하면 Cluster형 Index로 지정됨
);

-- Index 확인하기
SHOW INDEX FROM table1;

-- 보조 Index
CREATE TABLE table2 (
	col1 INT,
  col2 INT UNIQUE,
  col3 INT UNIQUE,
  
  PRIMARY KEY (col1)
);

SHOW INDEX FROM table2;

-- Cluster형 Index
DROP TABLE IF EXISTS buy, member;

CREATE TABLE member (
	mem_id CHAR(8),
  mem_name VARCHAR(10),
  mem_number INT,
  addr CHAR(2)
);

INSERT INTO member
VALUE
	('TWC', '트와이스', 9, '서울'),
  ('BLK', '블랙핑크', 4, '경남'),
  ('WMN', '여자친구', 6, '경기'),
  ('OMY', '오마이걸', 7, '서울');
  
SELECT * FROM member;

ALTER TABLE member
	ADD CONSTRAINT
		PRIMARY KEY (mem_id); -- mem_id를 기본 키로 지정 => mem_id에 Cluster Index가 생성 => 자동 정렬 (like 영어사전)
    
ALTER TABLE member
	DROP PRIMARY KEY; -- 기본 키 제거
  
ALTER TABLE member
	ADD CONSTRAINT
		PRIMARY KEY (mem_name); -- mem_name에 Cluster Index 생성 => 정렬
    
INSERT INTO member
VALUE ('GRL', '소녀시대', 8, '서울'); -- 입력하면 자동정렬

-- 보조 Index
DROP TABLE IF EXISTS buy, member;

CREATE TABLE member (
	mem_id CHAR(8),
  mem_name VARCHAR(10),
  mem_number INT,
  addr CHAR(2)
);

INSERT INTO member
VALUE
	('TWC', '트와이스', 9, '서울'),
  ('BLK', '블랙핑크', 4, '경남'),
  ('WMN', '여자친구', 6, '경기'),
  ('OMY', '오마이걸', 7, '서울');
  
SELECT * FROM member;

-- 보조 Index 생성 (고유 키 지정)
ALTER TABLE member
	ADD CONSTRAINT
		UNIQUE (mem_id);
    
SELECT * FROM member; -- 자동 정렬은 안 됨

-- 보조 Index 추가 지정
ALTER TABLE member
	ADD CONSTRAINT
		UNIQUE (mem_name);
    
SELECT * FROM member;

INSERT INTO member
VALUE ('GRL', '소녀시대', 8, '서울'); -- 자동 정렬되지 않아 제일 밑에 추가됨