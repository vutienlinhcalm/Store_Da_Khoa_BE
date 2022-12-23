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

--skirts
INSERT INTO "Product" VALUES ('01','Adidas','UNDERCOOL Tenis','UNDERCOOL Tenis Tennis Skirt 100% Cotton, Imported, Button closure, Regular fit through the chest for a relaxed, unrestricted fit with a printed neck label to maximize comfort','https://m.media-amazon.com/images/I/61B4GgfKuJL._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/71KlsVhQMLL._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/61nFkDvEsdL._AC_UL1500_.jpg',250,12,0,'skirts')
INSERT INTO "Product" VALUES ('02','Eva de Eva','skirt Vintage','Vintage Ulzzang Zinti 100% Cotton, Imported, Button closure, Regular fit through the chest for a relaxed, unrestricted fit with a printed neck label to maximize comfort','https://cf.shopee.vn/file/a7e2304babc7b574d62fed84172cc605','https://cf.shopee.vn/file/57cbe3b53b7d301bcf4d7347b5da3577','https://cf.shopee.vn/file/d092ce55fab49170e16ed283b8625ba8',200,22,0,'skirts')
INSERT INTO "Product" VALUES ('03','Eva de Eva','skirt midi Lolliemade','midiLolliemade 100% Cotton, Imported, Button closure, Regular fit through the chest for a relaxed, unrestricted fit with a printed neck label to maximize comfort','https://cf.shopee.vn/file/sg-11134201-22120-rbjgpv2y6alvfd','https://cf.shopee.vn/file/sg-11134201-22120-fc3q39pde0kvd4','https://cf.shopee.vn/file/sg-11134201-22120-z6b5zkmde0kvad',225,15,0,'skirts')
INSERT INTO "Product" VALUES ('04','Elise','skirt Ulzzang','Ulzzang 100% Cotton, Imported, Button closure, Regular fit through the chest for a relaxed, unrestricted fit with a printed neck label to maximize comfort','https://cf.shopee.vn/file/8fef2392897f82002388802e92fa8139','https://cf.shopee.vn/file/95b1cea4964d81116524005befc78886','https://cf.shopee.vn/file/7cce11948451cff75a66bd2608241299',175,14,0,'skirts')
INSERT INTO "Product" VALUES ('05','Elise','Kelly Skirt','Kelly Skirt 100% Cotton, Imported, Button closure, Regular fit through the chest for a relaxed, unrestricted fit with a printed neck label to maximize comfort','https://cf.shopee.vn/file/sg-11134201-22110-q49x1h5b4tjvcd','https://cf.shopee.vn/file/2da481fb4ed84e9e1beda34840e2c4b1','https://cf.shopee.vn/file/sg-11134201-22110-imrruiclixjvc5',300,21,0,'skirts')
INSERT INTO "Product" VALUES ('06','Deliciae','Elly Skirt','Tafta, 100% designed by Deliciae, outfit for luxury party, cafe, important dinner, dating,...','https://cf.shopee.vn/file/689687536e9c4cbefa7414a2808830f9','https://cf.shopee.vn/file/2da481fb4ed84e9e1beda34840e2c4b1','https://cf.shopee.vn/file/2da481fb4ed84e9e1beda34840e2c4b1',500,20,0,'skirts')
INSERT INTO "Product" VALUES ('07','Sissy Nation','Alice','Flower Silk, Imported, Button closure, Cottage core outfit','https://cf.shopee.vn/file/sg-11134201-22120-o4ct8uwsylkv91','https://cf.shopee.vn/file/sg-11134201-22120-o4ct8uwsylkv91','https://cf.shopee.vn/file/sg-11134201-22120-o4ct8uwsylkv91',1690,2,0,'skirts')
INSERT INTO "Product" VALUES ('08','Local','Short skirt','Vintage short tennis skirt','https://cf.shopee.vn/file/15d617b8570d33fb79f6175ce1e187ec','https://cf.shopee.vn/file/1b723da665c047cffbe568c7f048963d','https://cf.shopee.vn/file/1b723da665c047cffbe568c7f048963d',55,100,0,'skirts')
INSERT INTO "Product" VALUES ('09','comecloud','jeans skirt','100% jeans, maximize comfort','https://cf.shopee.vn/file/388b62be6e20e92c8f2504c5446aa300','https://cf.shopee.vn/file/388b62be6e20e92c8f2504c5446aa300','https://cf.shopee.vn/file/31f8edbfb9555121cf2622ca52dc67f5',130,15,0,'skirts')
INSERT INTO "Product" VALUES ('10','BeautebyV','A shape skirt','100% Cotton, office skirt, student skirt','https://cf.shopee.vn/file/288e82afe5f46415c95aa1250a85ba97','https://cf.shopee.vn/file/288e82afe5f46415c95aa1250a85ba97','https://cf.shopee.vn/file/288e82afe5f46415c95aa1250a85ba97',175,14,0,'skirts')

INSERT INTO "Product" VALUES ('11','Cosmetic01vn','Short cute Skirt','100% Cotton, Regular fit, maximize comfort','https://cf.shopee.vn/file/be8f08e5563e382b5b171256e6f6a923','https://cf.shopee.vn/file/be8f08e5563e382b5b171256e6f6a923','https://cf.shopee.vn/file/be8f08e5563e382b5b171256e6f6a923',230,55,0,'skirts')
INSERT INTO "Product" VALUES ('12','Hoang Yen Workshop','Ballerina Wrap Skirt','Satin silk, outfit for luxury party, cafe, important diiner, dating,...','https://cf.shopee.vn/file/sg-11134201-22110-etjpi32whkjvb2','https://cf.shopee.vn/file/sg-11134201-22110-jhetkmlthkjvc1','https://cf.shopee.vn/file/sg-11134201-22110-jhetkmlthkjvc1',200,20,0,'skirts')
INSERT INTO "Product" VALUES ('13','Cocoland','Midi skirt','100% designed by Cocoland, cafe, dating,...','https://cf.shopee.vn/file/178a0ac9d7e710301c40619052e2a554','https://cf.shopee.vn/file/178a0ac9d7e710301c40619052e2a554','https://cf.shopee.vn/file/178a0ac9d7e710301c40619052e2a554',79,80,0,'skirts')
INSERT INTO "Product" VALUES ('14','Joie des roses','Tweed skirt','Luxury tweed skirt for year end','https://cf.shopee.vn/file/54cdcbb0e625ef29afca5664bbe5ad13','https://cf.shopee.vn/file/54cdcbb0e625ef29afca5664bbe5ad13','https://cf.shopee.vn/file/54cdcbb0e625ef29afca5664bbe5ad13',510,10,0,'skirts')
INSERT INTO "Product" VALUES ('15','Adidas','UNDERCOOL Tenis','UNDERCOOL Tenis Tennis Skirt 100% Cotton, Imported, Button closure, Regular fit through the chest for a relaxed, unrestricted fit with a printed neck label to maximize comfort','https://m.media-amazon.com/images/I/61B4GgfKuJL._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/71KlsVhQMLL._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/61nFkDvEsdL._AC_UL1500_.jpg',250,12,0,'skirts')
INSERT INTO "Product" VALUES ('16','LisHouCaivn','Long skirt uzzlang','Dark wind irregular skirt trousers lotus leaf edge splicing half-body skirt woman medium-long style high waist show thin A word 2021 new style','https://cf.shopee.vn/file/1aab643f3c8becee02896f0fa740dcff','https://cf.shopee.vn/file/1aab643f3c8becee02896f0fa740dcff','https://cf.shopee.vn/file/1aab643f3c8becee02896f0fa740dcff',170,40,0,'skirts')
INSERT INTO "Product" VALUES ('17','Eva de Eva','skirt midi Lolliemade','midiLolliemade 100% Cotton, Imported, Button closure, Regular fit through the chest for a relaxed, unrestricted fit with a printed neck label to maximize comfort','https://cf.shopee.vn/file/sg-11134201-22120-rbjgpv2y6alvfd','https://cf.shopee.vn/file/sg-11134201-22120-fc3q39pde0kvd4','https://cf.shopee.vn/file/sg-11134201-22120-z6b5zkmde0kvad',225,15,0,'skirts')
INSERT INTO "Product" VALUES ('18','Elise','skirt Ulzzang','Ulzzang 100% Cotton, Imported, Button closure, Regular fit through the chest for a relaxed, unrestricted fit with a printed neck label to maximize comfort','https://cf.shopee.vn/file/8fef2392897f82002388802e92fa8139','https://cf.shopee.vn/file/95b1cea4964d81116524005befc78886','https://cf.shopee.vn/file/7cce11948451cff75a66bd2608241299',175,14,0,'skirts')
INSERT INTO "Product" VALUES ('19','Elise','Kelly Skirt','Kelly Skirt 100% Cotton, Imported, Button closure, Regular fit through the chest for a relaxed, unrestricted fit with a printed neck label to maximize comfort','https://cf.shopee.vn/file/sg-11134201-22110-q49x1h5b4tjvcd','https://cf.shopee.vn/file/2da481fb4ed84e9e1beda34840e2c4b1','https://cf.shopee.vn/file/sg-11134201-22110-imrruiclixjvc5',300,21,0,'skirts')
INSERT INTO "Product" VALUES ('20','Deliciae','Elly Skirt','Tafta, 100% designed by Deliciae, outfit for luxury party, cafe, important dinner, dating,...','https://cf.shopee.vn/file/689687536e9c4cbefa7414a2808830f9','https://cf.shopee.vn/file/2da481fb4ed84e9e1beda34840e2c4b1','https://cf.shopee.vn/file/2da481fb4ed84e9e1beda34840e2c4b1',500,20,0,'skirts')

