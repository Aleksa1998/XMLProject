USE [master]
GO
/****** Object:  Database [chatdb]    Script Date: 5/27/2021 1:28:44 PM ******/
CREATE DATABASE [chatdb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'chatdb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\chatdb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'chatdb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\chatdb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [chatdb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [chatdb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [chatdb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [chatdb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [chatdb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [chatdb] SET ARITHABORT OFF 
GO
ALTER DATABASE [chatdb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [chatdb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [chatdb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [chatdb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [chatdb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [chatdb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [chatdb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [chatdb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [chatdb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [chatdb] SET  DISABLE_BROKER 
GO
ALTER DATABASE [chatdb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [chatdb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [chatdb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [chatdb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [chatdb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [chatdb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [chatdb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [chatdb] SET RECOVERY FULL 
GO
ALTER DATABASE [chatdb] SET  MULTI_USER 
GO
ALTER DATABASE [chatdb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [chatdb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [chatdb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [chatdb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [chatdb] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'chatdb', N'ON'
GO
ALTER DATABASE [chatdb] SET QUERY_STORE = OFF
GO
USE [chatdb]
GO
/****** Object:  Table [dbo].[Blocks]    Script Date: 5/27/2021 1:28:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Blocks](
	[id] [uniqueidentifier] NOT NULL,
	[blocked_by_id] [uniqueidentifier] NOT NULL,
	[blocked_id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_BlockList] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Follows]    Script Date: 5/27/2021 1:28:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Follows](
	[id] [uniqueidentifier] NOT NULL,
	[followed_by_id] [uniqueidentifier] NOT NULL,
	[followed_id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_FollowList] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Message]    Script Date: 5/27/2021 1:28:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Message](
	[id] [uniqueidentifier] NOT NULL,
	[isApproved] [bit] NOT NULL,
	[timestamp] [datetime2](7) NULL,
	[message_content_id] [uniqueidentifier] NULL,
	[message_sender_id] [uniqueidentifier] NOT NULL,
	[message_receiver_id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Message] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MessageContent]    Script Date: 5/27/2021 1:28:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MessageContent](
	[id] [uniqueidentifier] NOT NULL,
	[text] [nvarchar](250) NULL,
	[image_path] [nvarchar](250) NULL,
	[type] [nvarchar](10) NULL,
	[content_id] [nvarchar](10) NULL,
	[isSeen] [bit] NOT NULL,
 CONSTRAINT [PK_MessageContent] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RegisteredUser]    Script Date: 5/27/2021 1:28:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RegisteredUser](
	[id] [uniqueidentifier] NOT NULL,
	[username] [nvarchar](50) NOT NULL,
	[first_name] [nvarchar](50) NULL,
	[last_name] [nvarchar](50) NULL,
	[isPrivate] [bit] NOT NULL,
	[isAcceptingMessages] [bit] NOT NULL,
	[profilePicturePath] [nvarchar](250) NULL,
 CONSTRAINT [PK_RegisteredUser] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Blocks]  WITH CHECK ADD  CONSTRAINT [FK_BlockList_RegisteredUser_blocked_by] FOREIGN KEY([blocked_by_id])
REFERENCES [dbo].[RegisteredUser] ([id])
GO
ALTER TABLE [dbo].[Blocks] CHECK CONSTRAINT [FK_BlockList_RegisteredUser_blocked_by]
GO
ALTER TABLE [dbo].[Blocks]  WITH CHECK ADD  CONSTRAINT [FK_BlockList_RegisteredUser_blocking] FOREIGN KEY([blocked_id])
REFERENCES [dbo].[RegisteredUser] ([id])
GO
ALTER TABLE [dbo].[Blocks] CHECK CONSTRAINT [FK_BlockList_RegisteredUser_blocking]
GO
ALTER TABLE [dbo].[Follows]  WITH CHECK ADD  CONSTRAINT [FK_FollowList_RegisteredUser_followed_by] FOREIGN KEY([followed_by_id])
REFERENCES [dbo].[RegisteredUser] ([id])
GO
ALTER TABLE [dbo].[Follows] CHECK CONSTRAINT [FK_FollowList_RegisteredUser_followed_by]
GO
ALTER TABLE [dbo].[Follows]  WITH CHECK ADD  CONSTRAINT [FK_FollowList_RegisteredUser_following] FOREIGN KEY([followed_id])
REFERENCES [dbo].[RegisteredUser] ([id])
GO
ALTER TABLE [dbo].[Follows] CHECK CONSTRAINT [FK_FollowList_RegisteredUser_following]
GO
ALTER TABLE [dbo].[Message]  WITH CHECK ADD  CONSTRAINT [FK_Message_MessageContent] FOREIGN KEY([message_content_id])
REFERENCES [dbo].[MessageContent] ([id])
GO
ALTER TABLE [dbo].[Message] CHECK CONSTRAINT [FK_Message_MessageContent]
GO
ALTER TABLE [dbo].[Message]  WITH CHECK ADD  CONSTRAINT [FK_Message_RegisteredUser_receiver] FOREIGN KEY([message_receiver_id])
REFERENCES [dbo].[RegisteredUser] ([id])
GO
ALTER TABLE [dbo].[Message] CHECK CONSTRAINT [FK_Message_RegisteredUser_receiver]
GO
ALTER TABLE [dbo].[Message]  WITH CHECK ADD  CONSTRAINT [FK_Message_RegisteredUser_sender] FOREIGN KEY([message_sender_id])
REFERENCES [dbo].[RegisteredUser] ([id])
GO
ALTER TABLE [dbo].[Message] CHECK CONSTRAINT [FK_Message_RegisteredUser_sender]
GO
USE [master]
GO
ALTER DATABASE [chatdb] SET  READ_WRITE 
GO
