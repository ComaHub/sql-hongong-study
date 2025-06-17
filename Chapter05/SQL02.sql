USE naver_db;
DROP TABLE IF EXISTS buy, member;

-- Primary Key
CREATE TABLE member (
	mem_id CHAR(8) NOT NULL,
  mem_name VARCHAR(10) NOT NULL,
  height TINYINT UNSIGNED,
  
  PRIMARY KEY (mem_id)
);

DESC member;

-- ALTER 사용
CREATE TABLE member (
	mem_id CHAR(8) NOT NULL,
  mem_name VARCHAR(10) NOT NULL,
  height TINYINT UNSIGNED
);

ALTER TABLE member -- 변경 대상: member 테이블
	ADD CONSTRAINT -- 제약조건 추가
		PRIMARY KEY (mem_id); -- mem_id를 기본 키로 설정
    
-- Foreign Key
CREATE TABLE member (
	mem_id CHAR(8) NOT NULL,
  mem_name VARCHAR(10) NOT NULL,
  height TINYINT UNSIGNED,
  
  PRIMARY KEY (mem_id)
);

CREATE TABLE buy (
	num INT AUTO_INCREMENT NOT NULL,
  mem_id CHAR(8) NOT NULL,
  prod_name CHAR(6) NOT NULL,
  
  PRIMARY KEY (num),
  FOREIGN KEY (mem_id) REFERENCES member(mem_id)
);

-- ALTER 사용
CREATE TABLE buy (
	num INT AUTO_INCREMENT NOT NULL,
  mem_id CHAR(8) NOT NULL,
  prod_name CHAR(6) NOT NULL,
  
  PRIMARY KEY (num)
);

ALTER TABLE buy
	ADD CONSTRAINT
		FOREIGN KEY (mem_id) REFERENCES member(mem_id);
    
INSERT INTO member
VALUE	('BLK', '블랙핑크', 163);

INSERT INTO buy
VALUE
	(NULL, 'BLK', '지갑'),
  (NULL, 'BLK', '맥북');
  
SELECT M.mem_id, M.mem_name, B.prod_name FROM buy B
INNER JOIN member M ON B.mem_id = M.mem_id;

-- UPDATE & DELETE 시도
UPDATE member
SET mem_id = 'PINK'
WHERE mem_id = 'BLK'; -- 오류 발생!

DELETE FROM member
WHERE mem_id = 'BLK'; -- 오류 발생!

-- 데이터 변경 시 참조 테이블도 자동 변경: CASCADE
ALTER TABLE buy
	ADD CONSTRAINT
		FOREIGN KEY (mem_id) REFERENCES member(mem_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE;
    
UPDATE member
SET mem_id = 'PINK'
WHERE mem_id = 'BLK'; -- CASCADE 설정: 참조 테이블의 id도 모두 변경됨

SELECT M.mem_id, M.mem_name, B.prod_name FROM buy B
INNER JOIN member M ON B.mem_id = M.mem_id;

DELETE FROM member
WHERE mem_id = 'PINK'; -- CASCADE 설정: 조건에 맞는 참조 테이블의 레코드도 모두 삭제됨

SELECT * FROM buy; -- 모두 삭제된 것을 확인

-- Unique Key
CREATE TABLE member (
	mem_id CHAR(8) NOT NULL,
  mem_name VARCHAR(10) NOT NULL,
  height TINYINT UNSIGNED,
  email CHAR(30) UNIQUE,
  
  PRIMARY KEY (mem_id)
);

INSERT INTO member
VALUE
	('BLK', '블랙핑크', 163, 'pink@gmail.com'),
  ('TWC', '트와이스', 167, NULL),
  ('APN', '에이핑크', 164, 'pink@gmail.com'); -- email 중복 오류!
  
  
-- Check
CREATE TABLE member (
	mem_id CHAR(8) NOT NULL,
  mem_name VARCHAR(10) NOT NULL,
  height TINYINT UNSIGNED CHECK (height >= 100),
  phone1 CHAR(3),
  
  PRIMARY KEY (mem_id)
);

INSERT INTO member
VALUE
	('BLK', '블랙핑크', 163, NULL),
  ('TWC', '트와이스', 99, NULL); -- <= height이 100보다 작아 CHECK에 위배
  
-- ALTER로 Check 조건 추가
ALTER TABLE member
	ADD CONSTRAINT
		CHECK (phone1 IN ('02', '031', '032', '054', '055', '061'));
    
INSERT INTO member
VALUE
	('TWC', '트와이스', 167, '02'),
  ('OMY', '오마이걸', 167, '010'); -- <= phone1의 값이 IN에 포함되지 않아 CHECK에 위배
  
-- Default
CREATE TABLE member (
	mem_id CHAR(8) NOT NULL,
  mem_name VARCHAR(10) NOT NULL,
  height TINYINT UNSIGNED DEFAULT 160, -- 미입력시 기본값인 160으로 넣어줌
  phone1 CHAR(3),
  
  PRIMARY KEY (mem_id)
);

-- ALTER를 사용해 기본값 지정
ALTER TABLE member -- 변경 대상: member 테이블
	ALTER COLUMN phone1 -- 변경 대상: phone1 컬럼
		SET DEFAULT '02'; -- 기본값을 '02'로 지정
    
-- default 명시
INSERT INTO member
VALUE
	('RED', '레드벨벳', 161, '054'),
  ('SPC', '우주소녀', default, default); -- 기본값을 넣고 싶을 때 명시
  
SELECT * FROM member;