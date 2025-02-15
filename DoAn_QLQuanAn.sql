USE [DoAn_QLTechCenterFood]
GO
/****** Object:  UserDefinedFunction [dbo].[fuConvertToUnsign1]    Script Date: 9/15/2024 12:53:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Tìm kiếm món ăn theo tên
CREATE FUNCTION [dbo].[fuConvertToUnsign1] ( @strInput NVARCHAR(4000) ) RETURNS NVARCHAR(4000) 
AS 
BEGIN 
IF @strInput IS NULL 
RETURN @strInput 
IF @strInput = '' 
RETURN @strInput 
DECLARE @RT NVARCHAR(4000) 
DECLARE @SIGN_CHARS NCHAR(136) 
DECLARE @UNSIGN_CHARS NCHAR (136) 
SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý ĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍ ÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' +NCHAR(272)+ NCHAR(208) 
SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee iiiiiooooooooooooooouuuuuuuuuuyyyyy AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD' DECLARE @COUNTER int 
DECLARE @COUNTER1 int 
SET @COUNTER = 1 
WHILE (@COUNTER <=LEN(@strInput)) 
BEGIN 
SET @COUNTER1 = 1 WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1) 
BEGIN 
IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) ) 
BEGIN 
IF @COUNTER=1 SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1) 
ELSE 
SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER) 
BREAK END 
SET @COUNTER1 = @COUNTER1 +1 
END 
SET @COUNTER = @COUNTER +1 
END 
SET @strInput = replace(@strInput,' ','-') RETURN @strInput 
END

GO
/****** Object:  Table [dbo].[Account]    Script Date: 9/15/2024 12:53:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[UserName] [nvarchar](100) NOT NULL,
	[DisplayName] [nvarchar](100) NOT NULL,
	[PassWord] [nvarchar](1000) NOT NULL,
	[Type] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bill]    Script Date: 9/15/2024 12:53:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bill](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[DateCheckIn] [date] NOT NULL,
	[DateCheckOut] [date] NULL,
	[idTable] [int] NOT NULL,
	[status] [int] NOT NULL,
	[totalPrice] [float] NULL,
	[discount] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BillInfo]    Script Date: 9/15/2024 12:53:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BillInfo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idBill] [int] NOT NULL,
	[idFood] [int] NOT NULL,
	[count] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Food]    Script Date: 9/15/2024 12:53:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Food](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[idCategory] [int] NOT NULL,
	[price] [float] NOT NULL,
	[imageFood] [image] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FoodCategory]    Script Date: 9/15/2024 12:53:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FoodCategory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[imageCategory] [image] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TableFood]    Script Date: 9/15/2024 12:53:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TableFood](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[status] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Account] ([UserName], [DisplayName], [PassWord], [Type]) VALUES (N'Admin', N'Quản lý', N'quanly', 1)
INSERT [dbo].[Account] ([UserName], [DisplayName], [PassWord], [Type]) VALUES (N'Staff', N'Nhân viên', N'nhanvien', 0)
INSERT [dbo].[Account] ([UserName], [DisplayName], [PassWord], [Type]) VALUES (N'Staff1', N'Nhân viên', N'nhanvien', 0)
GO
SET IDENTITY_INSERT [dbo].[Bill] ON 

INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (8, CAST(N'2024-09-13' AS Date), CAST(N'2024-09-13' AS Date), 13, 1, 80750, 5)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (9, CAST(N'2024-09-13' AS Date), CAST(N'2024-09-13' AS Date), 13, 0, NULL, NULL)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (10, CAST(N'2024-07-23' AS Date), CAST(N'2022-07-23' AS Date), 12, 1, 95000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (11, CAST(N'2024-09-13' AS Date), CAST(N'2024-09-13' AS Date), 15, 1, 150000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (12, CAST(N'2024-09-13' AS Date), CAST(N'2024-09-13' AS Date), 20, 1, 191500, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (13, CAST(N'2024-09-13' AS Date), CAST(N'2024-09-13' AS Date), 18, 1, 20000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (14, CAST(N'2024-09-13' AS Date), CAST(N'2024-09-13' AS Date), 15, 1, 266000, 5)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (15, CAST(N'2024-09-13' AS Date), CAST(N'2024-09-13' AS Date), 20, 1, 270000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (16, CAST(N'2024-09-13' AS Date), CAST(N'2024-09-13' AS Date), 20, 0, NULL, NULL)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (17, CAST(N'2024-09-13' AS Date), CAST(N'2024-09-13' AS Date), 12, 1, 150000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (18, CAST(N'2024-09-13' AS Date), CAST(N'2024-09-13' AS Date), 16, 1, 30000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (19, CAST(N'2024-09-14' AS Date), CAST(N'2024-09-14' AS Date), 14, 1, 285000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (20, CAST(N'2024-09-15' AS Date), CAST(N'2024-09-15' AS Date), 16, 1, 60000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (21, CAST(N'2024-09-15' AS Date), CAST(N'2024-09-15' AS Date), 12, 1, 125000, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [totalPrice], [discount]) VALUES (22, CAST(N'2024-09-15' AS Date), CAST(N'2024-09-15' AS Date), 12, 1, 80000, 0)
SET IDENTITY_INSERT [dbo].[Bill] OFF
GO
SET IDENTITY_INSERT [dbo].[BillInfo] ON 

INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (15, 8, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (16, 8, 7, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (17, 8, 12, 4)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (19, 10, 12, 5)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (20, 10, 9, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (21, 11, 9, 10)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (22, 12, 3, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (23, 12, 5, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (24, 12, 10, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (25, 12, 11, 5)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (26, 13, 14, 6)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (27, 14, 11, 10)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (28, 14, 3, 5)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (29, 15, 5, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (30, 15, 14, 6)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (31, 15, 9, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (32, 15, 10, 5)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (33, 17, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (34, 17, 13, 4)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (35, 18, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (36, 19, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (37, 19, 4, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (38, 19, 6, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (39, 19, 13, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (40, 19, 14, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (41, 19, 3, 5)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (42, 20, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (43, 21, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (44, 21, 3, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (45, 21, 4, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (46, 21, 5, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (47, 22, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (48, 22, 4, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (49, 22, 12, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (50, 22, 14, 1)
SET IDENTITY_INSERT [dbo].[BillInfo] OFF
GO
SET IDENTITY_INSERT [dbo].[Food] ON 

INSERT [dbo].[Food] ([id], [name], [idCategory], [price], [imageFood]) VALUES (1, N'Hamburger', 1, 30000, NULL)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price], [imageFood]) VALUES (2, N'Bánh mì', 1, 15000, NULL)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price], [imageFood]) VALUES (3, N'Khoai tây chiên', 1, 15000, NULL)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price], [imageFood]) VALUES (4, N'Há cảo hấp', 1, 20000, NULL)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price], [imageFood]) VALUES (5, N'Sushi', 1, 20000, NULL)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price], [imageFood]) VALUES (6, N'Bánh donut', 2, 10000, NULL)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price], [imageFood]) VALUES (7, N'Bánh chocolate', 2, 15000, NULL)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price], [imageFood]) VALUES (8, N'Bánh flan', 2, 10000, NULL)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price], [imageFood]) VALUES (9, N'7Up', 3, 15000, NULL)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price], [imageFood]) VALUES (10, N'Coca-cola', 3, 12000, NULL)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price], [imageFood]) VALUES (11, N'Strongbow', 3, 20500, NULL)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price], [imageFood]) VALUES (12, N'Bánh flan trân châu', 4, 10000, NULL)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price], [imageFood]) VALUES (13, N'Tokbokki chả cá phô mai', 4, 30000, NULL)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price], [imageFood]) VALUES (14, N'Bánh gạo lắc phô mai', 4, 20000, NULL)
SET IDENTITY_INSERT [dbo].[Food] OFF
GO
SET IDENTITY_INSERT [dbo].[FoodCategory] ON 

INSERT [dbo].[FoodCategory] ([id], [name], [imageCategory]) VALUES (1, N'Thức ăn nhanh', NULL)
INSERT [dbo].[FoodCategory] ([id], [name], [imageCategory]) VALUES (2, N'Đồ ngọt', NULL)
INSERT [dbo].[FoodCategory] ([id], [name], [imageCategory]) VALUES (3, N'Nước uống', NULL)
INSERT [dbo].[FoodCategory] ([id], [name], [imageCategory]) VALUES (4, N'Món đặc biệt', NULL)
SET IDENTITY_INSERT [dbo].[FoodCategory] OFF
GO
SET IDENTITY_INSERT [dbo].[TableFood] ON 

INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (12, N'Bàn 0', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (13, N'Bàn 1', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (14, N'Bàn 2', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (15, N'Bàn 3', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (16, N'Bàn 4', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (17, N'Bàn 5', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (18, N'Bàn 6', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (19, N'Bàn 7', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (20, N'Bàn 8', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (21, N'Bàn 9', N'Trống')
SET IDENTITY_INSERT [dbo].[TableFood] OFF
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT (N'TechCenterFood') FOR [DisplayName]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT ((0)) FOR [PassWord]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT ((0)) FOR [Type]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT (getdate()) FOR [DateCheckIn]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dbo].[BillInfo] ADD  DEFAULT ((0)) FOR [count]
GO
ALTER TABLE [dbo].[Food] ADD  DEFAULT (N'Chưa đặt tên món') FOR [name]
GO
ALTER TABLE [dbo].[Food] ADD  DEFAULT ((0)) FOR [price]
GO
ALTER TABLE [dbo].[FoodCategory] ADD  DEFAULT (N'Chưa đặt tên danh mục') FOR [name]
GO
ALTER TABLE [dbo].[TableFood] ADD  DEFAULT (N'Chưa đặt tên bàn') FOR [name]
GO
ALTER TABLE [dbo].[TableFood] ADD  DEFAULT (N'Trống') FOR [status]
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD FOREIGN KEY([idTable])
REFERENCES [dbo].[TableFood] ([id])
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD FOREIGN KEY([idBill])
REFERENCES [dbo].[Bill] ([id])
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD FOREIGN KEY([idFood])
REFERENCES [dbo].[Food] ([id])
GO
ALTER TABLE [dbo].[Food]  WITH CHECK ADD FOREIGN KEY([idCategory])
REFERENCES [dbo].[FoodCategory] ([id])
GO
/****** Object:  StoredProcedure [dbo].[HoaDonTTBan]    Script Date: 9/15/2024 12:53:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[HoaDonTTBan]
(
	@name nvarchar(100)
)
AS
	SET NOCOUNT ON;
SELECT f.name, bi.count, f.price, f.price * bi.count AS totalPrice
FROM BillInfo AS bi INNER JOIN
     Bill AS b ON bi.idBill = b.id INNER JOIN
     Food AS f ON bi.idFood = f.id INNER JOIN
     TableFood AS t ON b.idTable = t.id
WHERE (b.status = 0) AND (t.name = @name)
GO
/****** Object:  StoredProcedure [dbo].[NewSelectCommand]    Script Date: 9/15/2024 12:53:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[NewSelectCommand]
(
	@name nvarchar(100)
)
AS
	SET NOCOUNT ON;
SELECT        f.name, bi.count, f.price, f.price * bi.count AS totalPrice
FROM            BillInfo AS bi INNER JOIN
                         Bill AS b ON bi.idBill = b.id INNER JOIN
                         Food AS f ON bi.idFood = f.id INNER JOIN
                         TableFood AS t ON b.idTable = t.id
WHERE        (b.status = 0) AND (t.name = @name)
GO
/****** Object:  StoredProcedure [dbo].[USP_GetAccountByUserName]    Script Date: 9/15/2024 12:53:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Lấy tài khoản từ user name
CREATE PROC [dbo].[USP_GetAccountByUserName]
@userName nvarchar(100)
AS 
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @userName
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetFoodList]    Script Date: 9/15/2024 12:53:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Lấy danh sách món ăn
CREATE PROC [dbo].[USP_GetFoodList]
AS SELECT * FROM dbo.Food

GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByDate]    Script Date: 9/15/2024 12:53:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--Lấy danh sách hóa đơn theo thời gian
CREATE PROC [dbo].[USP_GetListBillByDate]
@checkIn date, @checkOut date
AS 
BEGIN
	SELECT t.name AS [Tenban], b.totalPrice AS [Tongtien], DateCheckIn AS [Ngayvao], DateCheckOut AS [Ngayra], discount AS [Giamgia]
	FROM dbo.Bill AS b,dbo.TableFood AS t
	WHERE DateCheckIn >= @checkIn AND DateCheckOut <= @checkOut AND b.status = 1
	AND t.id = b.idTable
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByTableName]    Script Date: 9/15/2024 12:53:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Lấy danh sách hóa đơn từ tên bàn
CREATE PROC [dbo].[USP_GetListBillByTableName]
	@name nvarchar(100)
AS 
BEGIN
	SELECT f.name, bi.count, f.price, f.price*bi.count AS totalPrice 
	FROM dbo.BillInfo AS bi, dbo.Bill AS b, dbo.Food AS f, dbo.TableFood AS t
	WHERE bi.idBill = b.id AND bi.idFood = f.id AND b.status = 0 AND b.idTable = t.id AND t.name = @name
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetTableList]    Script Date: 9/15/2024 12:53:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Lấy danh sách bàn
CREATE PROC [dbo].[USP_GetTableList]
AS SELECT * FROM dbo.TableFood

GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBill]    Script Date: 9/15/2024 12:53:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Tạo hóa đơn
CREATE PROC [dbo].[USP_InsertBill]
@idTable INT
AS
BEGIN
	INSERT	dbo.Bill
        ( DateCheckIn ,
          DateCheckOut ,
          idTable ,
          status
        )
VALUES  ( GETDATE() , -- DateCheckIn - date
          NULL , -- DateCheckOut - date
          @idTable , -- idTable - int
          0  -- status - int
        )
END

GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBillInfo]    Script Date: 9/15/2024 12:53:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Tạo thông tin hóa đơn
CREATE PROC [dbo].[USP_InsertBillInfo]
@idBill INT, @idFood INT, @count INT
AS
BEGIN
	DECLARE @isExitsBillInfo INT
	DECLARE @foodCount INT = 1

	SELECT @isExitsBillInfo = id, @foodCount = b.count 
	FROM dbo.BillInfo AS b
	WHERE idBill = @idBill AND idFood = @idFood

	IF(@isExitsBillInfo >0)
	BEGIN
		DECLARE @newCount INT = @foodCount + @count
		IF(@newCount > 0 )
			UPDATE dbo.BillInfo SET COUNT = @foodCount + @count 
			WHERE idFood = @idFood
		ELSE
			DELETE dbo.BillInfo WHERE idBill = @idBill AND idFood = @idFood
	END
		ELSE
		BEGIN
			INSERT dbo.BillInfo
			( idBill, idFood, count)
			VALUES (@idBill,
					@idFood,
					@count)
		END
END

GO
/****** Object:  StoredProcedure [dbo].[USP_Login]    Script Date: 9/15/2024 12:53:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_Login]
@userName nvarchar(100), @passWord nvarchar(100)
AS
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @userName AND PassWord = @passWord
END

GO
/****** Object:  StoredProcedure [dbo].[USP_SwitchTabel]    Script Date: 9/15/2024 12:53:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--Tạo lệnh dùng để chuyển bàn
CREATE PROC [dbo].[USP_SwitchTabel]
@idTable1 INT, @idTable2 int
AS BEGIN

	DECLARE @idFirstBill int
	DECLARE @idSeconrdBill INT
	
	DECLARE @isFirstTablEmty INT = 1
	DECLARE @isSecondTablEmty INT = 1
	
	
	SELECT @idSeconrdBill = id FROM dbo.Bill WHERE idTable = @idTable2 AND status = 0
	SELECT @idFirstBill = id FROM dbo.Bill WHERE idTable = @idTable1 AND status = 0
	
	PRINT @idFirstBill
	PRINT @idSeconrdBill
	PRINT '-----------'
	
	IF (@idFirstBill IS NULL)
	BEGIN
		PRINT '0000001'
		INSERT dbo.Bill
		        ( DateCheckIn ,
		          DateCheckOut ,
		          idTable ,
		          status
		        )
		VALUES  ( GETDATE() , -- DateCheckIn - date
		          NULL , -- DateCheckOut - date
		          @idTable1 , -- idTable - int
		          0  -- status - int
		        )
		        
		SELECT @idFirstBill = MAX(id) FROM dbo.Bill WHERE idTable = @idTable1 AND status = 0
		
	END
	
	SELECT @isFirstTablEmty = COUNT(*) FROM dbo.BillInfo WHERE idBill = @idFirstBill
	
	PRINT @idFirstBill
	PRINT @idSeconrdBill
	PRINT '-----------'
	
	IF (@idSeconrdBill IS NULL)
	BEGIN
		PRINT '0000002'
		INSERT dbo.Bill
		        ( DateCheckIn ,
		          DateCheckOut ,
		          idTable ,
		          status
		        )
		VALUES  ( GETDATE() , -- DateCheckIn - date
		          NULL , -- DateCheckOut - date
		          @idTable2 , -- idTable - int
		          0  -- status - int
		        )
		SELECT @idSeconrdBill = MAX(id) FROM dbo.Bill WHERE idTable = @idTable2 AND status = 0
		
	END
	
	SELECT @isSecondTablEmty = COUNT(*) FROM dbo.BillInfo WHERE idBill = @idSeconrdBill
	
	PRINT @idFirstBill
	PRINT @idSeconrdBill
	PRINT '-----------'

	SELECT id INTO IDBillInfoTable FROM dbo.BillInfo WHERE idBill = @idSeconrdBill
	
	UPDATE dbo.BillInfo SET idBill = @idSeconrdBill WHERE idBill = @idFirstBill
	
	UPDATE dbo.BillInfo SET idBill = @idFirstBill WHERE id IN (SELECT * FROM IDBillInfoTable)
	
	DROP TABLE IDBillInfoTable
	
	IF (@isFirstTablEmty = 0)
		UPDATE dbo.TableFood SET status = N'Trống' WHERE id = @idTable2
		
	IF (@isSecondTablEmty= 0)
		UPDATE dbo.TableFood SET status = N'Trống' WHERE id = @idTable1
END

GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateAccount]    Script Date: 9/15/2024 12:53:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Cập nhật thông tin tài khoản
CREATE PROC [dbo].[USP_UpdateAccount]
@userName NVARCHAR(100), @displayName NVARCHAR(100), @password NVARCHAR(100), @newPassword NVARCHAR(100)
AS
BEGIN
	DECLARE @isRightPass INT = 0
	
	SELECT @isRightPass = COUNT(*) FROM dbo.Account WHERE USERName = @userName AND PassWord = @password
	
	IF (@isRightPass = 1)
	BEGIN
		IF (@newPassword = NULL OR @newPassword = '')
		BEGIN
			UPDATE dbo.Account SET DisplayName = @displayName WHERE UserName = @userName
		END		
		ELSE
			UPDATE dbo.Account SET DisplayName = @displayName, PassWord = @newPassword WHERE UserName = @userName
	end
END

GO