INSERT INTO "Product" VALUES ('21','Sissy Nation','Alice','Flower Silk, Imported, Button closure, Cottage core outfit','https://cf.shopee.vn/file/sg-11134201-22120-o4ct8uwsylkv91','https://cf.shopee.vn/file/sg-11134201-22120-o4ct8uwsylkv91','https://cf.shopee.vn/file/sg-11134201-22120-o4ct8uwsylkv91',1690,2,0,'skirts')
INSERT INTO "Product" VALUES ('22','Local','Short skirt','Vintage short tennis skirt','https://cf.shopee.vn/file/15d617b8570d33fb79f6175ce1e187ec','https://cf.shopee.vn/file/1b723da665c047cffbe568c7f048963d','https://cf.shopee.vn/file/1b723da665c047cffbe568c7f048963d',55,100,0,'skirts')
INSERT INTO "Product" VALUES ('23','comecloud','jeans skirt','100% jeans, maximize comfort','https://cf.shopee.vn/file/388b62be6e20e92c8f2504c5446aa300','https://cf.shopee.vn/file/388b62be6e20e92c8f2504c5446aa300','https://cf.shopee.vn/file/31f8edbfb9555121cf2622ca52dc67f5',130,15,0,'skirts')
INSERT INTO "Product" VALUES ('24','BeautebyV','A shape skirt','100% Cotton, office skirt, student skirt','https://cf.shopee.vn/file/288e82afe5f46415c95aa1250a85ba97','https://cf.shopee.vn/file/288e82afe5f46415c95aa1250a85ba97','https://cf.shopee.vn/file/288e82afe5f46415c95aa1250a85ba97',175,14,0,'skirts')
INSERT INTO "Product" VALUES ('25','Cosmetic01vn','Short cute Skirt','100% Cotton, Regular fit, maximize comfort','https://cf.shopee.vn/file/be8f08e5563e382b5b171256e6f6a923','https://cf.shopee.vn/file/be8f08e5563e382b5b171256e6f6a923','https://cf.shopee.vn/file/be8f08e5563e382b5b171256e6f6a923',230,55,0,'skirts')
INSERT INTO "Product" VALUES ('26','Hoang Yen Workshop','Ballerina Wrap Skirt','Satin silk, outfit for luxury party, cafe, important diiner, dating,...','https://cf.shopee.vn/file/sg-11134201-22110-etjpi32whkjvb2','https://cf.shopee.vn/file/sg-11134201-22110-jhetkmlthkjvc1','https://cf.shopee.vn/file/sg-11134201-22110-jhetkmlthkjvc1',200,20,0,'skirts')
INSERT INTO "Product" VALUES ('27','Cocoland','Midi skirt','100% designed by Cocoland, cafe, dating,...','https://cf.shopee.vn/file/178a0ac9d7e710301c40619052e2a554','https://cf.shopee.vn/file/178a0ac9d7e710301c40619052e2a554','https://cf.shopee.vn/file/178a0ac9d7e710301c40619052e2a554',79,80,0,'skirts')
INSERT INTO "Product" VALUES ('28','Joie des roses','Tweed skirt','Luxury tweed skirt for year end','https://cf.shopee.vn/file/54cdcbb0e625ef29afca5664bbe5ad13','https://cf.shopee.vn/file/54cdcbb0e625ef29afca5664bbe5ad13','https://cf.shopee.vn/file/54cdcbb0e625ef29afca5664bbe5ad13',510,10,0,'skirts')

-- tops
INSERT INTO "Product" VALUES ('29','Adidas','Essentials Men Regular-Fit Cotton Pique Polo Shirt','100% Cotton, Imported, Button closure, Regular fit through the chest for a relaxed, unrestricted fit with a printed neck label to maximize comfort','https://m.media-amazon.com/images/I/81wq4EAzEfL._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/91HDxf89jlL._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/91+8Js6mHdL._AC_UL1500_.jpg',250,11,1,'tops')
INSERT INTO "Product" VALUES ('30','4Men','Mazify','65% Polyester, 35% Cotton, SO SOFT - Midweight pique fabric feels super-soft up against your skin.','https://cf.shopee.vn/file/d03650ea4d31a1e30ec822d00d0210f3','https://cf.shopee.vn/file/50c3d54fcc613cbca48979f7a70ccc26','https://cf.shopee.vn/file/d492f7b22c618cd8fb32a3fcb9f624dd',300,12,1,'tops')
INSERT INTO "Product" VALUES ('31','Top4man','soccer Argentina','65% Polyester, 35% Cotton, SO SOFT - Midweight pique fabric feels super-soft up against your skin.','https://cf.shopee.vn/file/sg-11134201-22120-dz30sw5vy5kv71','https://cf.shopee.vn/file/sg-11134201-22120-pgg6j07tk4kvc7','https://cf.shopee.vn/file/sg-11134201-22120-j8wunwvty5kvba',350,13,1,'tops')
INSERT INTO "Product" VALUES ('32','Top4man','RYAN COOL BABY','RYAN 65% Polyester, 35% Cotton, SO SOFT - Midweight pique fabric feels super-soft up against your skin.','https://cf.shopee.vn/file/595a61e0b46d45f8f836ad603c90474c','https://cf.shopee.vn/file/679fb99bb82b6d05b7a535eb630c77c5','https://cf.shopee.vn/file/f05ccc9503022fdf42cc679712fb2275',200,14,1,'tops')
INSERT INTO "Product" VALUES ('33','Elise','VEST CRTOP','65% Polyester, 35% Cotton, SO SOFT - Midweight pique fabric feels super-soft up against your skin.','https://cf.shopee.vn/file/cab6b5fde0df8f289b728ca5d8be3d12','https://cf.shopee.vn/file/95324c92482a0e8729e5671453e29b5b','https://cf.shopee.vn/file/7699ddf98029e14a9224353b91d35a43',150,15,0,'tops')
INSERT INTO "Product" VALUES ('34','Local','Women cute croptop','100% Cotton, freesize, fit with a printed neck label to maximize comfort','https://cf.shopee.vn/file/58c8bbfb4d9e19f932c72bfcdf7c8c2c','https://cf.shopee.vn/file/58c8bbfb4d9e19f932c72bfcdf7c8c2c','https://cf.shopee.vn/file/58c8bbfb4d9e19f932c72bfcdf7c8c2c',50,100,0,'tops')
INSERT INTO "Product" VALUES ('35','4Woman','Triangle croptop','Body top cute for uzzlang girl','https://cf.shopee.vn/file/80400f14eaa80ffb198cdf17be3999b0','https://cf.shopee.vn/file/80400f14eaa80ffb198cdf17be3999b0','https://cf.shopee.vn/file/80400f14eaa80ffb198cdf17be3999b0',60,12,0,'tops')
INSERT INTO "Product" VALUES ('36','Regalaga','Autumn top','freesize croptop for girl','https://cf.shopee.vn/file/1283dceff7de8f35db562a20052bfbce','https://cf.shopee.vn/file/1283dceff7de8f35db562a20052bfbce','https://cf.shopee.vn/file/1283dceff7de8f35db562a20052bfbce',350,13,0,'tops')
INSERT INTO "Product" VALUES ('37','Leimo','White chinese top','linen croptop, body fit','https://cf.shopee.vn/file/34a4acf66f869ac3353544d536640f9e','https://cf.shopee.vn/file/34a4acf66f869ac3353544d536640f9e','https://cf.shopee.vn/file/34a4acf66f869ac3353544d536640f9e',100,14,0,'tops')
INSERT INTO "Product" VALUES ('38','Rockmore','Rock style top','100% Cotton, black cool top for rock fans','https://cf.shopee.vn/file/8543c567df74b08fac12a30f73e3c747','https://cf.shopee.vn/file/8543c567df74b08fac12a30f73e3c747','https://cf.shopee.vn/file/8543c567df74b08fac12a30f73e3c747',90,15,0,'tops')

