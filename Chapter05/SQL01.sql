DROP DATABASE IF EXISTS naver_db;
CREATE DATABASE naver_db;
USE naver_db;

DROP TABLE IF EXISTS member;
CREATE TABLE member (
	mem_id CHAR(8) NOT NULL,
  mem_name VARCHAR(10) NOT NULL,
  mem_number TINYINT NOT NULL,
  addr CHAR(2) NOT NULL,
  phone1 CHAR(3),
  phone2 CHAR(8),
  height TINYINT UNSIGNED,
  debut_date DATE,
  
  PRIMARY KEY (mem_id)
);

DROP TABLE IF EXISTS buy;
CREATE TABLE buy (
	num INT AUTO_INCREMENT NOT NULL,
  mem_id CHAR(8) NOT NULL,
  prod_name CHAR(6) NOT NULL,
  group_name CHAR(4),
  price INT UNSIGNED NOT NULL,
  amount SMALLINT UNSIGNED NOT NULL,
  
  PRIMARY KEY (num),
  FOREIGN KEY (mem_id) REFERENCES member(mem_id)
);

INSERT INTO member
VALUE
	('TWC', '트와이스', 9, '서울', '02', '11111111', 167, '2015-10-19'),
  ('BLK', '블랙핑크', 4, '경남', '055', '22222222', 163, '2016-08-08'),
  ('WMN', '여자친구', 6, '경기', '031', '33333333', 166, '2015-01-15');
  
INSERT INTO buy
VALUE
	(NULL, 'BLK', '지갑', NULL, 30, 2),
  (NULL, 'BLK', '맥북프로', '디지털', 1000, 1),
  (NULL, 'APN', '아이폰', '디지털', 200, 1);

