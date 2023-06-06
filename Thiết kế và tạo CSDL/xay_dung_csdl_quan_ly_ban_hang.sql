create database QuanLyBanHang;
use QuanLyBanHang;
create table Customer(
cID int auto_increment primary key,
cName varchar(30),
cAge int
);
create table `Order`(
oID int auto_increment primary key,
cID int not null,
oDate Datetime,
oTotalPrice float,
foreign key (cID) references Customer(cID)
);
create table Orderdetai(
oID int not null,
pID varchar(50) not null,
odQTY int,
primary key (oID, pID),
foreign  key (oID) references `Order`(oID),
foreign key (pID) references Product(pID)
);
create table Product(
pID varchar(50)  primary key,
pName varchar(50),
pPrice float
);

-- ---------------------------------
insert into customer(cID, cName, cAge)
values
(1, 'Minh Quan', 10),
(2, 'Ngoc Oanh', 20),
(3, 'Hong Ha', 50);
insert into `order`(oID, cID, oDate) 
values
(1,1,'2006/03/21'),
(2,2,'2006/03/23'),
(3,1,'2006/03/16');
INSERT INTO `quanlybanhang`.`product` (`pID`, `pName`, `pPrice`) VALUES ('1', 'May Giat', '3');
INSERT INTO `quanlybanhang`.`product` (`pID`, `pName`, `pPrice`) VALUES ('2', 'Tu Lanh', '5');
INSERT INTO `quanlybanhang`.`product` (`pID`, `pName`, `pPrice`) VALUES ('3', 'Dieu Hoa', '7');
INSERT INTO `quanlybanhang`.`product` (`pID`, `pName`, `pPrice`) VALUES ('4', 'Quat', '1');
INSERT INTO `quanlybanhang`.`product` (`pID`, `pName`, `pPrice`) VALUES ('5', 'Bep Dien', '2');

INSERT INTO `quanlybanhang`.`orderdetai` (`oID`, `pID`, `odQTY`) 
VALUES 
('1', '1', '3'),
('1', '3', '7'),
('1', '4', '2'),
('2', '1', '1'),
('3', '1', '8'),
('2', '5', '4'),
('2', '3', '3');


-- Hiển thị các thông tin  gồm oID, oDate, oPrice của tất cả các hóa đơn trong bảng Order
select O.oID, O.oDate, O.oTotalPrice
from `order` O;

-- Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách
select C.cName as TenKhachHang, P.pName as SanPhamDaMua
from customer C
join `order` O on C.cID = O.cID
join orderdetail OD on O.oID = OD.oID
join product P on OD.pID = P.pID;

-- Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào
select C.cName as TenKhachHangKhongMuaHang
from customer C
left join `order` O on C.cID = O.cID
where O.cID is null
group by C.cName;

-- Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn 
-- (giá một hóa đơn được tính bằng tổng giá bán của từng loại mặt 
-- hàng xuất hiện trong hóa đơn. Giá bán của từng loại được tính = odQTY*pPrice)
select O.oID, O.oDate, sum(P.pPrice * OD.OdQTY) as oPrice
from `order` O
join orderdetail OD on O.oID = OD.oID
join product P on OD.pID = P.pID
group by O.oID;


