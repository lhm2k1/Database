use QuanLyBanHang
go

--													Chi tiết mặt hàng nhập INSERT
create trigger trg_insert_Chitietmathangnhap on Chitietmathangnhap
for insert as
begin
	declare @Mahang nvarchar(20)
	select @Mahang = inserted.Mahang from inserted
	update Mathang set Soluongton = Soluongton + inserted.Soluongnhap from inserted where @Mahang = Mathang.Mahang
	update Chitietmathangnhap set Thanhtien = inserted.Soluongnhap * inserted.Gianhap - inserted.Giamgia from inserted where @Mahang = Chitietmathangnhap.Mahang
end
drop trigger trg_insert_Chitietmathangnhap

--													Chi tiết mặt hàng nhập DELETE
create trigger trg_delete_Chitietmathangnhap on Chitietmathangnhap
for delete as
begin
	declare @Mahang nvarchar(20)
	select @Mahang = deleted.Mahang from deleted
	update Mathang set Soluongton= Soluongton + deleted.Soluongnhap from deleted where @Mahang = Mathang.Mahang
end
drop trigger trg_delete_Chitietmathangnhap

--													Chi tiết mặt hàng nhập UPDATE
create trigger trg_update_Chitietmathangnhap on Chitietmathangnhap
for update as
begin
	declare @Mahang nvarchar(20)
	if update (Soluongnhap)
		begin
			
			select @Mahang = Mahang from inserted
			update Mathang set Soluongton = Soluongton + deleted.Soluongnhap - inserted.Soluongnhap from inserted,deleted where @Mahang = Mathang.Mahang
			update Chitietmathangnhap set Thanhtien = inserted.Soluongnhap * inserted.Gianhap - inserted.Giamgia from inserted where @Mahang = Chitietmathangnhap.Mahang
		end
	else
		if update (Gianhap)
			begin
				select	@Mahang  = Mahang from inserted
				update Chitietmathangnhap set Thanhtien = inserted.Soluongnhap * inserted.Gianhap - inserted.Giamgia from inserted where @Mahang = Chitietmathangnhap.Mahang
			end
		else
			if update (Soluongnhap)
				begin
					select	@Mahang  = Mahang from inserted
					update Chitietmathangnhap set Thanhtien = inserted.Soluongnhap * inserted.Gianhap - inserted.Giamgia from inserted where @Mahang = Chitietmathangnhap.Mahang
				end
			else
				if update (Giamgia)
					begin
						select	@Mahang  = Mahang from inserted
						update Chitietmathangnhap set Thanhtien = inserted.Soluongnhap * inserted.Gianhap - inserted.Giamgia from inserted where @Mahang = Chitietmathangnhap.Mahang
					end
				else
					rollback transaction
end
drop trigger trg_update_Chitietmathangnhap
