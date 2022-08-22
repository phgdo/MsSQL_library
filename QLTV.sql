create database QUAN_LY_MUON_TRA_SACH
GO
USE QUAN_LY_MUON_TRA_SACH

GO

--TAO BANG THU_VIEN
if OBJECT_ID('THU_VIEN') is not null
drop table THU_VIEN
CREATE TABLE THU_VIEN
(
	--Mã thư viện
	MaThuVien int PRIMARY KEY not null,
	--Tên thư viện
	TenTV nvarchar(50) null,
	--Địa chỉ thư viện
	DiaChiTV nvarchar(100) not null
);

GO
--TAO BANG THE_DOC_GIA
if OBJECT_ID('THE_DOC_GIA') is not null
drop table THE_DOC_GIA
CREATE TABLE THE_DOC_GIA
(
	--Mã thẻ độc giả
	MaTDG int PRIMARY KEY not null,
	--Họ và tên độc giả
	HoTenDG NVARCHAR(30) not null,
	--Ngày sinh của độc giả
	NgaySinh DATE null,
	-- Số điện thoại độc giả
	SDT CHAR(10) not null,
	--Địa chỉ thường trú của độc giả
	DiaChi NVARCHAR (100) null,
	--Nơi học tập/làm việc của độc giả
	DonViHTLV NVARCHAR (50) null,
	--Mã thư viện mà độc giả đăng kí
	MaThuVien int not null
		constraint  fk_THEDOCGIA_THUVIEN foreign key (MATHUVIEN) references THUVIEN(MATHUVIEN)
	on delete cascade
    on update cascade
);

GO

--TAO BANG THE_LOAI
if OBJECT_ID('THE_LOAI') is not null
drop table THE_LOAI
CREATE TABLE THE_LOAI
(
	--Mã thể loại sách
	MaTheLoai char(10) PRIMARY KEY not null,
	--Vị trí kệ sách chứa thể loại sách
	ViTri nvarchar(50) not null,
	MaThuVien int not null,
	constraint  fk_THELOAI_THUVIEN foreign key (MATHUVIEN)
	references THUVIEN(MATHUVIEN)
	on delete cascade
    on update cascade
);

GO
--TAO BANG SACH
if OBJECT_ID('SACH') is not null
drop table SACH
CREATE TABLE SACH
(
	--Mã sách
	MaSach char(10) PRIMARY KEY not null,
	--Tên sách
	TenSach NVARCHAR(100) not null,
	--Số lượng bạn đầu của sách
	SLBD int not null,
	--Số lượng còn lại trong thư việc
	SLCL int not null,
	--Ngôn ngữ sách
	NgonNgu NVARCHAR(20) not null,
	--Số tái bản của sách
	TaiBan TINYINT not null,
	--Tên nhà xuất bản
	TenNXB NVARCHAR(50) null,
	--Mã thể loại sách
	MaTheLoai char(10) not null,
	constraint  fk_SACH_THELOAI foreign key (MATHELOAI)
	references THELOAI(MATHELOAI)
	on delete cascade
    on update cascade
);


GO


--TAO BANG TAC_GIA
if OBJECT_ID('TAC_GIA') is not null
drop table TAC_GIA
CREATE TABLE TAC_GIA
(
	MaSach char(10) not null,
	TenTacGia NVARCHAR(50) null
		constraint  fk_TACGIA_SACH foreign key (MASACH)
	references SACH(MASACH)
	on delete cascade
    on update cascade
);

GO
--TAO BANG PHIEU_MUON
if OBJECT_ID('PHIEU_MUON') is not null
drop table PHIEU_MUON
CREATE TABLE PHIEU_MUON
(
	--Mã số phiếu mượn sách
	MaSoPhieu char(10) PRIMARY KEY not null,
	--Mã thẻ độc giả
	MaTDG int not null,
	--Mã sách muốn mượn
	MaSach char(10) not null,
	--Thời gian mượn sách (YYYY-MM-DD T hh:mm:ss)
	ThoiGianMuon DATETIME not null,
	--Thời hạn trả sách (YYYY-MM-DD T hh:mm:ss)
	ThoiHanTra DATETIME not null,
	constraint  fk_PHIEUMUON_THEODCGIA foreign key (MATDG)
	references THEDOCGIA(MATDG),
	constraint  fk_PHIEUMUON_SACH foreign key (MASACH)
	references SACH(MASACH)
	on delete cascade
    on update cascade
);

