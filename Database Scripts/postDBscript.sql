USE [master]
GO
/****** Object:  Database [postdb]    Script Date: 5/25/2021 2:13:24 PM ******/
CREATE DATABASE [postdb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'postdb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\postdb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'postdb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\postdb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [postdb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [postdb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [postdb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [postdb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [postdb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [postdb] SET ARITHABORT OFF 
GO
ALTER DATABASE [postdb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [postdb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [postdb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [postdb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [postdb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [postdb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [postdb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [postdb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [postdb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [postdb] SET  DISABLE_BROKER 
GO
ALTER DATABASE [postdb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [postdb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [postdb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [postdb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [postdb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [postdb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [postdb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [postdb] SET RECOVERY FULL 
GO
ALTER DATABASE [postdb] SET  MULTI_USER 
GO
ALTER DATABASE [postdb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [postdb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [postdb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [postdb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [postdb] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'postdb', N'ON'
GO
ALTER DATABASE [postdb] SET QUERY_STORE = OFF
GO
USE [postdb]
GO
/****** Object:  Table [dbo].[Collection]    Script Date: 5/25/2021 2:13:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Collection](
	[id] [uniqueidentifier] NOT NULL,
	[collection_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Collection] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CollectionContent]    Script Date: 5/25/2021 2:13:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CollectionContent](
	[id] [uniqueidentifier] NOT NULL,
	[collection_id] [uniqueidentifier] NOT NULL,
	[post_id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_CollectionContent] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comment]    Script Date: 5/25/2021 2:13:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comment](
	[id] [uniqueidentifier] NOT NULL,
	[timestamp] [datetime2](7) NOT NULL,
	[comment_text] [nvarchar](200) NOT NULL,
	[registered_user_id] [uniqueidentifier] NOT NULL,
	[post_id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Comment] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CommentProfileTags]    Script Date: 5/25/2021 2:13:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CommentProfileTags](
	[id] [uniqueidentifier] NOT NULL,
	[comment_id] [uniqueidentifier] NOT NULL,
	[registered_user_id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_CommentProfileTags] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Content]    Script Date: 5/25/2021 2:13:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Content](
	[id] [uniqueidentifier] NOT NULL,
	[post_id] [uniqueidentifier] NOT NULL,
	[content_path] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_Content] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DislikesList]    Script Date: 5/25/2021 2:13:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DislikesList](
	[id] [uniqueidentifier] NOT NULL,
	[post_id] [uniqueidentifier] NOT NULL,
	[registered_user_id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_DislikesList] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HashTags]    Script Date: 5/25/2021 2:13:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HashTags](
	[id] [uniqueidentifier] NOT NULL,
	[post_id] [uniqueidentifier] NOT NULL,
	[text] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_HashTags] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LikesList]    Script Date: 5/25/2021 2:13:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LikesList](
	[id] [uniqueidentifier] NOT NULL,
	[post_id] [uniqueidentifier] NOT NULL,
	[registered_user_id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_LikesList] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Location]    Script Date: 5/25/2021 2:13:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Location](
	[id] [uniqueidentifier] NOT NULL,
	[city_name] [nvarchar](30) NULL,
	[street] [nvarchar](50) NULL,
	[country] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Location] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Post]    Script Date: 5/25/2021 2:13:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Post](
	[id] [uniqueidentifier] NOT NULL,
	[timestamp] [datetime2](7) NOT NULL,
	[description] [nvarchar](200) NOT NULL,
	[registered_user_id] [uniqueidentifier] NOT NULL,
	[type] [nvarchar](10) NOT NULL,
	[location_id] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Post] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PostProfileTags]    Script Date: 5/25/2021 2:13:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PostProfileTags](
	[id] [uniqueidentifier] NOT NULL,
	[post_id] [uniqueidentifier] NOT NULL,
	[registered_user_id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_PostProfileTags] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RegisteredUser]    Script Date: 5/25/2021 2:13:24 PM ******/
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
	[isAcceptingTags] [bit] NOT NULL,
	[profilePicturePath] [nvarchar](250) NULL,
 CONSTRAINT [PK_RegisteredUser] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CollectionContent]  WITH CHECK ADD  CONSTRAINT [FK_CollectionContent_Collection] FOREIGN KEY([collection_id])
REFERENCES [dbo].[Collection] ([id])
GO
ALTER TABLE [dbo].[CollectionContent] CHECK CONSTRAINT [FK_CollectionContent_Collection]
GO
ALTER TABLE [dbo].[CollectionContent]  WITH CHECK ADD  CONSTRAINT [FK_CollectionContent_Post] FOREIGN KEY([post_id])
REFERENCES [dbo].[Post] ([id])
GO
ALTER TABLE [dbo].[CollectionContent] CHECK CONSTRAINT [FK_CollectionContent_Post]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_Post] FOREIGN KEY([post_id])
REFERENCES [dbo].[Post] ([id])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_Post]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_RegisteredUser] FOREIGN KEY([registered_user_id])
REFERENCES [dbo].[RegisteredUser] ([id])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_RegisteredUser]
GO
ALTER TABLE [dbo].[CommentProfileTags]  WITH CHECK ADD  CONSTRAINT [FK_CommentProfileTags_Comment] FOREIGN KEY([comment_id])
REFERENCES [dbo].[Comment] ([id])
GO
ALTER TABLE [dbo].[CommentProfileTags] CHECK CONSTRAINT [FK_CommentProfileTags_Comment]
GO
ALTER TABLE [dbo].[CommentProfileTags]  WITH CHECK ADD  CONSTRAINT [FK_CommentProfileTags_RegisteredUser] FOREIGN KEY([registered_user_id])
REFERENCES [dbo].[RegisteredUser] ([id])
GO
ALTER TABLE [dbo].[CommentProfileTags] CHECK CONSTRAINT [FK_CommentProfileTags_RegisteredUser]
GO
ALTER TABLE [dbo].[Content]  WITH CHECK ADD  CONSTRAINT [FK_Content_Post] FOREIGN KEY([post_id])
REFERENCES [dbo].[Post] ([id])
GO
ALTER TABLE [dbo].[Content] CHECK CONSTRAINT [FK_Content_Post]
GO
ALTER TABLE [dbo].[DislikesList]  WITH CHECK ADD  CONSTRAINT [FK_DislikesList_Post] FOREIGN KEY([post_id])
REFERENCES [dbo].[Post] ([id])
GO
ALTER TABLE [dbo].[DislikesList] CHECK CONSTRAINT [FK_DislikesList_Post]
GO
ALTER TABLE [dbo].[DislikesList]  WITH CHECK ADD  CONSTRAINT [FK_DislikesList_RegisteredUser] FOREIGN KEY([registered_user_id])
REFERENCES [dbo].[RegisteredUser] ([id])
GO
ALTER TABLE [dbo].[DislikesList] CHECK CONSTRAINT [FK_DislikesList_RegisteredUser]
GO
ALTER TABLE [dbo].[HashTags]  WITH CHECK ADD  CONSTRAINT [FK_HashTags_Post] FOREIGN KEY([post_id])
REFERENCES [dbo].[Post] ([id])
GO
ALTER TABLE [dbo].[HashTags] CHECK CONSTRAINT [FK_HashTags_Post]
GO
ALTER TABLE [dbo].[LikesList]  WITH CHECK ADD  CONSTRAINT [FK_LikesList_Post] FOREIGN KEY([post_id])
REFERENCES [dbo].[Post] ([id])
GO
ALTER TABLE [dbo].[LikesList] CHECK CONSTRAINT [FK_LikesList_Post]
GO
ALTER TABLE [dbo].[LikesList]  WITH CHECK ADD  CONSTRAINT [FK_LikesList_RegisteredUser] FOREIGN KEY([registered_user_id])
REFERENCES [dbo].[RegisteredUser] ([id])
GO
ALTER TABLE [dbo].[LikesList] CHECK CONSTRAINT [FK_LikesList_RegisteredUser]
GO
ALTER TABLE [dbo].[Post]  WITH CHECK ADD  CONSTRAINT [FK_Post_Location] FOREIGN KEY([location_id])
REFERENCES [dbo].[Location] ([id])
GO
ALTER TABLE [dbo].[Post] CHECK CONSTRAINT [FK_Post_Location]
GO
ALTER TABLE [dbo].[Post]  WITH CHECK ADD  CONSTRAINT [FK_Post_RegisteredUser] FOREIGN KEY([registered_user_id])
REFERENCES [dbo].[RegisteredUser] ([id])
GO
ALTER TABLE [dbo].[Post] CHECK CONSTRAINT [FK_Post_RegisteredUser]
GO
ALTER TABLE [dbo].[PostProfileTags]  WITH CHECK ADD  CONSTRAINT [FK_PostProfileTags_Post] FOREIGN KEY([post_id])
REFERENCES [dbo].[Post] ([id])
GO
ALTER TABLE [dbo].[PostProfileTags] CHECK CONSTRAINT [FK_PostProfileTags_Post]
GO
ALTER TABLE [dbo].[PostProfileTags]  WITH CHECK ADD  CONSTRAINT [FK_PostProfileTags_RegisteredUser] FOREIGN KEY([registered_user_id])
REFERENCES [dbo].[RegisteredUser] ([id])
GO
ALTER TABLE [dbo].[PostProfileTags] CHECK CONSTRAINT [FK_PostProfileTags_RegisteredUser]
GO
USE [master]
GO
ALTER DATABASE [postdb] SET  READ_WRITE 
GO
