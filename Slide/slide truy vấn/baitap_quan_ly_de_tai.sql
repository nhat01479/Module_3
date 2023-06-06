use baitap_my_sql;
select * from giaovien;
-- Dùng các hàm gộp 

-- Câu 1: Cho biết số lượng giáo viên của toàn trường
select count(*) as SoLuongGiaoVien
from giaovien;

-- Câu 2: Cho biết số lượng giáo viên của bộ môn HTTT
select count(*) as SoLuongGiaoVienMonHTTT
from giaovien
where MABM = 'HTTT';

-- Câu 3: Tính số lượng giáo viên có người quản lý về mặt chuyên môn
select * from giaovien where GVQLCM is not null;


select count(*) as SoLuongGiaoVienCoNguoiQLCM
from giaovien
where GVQLCM is not null;


-- Câu 4: Tính số lượng giáo viên làm nhiệm vụ quản lý chuyên môn cho giáo viên khác mà thuộc bộ môn HTTT.
select * from giaovien where GVQLCM is null and MABM = 'HTTT';


select count(*)
from giaovien 
where GVQLCM is null and MABM = 'HTTT';

-- Câu 5:  Tính lương trung bình của giáo viên bộ môn Hệ thống thông tin
select * from giaovien where MABM = 'HTTT';

select avg(LUONG) as LuongTBBoMonHTTT
from giaovien 
where MABM = 'HTTT';

SELECT AVG(LUONG)
FROM GIAOVIEN GV, BOMON BM
WHERE GV.MABM = BM.MABM AND BM.TENBM = 'Hệ thống thông tin';

-- Dùng group by
SELECT TENDT, CAPQL
FROM DETAI
WHERE datediff(NGAYBD, '4/30/2005') < 0;
-- Câu 6: Với mỗn bộ môn cho biết bộ môn (MAMB) và số lượng giáo viên của bộ môn đó.
select MABM, count(*) as SoLuongGV
from giaovien
group by MABM;

-- Câu 7: Với mỗi giáo viên, cho biết MAGV và số lượng công việc mà giáo viên đó có tham gia.

SELECT MAGV, COUNT(*) AS SLCV
FROM THAMGIADT
GROUP BY MAGV;

-- Câu 8: Với mỗi giáo viên, cho biết MAGV và số lượng đề tài mà giáo viên đó có tham gia.
use baitap_my_sql;
select MAGV, count(distinct MADT) as SoLuongDeTai
from thamgiadt
group by MAGV;

select thamgiadt.MAGV, count(distinct MADT) as SoLuongDeTai
from thamgiadt 
left join giaovien on giaovien.MAGV = thamgiadt.MAGV
group by thamgiadt.MAGV;

-- Cách nâng cao
select gv.magv, gv.hoten, count(distinct madt) as SLDT 
from  giaovien gv
left join thamgiadt tgdt on gv.magv = tgdt.magv 
group by gv.magv;



-- Câu 9:  Với mỗi bộ môn, cho biết số đề tài mà giáo viên của bộ môn đó chủ trì

select giaovien.MABM, count(GVCNDT)  as SoLuongDeTaiCuaBoMon
from giaovien
join detai on giaovien.MAGV = detai.GVCNDT
group by giaovien.MABM;

SELECT GV.MABM, COUNT(*)
FROM DETAI DT, GIAOVIEN GV
WHERE DT.GVCNDT = GV.MAGV
GROUP BY GV.MABM;
-- Câu 10: Với mỗn bộ môn cho biết tên bộ môn và số lượng giáo viên của bộ môn đó.
select bomon.MABM, bomon.TENBM, count(giaovien.MAGV) SoLuongGiaoVienCuaBoMon
from bomon
left join giaovien on bomon.MABM = giaovien.MABM
group by bomon.MABM;

-- Cách 2
select bm.MABM, bm.TENBM, (select count(*) from giaovien where MABM = bm.MABM) as SoLuongGiaoVien
from bomon bm;

-- Dùng GROUP BY + HAVING
-- Câu 11: Cho biết những bộ môn từ 2 giáo viên trở lên.

