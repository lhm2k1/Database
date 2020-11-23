--create database QuanLyBanHang
use QuanLyBanHang

create table Sign_up(
	[Susername]				nvarchar(50)			not null,
	Spassword				nvarchar(50)			not null,
	Gmail					nvarchar(50)			not null,
)
create table Nhanvien
(
	[Manhanvien]			nvarchar(20)			not null,
	Hoten					nvarchar(50)			not null,
	SDT						nvarchar(10)			not null,
	Gmail					nvarchar(50)			not null,

	constraint				pk_Nhanvien				primary key	([Manhanvien]),
	constraint				ck_Nhanvien_SDT			check(SDT like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
)
create table Loaihang
(
	[Maloaihang]			nvarchar(20)			not null,
	Tenloaihang				nvarchar(50)			not null,

	constraint pk_Loaihang primary key ([Maloaihang])
)
create table Mathang
(
	[Mahang]				nvarchar(20)			not null,
	Tenhang					nvarchar(100)			not null,
	MaLoaihang				nvarchar(20)					,
	Soluongton				int						default	0,
	Gianhap					decimal(12,3)	        default 0.0,      
	Giaxuat					decimal(12,3)			default 0.0,

	constraint				pk_Mathang				primary key ([Mahang]),
	constraint				fk_Mathang_Maloaihang	foreign key (Maloaihang)	references Loaihang([Maloaihang]),

	constraint				ck_Mathang_Soluongton	check(Soluongton >= 0),
	constraint				ck_Mathang_Gianhap		check (Gianhap >= 0 and Gianhap <= 999999999),
	constraint				ck_Mathang_Giaxuat		check (Giaxuat >= 0 and Giaxuat <= 999999999)

)
create table Hoadonnhap
(
	[Mahoadonnhap]			nvarchar(20)			not null,
	Manhanvien				nvarchar(20)			not null,
	Ngaynhap				date				not null,
	Tongtien				decimal(12,3)			not null,

	constraint				pk_Hoadonnhap						primary key ([Mahoadonnhap]),
	constraint				fk_Hoadonnhap_Manhanvien			foreign key (Manhanvien) references Nhanvien([Manhanvien]),
	constraint				ck_Hoadonnhap_Tongtien				check(Tongtien >= 0 and Tongtien <= 999999999)
)
create table Chitietmathangnhap
(
	[Mahoadonnhap]			nvarchar(20)			not null,
	[Mahang]					nvarchar(20)			not null,
	Soluongnhap 			int						default 0,
	Gianhap					decimal(12,3)			default 0.0,
	Giamgia					decimal(12,3)			default 0.0,
	Thanhtien				decimal(12,3)			default 0.0,
	Nhacungcap				nvarchar(50)			,

	constraint				pk_Chitietmathangnhap				primary key ([Mahoadonnhap],[Mahang]),

	constraint				ck_Chitietmathangnhap_Soluongnhap	check(Soluongnhap >= 0),
	constraint				ck_Chitietmathangnhap_Gianhap		check (Gianhap >= 0 and Gianhap <= 999999999),
	constraint				ck_Chitietmathangnhap_Giamgia		check (Giamgia >= 0 and Giamgia <= Gianhap),
	constraint				ck_Chiitetmathangnhap_Thanhtien		check (Thanhtien >= 0 and Thanhtien <= 999999999)
)

alter table Chitietmathangnhap
add
constraint fk_Chitietmathangnhap_Mahoadonhap foreign key ([Mahoadonnhap]) references Hoadonnhap([Mahoadonnhap]),
constraint fk_Chitietmathangnhap_Mahang foreign key ([Mahang]) references Mathang([Mahang])

create table Khachhang
(
	[ID]					nvarchar(20)			not null,
	Diemtichluy				decimal(12,3)			default 0.0,
	SDT						char(10)				default '0000000000',
	
	constraint				pk_Khachhang						primary key ([ID]),

	constraint				ck_Khachhang_SDT					check(SDT like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	constraint				ck_Khachhang_Diemtichluy			check(Diemtichluy >= 0 and Diemtichluy <= 999999999)
)
create table Hoadonxuat
(
	[Mahoadonxuat]			nvarchar(20)			not null,
	Manhanvien				nvarchar(20)			not null,
	Ngayxuat				date				not null,
	Quay					nvarchar(10)			not null,
	ID						nvarchar(20)					,
	Tongtien				decimal(12,3)			default 0.0,

	constraint				pk_Hoadonxuat_Mahoadonxuat			primary key ([Mahoadonxuat]),
	constraint				fk_Hoadonxuat_Manhanvien			foreign key (Manhanvien)  references Nhanvien([Manhanvien]),

	constraint				ck_Hoadonxuat_Tongtien				check(Tongtien >= 0 and Tongtien <= 999999999)
)
 create table Chitietmathangxuat
 (
	[Mahoadonxuat]			nvarchar(20)			not null,
	[Mahang]				nvarchar(20)			not null,
	Loaihang				nvarchar(50)					,
	Soluongxuat 			int						default 0,
	Giaxuat					decimal(12,3)			default 0.0,
	Giamgia					decimal(12,3)			default 0.0,
	Thanhtien				decimal(12,3)			default 0.0

	constraint				pk_Chitietmathangxuat				primary key ([Mahoadonxuat],[Mahang]),

	constraint				ck_Chitietmathangxuat_Soluongxuat	check(Soluongxuat >= 0),
	constraint				ck_Chitietmathangxuat_Gianhap		check (Giaxuat >= 0 and Giaxuat <= 999999999),
	constraint				ck_Chitietmathangxuat_Giamgia		check (Giamgia >= 0 and Giamgia <= Giaxuat),
	constraint				ck_Chiitetmathangxuat_Thanhtien		check (Thanhtien >= 0 and Thanhtien <= 999999999)
 )
alter table Chitietmathangxuat
add
constraint				fk_Chitietmathangxuat_Mahang		foreign key (Mahang) references Mathang([Mahang]),
constraint				fk_Chitietmathangxuat_Mahoadonxuat	foreign key (Mahoadonxuat) references Hoadonxuat([Mahoadonxuat])

alter table Nhanvien drop column Gmail
/*
drop table Log_in
drop table Sign_up
drop table Khachhang
drop table Loaihang
drop table Mathang
drop table Nhanvien
drop table Chitietmathangxuat
drop table Chitietmathangnhap
drop table Hoadonnhap
drop table Hoadonxuat




SELECT Tenhang, Soluongnhap, Mathang.Gianhap FROM (Chitietmathangnhap JOIN Mathang ON Chitietmathangnhap.Mahang = Mathang.Mahang) JOIN Hoadonnhap ON Chitietmathangnhap.Mahoadonnhap = Hoadonnhap.Mahoadonnhap WHERE Hoadonnhap.Mahoadonnhap = '00000001' 

--SELECT Tenhang, Mahang, Tenloaihang, Soluongton, Gianhap, Giaxuat FROM Mathang, Loaihang WHERE Mathang.MaLoaihang = Loaihang.Maloaihang
*/