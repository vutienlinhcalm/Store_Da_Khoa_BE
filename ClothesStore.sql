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
	"AccountId" nvarchar(100) primary key,
	"Name" nvarchar(100),
	"UserName" nvarchar(100),
	"Password" nvarchar(100),
	"IsAdmin" bit,
	"Email" nvarchar(100),
	"Phone" nvarchar(100)
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
	"ProductId" nvarchar(100) primary key,
	"Brand" nvarchar(100),
	"ProductName" nvarchar(100),
	"Description" TEXT,
	"MainImage" nvarchar(100),
	"SubImage1" nvarchar(100),
	"SubImage2" nvarchar(100),
	"Price" int,
	"StoreQuantity" int,
	"Gender" int,
	"Category" nvarchar(100)
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
	"OrderId" nvarchar(100) primary key,
	"AccountId" nvarchar(100),
	"OrderTime" datetime,
	"PaymentMethod" nvarchar(100),
	"Address" nvarchar(100),
	"Status" int,
	"TotalPrice" int,
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

--CREATE TABLE "Comment"(
--	"Customer_id" int,
--	"Product_id" int,
--	"Content" varchar(50),
--	"Commenttime" datetime,
--	CONSTRAINT "PK_Comment" PRIMARY KEY  CLUSTERED 
--	(
--		"Customer_id",
--		"Product_id"
--	),
--	CONSTRAINT FK_COM_USER FOREIGN KEY ("Customer_id") REFERENCES  "Customer" ("Customerid"),
--	CONSTRAINT FK_COM_PRODUCT FOREIGN KEY ("Product_id") REFERENCES  "Product" ("Productid"),
--)

--INSERT INTO "Account" VALUES (1,'Vũ Tiến Linh','linh123','linh123@gmail.com','0355654117');
--INSERT INTO "Account" VALUES (2,'Võ Thị Tường Vy','vy123','vy123@gmail.com','0865952624');
--INSERT INTO "Account" VALUES (3,'Phạm Hoàng Khang','khang123','khang123@gmail.com','0385456869');
--INSERT INTO "Account" VALUES (4,'Nguyễn Đăng Minh','minh123','minh123@gmail.com','0834856922');

--INSERT INTO "Account" VALUES (1,'Nguyễn Tiến Linh','linh123','linh123@gmail.com','0128556789');
--INSERT INTO "Account" VALUES (2,'Lê Xuân Minh','Minh123','minh123@gmail.com','0125456789');
--INSERT INTO "Account" VALUES (3,'Đoàn Triệu','Trieu123','trieu123@gmail.com','0185456789');
--INSERT INTO "Account" VALUES (4,'Tuấn Vũ','Vu123','vu123@gmail.com','0123465789');
--INSERT INTO "Account" VALUES (5,'Thanh Toàn','Toan123','toan123@gmail.com','0124256789');

--INSERT INTO "Category" VALUES (1,'Quan','Quần là loại trang phục mặc từ eo đến mắt cá chân hoặc che đến đầu gối, cao hoặc thấp hơn đầu gối tùy loại, che phủ từng chân riêng biệt.');
--INSERT INTO "Category" VALUES (2,'Ao','Áo là phần trang phục được mặc ở phần trên của cơ thể.');
--INSERT INTO "Category" VALUES (3,'Dam','Váy đầm là một trang phục truyền thống được phụ nữ hoặc các cô gái mặc, bao gồm một chiếc váy với một chiếc áo lót kèm theo.');
--INSERT INTO "Category" VALUES (4,'Vay','Váy là đồ mặc che thân từ thắt lưng trở xuống, trước đây đa số phụ nữ đều mặc. Một số nước nam giới cũng mặc váy.');

