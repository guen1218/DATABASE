set serveroutput on;

-- 1번
create or replace procedure getbook(p_bookid in book.bookid%type) is
p_bookname book.bookname%type;
p_pub book.publisher%type; 
p_price book.price%type;

begin 
select bookname, publisher, price into p_bookname, p_pub, p_price
from book
where book.bookid = p_bookid;
dbms_output.put_line ('도서명: ' || p_bookname);
dbms_output.put_line ('출판사: ' || p_pub);
dbms_output.put_line ('가격: ' || p_price);

exception
when no_data_found then dbms_output.put_line('해당 도서 번호('|| p_bookid ||')가 존재하지 않습니다.');
end;
/


exec getbook(1);


-- 2번
create or replace procedure customer_input(
p_custid in customer.custid%type,
p_name in customer.name%type,
p_address in customer.address%type,
p_phone in customer.phone%type
) is

begin
insert into customer(custid, name, address, phone) values (p_custid, p_name, p_address, p_phone); commit;
end;
/


exec customer_input(15, '앙야르렁띠', '야르렁', 1000);
select * from customer;


-- 3번
create or replace procedure update_price(p_bookid in book.bookid%type, p_price in book.price%type) is
begin
update book set book.price = p_price where book.bookid = p_bookid;
commit;

end;
/

exec update_price(1, 3000);
select * from book;


-- 4번
create or replace procedure delete_cust(p_custid in customer.custid%type)is

begin
delete from orders where custid = p_custid;
delete from customer where custid = p_custid;
commit;

end;
/

exec delete_cust(15);
select * from customer;


-- 5번 

create or replace procedure output_cust(p_orderid in orders.orderid%type)is
p_name customer.name%type;
p_bookname book.bookname%type;
p_saleprice orders.saleprice%type;
p_orderdate orders.orderdate%type;

begin
select c.name , b.bookname , o.saleprice , o.orderdate into p_name, p_bookname, p_saleprice, p_orderdate
from orders o
join customer c on c.custid = o.custid
join book b on b.bookid = o.bookid
where o.orderid = p_orderid;

dbms_output.put_line('고객 이름 : ' || p_name);
dbms_output.put_line('도서명 : ' || p_bookname);
dbms_output.put_line('주문금액' || p_saleprice);
dbms_output.put_line('주문날짜' || p_orderdate);
end;
/


exec output_cust(1);


--6번 

create or replace procedure output_publisher(
p_publisher in book.publisher%type
)is
cursor book_cursor is 
select bookid, bookname, price from book where publisher = p_publisher;

p_bookid book.bookid%type;
p_bookname book.bookname%type;
p_price book.price%type;

begin
open book_cursor;
LOOP
fetch book_cursor into p_bookid, p_bookname, p_price;
exit when book_cursor%notfound;
dbms_output.put_line(p_bookid || p_bookname || p_price);
end loop;
close book_cursor;

end;
/

exec output_publisher('대한미디어');


-- 7번
create or replace procedure output_custs(p_custid in customer.custid%type)is
cursor cooutput is
select b.bookname, o.saleprice, o.orderdate from orders o join book b on b.bookid = o.bookid where o.custid = p_custid;
p_bookname book.bookname%type;
p_saleprice orders.saleprice%type;
p_orderdate orders.orderdate%type;
begin
open cooutput;
loop
fetch cooutput into p_bookname, p_saleprice, p_orderdate;
exit when cooutput%notfound;
dbms_output.put_line(p_bookname || p_saleprice || p_orderdate);
end loop;
close cooutput;
end;
/

exec output_custs(1);


-- 8번
create or replace procedure incust(first_date in orders.orderdate%type, final_date in orders.orderdate%type) is
cursor datesss is 
select c.name, b.bookname, o.saleprice, o.orderdate from orders o 
join book b on b.bookid = o.bookid
join customer c on c.custid = o.custid
where o.orderdate between first_date and final_date;

p_name customer.name%type; 
p_bookname book.bookname%type;
p_saleprice orders.saleprice%type; 
p_orderdate orders.orderdate%type;

begin
open datesss;
loop
fetch datesss into p_name, p_bookname, p_saleprice, p_orderdate;
exit when datesss%notfound;
dbms_output.put_line(p_name || p_bookname || p_saleprice || p_orderdate);
end loop;
close datesss;

end;
/

exec incust('2025-07-01', '2025-07-05');


-- 9번
create or replace procedure bought_cust(p_bookname in book.bookname%type)is
cursor bought is
select c.name, o.saleprice from orders o
join customer c on c.custid = o.custid
join book b on b.bookid = o.bookid
where b.bookname = p_bookname;

p_custname customer.name%type;
p_saleprice orders.saleprice%type;

begin
open bought;
loop
fetch bought into p_custname, p_saleprice;
exit when bought%notfound;
dbms_output.put_line(p_custname || p_saleprice);
end loop;
close bought;

end;
/

exec bought_cust('야구를 부탁해');

-- 10번
create or replace procedure price_up_order(p_price in orders.saleprice%type)is
cursor ups is
select o.custid, c.name, count(*) from orders o
join customer c on c.custid = o.custid
where o.saleprice >= p_price
group by o.custid, c.name;

p_custid customer.custid%type;
p_name customer.name%type;
p_count number;

begin
open ups;
loop
fetch ups into p_custid, p_name, p_count;
exit when ups%notfound;
dbms_output.put_line(p_custid || p_name || p_count);
end loop;
close ups;
end;
/

exec price_up_order(10000);

--create index ix_book on book (bookname);
--create index ix_book2 on book (publisher, price);
--create or replace procedure cancel_order (p_order_id in orders.order_id%type) is v_status orders.status%type; begin select status into v_status from orders where order_id = p_order_id; if v_status = 'CANCELLED' then DBMS_output.put_line('이미 취소된 주문입니다.'); return; end if; dbms_output.put_line('주문 ' || p_order_id || '취소 완료 및 재고 복구됨'); if v_status = 'DELIVERED' then dbms_output.put_line('배송 완료된 주문은 취소할 수 없습니다.'); return; end if; update orders set status = 'CANDELLED', cancel_date = SYSDAtE where order_id = p_order_id; update inventory i set i.stock = i.stock + (select od.quantity from order_detail od where od.order_id = p_order_id and od.product_id = i.product_id) where i.product_id in (select product_id from order_detail where order_id = p_order_id); commit; dbms_output.put_line('주문 ' || p_order_id || ' 취소 완료 및 재고 복구됨'); exception when no_data_found then dbms_output.put_line('오류 발생: ' || sqlerrm); end cancel_order;