INSERT INTO "Product" VALUES ('39','Adidas','Essentials Men Regular-Fit Cotton Pique Polo Shirt','100% Cotton, Imported, Button closure, Regular fit through the chest for a relaxed, unrestricted fit with a printed neck label to maximize comfort','https://m.media-amazon.com/images/I/81wq4EAzEfL._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/91HDxf89jlL._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/91+8Js6mHdL._AC_UL1500_.jpg',250,11,1,'tops')
INSERT INTO "Product" VALUES ('40','4Men','Mazify','65% Polyester, 35% Cotton, SO SOFT - Midweight pique fabric feels super-soft up against your skin.','https://cf.shopee.vn/file/d03650ea4d31a1e30ec822d00d0210f3','https://cf.shopee.vn/file/50c3d54fcc613cbca48979f7a70ccc26','https://cf.shopee.vn/file/d492f7b22c618cd8fb32a3fcb9f624dd',300,12,1,'tops')
INSERT INTO "Product" VALUES ('41','Top4man','soccer Argentina','65% Polyester, 35% Cotton, SO SOFT - Midweight pique fabric feels super-soft up against your skin.','https://cf.shopee.vn/file/sg-11134201-22120-dz30sw5vy5kv71','https://cf.shopee.vn/file/sg-11134201-22120-pgg6j07tk4kvc7','https://cf.shopee.vn/file/sg-11134201-22120-j8wunwvty5kvba',350,13,1,'tops')
INSERT INTO "Product" VALUES ('42','Top4man','RYAN COOL BABY','RYAN 65% Polyester, 35% Cotton, SO SOFT - Midweight pique fabric feels super-soft up against your skin.','https://cf.shopee.vn/file/595a61e0b46d45f8f836ad603c90474c','https://cf.shopee.vn/file/679fb99bb82b6d05b7a535eb630c77c5','https://cf.shopee.vn/file/f05ccc9503022fdf42cc679712fb2275',200,14,1,'tops')
INSERT INTO "Product" VALUES ('43','Elise','VEST CRTOP','65% Polyester, 35% Cotton, SO SOFT - Midweight pique fabric feels super-soft up against your skin.','https://cf.shopee.vn/file/cab6b5fde0df8f289b728ca5d8be3d12','https://cf.shopee.vn/file/95324c92482a0e8729e5671453e29b5b','https://cf.shopee.vn/file/7699ddf98029e14a9224353b91d35a43',150,15,0,'tops')
INSERT INTO "Product" VALUES ('44','Local','Women cute croptop','100% Cotton, freesize, fit with a printed neck label to maximize comfort','https://cf.shopee.vn/file/58c8bbfb4d9e19f932c72bfcdf7c8c2c','https://cf.shopee.vn/file/58c8bbfb4d9e19f932c72bfcdf7c8c2c','https://cf.shopee.vn/file/58c8bbfb4d9e19f932c72bfcdf7c8c2c',50,100,0,'tops')
INSERT INTO "Product" VALUES ('45','4Woman','Triangle croptop','Body top cute for uzzlang girl','https://cf.shopee.vn/file/80400f14eaa80ffb198cdf17be3999b0','https://cf.shopee.vn/file/80400f14eaa80ffb198cdf17be3999b0','https://cf.shopee.vn/file/80400f14eaa80ffb198cdf17be3999b0',60,12,0,'tops')
INSERT INTO "Product" VALUES ('46','Regalaga','Autumn top','freesize croptop for girl','https://cf.shopee.vn/file/1283dceff7de8f35db562a20052bfbce','https://cf.shopee.vn/file/1283dceff7de8f35db562a20052bfbce','https://cf.shopee.vn/file/1283dceff7de8f35db562a20052bfbce',350,13,0,'tops')
INSERT INTO "Product" VALUES ('47','Leimo','White chinese top','linen croptop, body fit','https://cf.shopee.vn/file/34a4acf66f869ac3353544d536640f9e','https://cf.shopee.vn/file/34a4acf66f869ac3353544d536640f9e','https://cf.shopee.vn/file/34a4acf66f869ac3353544d536640f9e',100,14,0,'tops')
INSERT INTO "Product" VALUES ('48','Rockmore','Rock style top','100% Cotton, black cool top for rock fans','https://cf.shopee.vn/file/8543c567df74b08fac12a30f73e3c747','https://cf.shopee.vn/file/8543c567df74b08fac12a30f73e3c747','https://cf.shopee.vn/file/8543c567df74b08fac12a30f73e3c747',90,15,0,'tops')

INSERT INTO "Product" VALUES ('49','Adidas','Essentials Men Regular-Fit Cotton Pique Polo Shirt','100% Cotton, Imported, Button closure, Regular fit through the chest for a relaxed, unrestricted fit with a printed neck label to maximize comfort','https://m.media-amazon.com/images/I/81wq4EAzEfL._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/91HDxf89jlL._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/91+8Js6mHdL._AC_UL1500_.jpg',250,11,1,'tops')
INSERT INTO "Product" VALUES ('50','4Men','Mazify','65% Polyester, 35% Cotton, SO SOFT - Midweight pique fabric feels super-soft up against your skin.','https://cf.shopee.vn/file/d03650ea4d31a1e30ec822d00d0210f3','https://cf.shopee.vn/file/50c3d54fcc613cbca48979f7a70ccc26','https://cf.shopee.vn/file/d492f7b22c618cd8fb32a3fcb9f624dd',300,12,1,'tops')
INSERT INTO "Product" VALUES ('51','Top4man','soccer Argentina','65% Polyester, 35% Cotton, SO SOFT - Midweight pique fabric feels super-soft up against your skin.','https://cf.shopee.vn/file/sg-11134201-22120-dz30sw5vy5kv71','https://cf.shopee.vn/file/sg-11134201-22120-pgg6j07tk4kvc7','https://cf.shopee.vn/file/sg-11134201-22120-j8wunwvty5kvba',350,13,1,'tops')
INSERT INTO "Product" VALUES ('52','Top4man','RYAN COOL BABY','RYAN 65% Polyester, 35% Cotton, SO SOFT - Midweight pique fabric feels super-soft up against your skin.','https://cf.shopee.vn/file/595a61e0b46d45f8f836ad603c90474c','https://cf.shopee.vn/file/679fb99bb82b6d05b7a535eb630c77c5','https://cf.shopee.vn/file/f05ccc9503022fdf42cc679712fb2275',200,14,1,'tops')
INSERT INTO "Product" VALUES ('53','Elise','VEST CRTOP','65% Polyester, 35% Cotton, SO SOFT - Midweight pique fabric feels super-soft up against your skin.','https://cf.shopee.vn/file/cab6b5fde0df8f289b728ca5d8be3d12','https://cf.shopee.vn/file/95324c92482a0e8729e5671453e29b5b','https://cf.shopee.vn/file/7699ddf98029e14a9224353b91d35a43',150,15,0,'tops')
INSERT INTO "Product" VALUES ('54','Local','Women cute croptop','100% Cotton, freesize, fit with a printed neck label to maximize comfort','https://cf.shopee.vn/file/58c8bbfb4d9e19f932c72bfcdf7c8c2c','https://cf.shopee.vn/file/58c8bbfb4d9e19f932c72bfcdf7c8c2c','https://cf.shopee.vn/file/58c8bbfb4d9e19f932c72bfcdf7c8c2c',50,100,0,'tops')
INSERT INTO "Product" VALUES ('55','4Woman','Triangle croptop','Body top cute for uzzlang girl','https://cf.shopee.vn/file/80400f14eaa80ffb198cdf17be3999b0','https://cf.shopee.vn/file/80400f14eaa80ffb198cdf17be3999b0','https://cf.shopee.vn/file/80400f14eaa80ffb198cdf17be3999b0',60,12,0,'tops')
INSERT INTO "Product" VALUES ('56','Regalaga','Autumn top','freesize croptop for girl','https://cf.shopee.vn/file/1283dceff7de8f35db562a20052bfbce','https://cf.shopee.vn/file/1283dceff7de8f35db562a20052bfbce','https://cf.shopee.vn/file/1283dceff7de8f35db562a20052bfbce',350,13,0,'tops')

