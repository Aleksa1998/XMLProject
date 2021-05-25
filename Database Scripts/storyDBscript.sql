USE [master]
GO
/****** Object:  Database [storydb]    Script Date: 5/25/2021 2:14:03 PM ******/
CREATE DATABASE [storydb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'storydb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\storydb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'storydb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\storydb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [storydb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [storydb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [storydb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [storydb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [storydb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [storydb] SET ARITHABORT OFF 
GO
ALTER DATABASE [storydb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [storydb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [storydb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [storydb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [storydb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [storydb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [storydb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [storydb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [storydb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [storydb] SET  DISABLE_BROKER 
GO
ALTER DATABASE [storydb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [storydb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [storydb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [storydb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [storydb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [storydb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [storydb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [storydb] SET RECOVERY FULL 
GO
ALTER DATABASE [storydb] SET  MULTI_USER 
GO
ALTER DATABASE [storydb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [storydb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [storydb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [storydb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [storydb] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'storydb', N'ON'
GO
ALTER DATABASE [storydb] SET QUERY_STORE = OFF
GO
USE [storydb]
GO
/****** Object:  Table [dbo].[Highlights]    Script Date: 5/25/2021 2:14:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Highlights](
	[id] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Highlights] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProfileTags]    Script Date: 5/25/2021 2:14:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProfileTags](
	[id] [uniqueidentifier] NULL,
	[sto] [nchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RegisteredUser]    Script Date: 5/25/2021 2:14:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RegisteredUser](
	[id] [uniqueidentifier] NOT NULL,
	[username] [nvarchar](50) NOT NULL,
	[first_name] [nvarchar](50) NOT NULL,
	[last_name] [nvarchar](50) NOT NULL,
	[is_private] [bit] NOT NULL,
	[is_accepting_tags] [bit] NOT NULL,
	[profilePicturePath] [nvarchar](250) NULL,
 CONSTRAINT [PK_RegisteredUser] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Story]    Script Date: 5/25/2021 2:14:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Story](
	[id] [uniqueidentifier] NOT NULL,
	[content_path] [nvarchar](50) NOT NULL,
	[timestamp] [datetime2](7) NOT NULL,
	[type] [nvarchar](11) NOT NULL,
	[registered_user_id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Story] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StoryList]    Script Date: 5/25/2021 2:14:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StoryList](
	[id] [uniqueidentifier] NOT NULL,
	[story_id] [uniqueidentifier] NOT NULL,
	[highlights_id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_StoryList] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StoryProfileTags]    Script Date: 5/25/2021 2:14:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StoryProfileTags](
	[id] [uniqueidentifier] NOT NULL,
	[story_id] [uniqueidentifier] NOT NULL,
	[registered_user_id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_StoryProfileTags] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Story]  WITH CHECK ADD  CONSTRAINT [FK_Story_RegisteredUser] FOREIGN KEY([registered_user_id])
REFERENCES [dbo].[RegisteredUser] ([id])
GO
ALTER TABLE [dbo].[Story] CHECK CONSTRAINT [FK_Story_RegisteredUser]
GO
ALTER TABLE [dbo].[StoryList]  WITH CHECK ADD  CONSTRAINT [FK_StoryList_Highlights] FOREIGN KEY([highlights_id])
REFERENCES [dbo].[Highlights] ([id])
GO
ALTER TABLE [dbo].[StoryList] CHECK CONSTRAINT [FK_StoryList_Highlights]
GO
ALTER TABLE [dbo].[StoryList]  WITH CHECK ADD  CONSTRAINT [FK_StoryList_Story] FOREIGN KEY([story_id])
REFERENCES [dbo].[Story] ([id])
GO
ALTER TABLE [dbo].[StoryList] CHECK CONSTRAINT [FK_StoryList_Story]
GO
ALTER TABLE [dbo].[StoryProfileTags]  WITH CHECK ADD  CONSTRAINT [FK_StoryProfileTags_RegisteredUser] FOREIGN KEY([registered_user_id])
REFERENCES [dbo].[RegisteredUser] ([id])
GO
ALTER TABLE [dbo].[StoryProfileTags] CHECK CONSTRAINT [FK_StoryProfileTags_RegisteredUser]
GO
ALTER TABLE [dbo].[StoryProfileTags]  WITH CHECK ADD  CONSTRAINT [FK_StoryProfileTags_Story] FOREIGN KEY([story_id])
REFERENCES [dbo].[Story] ([id])
GO
ALTER TABLE [dbo].[StoryProfileTags] CHECK CONSTRAINT [FK_StoryProfileTags_Story]
GO
USE [master]
GO
ALTER DATABASE [storydb] SET  READ_WRITE 
GO
