-- 단순질의
SELECT 극장이름, 위치 FROM 극장;
SELECT 극장이름 FROM 극장 WHERE 위치 = '서울';
SELECT 극장번호, 상영관번호, 영화제목 FROM 상영관 WHERE 가격 >= 10000;
SELECT 영화제목, COUNT(*) AS 상영관수 FROM 상영관 GROUP BY 영화제목;
SELECT * FROM 예약 WHERE 날짜 = '2024-01-01';
SELECT 주소, COUNT(*) AS "고객 수" FROM 고객 GROUP BY 주소;
SELECT 극장번호, 상영관번호 FROM 상영관 WHERE 좌석수 = (SELECT MAX(좌석수) FROM 상영관);
SELECT COUNT(*) AS "예약 횟수" FROM 예약 GROUP BY 고객번호;
SELECT ROUND(AVG(가격),2) AS "평균 가격" FROM 상영관 GROUP BY 극장번호;
SELECT 이름, 주소 FROM 고객 WHERE 이름 LIKE '김%'

-- 조인질의


-- 부속질의


-- 상관부속질의