-- pants
INSERT INTO "Product" VALUES ('57','Sadboy','Slim-Fit Wrinkle-Resistant Flat-Front Chino Pant','60% Cotton, 40% Polyester, This slim-fit chino pant features wrinkle-free fabric, a flat-front design, and button-through back welt pockets for a tailored look and all-day comfort','https://m.media-amazon.com/images/I/71TOtMq54ML._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/71ryIbNmh6L._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/71yUUkSSPvL._AC_UL1500_.jpg',550,21,1,'pants')
INSERT INTO "Product" VALUES ('58','Sadboy','Triple Button Cargo Pants','60% Cotton, 40% Polyester, This slim-fit chino pant features wrinkle-free fabric, a flat-front design, and button-through back welt pockets for a tailored look and all-day comfort','https://cf.shopee.vn/file/1a48b7b27b1dd9c7650c0278c08ed724','https://cf.shopee.vn/file/449de264ecc09d80ae65be66b64b3968','https://cf.shopee.vn/file/8414d5482214b1e49868663ff873345a',450,22,1,'pants')
INSERT INTO "Product" VALUES ('59','Sadboy','JOGGER PANTS','60% Cotton, 40% Polyester, This slim-fit chino pant features wrinkle-free fabric, a flat-front design, and button-through back welt pockets for a tailored look and all-day comfort','https://cf.shopee.vn/file/0b436002ee572694145b63d66f0ef34f','https://cf.shopee.vn/file/d105d25558cd26dd9d80a11ca115f892','https://cf.shopee.vn/file/51d66895be2f6afd0eea554ece5613fc',500,23,1,'pants')
INSERT INTO "Product" VALUES ('60','Arhi','CARGO FELT PANTS','60% Cotton, 40% Polyester, This slim-fit chino pant features wrinkle-free fabric, a flat-front design, and button-through back welt pockets for a tailored look and all-day comfort','https://cf.shopee.vn/file/sg-11134201-22110-91yxzinkiyjva2','https://cf.shopee.vn/file/sg-11134201-22110-ej3megnpiyjv15','https://cf.shopee.vn/file/sg-11134201-22110-g08i3hnpiyjv88',200,14,0,'pants')
INSERT INTO "Product" VALUES ('61','Arhi','TROUSERS PANTS','60% Cotton, 40% Polyester, This slim-fit chino pant features wrinkle-free fabric, a flat-front design, and button-through back welt pockets for a tailored look and all-day comfort','https://cf.shopee.vn/file/aa33d3887f05fe7a3434d9898daab70f','https://cf.shopee.vn/file/7dac7f23cce7844fbb74d9c07b948568','https://cf.shopee.vn/file/7dac7f23cce7844fbb74d9c07b948568',250,15,0,'pants')
INSERT INTO "Product" VALUES ('62','Gonz Brand','Slim-Fit Wrinkle-Resistant Flat-Front Chino Pant','60% Cotton, 40% Polyester, This slim-fit chino pant features wrinkle-free fabric, a flat-front design, and button-through back welt pockets for a tailored look and all-day comfort','https://cf.shopee.vn/file/18c942289e18768ab02428cf65a4b240','https://cf.shopee.vn/file/18c942289e18768ab02428cf65a4b240','https://cf.shopee.vn/file/18c942289e18768ab02428cf65a4b240',175,35,1,'pants')
INSERT INTO "Product" VALUES ('63','The Maze if we kiss','Washed skinny','slim-fit for gentleman','https://cf.shopee.vn/file/a8c43721fbb0f77c3545d7f0898abfe1','https://cf.shopee.vn/file/a8c43721fbb0f77c3545d7f0898abfe1','https://cf.shopee.vn/file/a8c43721fbb0f77c3545d7f0898abfe1',400,62,1,'pants')
INSERT INTO "Product" VALUES ('64','YobaShop','Long skinny jeans','skinny jeans for energetic days','https://cf.shopee.vn/file/2de33dca08976c9d2b275a609a633f28','https://cf.shopee.vn/file/2de33dca08976c9d2b275a609a633f28','https://cf.shopee.vn/file/2de33dca08976c9d2b275a609a633f28',380,20,1,'pants')
INSERT INTO "Product" VALUES ('65','Local','CARGO FELT PANTS','60% Cotton, 40% Polyester, This slim-fit chino pant features wrinkle-free fabric, a flat-front design, and button-through back welt pockets for a tailored look and all-day comfort','https://cf.shopee.vn/file/6fed74857715ecf8184361ff9217bcc5','https://cf.shopee.vn/file/6fed74857715ecf8184361ff9217bcc5','https://cf.shopee.vn/file/6fed74857715ecf8184361ff9217bcc5',170,14,1,'pants')
INSERT INTO "Product" VALUES ('66','Arhi','TROUSERS PANTS','60% Cotton, 40% Polyester, This slim-fit chino pant features wrinkle-free fabric, a flat-front design, and button-through back welt pockets for a tailored look and all-day comfort','https://cf.shopee.vn/file/aa33d3887f05fe7a3434d9898daab70f','https://cf.shopee.vn/file/7dac7f23cce7844fbb74d9c07b948568','https://cf.shopee.vn/file/7dac7f23cce7844fbb74d9c07b948568',250,15,0,'pants')
INSERT INTO "Product" VALUES ('67','Luxury','Skinny jeanse','40% Polyester, 40% jeans, worldwide best seller','https://cf.shopee.vn/file/e1c41901c576cacb050d619b913b55e5','https://cf.shopee.vn/file/e1c41901c576cacb050d619b913b55e5','https://cf.shopee.vn/file/e1c41901c576cacb050d619b913b55e5',160,70,1,'pants')

