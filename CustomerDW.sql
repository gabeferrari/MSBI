USE [master]
GO
/****** Object:  Database [CustomerDataWareHouse]    Script Date: 8/31/2015 9:35:23 PM ******/
CREATE DATABASE [CustomerDataWareHouse]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CustomerDataWareHouse', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\CustomerDataWareHouse.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'CustomerDataWareHouse_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\CustomerDataWareHouse_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [CustomerDataWareHouse] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CustomerDataWareHouse].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CustomerDataWareHouse] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CustomerDataWareHouse] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CustomerDataWareHouse] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CustomerDataWareHouse] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CustomerDataWareHouse] SET ARITHABORT OFF 
GO
ALTER DATABASE [CustomerDataWareHouse] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CustomerDataWareHouse] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CustomerDataWareHouse] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CustomerDataWareHouse] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CustomerDataWareHouse] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CustomerDataWareHouse] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CustomerDataWareHouse] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CustomerDataWareHouse] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CustomerDataWareHouse] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CustomerDataWareHouse] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CustomerDataWareHouse] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CustomerDataWareHouse] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CustomerDataWareHouse] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CustomerDataWareHouse] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CustomerDataWareHouse] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CustomerDataWareHouse] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CustomerDataWareHouse] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CustomerDataWareHouse] SET RECOVERY FULL 
GO
ALTER DATABASE [CustomerDataWareHouse] SET  MULTI_USER 
GO
ALTER DATABASE [CustomerDataWareHouse] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CustomerDataWareHouse] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CustomerDataWareHouse] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CustomerDataWareHouse] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'CustomerDataWareHouse', N'ON'
GO
USE [CustomerDataWareHouse]
GO
/****** Object:  Table [dbo].[DimCountry]    Script Date: 8/31/2015 9:35:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimCountry](
	[CountryId] [int] NOT NULL,
	[CountryName] [nvarchar](50) NULL,
	[IsNew] [bit] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DimProduct]    Script Date: 8/31/2015 9:35:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimProduct](
	[ProductId] [int] NOT NULL,
	[ProductName] [nvarchar](50) NULL,
	[DateCreated] [datetime] NULL,
	[DateExpired] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DimSalesPerson]    Script Date: 8/31/2015 9:35:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimSalesPerson](
	[SalesPersonId] [int] NOT NULL,
	[SalesPersonName] [nvarchar](50) NULL,
 CONSTRAINT [PK_DimSalesPerson] PRIMARY KEY CLUSTERED 
(
	[SalesPersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DimStates]    Script Date: 8/31/2015 9:35:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimStates](
	[StatesId] [int] NOT NULL,
	[StatesName] [nvarchar](50) NULL,
 CONSTRAINT [PK_DimStates] PRIMARY KEY CLUSTERED 
(
	[StatesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FactCustomer]    Script Date: 8/31/2015 9:35:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactCustomer](
	[CustomerCode] [nvarchar](50) NOT NULL,
	[CustomerName] [nvarchar](50) NULL,
	[CustomerAmount] [money] NULL,
	[SalesDate] [datetime] NULL,
	[Countryid_fk] [int] NULL,
	[StatesId_fk] [int] NULL,
	[Productid_fk] [int] NULL,
	[SalesPersonId_fk] [int] NULL,
 CONSTRAINT [PK_tblCustomer] PRIMARY KEY CLUSTERED 
(
	[CustomerCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[FactCustomer]  WITH NOCHECK ADD  CONSTRAINT [FK_FactCustomer_DimSalesPerson] FOREIGN KEY([SalesPersonId_fk])
REFERENCES [dbo].[DimSalesPerson] ([SalesPersonId])
GO
ALTER TABLE [dbo].[FactCustomer] CHECK CONSTRAINT [FK_FactCustomer_DimSalesPerson]
GO
ALTER TABLE [dbo].[FactCustomer]  WITH NOCHECK ADD  CONSTRAINT [FK_FactCustomer_DimStates] FOREIGN KEY([StatesId_fk])
REFERENCES [dbo].[DimStates] ([StatesId])
GO
ALTER TABLE [dbo].[FactCustomer] CHECK CONSTRAINT [FK_FactCustomer_DimStates]
GO
USE [master]
GO
ALTER DATABASE [CustomerDataWareHouse] SET  READ_WRITE 
GO
