USE market_db;
SELECT * FROM member;

-- 테이블의 인덱스 확인
SHOW INDEX FROM member;

-- 인덱스 크기 확인
SHOW TABLE STATUS LIKE 'member'; -- LIKE: 'member'라는 글자가 들어간 테이블 정보 확인하기

-- 단순 보조 인덱스 생성
CREATE INDEX idx_member_addr ON member (addr); -- member의 addr 속성에 idx_member_addr 인덱스 생성

SHOW INDEX FROM member;
SHOW TABLE STATUS LIKE 'member'; -- 보조 인덱스의 크기가 0?

-- 테이블을 분석/처리 해주어야 보조 인덱스가 적용됨
ANALYZE TABLE member;
SHOW TABLE STATUS LIKE 'member'; -- 적용된 것을 확인할 수 있다

-- 고유 보조 인덱스 생성
CREATE UNIQUE INDEX idx_member_mem_number ON member (mem_number); -- 이미 중복된 값이 있어 생성이 안 됨!

CREATE UNIQUE INDEX idx_member_mem_name ON member (mem_name); -- 중복값이 없어 잘 생성됨
SHOW INDEX FROM member;

INSERT INTO member
VALUE ('MOO', '마마무', 2, '태국', '001', '12341234', 155, '2020.10.10'); -- 고유 보조 인덱스로 인해 더이상 해당 속성에 중복된 값을 넣을 수 없음

-- Index 활용 실습
ANALYZE TABLE member;
SHOW INDEX FROM member;

SELECT * FROM member; -- Index를 사용하지 않음

SELECT mem_id, mem_name, addr FROM member; -- Index를 사용하지 않음

SELECT mem_id, mem_name, addr FROM member
WHERE mem_name = '에이핑크'; -- Single Row (Index를 사용함!) => WHERE 절에 열 이름이 들어 있어야 Index를 사용함

-- 숫자 범위로 조회
CREATE INDEX idx_member_mem_number ON member (mem_number);
ANALYZE TABLE member;

SELECT mem_name, mem_number FROM member
WHERE mem_number >= 7; -- 숫자의 범위로 조회하는 것도 인덱스를 사용

SELECT mem_name, mem_number FROM member
WHERE mem_number * 2 >= 14; -- 동일한 조건이지만 연산이 가해지면 인덱스를 사용하지 않음

SELECT mem_name, mem_number FROM member
WHERE mem_number >= 14 / 2; -- 이렇게 하면 또 인덱스를 씀 (???) 열에는 연산을 가하지 않았기 때문
-- 아무튼 WHERE절에 나온 열에는 연산하지 않는 것이 좋다

-- MySQL의 인덱스 사용 판단
SELECT mem_name, mem_number FROM member
WHERE mem_number >= 1; -- 인덱스가 있고 WHERE절에 해당 열을 썼지만 인덱스를 쓰지 않음 -> MySQL이 자체적으로 안 쓰는게 더 낫겠다 판단

-- Index 제거 실습
SHOW INDEX FROM member;

-- 제거는 보조부터 (클러스터부터 제거하면 데이터를 재구성해서 시간이 오래걸림)
DROP INDEX idx_member_mem_name ON member;
DROP INDEX idx_member_addr ON member;
DROP INDEX idx_member_mem_number ON member;

ALTER TABLE member
	DROP PRIMARY KEY;