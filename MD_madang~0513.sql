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
SELECT 이름, 주소 FROM 고객 WHERE 이름 LIKE '김%';

-- 조인질의
select 극장.극장이름, 상영관.영화제목 from 극장 join 상영관 on 극장.극장번호 = 상영관.극장번호;
select 극장.극장이름, 상영관.영화제목, 예약.날짜 as "예약 날짜" from 상영관 join 극장 on 극장.극장번호 = 상영관.극장번호 join 예약 on 예약.상영관번호 = 상영관.상영관번호 and 예약.극장번호 = 상영관.극장번호;
select g.이름 as "고객 이름", y.날짜 as "예약 날짜" from 예약 y join 고객 g on g.고객번호 = y.고객번호;
select g.극장이름, s.영화제목, k.이름, 좌석번호 from 예약 y join 극장 g on g.극장번호 = y.극장번호 join 상영관 s on s.극장번호 = y.극장번호 and s.상영관번호 = y.상영관번호 join 고객 k on k.고객번호 = y.고객번호;
select 상영관.영화제목, count(*) as "총 예약 수" from 상영관 join 예약 on 상영관.극장번호 = 예약.극장번호 and 상영관.상영관번호 = 예약.상영관번호 group by 영화제목;
select s.영화제목, s.가격 from 상영관 s join 극장 g on g.극장번호 = s.극장번호 where g.위치 = '서울';
select 고객.이름 from 고객 left join 예약 on 고객.고객번호 = 예약.고객번호 where 예약.고객번호 is NULL;

-- 부속질의


-- 상관부속질의