select bomon.MABM, bomon.TENBM, count(*) as SoLuongGV
from bomon
join giaovien on bomon.MABM = giaovien.MABM
group by bomon.MABM
having (SoLuongGV >= 2);

-- Câu 12: Cho biết tên những giáo viên và số lượng đề tài của những GV tham gia từ 3 đề tài trở lên.
select MAGV, count(distinct MADT) as SoLuongDeTai
from thamgiadt
group by MAGV
having count(distinct MADT) >= 2;

-- Câu 13: Cho biết số lượng đề tài được thực hiện trong từng năm.
select YEAR(NgayBD), count(*)
from detai
group by YEAR(NgayBD);


-- Dùng truy vấn con + mệnh đề SELECT
-- Câu A1: Với mỗi bộ môn, cho biết tên bộ môn và số lượng giáo viên của bộ môn đó.
                  
select bm.TENBM, (select count(*) 
				  from giaovien gv
                  where bm.MABM = gv.MABM) as SLGV
from bomon bm;

-- Dùng truy vấn con + mệnh đề FROM
-- Câu A2: Cho biết họ tên và lương của các giáo viên bộ môn HTTT

select T.HOTEN, T.L
from (select MAGV, HOTEN, LUONG as L
      from giaovien
      where MABM = 'HTTT') as T;

-- Dùng truy vấn con + mệnh đề WHERE
-- Câu A3: Cho biết những giáo viên có lương lớn hơn lương của giáo viên có MAGV=‘001’
select MAGV, HOTEN, LUONG
from giaovien
where LUONG > (select LUONG from giaovien where MAGV = '001');

-- Câu A4: Cho biết họ tên những giáo viên mà không có một người thân nào
select MAGV, HOTEN
from giaovien
where MAGV not in (select MAGV from nguoithan);
-- Câu A5: Cho biết những giáo viên có tham gia đề tài
select *
from giaovien
where MAGV in (select MAGV from thamgiadt);
-- Câu A6: Cho biết những giáo viên có lương nhỏ nhất
-- Cách 1
select *
from giaovien
where LUONG = (select min(LUONG) from giaovien);
-- Cách 2
select *
from giaovien
where LUONG <= all (select LUONG from giaovien);
-- Câu A7: Cho biết những giáo viên có lương cao hơn tất cả các giáo viên của bộ môn HTTT
select *
from giaovien
where LUONG >= all (select LUONG from giaovien where MABM = 'HTTT');
-- ------------------------
select *
from giaovien
where LUONG >= (select max(LUONG) from giaovien where MABM = 'HTTT');

-- Câu A8: Cho biết bộ môn (MABM) có đông giáo viên nhất

select MABM, count(*) as SLGVNhieuNhat
from giaovien
group by MABM
having count(*) >= all (select count(*) 
					   from giaovien 
					   group by MABM);
                       
-- Tạo bảng mới đặt tên là SLGV
with SLGV as (select MABM, count(*) as SL
	          from giaovien
              group by MABM)      
select MABM, sl
from SLGV
where sl >= (select max(SL) from SLGV);

-- Câu A9: Cho biết họ tên những giáo viên mà không có một người thân nào.
-- Sử dụng ALL thay vì NOT IN
select MAGV, HOTEN
from giaovien
where MAGV != all (select MAGV from nguoithan);

-- Câu A10: Cho biết họ tên những giáo viên có tham gia đề tài. (Sử dụng = ANY thay vì IN)

select MAGV, HOTEN
from giaovien
where MAGV = any (select MAGV from thamgiadt);
-- Câu A11: Cho biết các giáo viên có tham gia đề tài.
select *
from giaovien 
where exists (select MAGV from thamgiadt where giaovien.MAGV = thamgiadt.MAGV);

-- Câu A12: Cho biết các giáo viên không có người thân

select MAGV, HOTEN
from giaovien gv
where not exists (select MAGV from nguoithan nt where gv.MAGV = nt.MAGV);
 
-- Câu A14: Cho biết những giáo viên có lương lớn hơn lương trung bình của bộ môn mà giáo
-- viên đó làm việc.

