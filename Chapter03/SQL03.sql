USE market_db;
CREATE TABLE hongong1 (
	toy_id INT,
  toy_name CHAR(4),
  age INT
);

-- 열 생략
INSERT INTO hongong1
VALUE (1, '우디', 25); -- 반드시 테이블의 속성과 맞춰야 함

-- 특성 속성의 값이 없으면 속성을 명시해야 함
INSERT INTO hongong1 (toy_id, toy_name)
VALUE (2, '버즈'); -- 생략한 속성에는 Null이 들어감

-- 속성의 순서를 바꿔서 입력
INSERT INTO hongong1 (toy_name, age, toy_id)
VALUE ('제시', 20, 3); -- 입력값도 맞춰주면 된다

-- AUTO_INCREMENT
CREATE TABLE hongong2 (
	toy_id INT AUTO_INCREMENT, -- 1부터 자동으로 들어감
  toy_name CHAR(4),
  age INT,
  PRIMARY KEY (toy_id) -- AUTO_INCREMENT된 속성은 반드시 PRIMARY KEY로 지정해야 함
);

INSERT INTO hongong2
VALUE
	(NULL, '보핍', 25), -- AUTO_INCREMENT된 속성은 NULL로 입력 (1부터 자동으로 들어감)
  (NULL, '슬링키', 22),
  (NULL, '렉스', 21);
  
SELECT * FROM hongong2;

SELECT LAST_INSERT_ID();

ALTER TABLE hongong2 AUTO_INCREMENT = 100; -- 순번을 100부터 넣고 싶다면...

INSERT INTO hongong2
VALUE (NULL, '재남', 35);

SELECT * FROM hongong2;

-- AUTO_INCREMENT 심화
CREATE TABLE hongong3 (
	toy_id INT AUTO_INCREMENT,
  toy_name CHAR(4),
  age INT,
  PRIMARY KEY (toy_id)
);

ALTER TABLE hongong3 AUTO_INCREMENT = 1000;
SET @@auto_increment_increment = 3; -- 순번의 증감을 1에서 3으로 변경

INSERT INTO hongong3
VALUE
	(NULL, '유니', 20),
	(NULL, '히나', 23),
	(NULL, '부키', 25);
  
SELECT * FROM hongong3;

-- 다른 테이블 데이터를 가져와서 입력
SELECT COUNT(*) FROM world.city;

-- 테이블 구조 확인
DESC world.city;

SELECT * FROM world.city
LIMIT 5;

CREATE TABLE city_popul (
	city_name CHAR(35),
  population INT
);

INSERT INTO city_popul
SELECT Name, Population FROM world.city;

SELECT * FROM city_popul
LIMIT 10;