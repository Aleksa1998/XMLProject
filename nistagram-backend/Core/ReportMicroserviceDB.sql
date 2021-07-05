USE [master]
GO
/****** Object:  Database [reportdb]    Script Date: 6/19/2021 8:06:32 PM ******/
CREATE DATABASE [reportdb]
GO
ALTER DATABASE [reportdb] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [reportdb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [reportdb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [reportdb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [reportdb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [reportdb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [reportdb] SET ARITHABORT OFF 
GO
ALTER DATABASE [reportdb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [reportdb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [reportdb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [reportdb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [reportdb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [reportdb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [reportdb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [reportdb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [reportdb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [reportdb] SET  DISABLE_BROKER 
GO
ALTER DATABASE [reportdb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [reportdb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [reportdb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [reportdb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [reportdb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [reportdb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [reportdb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [reportdb] SET RECOVERY FULL 
GO
ALTER DATABASE [reportdb] SET  MULTI_USER 
GO
ALTER DATABASE [reportdb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [reportdb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [reportdb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [reportdb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [reportdb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [reportdb] SET QUERY_STORE = OFF
GO
USE [reportdb]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [reportdb]
GO
/****** Object:  Table [dbo].[RegisteredUser]    Script Date: 6/19/2021 8:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RegisteredUser](
	[id] [uniqueidentifier] NOT NULL,
	[username] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_RegisteredUser] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Report]    Script Date: 6/19/2021 8:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Report](
	[id] [uniqueidentifier] NOT NULL,
	[timestamp] [datetime2](7) NOT NULL,
	[report_reason] [nvarchar](250) NOT NULL,
	[registered_user_id] [uniqueidentifier] NOT NULL,
	[type] [nvarchar](10) NOT NULL,
	[content_id] [uniqueidentifier] NOT NULL,
	[action] [nvarchar](250) NULL,
 CONSTRAINT [PK_Report] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Report]  WITH CHECK ADD  CONSTRAINT [FK_Report_RegisteredUser] FOREIGN KEY([registered_user_id])
REFERENCES [dbo].[RegisteredUser] ([id])
GO
ALTER TABLE [dbo].[Report] CHECK CONSTRAINT [FK_Report_RegisteredUser]
GO
USE [master]
GO
ALTER DATABASE [reportdb] SET  READ_WRITE 
GO
