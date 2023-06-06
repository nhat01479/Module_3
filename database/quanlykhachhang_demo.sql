create database quan_ly_khach_hang_demo;
use quan_ly_khach_hang_demo;
-- Lấy ra tất cả thông tin của tất cả khách hàng
select*from customers;

-- Lấy ra thông tin sản phẩm có giá lơn hơn 30
select*from products
where buyPrice > 30;

-- Lấy ra thông tin khách hàng tại USA
select*from customers
where Country = 'USA';

SELECT CustomerName, City FROM Customers;

-- Lấy về danh sách số điện thoại của khách hàng
select	phone  from customers;

-- In ra các trạng thái đơn hàng
-- Từ khoá DISTINCT dùng trong câu lệnh select để chỉ định các giá trị duy nhất (không trùng lặp) của một cụ thể sẽ được trả về
select distinct status
from my1.orders;

-- In ra tổng số đơn hàng trong tháng 5/2005
select count(orderNumber) as tongDonHang
from orders
where orderDate
between '2005-05-01' and '2005-05-31';

-- Thống kê các quốc gia không có nhân viên hỗ trợ.
select distinct country
from 			customers
where			salesRepEmployeeNumber is null;

-- In ra tên và số lượng của 5 sản phẩm có số lượng tồn kho lớn nhất
select * FROM products;
SELECT productName,
	   sum(quantityInStock) AS tongXe
FROM     products
GROUP BY productName
ORDER BY tongXe DESC
LIMIT 5 ;

-- In ra 5 loại sản phẩm có chênh lệch giá giữa giá đề xuất và giá thị trường cao nhất.
SELECT   productName, 
         ABS(MSRP - buyPrice) AS chenhLechGia
FROM     products
ORDER BY chenhLechGia DESC
LIMIT    5 ;

-- Dự đoán là giá sản phẩm năm tới sẽ tăng 20% so với năm nay, in ra tên sản phẩm, giá sản phẩm hiện tại và giá sản phẩm dự đoán năm sau.
select	productName,
		buyPrice as giaBanNamnay,
        buyPrice * 1.2 as giaBanNamSau
from products;

-- Tính tổng doanh thu thu được từ mặt hàng có mã 'S18_1749'. 
SELECT productCode, 
       SUM( quantityOrdered * priceEach) AS tongTien
FROM   orderdetails
WHERE  productCode = 'S18_2248';

-- In ra 5 mã khách hàng của những khách hàng tiềm năng (có số tiền chi tiêu lớn nhất). 
SELECT   customerNumber, SUM(amount) AS tongChiTieu
FROM     payments
GROUP BY customerNumber
ORDER BY tongChiTieu DESC
LIMIT    5 ;

--
select productCode, sum(quantityOrdered)
from orderdetails
group by productCode
order by sum(quantityOrdered) desc
limit 3;

-- 
SELECT productCode, 
       COUNT(quantityOrdered) AS tongDonHang
FROM   orderdetails
WHERE  productCode = 'S18_1749' ;

--
SELECT * FROM orderdetails 
WHERE priceEach BETWEEN '50' AND '100' ;

--
SELECT * FROM orders
WHERE         status = 'Disputed' ;
--
SELECT country, AVG(creditLimit) 
FROM   customers 
WHERE  country = 'USA' ;
--
SELECT   country, 
         COUNT(customerNumber) AS soKhachHangQuocTe
FROM     customers
WHERE NOT country = 'USA'
GROUP BY country ;
--
SELECT DISTINCT jobTitle
FROM            employees ;