--INSERT INTO "Brand" VALUES (1,'NEM FASHION','Thương hiệu thời trang nữ ở Việt Nam không thể không kể tới NEM. Đây là thương hiệu thời trang nữ cao cấp được chị em công sở yêu thích vì thiết kế thanh lịch, quyến rũ và tinh tế.');
--INSERT INTO "Brand" VALUES (2,'K&K Fashion','Ra mắt trên thị trường từ năm 2009, hiện K&K là một trong những thương hiệu được yêu thích nhất. Với mức giá bình dân nhưng chất lượng và thiết kế rất tốt, những sản phẩm của K&K vẫn tôn lên vẻ sang trọng và quý phái của người phụ nữ.');
--INSERT INTO "Brand" VALUES (3,'IVy Moda','ới phương châm đem lại sự hiện đại, cá tính và thời thượng cho khách hàng, thương hiệu này luôn duy trì ra mắt những dòng sản phẩm với xu hướng mới nhất, sản phẩm đa dạng từ công sở, quần jeans đến túi, giày.');
--INSERT INTO "Brand" VALUES (4,'Owen','Owen được biết đến lúc đầu là thương hiệu thời trang nam công sở, Owen đã không ngừng hoàn thiện, tìm tòi và cho ra đời các sản phẩm mới đáp ứng mọi nhu cầu về thời trang cho các quý ông.');
--INSERT INTO "Brand" VALUES (5,'4Men','4Men nghĩ rằng thời trang là một nhiệm vụ và sáng tạo, vì vậy hầu hết các sản phẩm của 4Men đều được thiết kế với phong cách trẻ trung và hiện đại để mang đến thời trang thời trang nhất cho giới trẻ.');
--INSERT INTO "Brand" VALUES (6,'Top4man','Top4man là một trong những thương hiệu đứng đầu trong lĩnh vực thời trang thiết kế hiện đại dành cho phái mạnh. Thương hiệu này được yêu thích bởi những thiết kế Độc - Đẹp -Lạ, luôn bắt kịp xu hướng.');