GO
--TAO BANG THU_THU
if OBJECT_ID('THU_THU') is not null
drop table THU_THU
CREATE TABLE THU_THU
(
	--Mã thủ thư
	MaTT int PRIMARY KEY not null,
	-- Họ tên thủ thư
	HoTen NVARCHAR(30) not null,
	--Số điện thoại thủ thư
	SDTTT char(10) null,
	--Mã thư viện mà thủ thư làm việc
	MaThuVien int not null
		constraint  fk_THUTHU_THUVIEN foreign key (MATHUVIEN)
	references THUVIEN(MATHUVIEN)
	on delete cascade
    on update cascade
);

GO
--TAO BANG XU_LY_VP
if OBJECT_ID('XU_LY_VP') is not null
drop table XU_LY_VP
CREATE TABLE XU_LY_VP
(
	--Mã xử phạt
	MaXP int PRIMARY KEY not null,
	--Mã số phiếu 
	MaSoPhieu char(10) not null,
	--Mã thủ thư tiếp nhận xử phạt 
	MaTT int not null,
	--Lỗi vi phạm của 
	LoiViPham nvarchar(500) not null,
	--Hình thức phạt
	HinhThucPhat nvarchar(500) not null
		constraint  fk_XULYVP_THUTHU foreign key (MATT)
	references THUTHU(MATT),
	constraint  fk_XULYVP_PHIEUMUON foreign key (MASOPHIEU)
	references PHIEUMUON(MASOPHIEU)
	on delete cascade
    on update cascade
);

--THEM DU LIEU BANG THU_VIEN
INSERT INTO THU_VIEN
VALUES(1, N'Thu vien Truong Dai hoc Su pham Ha Noi', N'136 Xuan Thuy, Dich Vong Hau, Cau Giay')


--THEM DU LIEU BANG THE_DOC_GIA
INSERT INTO THE_DOC_GIA
VALUES('705102074', N'Nguyen Van Viet', '2002-11-23', '0943721684', 'So 9 Ngo 181 Duong Xuan Thuy, Dich Vong Hau, Cau Giay, Ha Noi', '70A, Khoa Su pham Hoa hoc, Dai hoc Su pham Ha Noi', 1)
INSERT INTO THE_DOC_GIA
VALUES('705102044', N'Nguyen Thi Thu', '2002-12-02', '0959710626', '71 Tran Quoc Vuong, Dich Vong Hau, Cau Giay, Ha Noi', '70A, Khoa Su pham Hoa hoc, Dai hoc Su pham Ha Noi', 1)
INSERT INTO THE_DOC_GIA
VALUES('695205074', N'Pham Nhat Vuong', '2000-05-05', '0936788548', 'Ngo 37 Tran Quoc Hoan, Dich Vong Hau, Cau Giay, Ha Noi', '69C, Khoa CNTT, Dai hoc Su pham Ha Noi', 1)
INSERT INTO THE_DOC_GIA
VALUES('685105014', N'Le Phuc Tu', '2000-01-23', '0912044913', '25 An Trai, Van Canh, Tu Liem, Ha Noi', '68B, Khoa CNTT, Dai hoc Su pham Ha Noi', 1)
INSERT INTO THE_DOC_GIA
VALUES('705103128', N'Ngo Ba Tien', '2002-11-23', '0950820734', '119 Chua Lang, Lang Thuong, Dong Da, Ha Noi', '70A, Khoa Su pham Vat ly, Dai hoc Su pham Ha Noi', 1)
INSERT INTO THE_DOC_GIA
VALUES('705106001', N'Nguyen Thu Thao', '2001-10-13', '0994945285', '45B Ly Thuong Kiet, Tran Hung Dao, Hoan Kiem, Ha Noi', '70A, Khoa Su pham Dia ly, Dai hoc Su pham Ha Noi', 1)
INSERT INTO THE_DOC_GIA
VALUES('100000183', N'Phan Viet Anh', '2007-10-05', '0924996245', 'Ngo 233 To Hieu, Dich Vong Hau, Cau Giay Ha Noi', 'Truong THCS Nghia Tan', 1)
INSERT INTO THE_DOC_GIA
VALUES('100000184', N'Nguyen Thi Hai', '2008-04-05', '0935345212', 'B8 To Hieu, Khu tap the Nghia Tan, Cau Giay Ha Noi', 'Truong THCS Nghia Tan', 1)

