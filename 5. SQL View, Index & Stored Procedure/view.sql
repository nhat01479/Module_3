-- Tạo view
create view customer_views as
select customerNumber, customerName, phone
from customers;

select * from customer_views;

-- Cập nhật view
/*
create or replace view view_name as
select column1, colum2, ...
from table_name;
*/
-- Ví dụ

create or replace view customer_views as
select customerNumber, customerName, contactFirstName, contactLastName, phone
from customers
where city = 'Nantes';

-- Xoá view: drop view view_name;

drop view customer_views;
