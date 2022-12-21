SET NOCOUNT ON
GO

USE master
GO

if exists (select * from sysdatabases where name='ClothesStore')
		drop database ClothesStore
go

DECLARE @device_directory NVARCHAR(520)
SELECT @device_directory = SUBSTRING(filename, 1, CHARINDEX(N'master.mdf', LOWER(filename)) - 1)
FROM master.dbo.sysaltfiles WHERE dbid = 1 AND fileid = 1

-- @device_directory = C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\

EXECUTE (N'CREATE DATABASE ClothesStore
  ON PRIMARY (NAME = N''ClothesStore'', FILENAME = N''' + @device_directory + N'clothstore.mdf'')
  LOG ON (NAME = N''ClothesStore_log'',  FILENAME = N''' + @device_directory + N'clothstore.ldf'')')
GO

USE ClothesStore
GO

--CREATE TABLE "Admin" (
--	"Adminid" int Primary key,
--	"Cusname" varchar(100),
--	"Password" varchar(100),
--	"Email" varchar(100),
--	"Phone" varchar(10)
--)
--CREATE TABLE "Customer" (
--	"Customerid" int Primary key,
--	"Cusname" varchar(100),
--	"Password" varchar(100),
--	"Email" varchar(100),
--	"Phone" varchar(10)
--)

CREATE TABLE "Account" (
	"AccountId" nvarchar(100),
	"Name" nvarchar(100),
	"UserName" nvarchar(100),
	"Password" nvarchar(100),
	"IsAdmin" bit,
	"Email" nvarchar(100),
	"Phone" nvarchar(100),
	CONSTRAINT "PK_Account" PRIMARY KEY ("AccountId"),
)

--CREATE TABLE "Category"(
--	"CategoryId" nvarchar(100) primary key,
--	"CategoryName" nvarchar(100),
--	"Description" nvarchar(100)
--)
--CREATE TABLE "Brand"(
--	"Brandid" int Primary key,
--	"Brandname" varchar(50),
--	"Description" varchar(500)
--)

CREATE TABLE "Product"(
	"ProductId" nvarchar(100),
	"Brand" nvarchar(100),
	"ProductName" nvarchar(100),
	"Description" TEXT,
	"MainImage" nvarchar(100),
	"SubImage1" nvarchar(100),
	"SubImage2" nvarchar(100),
	"Price" int,
	"StoreQuantity" int,
	"Gender" int,
	"Category" nvarchar(100),
	CONSTRAINT "PK_Product" PRIMARY KEY ("ProductId"),
)

--CREATE TABLE "ProductCategory"(
--	"ProductId" nvarchar(100),
--	"CategoryId" nvarchar(100),
--	CONSTRAINT "PK_ProductCategory" PRIMARY KEY  CLUSTERED 
--	(
--		"ProductId",
--		"CategoryId"
--	),
--	CONSTRAINT FK_ProductCategory_Product FOREIGN KEY ("ProductId") REFERENCES  "Product" ("ProductId"),
--	CONSTRAINT FK_ProductCategory_Category FOREIGN KEY ("CategoryId") REFERENCES  "Category" ("CategoryId"),
--)

--CREATE TABLE "Ship"(
--	"Id" int Primary key,
--	"Street" varchar(100),
--	"Ward" varchar(100),
--	"District" varchar(100),
--	"Province" varchar(100),
--	"Name" varchar(50),
--	"Phone" varchar(10),
--	"Status" int
--)

CREATE TABLE "Order"(
	"OrderId" nvarchar(100),
	"AccountId" nvarchar(100),
	"OrderTime" datetime,
	"PaymentMethod" nvarchar(100),
	"Address" nvarchar(100),
	"Status" int,
	"TotalPrice" int,
	CONSTRAINT "PK_Order" PRIMARY KEY ("OrderId"),
	CONSTRAINT FK_Order_Account FOREIGN KEY ("AccountId") REFERENCES  "Account" ("AccountId")
)

CREATE TABLE "OrderDetail"(
	"OrderId" nvarchar(100),
	"ProductId" nvarchar(100),
	"Quantity" int,
	"Price" int,
	CONSTRAINT "PK_OrderDetail" PRIMARY KEY  CLUSTERED 
	(
		"OrderId",
		"ProductId"
	),
	CONSTRAINT FK_OrderDetail_Product FOREIGN KEY ("ProductId") REFERENCES  "Product" ("ProductId"),
	CONSTRAINT FK_OrderDetail_Order FOREIGN KEY ("OrderId") REFERENCES  "Order" ("OrderId"),
)

INSERT INTO "Account" VALUES ('01','Vũ Tiến Linh','TienLinh','linh123',1,'linh123@gmail.com','0355654117');
INSERT INTO "Account" VALUES ('02','Võ Thị Tường Vy','TuongVy','vy123',1,'vy123@gmail.com','0865952624');
INSERT INTO "Account" VALUES ('03','Phạm Hoàng Khang','HoangKhang','khang123',1,'khang123@gmail.com','0385456869');
INSERT INTO "Account" VALUES ('04','Nguyễn Đăng Minh','DangMinh','minh123',1,'minh123@gmail.com','0834856922');
INSERT INTO "Account" VALUES ('05','Nguyễn Tiến Linh','NguyenLinh','linh123',0,'linh123@gmail.com','0128556789');
INSERT INTO "Account" VALUES ('06','Lê Xuân Quyền','XuanQuyen','quyen123',0,'minh123@gmail.com','0125456789');
INSERT INTO "Account" VALUES ('07','Đoàn Triệu','DoanTrieu','Trieu123',0,'trieu123@gmail.com','0185456789');
INSERT INTO "Account" VALUES ('08','Tuấn Vũ','TuanVu','Vu123',0,'vu123@gmail.com','0123465789');
INSERT INTO "Account" VALUES ('09','Thanh Toàn','ThanhToan','Toan123',0,'toan123@gmail.com','0124256789');
INSERT INTO "Account" VALUES ('10','Võ Thị Hồng','HongVo','Hong123',0,'hong123@gmail.com','0325614587');


-- skirts
INSERT INTO "Product" VALUES ('01','Eva de Eva','Chân Váy xếp ly UNDERCOOL Tenis','Chân Váy xếp ly UNDERCOOL Tenis Lưng Cao Kiểu Tennis Skirt Chất Tuyết Mưa','https://cf.shopee.vn/file/29418fd82234d1c26dfcf54fdc3b7725','https://cf.shopee.vn/file/sg-11134201-22090-nnko5xafpxhv0b','https://cf.shopee.vn/file/sg-11134201-22090-bqu50i9epxhv9b',250000,12,0,'skirts')
INSERT INTO "Product" VALUES ('02','Eva de Eva','Chân Váy Hoa Nhí Vintage','Chân Váy Hoa Nhí Vintage Dáng Dài Qua Gối Ulzzang Cạp Chun Zinti','https://cf.shopee.vn/file/a7e2304babc7b574d62fed84172cc605','https://cf.shopee.vn/file/57cbe3b53b7d301bcf4d7347b5da3577','https://cf.shopee.vn/file/d092ce55fab49170e16ed283b8625ba8',200000,22,0,'skirts')
INSERT INTO "Product" VALUES ('03','Eva de Eva','Chân váy nỉ midi thêu hoa Lolliemade','Chân váy nỉ midi thêu hoa Lolliemade chất lượng cao','https://cf.shopee.vn/file/sg-11134201-22120-rbjgpv2y6alvfd','https://cf.shopee.vn/file/sg-11134201-22120-fc3q39pde0kvd4','https://cf.shopee.vn/file/sg-11134201-22120-z6b5zkmde0kvad',225000,15,0,'skirts')
INSERT INTO "Product" VALUES ('04','Elise','Chân váy len đuôi cá Ulzzang','Chân váy len đuôi cá Ulzzang xịn sò nhất quả đất','https://cf.shopee.vn/file/8fef2392897f82002388802e92fa8139','https://cf.shopee.vn/file/95b1cea4964d81116524005befc78886','https://cf.shopee.vn/file/7cce11948451cff75a66bd2608241299',175000,14,0,'skirts')
INSERT INTO "Product" VALUES ('05','Elise','Kelly Skirt - Chân váy xếp ly dáng xòe','Kelly Skirt - Chân váy xếp ly dáng xòe siêu xinh','https://cf.shopee.vn/file/sg-11134201-22110-q49x1h5b4tjvcd','https://cf.shopee.vn/file/2da481fb4ed84e9e1beda34840e2c4b1','https://cf.shopee.vn/file/sg-11134201-22110-imrruiclixjvc5',300000,21,0,'skirts')
-- tops
INSERT INTO "Product" VALUES ('06','4Men','Áo Sơ Mi Hiện Đại','Áo sơ mi dài tay, kiểu dáng Slim Fit dễ mặc, hợp form dáng.Màu sắc và kiểu dáng trẻ trung, kiểu dáng hiện đại, dễ phối đồ.','https://cf.shopee.vn/file/da84fd64b62d21957049da26452dbfa6','https://cf.shopee.vn/file/867f3a438ab5ca0aaf994cc71e76778b','https://cf.shopee.vn/file/d62d822a702062f46ef36024b2acb303',250000,11,1,'tops')
INSERT INTO "Product" VALUES ('07','4Men','Áo Thun Cổ Tròn Cài Nút Áo Ngực Mazify','Áo thun nam ngắn tay cổ tròn phong cách đường phố thời trang Hàn Quốc dành cho nam với chất bo gân cao cấp mềm mịn. Áo phông nam  là sự lựa chọn hoàn hảo cho các chàng trai bởi dễ mặc, form áo vừa vặn cơ thể, thoải mái theo từng cử động.','https://cf.shopee.vn/file/d03650ea4d31a1e30ec822d00d0210f3','https://cf.shopee.vn/file/50c3d54fcc613cbca48979f7a70ccc26','https://cf.shopee.vn/file/d492f7b22c618cd8fb32a3fcb9f624dd',300000,12,1,'tops')
INSERT INTO "Product" VALUES ('08','Top4man','Áo bóng đá Argentina','Thấm hút mồ hôi cực tốt, Thiết kế mạnh mẽ,  hiện đại','https://cf.shopee.vn/file/sg-11134201-22120-dz30sw5vy5kv71','https://cf.shopee.vn/file/sg-11134201-22120-pgg6j07tk4kvc7','https://cf.shopee.vn/file/sg-11134201-22120-j8wunwvty5kvba',350000,13,1,'tops')
INSERT INTO "Product" VALUES ('09','Top4man','RYAN Áo thun COOL BABY','RYAN Áo thun nam trắng ngắn tay vải cotton cổ bo tròn thương hiệu RYAN form rộng phong cách Hàn Quốc','https://cf.shopee.vn/file/595a61e0b46d45f8f836ad603c90474c','https://cf.shopee.vn/file/679fb99bb82b6d05b7a535eb630c77c5','https://cf.shopee.vn/file/f05ccc9503022fdf42cc679712fb2275',200000,14,1,'tops')
INSERT INTO "Product" VALUES ('10','Elise','ÁO SƠ MI VEST BÒ CRTOP TÚI CÚC','ÁO SƠ MI VEST BÒ CRTOP TÚI CÚC VỀ FULL SIZE SML xinh xuất sắc luôn nha. Chất bò sơ mi mềm đẹp đứng dáng , túi cúc bấm tỉ mỉ lắm luôn. Phom đẹp vô cùng .','https://cf.shopee.vn/file/cab6b5fde0df8f289b728ca5d8be3d12','https://cf.shopee.vn/file/95324c92482a0e8729e5671453e29b5b','https://cf.shopee.vn/file/7699ddf98029e14a9224353b91d35a43',150000,15,0,'tops')
-- pants
INSERT INTO "Product" VALUES ('11','Sadboy','QUẦN TÂY','Chất liệu Nano mềm mại thoáng mát, đứng form dáng. Thiết kế thanh lịch, thích hợp diện mặc khi tới công sở, dự sự kiện.','https://cf.shopee.vn/file/352d530bbea321fd112c0917d8c6ed24','https://cf.shopee.vn/file/sg-11134201-22100-dmngb2v4b9hvd7','https://cf.shopee.vn/file/sg-11134201-22100-qvau5993b9hv82',550000,21,1,'pants')
INSERT INTO "Product" VALUES ('12','Sadboy','Quần túi hộp - Triple Button Cargo Pants','Chất kaki dày dặn. Form quần cứng cáp, không nhăn. Phần gấu có ba chiếc cúc dễ dàng tháo mở.','https://cf.shopee.vn/file/1a48b7b27b1dd9c7650c0278c08ed724','https://cf.shopee.vn/file/449de264ecc09d80ae65be66b64b3968','https://cf.shopee.vn/file/8414d5482214b1e49868663ff873345a',450000,22,1,'pants')
INSERT INTO "Product" VALUES ('13','Sadboy','Quần JOGGER PANTS','Chất liệu: Kaki, Form dáng: Oversized, rộng rãi','https://cf.shopee.vn/file/0b436002ee572694145b63d66f0ef34f','https://cf.shopee.vn/file/d105d25558cd26dd9d80a11ca115f892','https://cf.shopee.vn/file/51d66895be2f6afd0eea554ece5613fc',500000,23,1,'pants')
INSERT INTO "Product" VALUES ('14','Arhi','QUẦN CARGO FELT PANTS','Chất liệu: Kaki, Form dáng: Oversized, rộng rãi','https://cf.shopee.vn/file/sg-11134201-22110-91yxzinkiyjva2','https://cf.shopee.vn/file/sg-11134201-22110-ej3megnpiyjv15','https://cf.shopee.vn/file/sg-11134201-22110-g08i3hnpiyjv88',200000,14,0,'pants')
INSERT INTO "Product" VALUES ('15','Arhi','QUẦN TÂY ỐNG RỘNG TROUSERS PANTS','QUẦN TÂY ỐNG RỘNG TROUSERS PANTS, Chất liệu: Kaki, Form dáng: Oversized, rộng rãi','https://cf.shopee.vn/file/aa33d3887f05fe7a3434d9898daab70f','https://cf.shopee.vn/file/7dac7f23cce7844fbb74d9c07b948568','https://cf.shopee.vn/file/7dac7f23cce7844fbb74d9c07b948568',250000,15,0,'pants')
-- t-shirt
INSERT INTO "Product" VALUES ('16','Sadboy','Áo thun SADBOIZ Signature Black','bst signature là bst đầu tiên đánh dấu sự ra mắt của icon sabo - đặc điểm nhận diện của sadboizaintcry, đánh dấu cho một bước tiến mới trên con đường xây dựng thương hiệu chuyên nghiệp.','https://cf.shopee.vn/file/19d393a0aedf782c549e04c24c1091a0','https://cf.shopee.vn/file/6f9d24b5ea5fc7066198412a339c57cf','https://cf.shopee.vn/file/c1646e373a5e0055f80b5591475fbd8f',150000,11,1,'t-shirt')
INSERT INTO "Product" VALUES ('17','4Men','Áo thun tay lỡ D.tshirt',' Chất liệu: Cotton 100% dày dặn, mềm, co giãn, Đường may được gia công tỉ mỉ, chắc chắn.','https://cf.shopee.vn/file/ce7a030787010dd7419a591da48baa61','https://cf.shopee.vn/file/d6b385c7f1ba30910693a23c3c50593f','https://cf.shopee.vn/file/6d496894bbb4f5dbff54db946ffafc9d',200000,12,1,'t-shirt')
INSERT INTO "Product" VALUES ('18','Top4man','Áo T-Shirt thêu logo xanh','Logo được thêu sắc nét trên ngực trái và đặc biệt phần tay áo có cũng có thêu nổi Logo và dòng chữ Team Châu Phi cùng màu áo như một cách để nhận diện thương hiệu của nhóm.','https://cf.shopee.vn/file/sg-11134201-22120-01ei7tlfhwkv81','https://cf.shopee.vn/file/25bc49d5fb16ae13d445d077db310e9b','https://cf.shopee.vn/file/51b15bef82f37e95f4d0674299429e37',150000,13,1,'t-shirt')
INSERT INTO "Product" VALUES ('19','Eva de Eva','Áo Thun Nữ Form Rộng 2s','Chất liệu: Vải Cotton 65%, Form áo: OVERSIZE form rộng chuẩn TAY LỠ UNISEX cực đẹp.','https://cf.shopee.vn/file/8674a2908d776e85b55fbba60627153a','https://cf.shopee.vn/file/sg-11134201-22100-9yenfk5fkkiv58','https://cf.shopee.vn/file/5270553b7391e0f67c4df4e03547539a',150000,14,0,'t-shirt')
INSERT INTO "Product" VALUES ('20','Sadboy','Áo thun SADBOIZ Dreamy Butterfly White','từ lúc thành lập thương hiệu, sadboiz luôn hướng tới những sản phẩm đem lại sự thoải mái và chất lượng khi mặc đi chơi, đi học hay các hoạt động hằng ngày.','https://cf.shopee.vn/file/2ba2ee463ee495f5c05953766dce9264','https://cf.shopee.vn/file/e8ab49b03729a15c9ea03d9b562577c9','https://cf.shopee.vn/file/3c2a43810a893955407b07e2f3b3bb34',150000,15,0,'t-shirt')
--shoes
INSERT INTO "Product" VALUES ('21','4Men','chelsea boot','Giày tây nam chelsea boot từ da bò tấm cao cấp độn đế tăng chiều cao Chelsea boot nam 4Men kiểu giày công sở đứng font','https://cf.shopee.vn/file/sg-11134201-22110-n925r64prfjv01','https://cf.shopee.vn/file/sg-11134201-22110-8vtdulcprfjv0e','https://cf.shopee.vn/file/sg-11134201-22110-rn97ykbqrfjv23',400000,11,1,'shoes')
INSERT INTO "Product" VALUES ('22','Top4man','combat boot','Giày da nam Top4man combat boot nam cổ lửng buộc dây đế chunky khâu chắc chắn, Boot cao cổ độn đế tăng chiều cao bằng cao su','https://cf.shopee.vn/file/e5640c4ea9096723aaf78a0d51760d78','https://cf.shopee.vn/file/8a4f2496d436751bf4fc76472a61c098','https://cf.shopee.vn/file/e961f083a8919b22ffc49849a59d1877',700000,6,1,'shoes')
INSERT INTO "Product" VALUES ('23','Elise','Giày cao gót nữ Lovie','Nếu bạn đi không vừa size, La Muse hỗ trợ đổi size nhưng không hỗ trợ phí ship, nếu hàng lỗi do nhà sản xuất, ','https://cf.shopee.vn/file/1f4464240cfe347be456d5ca4cb0b796','https://cf.shopee.vn/file/67ec86182fc77ba7ecdcde88a5e1a61c','https://cf.shopee.vn/file/d07658a74e40cdec88f6ada1bc5e60a6',200000,7,0,'shoes')
INSERT INTO "Product" VALUES ('24','Elise','Giày quai hậu nữ','Tránh mang sản phẩm khi trời mưa, không ngâm sản phẩm trong nước quá lâu. Không giặt tẩy bằng các chất tẩy rửa mạnh','https://cf.shopee.vn/file/23386d57b2ae38931fc361becb51e926','https://cf.shopee.vn/file/fe5d68c792fbf2bc14e5d876696cf57d','https://cf.shopee.vn/file/f64c15817a7e06090e03bafaeca5409a',300000,9,0,'shoes')
INSERT INTO "Product" VALUES ('25','Eva de Eva',' Boots nhăn nữ','Màu sắc: 2 màu đen và kem. Size: đủ size 35 đến 39','https://cf.shopee.vn/file/ffc8e8aacfed1dcfed217510eacc2b88','https://cf.shopee.vn/file/2316c69f4d7a22c21922a9edcab4320e','https://cf.shopee.vn/file/887833c01d27352a9c3b73f512f270cc',250000,5,0,'shoes')


INSERT INTO "Order" VALUES ('01','05','2022-11-04 04:10:36','COD','255 Phạm Ngũ Lão Quân 1',1,1500000);
INSERT INTO "Order" VALUES ('02','06','2022-12-04 14:10:36','COD','243 Lý Thường Kiệt Quận 10',1,500000);
INSERT INTO "Order" VALUES ('03','07','2022-09-24 00:10:36','COD','444 Phan Chu Trinh Quân Bình Thạnh',1,1500000);
INSERT INTO "Order" VALUES ('04','08','2022-09-15 00:10:32','COD','KTX Khu A Dĩ An Bình Dương',1,1500000);
INSERT INTO "Order" VALUES ('05','09','2022-09-24 00:00:00','COD','KTX Khu B Dĩ An Bình Dương',1,1500000);
INSERT INTO "Order" VALUES ('06','10','2022-09-24 00:00:00','COD','KTX Khu B Dĩ An Bình Dương',1,1500000);

INSERT INTO "OrderDetail" VALUES ('01','01',2,500000)
INSERT INTO "OrderDetail" VALUES ('01','02',5,1000000)
INSERT INTO "OrderDetail" VALUES ('02','06',1,250000)
INSERT INTO "OrderDetail" VALUES ('02','15',1,250000)

INSERT INTO "OrderDetail" VALUES ('03','11',1,550000)
INSERT INTO "OrderDetail" VALUES ('03','12',1,450000)
INSERT INTO "OrderDetail" VALUES ('03','13',1,500000)

INSERT INTO "OrderDetail" VALUES ('04','11',1,550000)
INSERT INTO "OrderDetail" VALUES ('04','12',1,450000)
INSERT INTO "OrderDetail" VALUES ('04','13',1,500000)

INSERT INTO "OrderDetail" VALUES ('05','11',1,550000)
INSERT INTO "OrderDetail" VALUES ('05','12',1,450000)
INSERT INTO "OrderDetail" VALUES ('05','13',1,500000)

INSERT INTO "OrderDetail" VALUES ('06','11',1,550000)
INSERT INTO "OrderDetail" VALUES ('06','12',1,450000)
INSERT INTO "OrderDetail" VALUES ('06','13',1,500000)
--