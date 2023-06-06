create database QuanLyDiemThi;
use QuanLyDiemThi;
create table HocSinh(
MaHS varchar(20),
TenHS varchar(255),
NgaySinh datetime,
Lop varchar(255),
GT varchar(255),
primary key (MaHS)
);
create table MonHoc(
MaMH varchar(20) primary key,
TenMH varchar(255)
-- MaGV varchar(20)
);
create table BangDiem(
MaHS varchar(20),
MaMH varchar(20),
DiemThi float,
NgayKT datetime,
foreign key (MaHS) references HocSinh(MaHS),
foreign key (MaMH) references MonHoc(MaMH)
);
create table GiaoVien(
MaGV varchar(20) primary key,
TenGV varchar(255),
SDT varchar(255)
);
-- Chỉnh sửa lại bảng MonHoc bổ sung thêm trường MaGV là khoá ngoại của bảng MonHoc
alter table MonHoc
	add column MaGV char(20);
    
alter table MonHoc
add constraint fk_MaGV foreign key (MaGV) references GiaoVien(MaGV);