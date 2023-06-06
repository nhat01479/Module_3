-- procedure với tham số IN

delimiter //
create procedure getCusById (IN cusNum int(11))
begin
select * from customers where customerNumber = cusNum;
end //
delimiter ;

-- Gọi store procedure
call getCusById(175);

-- procedure với tham số OUT

delimiter //
drop procedure if exists `GetCustomersCountByCity`;
create procedure GetCustomersCountByCity(IN in_city varchar(50), OUT total int)
begin
select count(customerNumber)
into total
from customers
where country = in_city;
-- set total = (select count(customerNumber)
-- from customers
-- where city = in_city);
end//
delimiter ;

call GetCustomersCountByCity('USA', @total);

select @total;