--INSERT INTO "Product" VALUES (1,1,1,'QUẦN ỐNG LOE Q12222','vải tổng hợp cao cấp, quần thiết kế dáng ống loe, tone màu đen trơn ','https://product.hstatic.net/200000182297/product/ak105421612234110402p1399dt_q122221722224110457p799dt_6__cea53da1d046493b8d037b0ceb8a9551_master.jpg',799000,10,1,'S')
--INSERT INTO "Product" VALUES (2,1,1,'QUẦN THIẾT KẾ Q12642','vải tổng hợp cao cấp,quần dài thiết kế dáng ống loe, tone màu đen trơn','https://product.hstatic.net/200000182297/product/ak102421612214110458p1459dt_q102321722213110447p899dt_2__1761f6af662247f1b1a6d0996a50361d_master.jpg',799000,11,1,'L')
--INSERT INTO "Product" VALUES (3,1,2,'Quần tây công sở nữ ống đứng lưng cao','Trang phục công sở đi làm phổ biến được các nàng khá ưa chuộng dù là mùa nào đi chăng nữa có lẽ là quần tây nữ lưng cao.Thiết kế quần QCS04-02 dáng đứng thanh lịch, cạp cao tôn dáng.','https://cdn.kkfashion.vn/18210-large_default/quan-tay-cong-so-nu-ong-dung-lung-cao-qcs04-02.jpg',330000,12,1,'S')
--INSERT INTO "Product" VALUES (4,2,2,'Áo sơ mi nữ công sở basic tay dài','Nếu yêu thích phong cách thời trang lịch sự, kín đáo đừng quên bổ sung vào tủ quần áo của mình mẫu áo sơ mi nữ công sở tay dài ASM11-22 này nhé. Tuy vẫn là thiết kế khá quen thuộc của nhiều cô nàng công sở nhưng item này vẫn luôn được lựa chọn qua nhiều mùa thời trang.','https://cdn.kkfashion.vn/18179-large_default/ao-so-mi-nu-cong-so-basic-tay-dai-asm11-22.jpg',270000,13,1,'L')
--INSERT INTO "Product" VALUES (5,2,3,'ÁO THUN GÂN CỔ KHOÉT CÁCH ĐIỆU','Áo thun gân cổ khoét tròn đính phụ kiện cách điệu. Tay áo dài. Dáng áo ôm. Vải thun gân cao cấp.','https://pubcdn.ivymoda.com/files/product/thumab/1400/2021/11/11/404a9333adb61cee5f3f1c3edea5c14b.JPG',395000,14,1,'S')
--INSERT INTO "Product" VALUES (6,2,3,'ÁO THUN HOA VOAN XUYÊN THẤU','Áo thun cổ tròn, tay dài. Bo gấu ở cổ và tay áo. Áo thêu họa tiết hoa từ chất liệu vải voan xuyên thấu, tạo điểm nhấn cho chiếc áo. Chất thun có độ dày vừa phải, mềm nhẹ, giữ ấm hiệu quả.','https://pubcdn.ivymoda.com/files/product/thumab/1400/2022/11/01/979dcfa5c07555211f8aa7c5b051c748.jpg',553000,5,1,'S')
--INSERT INTO "Product" VALUES (7,2,4,'ÁO SƠ MI - AS221562D','Áo sơ mi dài tay, kiểu dáng Slim Fit dễ mặc, hợp form dáng.
--Màu sắc và kiểu dáng trẻ trung, kiểu dáng hiện đại, dễ phối đồ.
--Chất liệu Recycle Poly mịn mát, thoải mái.','https://owen.vn/media/catalog/product/cache/d52d7e242fac6dae82288d9a793c0676/z/3/z3720235492982_163bff94ef1cb9417c5f66916d680506_1_.jpg',319000,6,0,'L')
--INSERT INTO "Product" VALUES (8,1,4,'QUẦN TÂY - QST220507R2','Chất liệu Nano mềm mại thoáng mát, đứng form dáng.
--Thiết kế thanh lịch, thích hợp diện mặc khi tới công sở, dự sự kiện.
--Tone màu trẻ trung, hiện đại, dễ phối đồ.','https://owen.vn/media/catalog/product/cache/d52d7e242fac6dae82288d9a793c0676/q/s/qst220507r2_5957.jpg',500000,7,0,'XL')
--INSERT INTO "Product" VALUES (9,2,6,'ÁO SƠ MI REGULAR POCKETDETAIL','ÁO SƠ MI REGULAR POCKETDETAIL chất liệu thoáng mát','https://4menshop.com/images/thumbs/2022/11/-17497-slide-products-636b6fe9924a7.JPG',345000,8,0,'XL')
--INSERT INTO "Product" VALUES (10,4,2,'CHÂN VÁY XẾP LI Z09822','vải tổng hợp cao cấp, chân váy midi thiết kế xếp li, tone màu vàng nâu.','https://product.hstatic.net/200000182297/product/98_fd9526a9da0247a28e5f8f0fec5da3ed_master.jpg',699000,9,1,'S')


--INSERT INTO "Ship" VALUES (1,'PHAM VAN DONG','DONG HOA','THU DUC','HCM','Thái','0325695487',0)
--INSERT INTO "Ship" VALUES (2,'PHAM Ngu Lao','DONG HOA','Q5','HCM','Tuấn','0865965422',1)
--INSERT INTO "Ship" VALUES (3,'Truong Son Đông','DONG HOA','Bình Thạnh','HCM','Hải','0398745623',2)

INSERT INTO "Product" VALUES ('test_1','test_brand_1','test_name_1','test_decription_1','test_img1_1','test_img2_1','test_img3_1',1,1,1,'test_category_1')
INSERT INTO "Product" VALUES ('test_2','test_brand_2','test_name_2','test_decription_2','test_img1_2','test_img2_2','test_img3_2',2,2,2,'test_category_2')
INSERT INTO "Product" VALUES ('test_3','test_brand_3','test_name_3','test_decription_3','test_img1_3','test_img2_3','test_img3_3',3,3,3,'test_category_3')
INSERT INTO "Product" VALUES ('test_4','test_brand_4','test_name_4','test_decription_4','test_img1_4','test_img2_4','test_img3_4',4,4,4,'test_category_4')
INSERT INTO "Product" VALUES ('test_5','test_brand_5','test_name_5','test_decription_5','test_img1_5','test_img2_5','test_img3_5',5,5,5,'test_category_5')