use QuanLyBanHang
--													Chi tiết mặt hàng xuất INSERT
go
create trigger trg_insert_Chitietmathangxuat on Chitietmathangxuat 
for insert as
begin
	declare @Mhang nvarchar(20)
	select @Mhang = inserted.Mahang from inserted
	update Mathang set Soluongton = Soluongton - inserted.Soluongxuat from inserted where @Mhang = Mathang.Mahang
	update Chitietmathangxuat set Thanhtien = inserted.Soluongxuat * inserted.Giaxuat - inserted.Giamgia from inserted where @Mhang = Chitietmathangxuat.Mahang
end

--													Chi tiết mặt hàng xuất DELETE
go
create trigger trg_delete_Chitietmathangxuat on Chitietmathangxuat
for delete as
begin
	declare @MH nvarchar(20)
	select @MH = deleted.Mahang from deleted
	update Mathang set Soluongton = Soluongton + deleted.Soluongxuat from deleted where @MH = Mathang.Mahang
end

--													Chi tiết mặt hàng xuất UPDATE
go
create trigger trg_update_Chitietmathangxuat on Chitietmathangxuat 
for update as
begin
	
	if update (Soluongxuat) or update(Giaxuat) or update(Giamgia)
		begin
			declare @Mahang nvarchar(20)
			select @Mahang = Mahang from deleted
			update Mathang set Soluongton = Soluongton + deleted.Soluongxuat - inserted.Soluongxuat from inserted,deleted where @Mahang = Mathang.Mahang
			update Chitietmathangxuat set Thanhtien = inserted.Soluongxuat * inserted.Giaxuat - inserted.Giamgia from inserted where @Mahang = Chitietmathangxuat.Mahang
		end
	else
		rollback transaction
end

--drop trigger trg_update_Chitietmathangxuat
--drop trigger trg_insert_Chitietmathangxuat
--drop trigger trg_delete_Chitietmathangxuat
--insert into Chitietmathangxuat(Mahoadonxuat, Mahang, Loaihang, Soluongxuat, Giaxuat) values('00000008','MS008','Thực phẩm',100,30000)

--alter table Chitietmathangxuat disable trigger trg_update_Chitietmathangxuat
--alter table Chitietmathangxuat disable trigger trg_insert_Chitietmathangxuat
--alter table Chitietmathangxuat disable trigger trg_delete_Chitietmathangxuat
--alter table Chitietmathangxuat enable trigger trg_update_Chitietmathangxuat
--alter table Chitietmathangxuat enable trigger trg_insert_Chitietmathangxuat
--alter table Chitietmathangxuat enable trigger trg_delete_Chitietmathangxuat