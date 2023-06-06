-- Tạo index
/*
CREATE UNIQUE INDEX index_name ON table_name; tạo index trên 1 bảng
ALTER TABLE tbl_name ADD PRIMARY KEY (column 1, column 2,..)
ALTER TABLE tbl_name ADD UNIQUE index_name (column 1, column 2,..)
ALTER TABLE tbl_name ADD INDEX index_name (column 1, column 2,..)
ALTER TABLE tbl_name ADD FULLTEXT index_name (column 1, column 2,..)
*/

create unique index idx_customerName on customers(customerName);
alter table customers add index idx_customerName(customerName);

-- Xoá index
alter table customers drop index idx_customerName;
drop index idx_customerName on customers;

-- Hiển thị danh sách các index
show indexes from customers;
