create database QuanLySinhVien;
use QuanLySinhVien;
create table Class(
ClassID int auto_increment primary key,
ClassName varchar(60) not null,
StartDate Datetime not null,
Status Bit
);
create table Student(
StudentID int auto_increment primary key,
StudentName varchar(30) not null,
Address varchar(50),
Phone varchar(20) default 'XinChao',
Status Bit,
ClassID int not null
);
create table `Subject`(
SubID int auto_increment primary key,
SubName varchar(30) not null,
Credit Tinyint not null default 1 check (Credit>=1),
Status Bit default 1
);

CREATE TABLE Mark(
    MarkId    INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SubId     INT NOT NULL,
    StudentId INT NOT NULL,
    Mark      FLOAT   DEFAULT 0 CHECK ( Mark BETWEEN 0 AND 100),
    ExamTimes TINYINT DEFAULT 1,
    UNIQUE (SubId, StudentId),
    FOREIGN KEY (SubId) REFERENCES Subject (SubId),
    FOREIGN KEY (StudentId) REFERENCES Student (StudentId)
);

insert into Class
values(1, 'A1', '2008-12-20',1);
INSERT INTO Class
VALUES (2, 'A2', '2008-12-22', 1);
INSERT INTO Class
VALUES (3, 'B3', current_date, 0);

insert into Student(StudentName, Address, Phone, Status, ClassID)
values ('Hung', 'Ha Noi', '0912113113', 1, 1);
INSERT INTO Student (StudentName, Address, Status, ClassId)
VALUES ('Hoa', 'Hai phong', 1, 1);
INSERT INTO Student (StudentName, Address, Phone, Status, ClassId)
VALUES ('Manh', 'HCM', '0123123123', 0, 2);

insert into Subject
values (1, 'CF', 5, 1),
	   (2, 'C', 6, 1),
       (3, 'HDJ', 5, 1),
       (4, 'RDBMS', 10, 1);
       
INSERT INTO Mark (SubId, StudentId, Mark, ExamTimes)
VALUES (1, 1, 8, 1),
       (1, 2, 10, 2),
       (2, 1, 12, 1);
       
-- Hiển thị danh sách học viên
select * from Student;
-- Hiển thị danh sách các học viên đang theo học
SELECT *
FROM Student
WHERE Status = 1;

-- Hiển thị danh sách các môn học có thời gian học nhỏ hơn 10 giờ.

select * from Subject
where Credit < 10;

-- Hiển thị danh sách học viên lớp A1
select S.StudentID, S.StudentName, C.ClassName
from Student S join class C on S.ClassID = C.classID
where C.ClassName = 'A1';

-- Hiển thị điểm môn CF của các học viên.
select S.StudentId, S.StudentName, Sub.SubName, M.Mark
from student S 
join mark M on S.StudentID = M.StudentID 
join `subject` Sub on M.SubID = Sub.SubID
where Sub.SubName = 'CF';

-- Hiển thị tất cả các sinh viên có tên bắt đầu bảng ký tự ‘h’
select StudentID, StudentName as SVTenBatDauBangH
from student
where StudentName like 'h%';

-- Hiển thị các thông tin lớp học có thời gian bắt đầu vào tháng 12.
select ClassID, ClassName, StartDate
from class
where month(StartDate) = 12;
-- where StartDate like '%-12-%';

-- Hiển thị tất cả các thông tin môn học có credit trong khoảng từ 3-5.
select * from subject
where Credit between 3 and 5;

-- Thay đổi mã lớp(ClassID) của sinh viên có tên ‘Hung’ là 2.
update student
set classID = '2'
where StudentName = 'Hung';

-- Hiển thị các thông tin: StudentName, SubName, Mark. Dữ liệu sắp xếp theo điểm thi (mark) giảm dần. nếu trùng sắp theo tên tăng dần.
select S.StudentName, Sub.SubName, M.Mark
from student S
join mark M on S.StudentID = M.StudentId
join subject Sub on M.SubId = Sub.SubID
order by mark desc, S.StudentName asc;

-- Hiển thị số lượng sinh viên ở từng nơi
select Address, count(*) as 'Số lượng học viên'
from student
group by Address;

-- Tính điểm trung bình các môn học của mỗi học viên
SELECT S.StudentId, S.StudentName, AVG(M.Mark) as DTB
FROM Student S join Mark M on S.StudentId = M.StudentId
GROUP BY S.StudentId, S.StudentName;


-- Hiển thị những bạn học viên co điểm trung bình các môn học lớn hơn 15

select S.studentid, S.studentName, avg(M.Mark) as DTB
from student S
join mark M on S.StudentID = M.StudentId
group by S.studentid, S.studentName
having DTB > 15;

-- Hiển thị thông tin các học viên có điểm trung bình lớn nhất.
select S.Studentid, S.StudentName, avg(M.Mark)
from student S
join mark M on S.StudentID = M.StudentId
group by S.StudentId, S.StudentName
having avg(Mark) >= all (select avg(Mark) from mark group by mark.StudentID); -- So sánh DTB của 1 SV với tất cả các giá trị trung bình của tất cả SV khác. all () trả về 1 tập các giá trị trung bình

-- Hiển thị tất cả các thông tin môn học (bảng subject) có credit lớn nhất.
select * 
from subject
where Credit = (select max(Credit) from subject);
-- ----
select SubID, SubName, max(Credit), `Status`
from subject
group by SubID, SubName, `Status`
having max(Credit) >= all (select Credit from subject);


-- Hiển thị các thông tin môn học có điểm thi lớn nhất.
select Sub.SubID, Sub.SubName, Sub.Credit, Sub.`Status`, max(Mark)
from subject Sub 
join mark M on Sub.SubID = M.SubID
group by Sub.SubID, Sub.SubName, Sub.Credit, Sub.`Status`
having max(Mark) = (select max(Mark) from mark);

-- Hiển thị các thông tin sinh viên và điểm trung bình của mỗi sinh viên, xếp hạng theo thứ tự điểm giảm dần
select S.StudentID, S.StudentName, S.Address, S.Phone, S.Status, S.ClassID, avg(Mark) as DTB
from student S
join mark M on S.StudentID = M.StudentID
group by S.StudentID
order by DTB desc;