--THEM DU LIEU THE_LOAI
INSERT INTO THE_LOAI
VALUES('IT', N'Tang 1, ke so 01 và ke so 02', 1)
INSERT INTO THE_LOAI
VALUES('MATH', N'Tang 1, ke so 03 và ke so 04', 1)
INSERT INTO THE_LOAI
VALUES('PSYC', N'Tang 2, ke so 03 và ke so 04', 1)
INSERT INTO THE_LOAI
VALUES('PHYS', N'Tang 1, ke so 05', 1)
INSERT INTO THE_LOAI
VALUES('SGK', N'Tang 2, ke so 06', 1)
INSERT INTO THE_LOAI
VALUES('ENGL', N'Tang 2, ke so 01', 1)

SELECT *
FROM SACH
--THEM DULIEU  SACH --đấy là tên tác giả đấy, đáng lẽ phải xóa đi rồi chứddossao xóa
INSERT INTO SACH
VALUES('IT01', N'Object-oriented programming in Microsoft C++', 10, 7, N'Tieng Anh', 6, NULL, 'IT')
INSERT INTO SACH
VALUES('IT02', N'Object-Oriented JavaScrip', 5, 5, N'Tieng Anh', 2, NULL, 'IT')
INSERT INTO SACH
VALUES('PSYC01', N'Tu duy nhanh va cham', 1, 0, N'Tieng Viet', 1, N'NXB The Gioi', 'PSYC')
INSERT INTO SACH
VALUES('ENGL01', N'Cambridge Advanced Learner`s Dictionary', 2, 2, N'Tieng Anh', 7, 'Nhà xuất bản Đại học Cambridge', 'ENGL')
INSERT INTO SACH
VALUES('MATH01', N'Giai tich - Tap 1 - Calculus 7e', 1, 1, N'Tieng Viet', 2, N'NXB Hong Duc', 'MATH')
INSERT INTO SACH
VALUES('MATH02', N'Giai tich - Tap 2 - Calculus 7e', 2, 2, N'Tieng Viet', 2, N'NXB Hong Duc', 'MATH')
INSERT INTO SACH
VALUES('IT03', N'Toan roi rac cho ky thuat so', 1, 1, N'Tieng Viet', 1, N'NXB Khoa học và kỹ thuật', 'IT')
INSERT INTO SACH
VALUES('PHYS03', N'Vu tru trong vo hat de', 1, 1, N'Tieng Anh', 3, N'NXB Trẻ', 'PHYS')
INSERT INTO SACH
VALUES('PHYS04', N'Vat ly thien van cho nguoi voi va', 1, 0, N'Tieng Viet', 1, N'NXB The Gioi', 'PHYS')
INSERT INTO SACH
VALUES('SGK1104', N'Sinh hoc 11', 14, 14, N'Tieng Viet', 10, N'NXB Giao duc Viet Nam', 'SGK')
INSERT INTO SACH
VALUES('SGK1201', N'Giai tich 12', 1, 1, N'Tieng Viet', 10, N'NXB Giao duc Viet Nam', 'SGK')
INSERT INTO SACH
VALUES('SGK1202', N'Hinh hoc 12', 2, 1, N'Tieng Viet', 10, N'NXB Giao duc Viet Nam', 'SGK')
--THEM DU LIEU PHIEU_MUON
INSERT INTO PHIEU_MUON
VALUES('111221001', '705102074', 'MATH01', '2021-12-11T08:30:00', '2021-12-11T11:30:00')
INSERT INTO PHIEU_MUON
VALUES('111221002', '705102074', 'MATH02', '2021-12-11T13:30:00', '2021-12-11T20:00:00')
INSERT INTO PHIEU_MUON
VALUES('111221003', '695205074', 'IT02', '2021-12-11T09:42:00', '2021-12-22T20:00:00')
INSERT INTO PHIEU_MUON
VALUES('131221001', '705103128', 'PHYS04', '2021-12-13T10:04:00', '2021-12-15T09:30:00')