select gv1.MAGV, gv1.HOTEN, gv1.LUONG
from giaovien gv1
where gv1.LUONG > (select avg(gv2.LUONG) from giaovien gv2 where gv1.MABM = gv2.MABM);

select MABM, avg(LUONG) from giaovien group by MABM;


with luong_tb as (select MABM, avg(LUONG) as luongtb from giaovien group by MABM)
select gv.MAGV, gv.HOTEN, gv.LUONG
from giaovien gv
where gv.LUONG > all (select luongtb from luong_tb where luong_tb.MABM = gv.MABM);


-- Câu A15: Cho biết những giáo viên có lương lớn nhất
select MAGV, HOTEN, LUONG as MAX_LUONG
from giaovien
where LUONG = (select max(LUONG) from giaovien);

-- Câu A16: Cho biết những đề tài mà giáo viên ‘001’ không tham gia.

select MADT, TENDT
from detai
where MADT not in (select MADT from thamgiadt where MAGV = '001');

-- Câu A17: Cho biết họ tên những giáo viên có vai trò quản lý về mặt chuyên môn với các giáo
-- viên khác

select MAGV, HOTEN
from giaovien
where MAGV in (select GVQLCM from giaovien);

select MAGV, HOTEN
from giaovien
where exists (select GVQLCM from giaovien where GVQLCM is not null);


-- Câu A18: Cho biết những giáo viên có lương lớn nhất.

select MAGV, HOTEN, LUONG as MAX_LUONG
from giaovien
where LUONG >= all (select LUONG from giaovien);

-- Câu A19: Cho biết những bộ môn (MABM) có đông giáo viên nhất
with slgv as (select MABM, count(*) as sl from giaovien group by MABM)
select slgv.MABM, sl
from slgv
where count(*)  >= all (select sl from slgv);


select MABM, count(*) as SLGVNhieuNhat
from giaovien
group by MABM
having count(*) >= all (select count(*) 
					   from giaovien 
					   group by MABM);




-- Câu A20: Cho biết những tên bộ môn, họ tên của trưởng bộ môn và số lượng giáo viên của
-- bộ môn có đông giáo viên nhất

select bm.MABM, bm.TENBM , gv.HOTEN
from bomon bm, giaovien gv
where gv.MAGV = bm.TRUONGBM
group by bm.MABM;

-- Câu A21: Cho biết những giáo viên có lương lớn hơn mức lương trung bình của giáo viên bộ
-- môn Hệ thống thông tin mà không trực thuộc bộ môn hệ thống thông tin

-- Câu A22: Cho tên biết đề tài có đông giáo viên tham gia nhất
-- viên bộ môn Hệ thống thông tin mà không trực thuộc bộ môn hệ thống thông tin

-- ************************************************B
-- Câu B2: Tìm các giáo viên không tham gia đề tài nào
-- Câu B3: Tìm các giáo viên vừa tham gia đề tài vừa là trưởng bộ môn.
-- Câu B4: Liệt kê những giáo viên có tham gia đề tài và những giáo viên là trưởng bộ môn.
-- Câu B5: Tìm các giáo viên (MAGV) mà tham gia tất cả các đề tài
-- Câu B6: Tìm các giáo viên (MAGV) mà tham gia tất cả các đề tài (Dùng NOT EXISTS)
-- Câu B7: Tìm các giáo viên (MAGV) mà tham gia tất cả các đề tài (Dùng NOT EXISTS)
-- Câu B9: Tìm tên các giáo viên ‘HTTT’ mà tham gia tất cả các đề tài thuộc chủ đề ‘QLGD


-- ADVANCED
-- Cho biết tên giáo viên và tên của giáo viên có nhiều người thân nhất
-- Cho biết tên của giáo viên lớn tuổi nhất của bộ môn hệ thống thông tin
-- Cho biết tên những đề tài mà giáo viên Nguyễn Hoài An chưa tham gia
-- Cho biết tên của giáo viên chủ nhiệm nhiều đề tài nhất.
-- Cho biết tên giáo viên và tên bộ môn của giáo viên tham gia nhiều đề tài nhất
-- Cho biết tên đề tài nào mà được tất cả giáo viên của bộ môn hóa hữu cơ tham gia