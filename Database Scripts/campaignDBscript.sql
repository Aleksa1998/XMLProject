USE [master]
GO
/****** Object:  Database [campaigndb]    Script Date: 5/22/2021 2:21:18 PM ******/
CREATE DATABASE [campaigndb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'campaigndb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\campaigndb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'campaigndb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\campaigndb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [campaigndb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [campaigndb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [campaigndb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [campaigndb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [campaigndb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [campaigndb] SET ARITHABORT OFF 
GO
ALTER DATABASE [campaigndb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [campaigndb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [campaigndb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [campaigndb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [campaigndb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [campaigndb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [campaigndb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [campaigndb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [campaigndb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [campaigndb] SET  DISABLE_BROKER 
GO
ALTER DATABASE [campaigndb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [campaigndb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [campaigndb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [campaigndb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [campaigndb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [campaigndb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [campaigndb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [campaigndb] SET RECOVERY FULL 
GO
ALTER DATABASE [campaigndb] SET  MULTI_USER 
GO
ALTER DATABASE [campaigndb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [campaigndb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [campaigndb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [campaigndb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [campaigndb] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'campaigndb', N'ON'
GO
ALTER DATABASE [campaigndb] SET QUERY_STORE = OFF
GO
USE [campaigndb]
GO
/****** Object:  Table [dbo].[Ad]    Script Date: 5/22/2021 2:21:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ad](
	[id] [uniqueidentifier] NOT NULL,
	[content_path] [nvarchar](200) NOT NULL,
	[link] [nvarchar](250) NOT NULL,
	[clickCount] [int] NOT NULL,
	[campaign_id] [uniqueidentifier] NOT NULL,
	[verified_user_id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Ad] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Campaign]    Script Date: 5/22/2021 2:21:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Campaign](
	[id] [uniqueidentifier] NOT NULL,
	[target_audience_id] [uniqueidentifier] NOT NULL,
	[agent_id] [uniqueidentifier] NOT NULL,
	[likesCount] [int] NOT NULL,
	[dislikesCount] [int] NOT NULL,
	[exposureCount] [int] NOT NULL,
	[clickCount] [int] NOT NULL,
	[type] [nvarchar](22) NOT NULL,
	[start_date] [datetime2](7) NOT NULL,
	[end_date] [datetime2](7) NOT NULL,
	[date_of_change] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Campaign] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CampaignRequest]    Script Date: 5/22/2021 2:21:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CampaignRequest](
	[id] [uniqueidentifier] NOT NULL,
	[isApproved] [bit] NOT NULL,
	[campaign_id] [uniqueidentifier] NOT NULL,
	[verified_user_id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_CampaignRequest] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ExposureDateList]    Script Date: 5/22/2021 2:21:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExposureDateList](
	[id] [uniqueidentifier] NOT NULL,
	[campaign_id] [uniqueidentifier] NOT NULL,
	[exposure_date] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_ExposureDateList] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RegisteredUser]    Script Date: 5/22/2021 2:21:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RegisteredUser](
	[id] [uniqueidentifier] NOT NULL,
	[username] [nvarchar](50) NOT NULL,
	[date_of_birth] [datetime2](7) NULL,
	[gender] [nvarchar](6) NOT NULL,
	[type] [nvarchar](8) NOT NULL,
	[category] [nvarchar](20) NULL,
 CONSTRAINT [PK_RegisteredUser] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TargetAudience]    Script Date: 5/22/2021 2:21:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TargetAudience](
	[id] [uniqueidentifier] NOT NULL,
	[min_date_of_birth] [datetime2](7) NULL,
	[max_date_of_birth] [datetime2](7) NULL,
	[gender] [nvarchar](6) NULL,
 CONSTRAINT [PK_TargetAudience] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TargetAudienceMembers]    Script Date: 5/22/2021 2:21:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TargetAudienceMembers](
	[id] [uniqueidentifier] NOT NULL,
	[target_audience_id] [uniqueidentifier] NOT NULL,
	[registered_user_id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_TargetAudienceMembers] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Ad]  WITH CHECK ADD  CONSTRAINT [FK_Ad_Campaign] FOREIGN KEY([campaign_id])
REFERENCES [dbo].[Campaign] ([id])
GO
ALTER TABLE [dbo].[Ad] CHECK CONSTRAINT [FK_Ad_Campaign]
GO
ALTER TABLE [dbo].[Ad]  WITH CHECK ADD  CONSTRAINT [FK_Ad_RegisteredUser] FOREIGN KEY([verified_user_id])
REFERENCES [dbo].[RegisteredUser] ([id])
GO
ALTER TABLE [dbo].[Ad] CHECK CONSTRAINT [FK_Ad_RegisteredUser]
GO
ALTER TABLE [dbo].[Campaign]  WITH CHECK ADD  CONSTRAINT [FK_Campaign_RegisteredUser] FOREIGN KEY([agent_id])
REFERENCES [dbo].[RegisteredUser] ([id])
GO
ALTER TABLE [dbo].[Campaign] CHECK CONSTRAINT [FK_Campaign_RegisteredUser]
GO
ALTER TABLE [dbo].[Campaign]  WITH CHECK ADD  CONSTRAINT [FK_Campaign_TargetAudience] FOREIGN KEY([target_audience_id])
REFERENCES [dbo].[TargetAudience] ([id])
GO
ALTER TABLE [dbo].[Campaign] CHECK CONSTRAINT [FK_Campaign_TargetAudience]
GO
ALTER TABLE [dbo].[CampaignRequest]  WITH CHECK ADD  CONSTRAINT [FK_CampaignRequest_Campaign] FOREIGN KEY([campaign_id])
REFERENCES [dbo].[Campaign] ([id])
GO
ALTER TABLE [dbo].[CampaignRequest] CHECK CONSTRAINT [FK_CampaignRequest_Campaign]
GO
ALTER TABLE [dbo].[CampaignRequest]  WITH CHECK ADD  CONSTRAINT [FK_CampaignRequest_RegisteredUser] FOREIGN KEY([verified_user_id])
REFERENCES [dbo].[RegisteredUser] ([id])
GO
ALTER TABLE [dbo].[CampaignRequest] CHECK CONSTRAINT [FK_CampaignRequest_RegisteredUser]
GO
ALTER TABLE [dbo].[ExposureDateList]  WITH CHECK ADD  CONSTRAINT [FK_ExposureDateList_Campaign] FOREIGN KEY([campaign_id])
REFERENCES [dbo].[Campaign] ([id])
GO
ALTER TABLE [dbo].[ExposureDateList] CHECK CONSTRAINT [FK_ExposureDateList_Campaign]
GO
ALTER TABLE [dbo].[TargetAudienceMembers]  WITH CHECK ADD  CONSTRAINT [FK_TargetAudienceMembers_RegisteredUser] FOREIGN KEY([registered_user_id])
REFERENCES [dbo].[RegisteredUser] ([id])
GO
ALTER TABLE [dbo].[TargetAudienceMembers] CHECK CONSTRAINT [FK_TargetAudienceMembers_RegisteredUser]
GO
ALTER TABLE [dbo].[TargetAudienceMembers]  WITH CHECK ADD  CONSTRAINT [FK_TargetAudienceMembers_TargetAudience] FOREIGN KEY([target_audience_id])
REFERENCES [dbo].[TargetAudience] ([id])
GO
ALTER TABLE [dbo].[TargetAudienceMembers] CHECK CONSTRAINT [FK_TargetAudienceMembers_TargetAudience]
GO
USE [master]
GO
ALTER DATABASE [campaigndb] SET  READ_WRITE 
GO
