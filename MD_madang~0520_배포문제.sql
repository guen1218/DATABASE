select * from flight where dest = '제주';
select * from flight where src = '김포' and dest = '제주';
sElECt DIStINcT b.fid FrOM BookIng b WHERE b.pid = 100 AND b.fdate > tO_DaTe('2025-01-01', 'YYyY-mM-Dd');
select distinct p.pname from passenger p where EXISTS (select * from booking b where b.pid = p.pid);
select distinct a.aname from agency a where a.acity = (select p.pcity from passenger p where p.pid = 100);
select * from flight where fdate between to_date ('2025-01-01', 'yyyy-mm-dd') and to_date('2025-01-30', 'yyyy-mm-dd') and time >= '16:00';
select a.aname from agency a where not exists (select * from booking b where b.aid = a.aid and b.pid = 100);
select distinct p.* from passenger p join booking b on p.pid = b.pid join agency a on b.aid = a.aid where a.aname = '마당여행사' and p.pgender = '남';


-- 단순질의
select pid, pname, pcity from passenger;
select pname, pcity from passenger where pgender = '남';
select fid, fdate, dest from flight where src = '김포';
select pid, count(pid) as "예약 건수" from booking group by pid;
select aid, aname, acity from agency;
select count(dest) as "항공편 수" from flight where dest = '제주' group by dest;
select pid, aid, fid from booking where fdate >= '2025-01-01';
select aid from booking order by aid desc;
select fid, src, dest from flight where fdate = (select max(fdate) from flight);
select pname from passenger where pcity in ('서울시 강남구', '서울시 강동구');


-- 조인질의
select p.pname as "승객 이름", b.fid from passenger p join booking b on p.pid = b.pid;
select a.aname as "여행사 이름", count(a.aname) as "예약 건수" from agency a join booking b on a.aid = b.aid group by a.aname;
select p.pname, f.src as "출발지", f.dest as "목적지" from booking b join passenger p on p.pid = b.pid join flight f on f.fid = b.fid;
select p.pname, 