INSERT INTO "Product" VALUES ('68','Sadboy','Slim-Fit Wrinkle-Resistant Flat-Front Chino Pant','60% Cotton, 40% Polyester, This slim-fit chino pant features wrinkle-free fabric, a flat-front design, and button-through back welt pockets for a tailored look and all-day comfort','https://m.media-amazon.com/images/I/71TOtMq54ML._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/71ryIbNmh6L._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/71yUUkSSPvL._AC_UL1500_.jpg',550,21,1,'pants')
INSERT INTO "Product" VALUES ('69','Sadboy','Triple Button Cargo Pants','60% Cotton, 40% Polyester, This slim-fit chino pant features wrinkle-free fabric, a flat-front design, and button-through back welt pockets for a tailored look and all-day comfort','https://cf.shopee.vn/file/1a48b7b27b1dd9c7650c0278c08ed724','https://cf.shopee.vn/file/449de264ecc09d80ae65be66b64b3968','https://cf.shopee.vn/file/8414d5482214b1e49868663ff873345a',450,22,1,'pants')
INSERT INTO "Product" VALUES ('70','Sadboy','JOGGER PANTS','60% Cotton, 40% Polyester, This slim-fit chino pant features wrinkle-free fabric, a flat-front design, and button-through back welt pockets for a tailored look and all-day comfort','https://cf.shopee.vn/file/0b436002ee572694145b63d66f0ef34f','https://cf.shopee.vn/file/d105d25558cd26dd9d80a11ca115f892','https://cf.shopee.vn/file/51d66895be2f6afd0eea554ece5613fc',500,23,1,'pants')
INSERT INTO "Product" VALUES ('71','Arhi','CARGO FELT PANTS','60% Cotton, 40% Polyester, This slim-fit chino pant features wrinkle-free fabric, a flat-front design, and button-through back welt pockets for a tailored look and all-day comfort','https://cf.shopee.vn/file/sg-11134201-22110-91yxzinkiyjva2','https://cf.shopee.vn/file/sg-11134201-22110-ej3megnpiyjv15','https://cf.shopee.vn/file/sg-11134201-22110-g08i3hnpiyjv88',200,14,0,'pants')
INSERT INTO "Product" VALUES ('72','Arhi','TROUSERS PANTS','60% Cotton, 40% Polyester, This slim-fit chino pant features wrinkle-free fabric, a flat-front design, and button-through back welt pockets for a tailored look and all-day comfort','https://cf.shopee.vn/file/aa33d3887f05fe7a3434d9898daab70f','https://cf.shopee.vn/file/7dac7f23cce7844fbb74d9c07b948568','https://cf.shopee.vn/file/7dac7f23cce7844fbb74d9c07b948568',250,15,0,'pants')
INSERT INTO "Product" VALUES ('73','Gonz Brand','Slim-Fit Wrinkle-Resistant Flat-Front Chino Pant','60% Cotton, 40% Polyester, This slim-fit chino pant features wrinkle-free fabric, a flat-front design, and button-through back welt pockets for a tailored look and all-day comfort','https://cf.shopee.vn/file/18c942289e18768ab02428cf65a4b240','https://cf.shopee.vn/file/18c942289e18768ab02428cf65a4b240','https://cf.shopee.vn/file/18c942289e18768ab02428cf65a4b240',175,35,1,'pants')
INSERT INTO "Product" VALUES ('74','The Maze if we kiss','Washed skinny','slim-fit for gentleman','https://cf.shopee.vn/file/a8c43721fbb0f77c3545d7f0898abfe1','https://cf.shopee.vn/file/a8c43721fbb0f77c3545d7f0898abfe1','https://cf.shopee.vn/file/a8c43721fbb0f77c3545d7f0898abfe1',400,62,1,'pants')
INSERT INTO "Product" VALUES ('75','YobaShop','Long skinny jeans','skinny jeans for energetic days','https://cf.shopee.vn/file/2de33dca08976c9d2b275a609a633f28','https://cf.shopee.vn/file/2de33dca08976c9d2b275a609a633f28','https://cf.shopee.vn/file/2de33dca08976c9d2b275a609a633f28',380,20,1,'pants')
INSERT INTO "Product" VALUES ('76','Local','CARGO FELT PANTS','60% Cotton, 40% Polyester, This slim-fit chino pant features wrinkle-free fabric, a flat-front design, and button-through back welt pockets for a tailored look and all-day comfort','https://cf.shopee.vn/file/6fed74857715ecf8184361ff9217bcc5','https://cf.shopee.vn/file/6fed74857715ecf8184361ff9217bcc5','https://cf.shopee.vn/file/6fed74857715ecf8184361ff9217bcc5',170,14,1,'pants')
INSERT INTO "Product" VALUES ('77','Arhi','TROUSERS PANTS','60% Cotton, 40% Polyester, This slim-fit chino pant features wrinkle-free fabric, a flat-front design, and button-through back welt pockets for a tailored look and all-day comfort','https://cf.shopee.vn/file/aa33d3887f05fe7a3434d9898daab70f','https://cf.shopee.vn/file/7dac7f23cce7844fbb74d9c07b948568','https://cf.shopee.vn/file/7dac7f23cce7844fbb74d9c07b948568',250,15,0,'pants')
INSERT INTO "Product" VALUES ('78','Luxury','Skinny jeanse','40% Polyester, 40% jeans, worldwide best seller','https://cf.shopee.vn/file/e1c41901c576cacb050d619b913b55e5','https://cf.shopee.vn/file/e1c41901c576cacb050d619b913b55e5','https://cf.shopee.vn/file/e1c41901c576cacb050d619b913b55e5',160,70,1,'pants')

INSERT INTO "Product" VALUES ('79','Sadboy','Slim-Fit Wrinkle-Resistant Flat-Front Chino Pant','60% Cotton, 40% Polyester, This slim-fit chino pant features wrinkle-free fabric, a flat-front design, and button-through back welt pockets for a tailored look and all-day comfort','https://m.media-amazon.com/images/I/71TOtMq54ML._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/71ryIbNmh6L._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/71yUUkSSPvL._AC_UL1500_.jpg',550,21,1,'pants')
INSERT INTO "Product" VALUES ('80','Sadboy','Triple Button Cargo Pants','60% Cotton, 40% Polyester, This slim-fit chino pant features wrinkle-free fabric, a flat-front design, and button-through back welt pockets for a tailored look and all-day comfort','https://cf.shopee.vn/file/1a48b7b27b1dd9c7650c0278c08ed724','https://cf.shopee.vn/file/449de264ecc09d80ae65be66b64b3968','https://cf.shopee.vn/file/8414d5482214b1e49868663ff873345a',450,22,1,'pants')
INSERT INTO "Product" VALUES ('81','Sadboy','JOGGER PANTS','60% Cotton, 40% Polyester, This slim-fit chino pant features wrinkle-free fabric, a flat-front design, and button-through back welt pockets for a tailored look and all-day comfort','https://cf.shopee.vn/file/0b436002ee572694145b63d66f0ef34f','https://cf.shopee.vn/file/d105d25558cd26dd9d80a11ca115f892','https://cf.shopee.vn/file/51d66895be2f6afd0eea554ece5613fc',500,23,1,'pants')
INSERT INTO "Product" VALUES ('82','Arhi','CARGO FELT PANTS','60% Cotton, 40% Polyester, This slim-fit chino pant features wrinkle-free fabric, a flat-front design, and button-through back welt pockets for a tailored look and all-day comfort','https://cf.shopee.vn/file/sg-11134201-22110-91yxzinkiyjva2','https://cf.shopee.vn/file/sg-11134201-22110-ej3megnpiyjv15','https://cf.shopee.vn/file/sg-11134201-22110-g08i3hnpiyjv88',200,14,0,'pants')
INSERT INTO "Product" VALUES ('83','Arhi','TROUSERS PANTS','60% Cotton, 40% Polyester, This slim-fit chino pant features wrinkle-free fabric, a flat-front design, and button-through back welt pockets for a tailored look and all-day comfort','https://cf.shopee.vn/file/aa33d3887f05fe7a3434d9898daab70f','https://cf.shopee.vn/file/7dac7f23cce7844fbb74d9c07b948568','https://cf.shopee.vn/file/7dac7f23cce7844fbb74d9c07b948568',250,15,0,'pants')
INSERT INTO "Product" VALUES ('84','Gonz Brand','Slim-Fit Wrinkle-Resistant Flat-Front Chino Pant','60% Cotton, 40% Polyester, This slim-fit chino pant features wrinkle-free fabric, a flat-front design, and button-through back welt pockets for a tailored look and all-day comfort','https://cf.shopee.vn/file/18c942289e18768ab02428cf65a4b240','https://cf.shopee.vn/file/18c942289e18768ab02428cf65a4b240','https://cf.shopee.vn/file/18c942289e18768ab02428cf65a4b240',175,35,1,'pants')
INSERT INTO "Product" VALUES ('85','The Maze if we kiss','Washed skinny','slim-fit for gentleman','https://cf.shopee.vn/file/a8c43721fbb0f77c3545d7f0898abfe1','https://cf.shopee.vn/file/a8c43721fbb0f77c3545d7f0898abfe1','https://cf.shopee.vn/file/a8c43721fbb0f77c3545d7f0898abfe1',400,62,1,'pants')
INSERT INTO "Product" VALUES ('86','YobaShop','Long skinny jeans','skinny jeans for energetic days','https://cf.shopee.vn/file/2de33dca08976c9d2b275a609a633f28','https://cf.shopee.vn/file/2de33dca08976c9d2b275a609a633f28','https://cf.shopee.vn/file/2de33dca08976c9d2b275a609a633f28',380,20,1,'pants')
INSERT INTO "Product" VALUES ('87','Local','CARGO FELT PANTS','60% Cotton, 40% Polyester, This slim-fit chino pant features wrinkle-free fabric, a flat-front design, and button-through back welt pockets for a tailored look and all-day comfort','https://cf.shopee.vn/file/6fed74857715ecf8184361ff9217bcc5','https://cf.shopee.vn/file/6fed74857715ecf8184361ff9217bcc5','https://cf.shopee.vn/file/6fed74857715ecf8184361ff9217bcc5',170,14,1,'pants')