--THEM DU LIEU TAC_GIA
INSERT INTO TAC_GIA
VALUES('IT01', N'Robert Lafore')
INSERT INTO TAC_GIA
VALUES('IT02', N'Stoyan Stefanov')
INSERT INTO TAC_GIA
VALUES('PSYC01', N'Daniel Kahneman')
INSERT INTO TAC_GIA
VALUES('MATH01', N'James Stewart')
INSERT INTO TAC_GIA
VALUES('MATH02', N'James Stewart')
INSERT INTO TAC_GIA
VALUES('IT03', N'Nguyen Xuan Quynh')
INSERT INTO TAC_GIA
VALUES('PHYS03', N'Stephen Hawking')
INSERT INTO TAC_GIA
VALUES('PHYS04', N'Neil Degrasse Tyson')
INSERT INTO TAC_GIA
VALUES('SGK1104', N'Bo giao duc va dao tao')
INSERT INTO TAC_GIA
VALUES('SGK1201', N'Bo giao duc va dao tao')
INSERT INTO TAC_GIA
VALUES('SGK1202', N'Bo giao duc va dao tao')


--THEM DU LIEU THU_THU
INSERT INTO THU_THU
VALUES(10001, N'Nguyen Thi THanh Nga' , '0939510126', 1)
INSERT INTO THU_THU
VALUES(10002, N'Pham Van Thanh', '0953486250', 1)
INSERT INTO THU_THU
VALUES(10003, N'Le Thi Tan', '0951431548', 1)

--THEM DU LIEU XU_LY_VP
INSERT INTO XU_LY_VP
VALUES(1001, '111221001', '10003', N'Lam uot tu trang 23 den 35', N'Phat 50.000đ vi sach bi uot, co the khoi phuc duoc.')
INSERT INTO XU_LY_VP
VALUES(1002, '111221003', '10001', N'Tra sach qua han 2 ngay', N'Phat 20.000đ (10.000đ/Ngay)')



--Truy vấn
--Đưa ra mã thẻ độc giả, họ tên độc giả đăng kí thẻ ở thư viện Đại học Sư phạm Hà Nội
SELECT tdg.MaTDG, tdg.HoTenDG
FROM THE_DOC_GIA tdg, THU_VIEN tv
WHERE tdg.MaThuVien = tv.MaThuVien
	AND tv.TenTV = 'Thu vien Truong Dai hoc Su pham Ha Noi'

--Đưa ra thông tin độc giả và thông tin sách mượn sách quá hạn tại thư viện Đại học Sư phạm Hà Nội sau ngày 22/12/2021
SELECT tdg.MaTDG, tdg.HoTenDG, tdg.SDT, s.MaSach, s.TenSach
FROM THE_DOC_GIA tdg, THU_VIEN tv, PHIEU_MUON pm, SACH s
WHERE tdg.MaThuVien = tv.MaThuVien
	AND pm.MaSach = s.MaSach
	AND pm.MaTDG = tdg.MaTDG
	AND tv.TenTV = 'Thu vien Truong Dai hoc Su pham Ha Noi'
	AND pm.ThoiHanTra < '2021-12-22'


--Đưa ra các lỗi vi phạm của độc giả có mã thẻ là 705102074
SELECT tdg.MaTDG, tdg.HoTenDG, xl.LoiViPham, s.TenSach
FROM XU_LY_VP xl, PHIEU_MUON pm, THE_DOC_GIA tdg, SACH s
WHERE pm.MaSoPhieu = xl.MaSoPhieu
	AND tdg.MaTDG = pm.MaTDG
	AND s.MaSach=pm.MaSach
	AND pm.MaTDG = 705102074


--Đưa ra thông tin về ngôn ngữ, vị trí và số lượng còn lại của sách có tên Object-Oriented JavaScrip
SELECT s.TenSach, s.NgonNgu, tl.ViTri, s.SLCL
FROM SACH s, THE_LOAI tl
WHERE s.MaTheLoai = tl.MaTheLoai
	AND s.TenSach = 'Object-Oriented JavaScrip'

--Đưa ra tống số lượng  sách IT trong thư viện Trường Đại học Sư phạm Hà Nội
SELECT SUM(SLBD) AS SL_SachIT
FROM SACH s, THE_LOAI tl, THU_VIEN tv
WHERE tl.MaTheLoai = s.MaTheLoai
	AND tl.MaThuVien = tv.MaThuVien
	AND tl.MaTheLoai = 'IT'
	AND tv.TenTV = 'Thu vien Truong Dai hoc Su pham Ha Noi'

