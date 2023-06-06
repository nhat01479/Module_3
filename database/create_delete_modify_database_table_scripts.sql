create database my2;
use my2;

-- Tạo bảng
create table my2.persons (
PersonID int,
LastName varchar(255),
FirstName varchar(255),
Address varchar(255),
City varchar(255)
);

-- Add primary key
alter table my2.persons
add primary key (PersonID);

-- Đổi cột PersonID thành tự động tăng
alter table persons
	change column PersonID PersonID int auto_increment;

-- Đổi kiểu dữ liệu 1 cột table
alter table persons
modify column Email varchar(50);
    
-- Thêm dữ liệu vào table
insert into persons (PersonID,LastName,FirstName,Address,City, Email)
values ('1', 'John','Doe','LA','USA','john@gmail.com'),
('2', 'Stephen','Henry','GSG','USA','stephen@gmail.com');
;

-- Đổi tên cột
alter table persons
change column Address `Add` varchar(20);

-- Thêm cột Email vào table
alter table persons
add Email varchar(255)
after FirstName; -- first: thêm vào cột đầu tiên

-- Xoá cột table
alter table persons
drop column Email;

-- Xoá dữ liệu table
truncate table persons;

-- Xoá dòng kèm điều kiện
delete from persons where (PersonID = 1);

-- Xoá bảng
drop table persons;

-- Đổi tên bảng
alter table persons
	rename to people;

