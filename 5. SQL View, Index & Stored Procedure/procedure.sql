-- Tạo procedure

delimiter //
create procedure findAllCustomer()
begin
	select * from customers where customerNumber  = 175;
end //
delimiter ;

-- Gọi procedure

call findAllCustomer();

-- Xoá procedure

drop procedure if exists `findAllCustomer`;

-- Hiển thị các procedure đang có
show procedure status;


-- Ví dụ
DELIMITER //
 
DROP PROCEDURE IF EXISTS GetAllProducts;
 
CREATE PROCEDURE GetAllProducts()
BEGIN
   SELECT *  FROM products;
END//
 
DELIMITER ;

call GetAllProducts();