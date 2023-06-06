create database bt_view_index_procedure;
use bt_view_index_procedure;
create table products(
id int,
productCode int,
productName varchar(255),
productPrice int,
productAmount int,
productDescription varchar(255),
productStatus bit
);

insert into products values (1, 1, 'Trà xanh', 20, 100, 'Nước', 1);
insert into products values (2, 2, 'Bia', 30, 700, 'Nước', 1);
insert into products values (3, 3, 'Bánh', 40, 500, 'Đồ ăn', 0);

alter table products
add primary key (id);

alter table products
change column id id int auto_increment;

alter table products
modify column productCode int unique;
alter table products
modify column productName varchar(255) unique;


select id, productName, productDescription
from products
where productName = 'Bia';


alter table products
add unique index idx_productCode(productCode);

alter table products
add index idx_name_price(productName, productPrice);

explain select id, productName, productDescription
from products
where productName = 'Bia';

create view  products_view as
select productCode, productName
from products;

create or replace view products_view as
select productCode, productName
from products
where productCode > 1;

drop view products_view;

-- Tạo store procedure lấy tất cả thông tin của tất cả các sản phẩm trong bảng product
delimiter //
create procedure getAllProduct()
begin
	select * from products;
end //
delimiter ;

-- Tạo store procedure thêm một sản phẩm mới

delimiter //
drop procedure if exists addProduct;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addProduct`(
	IN new_productCode int,
	IN new_productName varchar(255),
	IN new_productPrice int,
	IN new_productAmount int,
	IN new_productDescription varchar(255),
	IN new_productStatus bit
)
begin
 declare has_error INT DEFAULT 0;
 declare error_message varchar(255) DEFAULT '';
 
--  if (exists (select * from products where id = new_id)) then
-- 	set has_error = 1;
-- 	set error_message = 'ID sản phẩm đã tồn tại';
-- end if;
if (exists (select * from products where productCode = new_productCode)) then
	set has_error = 1;
	set error_message = concat(error_message, 'Mã sản phẩm đã tồn tại');
end if;
 if (new_productPrice < 0  or new_productAmount < 0) then
	set has_error = 1;
	set error_message = concat(error_message, 'Số lượng hoặc giá không được < 0');
end if;
/* không check được
if ((new_productCode is null) or (new_productName = '')
 or (new_productPrice is null) or (new_productAmount  is null) or (new_productDescription = '') or (new_productStatus  is null)) then
	set has_error = 1;
	set error_message = concat(error_message, 'Dữ liệu không được rỗng');
end if;
*/
if(has_error = 0) then
		insert into  products(productCode, productName, productPrice, productAmount, productDescription, productStatus)
        values (new_productCode, new_productName, new_productPrice, new_productAmount, new_productDescription, new_productStatus);
    end if;
if(has_error = 1) then
    select error_message;
end if;
end //
delimiter ;


-- Xoá sản phẩm

delimiter //
drop procedure if exists removeProduct;
CREATE DEFINER=`root`@`localhost` PROCEDURE `removeProduct`(
	IN remove_id int
)
begin
 declare message varchar(255);
 
 if (exists (select * from products where id = remove_id)) then
	delete from products where id = remove_id;
 else 
	set error_message = 'Id không tồn tại';
	select message;
 end if;
end //
delimiter ;

-- Sửa sản phẩm

delimiter //
drop procedure if exists editProduct;
CREATE DEFINER=`root`@`localhost` PROCEDURE editProduct(
    IN new_id int,
    IN new_productCode int,
    IN new_productName varchar(255),
    IN new_productPrice int,
    IN new_productAmount int,
    IN new_productDescription varchar(255),
    IN new_productStatus bit
)
begin
    declare has_error INT DEFAULT 0;
    declare error_message varchar(255) DEFAULT '';

    if (not exists (select * from products where id = new_id)) then
        set has_error = 1;
        set error_message = concat(error_message, 'ID không tồn tại');
    end if;
    if (exists (select * from products where productCode = new_productCode)) then
        set has_error = 1;
        set error_message = concat(error_message, 'Mã sản phẩm đã tồn tại');
    end if;
    if (new_productPrice < 0 or new_productAmount < 0) then
        set has_error = 1;
        set error_message = concat(error_message, 'Số lượng hoặc giá không được < 0');
    end if;

    if (has_error = 0) then
        UPDATE products
        SET
            productCode = new_productCode,
            productName = new_productName,
            productPrice = new_productPrice,
            productAmount = new_productAmount,
            productDescription = new_productDescription,
            productStatus = new_productStatus
        WHERE id = new_id;
        select * from products;
    end if;
    if (has_error = 1) then
		select error_message;
	end if;
    
end //
delimiter ;