-- t-shirt
INSERT INTO "Product" VALUES ('85','Sadboy','Eversoft Cotton Stay Tucked Crew T-Shirt','Fruit of the Loom mens crews work great alone or to add an extra layer under a button-down or polo shirt. This shirt eliminates ride-up, it stays neatly tucked so you can go about your busy day with confidence.','https://m.media-amazon.com/images/I/71YYuvLpqxL._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/71GX5QGOKsL._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/81A5gnmQ2GL._AC_UL1500_.jpg',150,11,1,'t-shirt')
INSERT INTO "Product" VALUES ('86','4Men','Cotton T-Shirt, Classic Tee','cotton tee is one youll definitely want in your wardrobe in multiple colors. For serious athletes or couch quarterbacks, it offers the comfort and sturdiness of U.S','https://m.media-amazon.com/images/I/81HBW-IxstL._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/81Yaus0Tw5L._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/81137iglorL._AC_UL1500_.jpg',200,12,1,'t-shirt')
INSERT INTO "Product" VALUES ('87','Top4man','T-Shirt, Beefy Classic Crewneck Cotton Tee','classic cotton tee has set the standard for T-shirt comfort and quality. Today this unisex tee is better than ever, offering even greater durability and fit.','https://m.media-amazon.com/images/I/81EbOyjAYoL._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/81qmS+uStlL._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/51E0Gh8YzlL._AC_UL1000_.jpg',150,13,1,'t-shirt')
INSERT INTO "Product" VALUES ('88','Eva de Eva',' Womens Perfect Short-Sleeve T-Shirt','Discover our line of size-inclusive essentials across basics, dresses, denim, outerwear, and more—all certified as carbon neutral and featuring certifications that are part of the Climate Pledge Friendly program.','https://m.media-amazon.com/images/I/917VL9XBIUL._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/81fJOEn-B9L._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/81DLWoc3PEL._AC_UL1500_.jpg',150,14,0,'t-shirt')
INSERT INTO "Product" VALUES ('89','Sadboy','SADBOIZ Dreamy Butterfly White','This product is certified carbon neutral by ClimatePartner through the purchase of high-quality carbon credits.','https://cf.shopee.vn/file/2ba2ee463ee495f5c05953766dce9264','https://cf.shopee.vn/file/e8ab49b03729a15c9ea03d9b562577c9','https://cf.shopee.vn/file/3c2a43810a893955407b07e2f3b3bb34',150,15,0,'t-shirt')
INSERT INTO "Product" VALUES ('90','Oia Studio','Clairie Shirt','Luxury shirt designed by Oia Studio','https://cf.shopee.vn/file/12b9b93ee2414f892538b9df8b05cc9f','https://cf.shopee.vn/file/a8bffb81893ef1fbb281f02941598270','https://cf.shopee.vn/file/a8bffb81893ef1fbb281f02941598270',690,15,0,'t-shirt')
INSERT INTO "Product" VALUES ('91','Local','Young unisex t shirt','50% cotton, 50% polyeste','https://cf.shopee.vn/file/c4d1ff447779c83cb97711105663adfe','https://cf.shopee.vn/file/c4d1ff447779c83cb97711105663adfe','https://cf.shopee.vn/file/c4d1ff447779c83cb97711105663adfe',70,50,1,'t-shirt')
INSERT INTO "Product" VALUES ('92','Shinees','Green unique color','100% cotton','https://cf.shopee.vn/file/b52610e39333a7f514b9065c4deab3de','https://cf.shopee.vn/file/b52610e39333a7f514b9065c4deab3de','https://cf.shopee.vn/file/b52610e39333a7f514b9065c4deab3de',80,3,1,'t-shirt')
INSERT INTO "Product" VALUES ('93','Shinees','Blue ocean limited version','Young unisex t shirt, Korean style, Blue ocean limited version','https://cf.shopee.vn/file/ac998f616e9d1959a0f516fad037c361','https://cf.shopee.vn/file/ac998f616e9d1959a0f516fad037c361','https://cf.shopee.vn/file/ac998f616e9d1959a0f516fad037c361',80,3,1,'t-shirt')
INSERT INTO "Product" VALUES ('94','Make it Rain',' Men bigsize t shirt','Basic outerwear, 100% cotton','https://cf.shopee.vn/file/4808676967fefe1b362b1c58592da749','https://cf.shopee.vn/file/4808676967fefe1b362b1c58592da749','https://cf.shopee.vn/file/4808676967fefe1b362b1c58592da749',150,14,1,'t-shirt')

INSERT INTO "Product" VALUES ('95','Sadboy','Eversoft Cotton Stay Tucked Crew T-Shirt','Fruit of the Loom mens crews work great alone or to add an extra layer under a button-down or polo shirt. This shirt eliminates ride-up, it stays neatly tucked so you can go about your busy day with confidence.','https://m.media-amazon.com/images/I/71YYuvLpqxL._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/71GX5QGOKsL._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/81A5gnmQ2GL._AC_UL1500_.jpg',150,11,1,'t-shirt')
INSERT INTO "Product" VALUES ('96','4Men','Cotton T-Shirt, Classic Tee','cotton tee is one youll definitely want in your wardrobe in multiple colors. For serious athletes or couch quarterbacks, it offers the comfort and sturdiness of U.S','https://m.media-amazon.com/images/I/81HBW-IxstL._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/81Yaus0Tw5L._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/81137iglorL._AC_UL1500_.jpg',200,12,1,'t-shirt')
INSERT INTO "Product" VALUES ('97','Top4man','T-Shirt, Beefy Classic Crewneck Cotton Tee','classic cotton tee has set the standard for T-shirt comfort and quality. Today this unisex tee is better than ever, offering even greater durability and fit.','https://m.media-amazon.com/images/I/81EbOyjAYoL._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/81qmS+uStlL._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/51E0Gh8YzlL._AC_UL1000_.jpg',150,13,1,'t-shirt')
INSERT INTO "Product" VALUES ('98','Eva de Eva',' Womens Perfect Short-Sleeve T-Shirt','Discover our line of size-inclusive essentials across basics, dresses, denim, outerwear, and more—all certified as carbon neutral and featuring certifications that are part of the Climate Pledge Friendly program.','https://m.media-amazon.com/images/I/917VL9XBIUL._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/81fJOEn-B9L._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/81DLWoc3PEL._AC_UL1500_.jpg',150,14,0,'t-shirt')
INSERT INTO "Product" VALUES ('99','Sadboy','SADBOIZ Dreamy Butterfly White','This product is certified carbon neutral by ClimatePartner through the purchase of high-quality carbon credits.','https://cf.shopee.vn/file/2ba2ee463ee495f5c05953766dce9264','https://cf.shopee.vn/file/e8ab49b03729a15c9ea03d9b562577c9','https://cf.shopee.vn/file/3c2a43810a893955407b07e2f3b3bb34',150,15,0,'t-shirt')
INSERT INTO "Product" VALUES ('100','Oia Studio','Clairie Shirt','Luxury shirt designed by Oia Studio','https://cf.shopee.vn/file/12b9b93ee2414f892538b9df8b05cc9f','https://cf.shopee.vn/file/a8bffb81893ef1fbb281f02941598270','https://cf.shopee.vn/file/a8bffb81893ef1fbb281f02941598270',690,15,0,'t-shirt')
INSERT INTO "Product" VALUES ('101','Local','Young unisex t shirt','50% cotton, 50% polyeste','https://cf.shopee.vn/file/c4d1ff447779c83cb97711105663adfe','https://cf.shopee.vn/file/c4d1ff447779c83cb97711105663adfe','https://cf.shopee.vn/file/c4d1ff447779c83cb97711105663adfe',70,50,1,'t-shirt')
INSERT INTO "Product" VALUES ('102','Shinees','Green unique color','100% cotton','https://cf.shopee.vn/file/b52610e39333a7f514b9065c4deab3de','https://cf.shopee.vn/file/b52610e39333a7f514b9065c4deab3de','https://cf.shopee.vn/file/b52610e39333a7f514b9065c4deab3de',80,3,1,'t-shirt')
INSERT INTO "Product" VALUES ('103','Shinees','Blue ocean limited version','Young unisex t shirt, Korean style, Blue ocean limited version','https://cf.shopee.vn/file/ac998f616e9d1959a0f516fad037c361','https://cf.shopee.vn/file/ac998f616e9d1959a0f516fad037c361','https://cf.shopee.vn/file/ac998f616e9d1959a0f516fad037c361',80,3,1,'t-shirt')
INSERT INTO "Product" VALUES ('104','Make it Rain',' Men bigsize t shirt','Basic outerwear, 100% cotton','https://cf.shopee.vn/file/4808676967fefe1b362b1c58592da749','https://cf.shopee.vn/file/4808676967fefe1b362b1c58592da749','https://cf.shopee.vn/file/4808676967fefe1b362b1c58592da749',150,14,1,'t-shirt')

