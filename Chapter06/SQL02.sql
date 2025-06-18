USE market_db;

-- Index의 구조: Cluster
CREATE TABLE cluster (
	mem_id CHAR(8),
  mem_name VARCHAR(10)
);

INSERT INTO cluster
VALUE
	('TWC', '트와이스'),
  ('BLK', '블랙핑크'),
  ('WMN', '여자친구'),
  ('OMY', '오마이걸'),
  ('GRL', '소녀시대'),
  ('ITZ', '잇지'),
  ('RED', '레드벨벳'),
  ('APN', '에이핑크'),
  ('SPC', '우주소녀'),
  ('MMU', '마마무');
  
SELECT * FROM cluster; -- 현재는 입력순 정렬

ALTER TABLE cluster
	ADD CONSTRAINT
		PRIMARY KEY (mem_id); -- 기본 키 지정 (클러스터 인덱스 부여)
    
SELECT * FROM cluster; -- 클러스터 인덱스로 자동 정렬

-- Secondary Index
CREATE TABLE second (
	mem_id CHAR(8),
  mem_name VARCHAR(10)
);

INSERT INTO second
VALUE
	('TWC', '트와이스'),
  ('BLK', '블랙핑크'),
  ('WMN', '여자친구'),
  ('OMY', '오마이걸'),
  ('GRL', '소녀시대'),
  ('ITZ', '잇지'),
  ('RED', '레드벨벳'),
  ('APN', '에이핑크'),
  ('SPC', '우주소녀'),
  ('MMU', '마마무');
  
ALTER TABLE second
	ADD CONSTRAINT
		UNIQUE (mem_id); -- 고유 키 지정 (보조 인덱스 부여)
    
SELECT * FROM second; -- 자동 정렬되지 않음 (데이터 페이지를 건드리지 않고 별도의 공간에 인덱스를 생성)