INSERT INTO "Product" VALUES ('105','Sadboy','Eversoft Cotton Stay Tucked Crew T-Shirt','Fruit of the Loom mens crews work great alone or to add an extra layer under a button-down or polo shirt. This shirt eliminates ride-up, it stays neatly tucked so you can go about your busy day with confidence.','https://m.media-amazon.com/images/I/71YYuvLpqxL._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/71GX5QGOKsL._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/81A5gnmQ2GL._AC_UL1500_.jpg',150,11,1,'t-shirt')
INSERT INTO "Product" VALUES ('106','4Men','Cotton T-Shirt, Classic Tee','cotton tee is one youll definitely want in your wardrobe in multiple colors. For serious athletes or couch quarterbacks, it offers the comfort and sturdiness of U.S','https://m.media-amazon.com/images/I/81HBW-IxstL._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/81Yaus0Tw5L._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/81137iglorL._AC_UL1500_.jpg',200,12,1,'t-shirt')
INSERT INTO "Product" VALUES ('107','Top4man','T-Shirt, Beefy Classic Crewneck Cotton Tee','classic cotton tee has set the standard for T-shirt comfort and quality. Today this unisex tee is better than ever, offering even greater durability and fit.','https://m.media-amazon.com/images/I/81EbOyjAYoL._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/81qmS+uStlL._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/51E0Gh8YzlL._AC_UL1000_.jpg',150,13,1,'t-shirt')
INSERT INTO "Product" VALUES ('108','Eva de Eva',' Womens Perfect Short-Sleeve T-Shirt','Discover our line of size-inclusive essentials across basics, dresses, denim, outerwear, and more—all certified as carbon neutral and featuring certifications that are part of the Climate Pledge Friendly program.','https://m.media-amazon.com/images/I/917VL9XBIUL._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/81fJOEn-B9L._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/81DLWoc3PEL._AC_UL1500_.jpg',150,14,0,'t-shirt')
INSERT INTO "Product" VALUES ('109','Sadboy','SADBOIZ Dreamy Butterfly White','This product is certified carbon neutral by ClimatePartner through the purchase of high-quality carbon credits.','https://cf.shopee.vn/file/2ba2ee463ee495f5c05953766dce9264','https://cf.shopee.vn/file/e8ab49b03729a15c9ea03d9b562577c9','https://cf.shopee.vn/file/3c2a43810a893955407b07e2f3b3bb34',150,15,0,'t-shirt')
INSERT INTO "Product" VALUES ('110','Oia Studio','Clairie Shirt','Luxury shirt designed by Oia Studio','https://cf.shopee.vn/file/12b9b93ee2414f892538b9df8b05cc9f','https://cf.shopee.vn/file/a8bffb81893ef1fbb281f02941598270','https://cf.shopee.vn/file/a8bffb81893ef1fbb281f02941598270',690,15,0,'t-shirt')
INSERT INTO "Product" VALUES ('111','Local','Young unisex t shirt','50% cotton, 50% polyeste','https://cf.shopee.vn/file/c4d1ff447779c83cb97711105663adfe','https://cf.shopee.vn/file/c4d1ff447779c83cb97711105663adfe','https://cf.shopee.vn/file/c4d1ff447779c83cb97711105663adfe',70,50,1,'t-shirt')
INSERT INTO "Product" VALUES ('112','Shinees','Green unique color','100% cotton','https://cf.shopee.vn/file/b52610e39333a7f514b9065c4deab3de','https://cf.shopee.vn/file/b52610e39333a7f514b9065c4deab3de','https://cf.shopee.vn/file/b52610e39333a7f514b9065c4deab3de',80,3,1,'t-shirt')

--shoes
INSERT INTO "Product" VALUES ('113','4Men','chelsea boot','SODA latest collection “Pilot” A chunky heel and lug sole lend utilitarian flair to a timeless Chelsea boot updated with a croc-embossed leather pull tab at the counter.','https://cf.shopee.vn/file/sg-11134201-22110-n925r64prfjv01','https://cf.shopee.vn/file/sg-11134201-22110-8vtdulcprfjv0e','https://cf.shopee.vn/file/sg-11134201-22110-rn97ykbqrfjv23',400,11,1,'shoes')
INSERT INTO "Product" VALUES ('114','Top4man','combat boot','With a subtly cropped shaft and a lil’ extra lift, BETTYY offers an of-the-moment take on the classic combat boot — perfect for punk, goth and grunge looks alike!','https://cf.shopee.vn/file/e5640c4ea9096723aaf78a0d51760d78','https://cf.shopee.vn/file/8a4f2496d436751bf4fc76472a61c098','https://cf.shopee.vn/file/e961f083a8919b22ffc49849a59d1877',700,6,1,'shoes')
INSERT INTO "Product" VALUES ('115','Elise','LifeStride Womens Saldana Pump','The modern yet timeless saldana pump from LifeStride instantly elevates any look. Faux leather upper with a pointed toe, slip-on fit, patent accent, and d-orsay-style silhouette.','https://m.media-amazon.com/images/I/71kqVBHlI6L._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/61D17oo-hpL._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/611Rc1pIO1L._AC_UL1500_.jpg',200,7,0,'shoes')
INSERT INTO "Product" VALUES ('116','Elise','Dr. Scholl Shoes Women is Harlow Ankle Boot','Simplicity at its finest. you’ll love to step in comfortable style with a wedge bootie style that complements your entire wardrobe. pair it with a dress or jeans and you’re good to go.','https://m.media-amazon.com/images/I/81DKRUMLYZL._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/91ZHl7c-yjL._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/714RpsQWFcL._AC_UL1500_.jpg',300,9,0,'shoes')
INSERT INTO "Product" VALUES ('117','Eva de Eva','Dr. Scholls Shoes Women Into Groove Sneaker','A sporty, hiker-inspired sneaker bootie with a hidden wedge. SUSTAINABLY CRAFTED: Eco-conscious fabric toe box, linings and topcloth made from recycled bottles, and heel counter made from recycled materials.','https://m.media-amazon.com/images/I/81hy0AALqhS._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/718EQIHSNpS._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/7143ZxfzmXS._AC_UL1500_.jpg',250,5,0,'shoes')
INSERT INTO "Product" VALUES ('118','She Shoes','High Sandals','High heels sandal for office woman','https://cf.shopee.vn/file/e8d1d2ccb91aaaa8efdf66ce3d3c7f67','https://cf.shopee.vn/file/e8d1d2ccb91aaaa8efdf66ce3d3c7f67','https://cf.shopee.vn/file/e8d1d2ccb91aaaa8efdf66ce3d3c7f67',480,24,0,'shoes')
INSERT INTO "Product" VALUES ('119','Bejo','High heels','White high heels for bride, wedding day','https://cf.shopee.vn/file/ecf66cb96b6f9852cac10337912fef38','https://cf.shopee.vn/file/ecf66cb96b6f9852cac10337912fef38','https://cf.shopee.vn/file/ecf66cb96b6f9852cac10337912fef38',610,6,0,'shoes')
INSERT INTO "Product" VALUES ('120','Big Tree Store','Aiko heels','100% Original Aiko heels, white version','https://cf.shopee.vn/file/38810b2ccba9bdfc939fe110a5041f6b','https://cf.shopee.vn/file/38810b2ccba9bdfc939fe110a5041f6b','https://cf.shopee.vn/file/38810b2ccba9bdfc939fe110a5041f6b',370,40,0,'shoes')
INSERT INTO "Product" VALUES ('121','Big Tree Store','Lolita heels','You’ll love to step in comfortable style with a wedge bootie style that complements your entire wardrobe. pair it with a princess dress and you’re good to go.','https://cf.shopee.vn/file/a91c394437629bc0b7da6879060ae59f','https://cf.shopee.vn/file/a91c394437629bc0b7da6879060ae59f','https://cf.shopee.vn/file/a91c394437629bc0b7da6879060ae59f',450,10,0,'shoes')
INSERT INTO "Product" VALUES ('122','Oxford','Dr. Scholls Shoes Women Into Lolita shoes','A sporty, hiker-inspired sneaker bootie with a hidden wedge. SUSTAINABLY CRAFTED: Eco-conscious fabric toe box, linings and topcloth made from recycled bottles, and heel counter made from recycled materials.','https://cf.shopee.vn/file/d773f8a74dceb8690a5457f7de743c69','https://cf.shopee.vn/file/d773f8a74dceb8690a5457f7de743c69','https://cf.shopee.vn/file/d773f8a74dceb8690a5457f7de743c69',250,35,0,'shoes')

INSERT INTO "Product" VALUES ('123','4Men','chelsea boot','SODA latest collection “Pilot” A chunky heel and lug sole lend utilitarian flair to a timeless Chelsea boot updated with a croc-embossed leather pull tab at the counter.','https://cf.shopee.vn/file/sg-11134201-22110-n925r64prfjv01','https://cf.shopee.vn/file/sg-11134201-22110-8vtdulcprfjv0e','https://cf.shopee.vn/file/sg-11134201-22110-rn97ykbqrfjv23',400,11,1,'shoes')
INSERT INTO "Product" VALUES ('124','Top4man','combat boot','With a subtly cropped shaft and a lil’ extra lift, BETTYY offers an of-the-moment take on the classic combat boot — perfect for punk, goth and grunge looks alike!','https://cf.shopee.vn/file/e5640c4ea9096723aaf78a0d51760d78','https://cf.shopee.vn/file/8a4f2496d436751bf4fc76472a61c098','https://cf.shopee.vn/file/e961f083a8919b22ffc49849a59d1877',700,6,1,'shoes')
INSERT INTO "Product" VALUES ('125','Elise','LifeStride Womens Saldana Pump','The modern yet timeless saldana pump from LifeStride instantly elevates any look. Faux leather upper with a pointed toe, slip-on fit, patent accent, and d-orsay-style silhouette.','https://m.media-amazon.com/images/I/71kqVBHlI6L._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/61D17oo-hpL._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/611Rc1pIO1L._AC_UL1500_.jpg',200,7,0,'shoes')
INSERT INTO "Product" VALUES ('126','Elise','Dr. Scholl Shoes Women is Harlow Ankle Boot','Simplicity at its finest. you’ll love to step in comfortable style with a wedge bootie style that complements your entire wardrobe. pair it with a dress or jeans and you’re good to go.','https://m.media-amazon.com/images/I/81DKRUMLYZL._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/91ZHl7c-yjL._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/714RpsQWFcL._AC_UL1500_.jpg',300,9,0,'shoes')
INSERT INTO "Product" VALUES ('127','Eva de Eva','Dr. Scholls Shoes Women Into Groove Sneaker','A sporty, hiker-inspired sneaker bootie with a hidden wedge. SUSTAINABLY CRAFTED: Eco-conscious fabric toe box, linings and topcloth made from recycled bottles, and heel counter made from recycled materials.','https://m.media-amazon.com/images/I/81hy0AALqhS._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/718EQIHSNpS._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/7143ZxfzmXS._AC_UL1500_.jpg',250,5,0,'shoes')
INSERT INTO "Product" VALUES ('128','She Shoes','High Sandals','High heels sandal for office woman','https://cf.shopee.vn/file/e8d1d2ccb91aaaa8efdf66ce3d3c7f67','https://cf.shopee.vn/file/e8d1d2ccb91aaaa8efdf66ce3d3c7f67','https://cf.shopee.vn/file/e8d1d2ccb91aaaa8efdf66ce3d3c7f67',480,24,0,'shoes')
INSERT INTO "Product" VALUES ('129','Bejo','High heels','White high heels for bride, wedding day','https://cf.shopee.vn/file/ecf66cb96b6f9852cac10337912fef38','https://cf.shopee.vn/file/ecf66cb96b6f9852cac10337912fef38','https://cf.shopee.vn/file/ecf66cb96b6f9852cac10337912fef38',610,6,0,'shoes')
INSERT INTO "Product" VALUES ('130','Big Tree Store','Aiko heels','100% Original Aiko heels, white version','https://cf.shopee.vn/file/38810b2ccba9bdfc939fe110a5041f6b','https://cf.shopee.vn/file/38810b2ccba9bdfc939fe110a5041f6b','https://cf.shopee.vn/file/38810b2ccba9bdfc939fe110a5041f6b',370,40,0,'shoes')
INSERT INTO "Product" VALUES ('131','Big Tree Store','Lolita heels','You’ll love to step in comfortable style with a wedge bootie style that complements your entire wardrobe. pair it with a princess dress and you’re good to go.','https://cf.shopee.vn/file/a91c394437629bc0b7da6879060ae59f','https://cf.shopee.vn/file/a91c394437629bc0b7da6879060ae59f','https://cf.shopee.vn/file/a91c394437629bc0b7da6879060ae59f',450,10,0,'shoes')
INSERT INTO "Product" VALUES ('132','Oxford','Dr. Scholls Shoes Women Into Lolita shoes','A sporty, hiker-inspired sneaker bootie with a hidden wedge. SUSTAINABLY CRAFTED: Eco-conscious fabric toe box, linings and topcloth made from recycled bottles, and heel counter made from recycled materials.','https://cf.shopee.vn/file/d773f8a74dceb8690a5457f7de743c69','https://cf.shopee.vn/file/d773f8a74dceb8690a5457f7de743c69','https://cf.shopee.vn/file/d773f8a74dceb8690a5457f7de743c69',250,35,0,'shoes')

INSERT INTO "Product" VALUES ('133','4Men','chelsea boot','SODA latest collection “Pilot” A chunky heel and lug sole lend utilitarian flair to a timeless Chelsea boot updated with a croc-embossed leather pull tab at the counter.','https://cf.shopee.vn/file/sg-11134201-22110-n925r64prfjv01','https://cf.shopee.vn/file/sg-11134201-22110-8vtdulcprfjv0e','https://cf.shopee.vn/file/sg-11134201-22110-rn97ykbqrfjv23',400,11,1,'shoes')
INSERT INTO "Product" VALUES ('134','Top4man','combat boot','With a subtly cropped shaft and a lil’ extra lift, BETTYY offers an of-the-moment take on the classic combat boot — perfect for punk, goth and grunge looks alike!','https://cf.shopee.vn/file/e5640c4ea9096723aaf78a0d51760d78','https://cf.shopee.vn/file/8a4f2496d436751bf4fc76472a61c098','https://cf.shopee.vn/file/e961f083a8919b22ffc49849a59d1877',700,6,1,'shoes')
INSERT INTO "Product" VALUES ('135','Elise','LifeStride Womens Saldana Pump','The modern yet timeless saldana pump from LifeStride instantly elevates any look. Faux leather upper with a pointed toe, slip-on fit, patent accent, and d-orsay-style silhouette.','https://m.media-amazon.com/images/I/71kqVBHlI6L._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/61D17oo-hpL._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/611Rc1pIO1L._AC_UL1500_.jpg',200,7,0,'shoes')
INSERT INTO "Product" VALUES ('136','Elise','Dr. Scholl Shoes Women is Harlow Ankle Boot','Simplicity at its finest. you’ll love to step in comfortable style with a wedge bootie style that complements your entire wardrobe. pair it with a dress or jeans and you’re good to go.','https://m.media-amazon.com/images/I/81DKRUMLYZL._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/91ZHl7c-yjL._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/714RpsQWFcL._AC_UL1500_.jpg',300,9,0,'shoes')
INSERT INTO "Product" VALUES ('137','Eva de Eva','Dr. Scholls Shoes Women Into Groove Sneaker','A sporty, hiker-inspired sneaker bootie with a hidden wedge. SUSTAINABLY CRAFTED: Eco-conscious fabric toe box, linings and topcloth made from recycled bottles, and heel counter made from recycled materials.','https://m.media-amazon.com/images/I/81hy0AALqhS._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/718EQIHSNpS._AC_UL1500_.jpg','https://m.media-amazon.com/images/I/7143ZxfzmXS._AC_UL1500_.jpg',250,5,0,'shoes')
INSERT INTO "Product" VALUES ('138','She Shoes','High Sandals','High heels sandal for office woman','https://cf.shopee.vn/file/e8d1d2ccb91aaaa8efdf66ce3d3c7f67','https://cf.shopee.vn/file/e8d1d2ccb91aaaa8efdf66ce3d3c7f67','https://cf.shopee.vn/file/e8d1d2ccb91aaaa8efdf66ce3d3c7f67',480,24,0,'shoes')
INSERT INTO "Product" VALUES ('139','Bejo','High heels','White high heels for bride, wedding day','https://cf.shopee.vn/file/ecf66cb96b6f9852cac10337912fef38','https://cf.shopee.vn/file/ecf66cb96b6f9852cac10337912fef38','https://cf.shopee.vn/file/ecf66cb96b6f9852cac10337912fef38',610,6,0,'shoes')
INSERT INTO "Product" VALUES ('140','Big Tree Store','Aiko heels','100% Original Aiko heels, white version','https://cf.shopee.vn/file/38810b2ccba9bdfc939fe110a5041f6b','https://cf.shopee.vn/file/38810b2ccba9bdfc939fe110a5041f6b','https://cf.shopee.vn/file/38810b2ccba9bdfc939fe110a5041f6b',370,40,0,'shoes')
--