USE [master]
GO
/****** Object:  Database [HMUNO_DB]    Script Date: 1/8/2017 6:06:47 PM ******/
CREATE DATABASE [HMUNO_DB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'HMUNO_DB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\HMUNO_DB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'HMUNO_DB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\HMUNO_DB_log.ldf' , SIZE = 504KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
GO
ALTER DATABASE [HMUNO_DB] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HMUNO_DB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [HMUNO_DB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [HMUNO_DB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [HMUNO_DB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [HMUNO_DB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [HMUNO_DB] SET ARITHABORT OFF 
GO
ALTER DATABASE [HMUNO_DB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [HMUNO_DB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [HMUNO_DB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [HMUNO_DB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [HMUNO_DB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [HMUNO_DB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [HMUNO_DB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [HMUNO_DB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [HMUNO_DB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [HMUNO_DB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [HMUNO_DB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [HMUNO_DB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [HMUNO_DB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [HMUNO_DB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [HMUNO_DB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [HMUNO_DB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [HMUNO_DB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [HMUNO_DB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [HMUNO_DB] SET  MULTI_USER 
GO
ALTER DATABASE [HMUNO_DB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [HMUNO_DB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [HMUNO_DB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [HMUNO_DB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [HMUNO_DB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'HMUNO_DB', N'ON'
GO
ALTER DATABASE [HMUNO_DB] SET QUERY_STORE = OFF
GO
USE [HMUNO_DB]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [HMUNO_DB]
GO
/****** Object:  DatabaseRole [Organizers]    Script Date: 1/8/2017 6:06:47 PM ******/
CREATE ROLE [Organizers]
GO
/****** Object:  DatabaseRole [Advisors]    Script Date: 1/8/2017 6:06:47 PM ******/
CREATE ROLE [Advisors]
GO
/****** Object:  DatabaseRole [Admins]    Script Date: 1/8/2017 6:06:47 PM ******/
CREATE ROLE [Admins]
GO
/****** Object:  Table [dbo].[Schools]    Script Date: 1/8/2017 6:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Schools](
	[School_ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[Address] [varchar](100) NOT NULL,
	[Postal_Code] [int] NOT NULL,
	[Payment_Info] [int] NOT NULL,
 CONSTRAINT [PK_Schools] PRIMARY KEY CLUSTERED 
(
	[School_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Participant]    Script Date: 1/8/2017 6:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Participant](
	[Participant_ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Surname] [varchar](50) NOT NULL,
	[Date_of_birth] [date] NULL,
 CONSTRAINT [PK__Particip__E05F08252DF064B4] PRIMARY KEY CLUSTERED 
(
	[Participant_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Advisors_in_Schools]    Script Date: 1/8/2017 6:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Advisors_in_Schools](
	[Advisor_ID] [int] NOT NULL,
	[School_ID] [int] NOT NULL,
 CONSTRAINT [PK_Advisors_in_Schools] PRIMARY KEY CLUSTERED 
(
	[Advisor_ID] ASC,
	[School_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Delegates]    Script Date: 1/8/2017 6:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Delegates](
	[Delegate_ID] [int] NOT NULL,
	[School] [int] NULL,
 CONSTRAINT [PK_Delegates] PRIMARY KEY CLUSTERED 
(
	[Delegate_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Delegates_in_Countries]    Script Date: 1/8/2017 6:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Delegates_in_Countries](
	[Participant_ID] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Delegates_in_Countries] PRIMARY KEY CLUSTERED 
(
	[Participant_ID] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[Advisor_View]    Script Date: 1/8/2017 6:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Advisor_View]
AS
WITH A AS (SELECT        Advisor_ID, School_ID
                         FROM            dbo.Advisors_in_Schools
                         WHERE        (Advisor_ID = 4)), B AS
    (SELECT        School_ID, Name, Address, Postal_Code, Payment_Info
      FROM            dbo.Schools
      WHERE        (School_ID IN
                                    (SELECT        School_ID
                                      FROM            A AS A_1))), C AS
    (SELECT        Delegate_ID, School
      FROM            dbo.Delegates
      WHERE        (School IN
                                    (SELECT        School_ID
                                      FROM            B AS B_1))), D AS
    (SELECT        C_1.Delegate_ID, C_1.School, S.Participant_ID, S.Name
      FROM            C AS C_1 INNER JOIN
                                dbo.Delegates_in_Countries AS S ON C_1.Delegate_ID = S.Participant_ID)
    SELECT        dbo.Participant.Name, dbo.Participant.Surname, D_1.Name AS CountryName
     FROM            dbo.Participant INNER JOIN
                              D AS D_1 ON dbo.Participant.Participant_ID = D_1.Delegate_ID

GO
/****** Object:  Table [dbo].[Committees]    Script Date: 1/8/2017 6:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Committees](
	[Committee_ID] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[TopicA] [varchar](200) NOT NULL,
	[TpociB] [varchar](200) NULL,
	[Conference] [int] NOT NULL,
	[Officer1] [int] NULL,
	[Officer2] [int] NULL,
	[Press_Member] [int] NULL,
 CONSTRAINT [PK_Committees] PRIMARY KEY CLUSTERED 
(
	[Committee_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Delegates_in_Committees]    Script Date: 1/8/2017 6:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Delegates_in_Committees](
	[Participant_ID] [int] NOT NULL,
	[Committee_ID] [int] NOT NULL,
 CONSTRAINT [PK_Delegates_in_Committees] PRIMARY KEY CLUSTERED 
(
	[Participant_ID] ASC,
	[Committee_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[Delegates_in_Committee_View]    Script Date: 1/8/2017 6:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Delegates_in_Committee_View]
AS
WITH X AS (SELECT        Committee_ID
                          FROM            dbo.Committees
                          WHERE        (Name = 'Sustainable Development 2015')), Y AS
    (SELECT        Participant_ID
      FROM            dbo.Delegates_in_Committees
      WHERE        (Committee_ID IN
                                    (SELECT        Committee_ID
                                      FROM            X AS X_1)))
    SELECT        Name, Surname
     FROM            dbo.Participant
     WHERE        (Participant_ID IN
                                  (SELECT        Participant_ID
                                    FROM            Y AS Y_1))

GO
/****** Object:  View [dbo].[Committees_View]    Script Date: 1/8/2017 6:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Committees_View]
AS
SELECT        Name
FROM            dbo.Committees
WHERE        (Conference = 4)

GO
/****** Object:  Table [dbo].[Advisors]    Script Date: 1/8/2017 6:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Advisors](
	[Advisor_ID] [int] NOT NULL,
	[Mail] [varchar](50) NOT NULL,
	[Phone] [bigint] NOT NULL,
	[Expertise] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Advisors] PRIMARY KEY CLUSTERED 
(
	[Advisor_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Cities_and_Postal_code_Map]    Script Date: 1/8/2017 6:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cities_and_Postal_code_Map](
	[Postal_code] [int] NOT NULL,
	[City] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Cities_and_Postal_code_Map] PRIMARY KEY CLUSTERED 
(
	[Postal_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Conferences]    Script Date: 1/8/2017 6:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Conferences](
	[Numbered_Title] [int] NOT NULL,
	[Location] [varchar](50) NULL,
	[Date] [date] NOT NULL,
 CONSTRAINT [PK_Conferences] PRIMARY KEY CLUSTERED 
(
	[Numbered_Title] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Countries]    Script Date: 1/8/2017 6:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Countries](
	[Name] [varchar](50) NOT NULL,
	[Region] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Countries] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Countries_in_Committees]    Script Date: 1/8/2017 6:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Countries_in_Committees](
	[Name] [varchar](50) NOT NULL,
	[Committee_ID] [int] NOT NULL,
 CONSTRAINT [PK_Countries_in_Committees] PRIMARY KEY CLUSTERED 
(
	[Name] ASC,
	[Committee_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Officers]    Script Date: 1/8/2017 6:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Officers](
	[Officer_ID] [int] NOT NULL,
	[Mail] [varchar](50) NOT NULL,
	[Phone] [bigint] NULL,
	[Experience] [int] NOT NULL,
 CONSTRAINT [PK_Officers] PRIMARY KEY CLUSTERED 
(
	[Officer_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Press]    Script Date: 1/8/2017 6:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Press](
	[Press_ID] [int] NOT NULL,
	[Experience] [int] NOT NULL,
 CONSTRAINT [PK_Press] PRIMARY KEY CLUSTERED 
(
	[Press_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[Advisors] ([Advisor_ID], [Mail], [Phone], [Expertise]) VALUES (1, N'c.papaioannou09@gmail.com', 6980099789, N'English')
INSERT [dbo].[Advisors] ([Advisor_ID], [Mail], [Phone], [Expertise]) VALUES (2, N'davgerinou@hotmail.com', 6983349789, N'English')
INSERT [dbo].[Advisors] ([Advisor_ID], [Mail], [Phone], [Expertise]) VALUES (3, N'akokkinidou@gmail.com', 6989898879, N'English')
INSERT [dbo].[Advisors] ([Advisor_ID], [Mail], [Phone], [Expertise]) VALUES (4, N'dimitraanast2012@yahoo.gr', 6982318224, N'English')
INSERT [dbo].[Advisors] ([Advisor_ID], [Mail], [Phone], [Expertise]) VALUES (35, N'kleageo@gmail.com', 6944823569, N'Philologist')
INSERT [dbo].[Advisors] ([Advisor_ID], [Mail], [Phone], [Expertise]) VALUES (36, N'm.glaraki@gmail.com', 6972516934, N'Philologist')
INSERT [dbo].[Advisors] ([Advisor_ID], [Mail], [Phone], [Expertise]) VALUES (37, N'tyro.mpampis@yahoo.com', 6945182464, N'Mathematics')
INSERT [dbo].[Advisors] ([Advisor_ID], [Mail], [Phone], [Expertise]) VALUES (38, N'xaritini.gouso@yahoo.com', 6944124578, N'Fine Arts')
INSERT [dbo].[Advisors] ([Advisor_ID], [Mail], [Phone], [Expertise]) VALUES (39, N'm.nikiforidou@gmail.com', 6988005232, N'Philologist')
INSERT [dbo].[Advisors] ([Advisor_ID], [Mail], [Phone], [Expertise]) VALUES (40, N'tani.geo@gmail.com', 6987365100, N'Philologist')
INSERT [dbo].[Advisors] ([Advisor_ID], [Mail], [Phone], [Expertise]) VALUES (41, N'chlorophili@yahoo.com', 6990300100, N'Physics')
INSERT [dbo].[Advisors] ([Advisor_ID], [Mail], [Phone], [Expertise]) VALUES (42, N'a.rizou@gmail.com', 6978323568, N'Philologist')
INSERT [dbo].[Advisors] ([Advisor_ID], [Mail], [Phone], [Expertise]) VALUES (43, N'gerokyriakos@hotmail.com', 6944086395, N'English')
INSERT [dbo].[Advisors] ([Advisor_ID], [Mail], [Phone], [Expertise]) VALUES (44, N'glykeriasarafi@hotmail.com', 6945359157, N'English')
INSERT [dbo].[Advisors] ([Advisor_ID], [Mail], [Phone], [Expertise]) VALUES (45, N'n.papadimitriou78@gmail.com', 6935697159, N'Mathematics')
INSERT [dbo].[Advisors] ([Advisor_ID], [Mail], [Phone], [Expertise]) VALUES (46, N'm.papagiannis1985@gmail.com', 6932156987, N'Philologist')
INSERT [dbo].[Advisors] ([Advisor_ID], [Mail], [Phone], [Expertise]) VALUES (47, N'g.papatriantafyllou@yahoo.com', 6988563225, N'Philologist')
INSERT [dbo].[Advisors] ([Advisor_ID], [Mail], [Phone], [Expertise]) VALUES (48, N'n.varia@gmail.com', 6977256365, N'Philologist')
INSERT [dbo].[Advisors_in_Schools] ([Advisor_ID], [School_ID]) VALUES (1, 5)
INSERT [dbo].[Advisors_in_Schools] ([Advisor_ID], [School_ID]) VALUES (1, 24)
INSERT [dbo].[Advisors_in_Schools] ([Advisor_ID], [School_ID]) VALUES (2, 8)
INSERT [dbo].[Advisors_in_Schools] ([Advisor_ID], [School_ID]) VALUES (3, 7)
INSERT [dbo].[Advisors_in_Schools] ([Advisor_ID], [School_ID]) VALUES (3, 8)
INSERT [dbo].[Advisors_in_Schools] ([Advisor_ID], [School_ID]) VALUES (4, 3)
INSERT [dbo].[Advisors_in_Schools] ([Advisor_ID], [School_ID]) VALUES (4, 10)
INSERT [dbo].[Advisors_in_Schools] ([Advisor_ID], [School_ID]) VALUES (35, 1)
INSERT [dbo].[Advisors_in_Schools] ([Advisor_ID], [School_ID]) VALUES (36, 13)
INSERT [dbo].[Advisors_in_Schools] ([Advisor_ID], [School_ID]) VALUES (36, 14)
INSERT [dbo].[Advisors_in_Schools] ([Advisor_ID], [School_ID]) VALUES (36, 15)
INSERT [dbo].[Advisors_in_Schools] ([Advisor_ID], [School_ID]) VALUES (37, 13)
INSERT [dbo].[Advisors_in_Schools] ([Advisor_ID], [School_ID]) VALUES (37, 14)
INSERT [dbo].[Advisors_in_Schools] ([Advisor_ID], [School_ID]) VALUES (37, 15)
INSERT [dbo].[Advisors_in_Schools] ([Advisor_ID], [School_ID]) VALUES (38, 16)
INSERT [dbo].[Advisors_in_Schools] ([Advisor_ID], [School_ID]) VALUES (38, 17)
INSERT [dbo].[Advisors_in_Schools] ([Advisor_ID], [School_ID]) VALUES (39, 18)
INSERT [dbo].[Advisors_in_Schools] ([Advisor_ID], [School_ID]) VALUES (39, 19)
INSERT [dbo].[Advisors_in_Schools] ([Advisor_ID], [School_ID]) VALUES (40, 25)
INSERT [dbo].[Advisors_in_Schools] ([Advisor_ID], [School_ID]) VALUES (41, 24)
INSERT [dbo].[Advisors_in_Schools] ([Advisor_ID], [School_ID]) VALUES (42, 20)
INSERT [dbo].[Advisors_in_Schools] ([Advisor_ID], [School_ID]) VALUES (42, 21)
INSERT [dbo].[Advisors_in_Schools] ([Advisor_ID], [School_ID]) VALUES (43, 22)
INSERT [dbo].[Advisors_in_Schools] ([Advisor_ID], [School_ID]) VALUES (43, 23)
INSERT [dbo].[Advisors_in_Schools] ([Advisor_ID], [School_ID]) VALUES (44, 26)
INSERT [dbo].[Advisors_in_Schools] ([Advisor_ID], [School_ID]) VALUES (45, 1)
INSERT [dbo].[Advisors_in_Schools] ([Advisor_ID], [School_ID]) VALUES (45, 2)
INSERT [dbo].[Advisors_in_Schools] ([Advisor_ID], [School_ID]) VALUES (46, 2)
INSERT [dbo].[Advisors_in_Schools] ([Advisor_ID], [School_ID]) VALUES (46, 4)
INSERT [dbo].[Advisors_in_Schools] ([Advisor_ID], [School_ID]) VALUES (46, 5)
INSERT [dbo].[Advisors_in_Schools] ([Advisor_ID], [School_ID]) VALUES (47, 3)
INSERT [dbo].[Advisors_in_Schools] ([Advisor_ID], [School_ID]) VALUES (47, 6)
INSERT [dbo].[Advisors_in_Schools] ([Advisor_ID], [School_ID]) VALUES (47, 9)
INSERT [dbo].[Advisors_in_Schools] ([Advisor_ID], [School_ID]) VALUES (48, 11)
INSERT [dbo].[Advisors_in_Schools] ([Advisor_ID], [School_ID]) VALUES (48, 12)
INSERT [dbo].[Cities_and_Postal_code_Map] ([Postal_code], [City]) VALUES (50032, N'Thessaloniki')
INSERT [dbo].[Cities_and_Postal_code_Map] ([Postal_code], [City]) VALUES (50069, N'Thessaloniki')
INSERT [dbo].[Cities_and_Postal_code_Map] ([Postal_code], [City]) VALUES (50232, N'Thessaloniki')
INSERT [dbo].[Cities_and_Postal_code_Map] ([Postal_code], [City]) VALUES (50987, N'Thessaloniki')
INSERT [dbo].[Cities_and_Postal_code_Map] ([Postal_code], [City]) VALUES (51036, N'Thessaloniki')
INSERT [dbo].[Cities_and_Postal_code_Map] ([Postal_code], [City]) VALUES (51269, N'Thessaloniki')
INSERT [dbo].[Cities_and_Postal_code_Map] ([Postal_code], [City]) VALUES (51293, N'Thessaloniki')
INSERT [dbo].[Cities_and_Postal_code_Map] ([Postal_code], [City]) VALUES (51369, N'Thessaloniki')
INSERT [dbo].[Cities_and_Postal_code_Map] ([Postal_code], [City]) VALUES (52369, N'Thessaloniki')
INSERT [dbo].[Cities_and_Postal_code_Map] ([Postal_code], [City]) VALUES (53624, N'Thessaloniki')
INSERT [dbo].[Cities_and_Postal_code_Map] ([Postal_code], [City]) VALUES (54129, N'Thessaloniki')
INSERT [dbo].[Cities_and_Postal_code_Map] ([Postal_code], [City]) VALUES (54236, N'Thessaloniki')
INSERT [dbo].[Cities_and_Postal_code_Map] ([Postal_code], [City]) VALUES (54254, N'Thessaloniki')
INSERT [dbo].[Cities_and_Postal_code_Map] ([Postal_code], [City]) VALUES (54632, N'Thessaloniki')
INSERT [dbo].[Cities_and_Postal_code_Map] ([Postal_code], [City]) VALUES (54635, N'Thessaloniki')
INSERT [dbo].[Cities_and_Postal_code_Map] ([Postal_code], [City]) VALUES (54698, N'Thessaloniki')
INSERT [dbo].[Cities_and_Postal_code_Map] ([Postal_code], [City]) VALUES (54823, N'Thessaloniki')
INSERT [dbo].[Cities_and_Postal_code_Map] ([Postal_code], [City]) VALUES (54874, N'Thessaloniki')
INSERT [dbo].[Cities_and_Postal_code_Map] ([Postal_code], [City]) VALUES (55133, N'Thessaloniki')
INSERT [dbo].[Cities_and_Postal_code_Map] ([Postal_code], [City]) VALUES (55222, N'Thessaloniki')
INSERT [dbo].[Cities_and_Postal_code_Map] ([Postal_code], [City]) VALUES (55236, N'Thessaloniki')
INSERT [dbo].[Cities_and_Postal_code_Map] ([Postal_code], [City]) VALUES (55255, N'Thessaloniki')
INSERT [dbo].[Cities_and_Postal_code_Map] ([Postal_code], [City]) VALUES (55355, N'Thessaloniki')
INSERT [dbo].[Cities_and_Postal_code_Map] ([Postal_code], [City]) VALUES (55535, N'Thessaloniki')
INSERT [dbo].[Cities_and_Postal_code_Map] ([Postal_code], [City]) VALUES (56224, N'Thessaloniki')
INSERT [dbo].[Cities_and_Postal_code_Map] ([Postal_code], [City]) VALUES (56352, N'Thessaloniki')
INSERT [dbo].[Cities_and_Postal_code_Map] ([Postal_code], [City]) VALUES (56952, N'Thessaloniki')
INSERT [dbo].[Cities_and_Postal_code_Map] ([Postal_code], [City]) VALUES (57001, N'Thessaloniki')
INSERT [dbo].[Cities_and_Postal_code_Map] ([Postal_code], [City]) VALUES (57013, N'Thessaloniki')
INSERT [dbo].[Cities_and_Postal_code_Map] ([Postal_code], [City]) VALUES (57632, N'Thessaloniki')
INSERT [dbo].[Cities_and_Postal_code_Map] ([Postal_code], [City]) VALUES (57842, N'Thessaloniki')
INSERT [dbo].[Cities_and_Postal_code_Map] ([Postal_code], [City]) VALUES (58264, N'Thessaloniki')
INSERT [dbo].[Cities_and_Postal_code_Map] ([Postal_code], [City]) VALUES (58351, N'Thessaloniki')
INSERT [dbo].[Cities_and_Postal_code_Map] ([Postal_code], [City]) VALUES (58623, N'Thessaloniki')
INSERT [dbo].[Cities_and_Postal_code_Map] ([Postal_code], [City]) VALUES (58963, N'Thessaloniki')
INSERT [dbo].[Cities_and_Postal_code_Map] ([Postal_code], [City]) VALUES (59003, N'Thessaloniki')
INSERT [dbo].[Cities_and_Postal_code_Map] ([Postal_code], [City]) VALUES (59006, N'Thessaloniki')
INSERT [dbo].[Cities_and_Postal_code_Map] ([Postal_code], [City]) VALUES (59236, N'Thessaloniki')
INSERT [dbo].[Cities_and_Postal_code_Map] ([Postal_code], [City]) VALUES (59805, N'Thessaloniki')
INSERT [dbo].[Cities_and_Postal_code_Map] ([Postal_code], [City]) VALUES (59874, N'Thessaloniki')
INSERT [dbo].[Cities_and_Postal_code_Map] ([Postal_code], [City]) VALUES (61007, N'Evropos')
INSERT [dbo].[Cities_and_Postal_code_Map] ([Postal_code], [City]) VALUES (67100, N'Xanthi')
INSERT [dbo].[Committees] ([Committee_ID], [Name], [TopicA], [TpociB], [Conference], [Officer1], [Officer2], [Press_Member]) VALUES (1, N'UNESCO 2015', N'Assistance to kids of the 3rd World Counties During Crisis', NULL, 4, 22, 23, 49)
INSERT [dbo].[Committees] ([Committee_ID], [Name], [TopicA], [TpociB], [Conference], [Officer1], [Officer2], [Press_Member]) VALUES (2, N'Disarmament and International Security 2015', N'National Security During Crisis', NULL, 4, 24, 26, 50)
INSERT [dbo].[Committees] ([Committee_ID], [Name], [TopicA], [TpociB], [Conference], [Officer1], [Officer2], [Press_Member]) VALUES (3, N'Social Humanitarian and Cultural 2015', N'SubCulture during Crisis', NULL, 4, 57, 58, 51)
INSERT [dbo].[Committees] ([Committee_ID], [Name], [TopicA], [TpociB], [Conference], [Officer1], [Officer2], [Press_Member]) VALUES (4, N'Political and Decolonisation 2015', N'USA as a major political influence in Europe', NULL, 4, 59, 60, 52)
INSERT [dbo].[Committees] ([Committee_ID], [Name], [TopicA], [TpociB], [Conference], [Officer1], [Officer2], [Press_Member]) VALUES (5, N'Economic and Social Development 2015', N'How can volunteering help the economy to boost', NULL, 4, 61, 62, 53)
INSERT [dbo].[Committees] ([Committee_ID], [Name], [TopicA], [TpociB], [Conference], [Officer1], [Officer2], [Press_Member]) VALUES (6, N'Sustainable Development 2015', N'Start Up Businesses during Crisis', NULL, 4, 63, 64, 54)
INSERT [dbo].[Committees] ([Committee_ID], [Name], [TopicA], [TpociB], [Conference], [Officer1], [Officer2], [Press_Member]) VALUES (7, N'Security Council 2015', N'Is there a need to discuss about a Security council?', NULL, 4, 65, 66, 55)
INSERT [dbo].[Conferences] ([Numbered_Title], [Location], [Date]) VALUES (1, N'American Farm School', CAST(N'2012-04-24' AS Date))
INSERT [dbo].[Conferences] ([Numbered_Title], [Location], [Date]) VALUES (2, N'Hellenic College', CAST(N'2013-05-27' AS Date))
INSERT [dbo].[Conferences] ([Numbered_Title], [Location], [Date]) VALUES (3, N'Arsakeio Sxoleio Thessalonikis', CAST(N'2014-04-17' AS Date))
INSERT [dbo].[Conferences] ([Numbered_Title], [Location], [Date]) VALUES (4, N'Ekpaideutiria Mantoulidi', CAST(N'2015-03-30' AS Date))
INSERT [dbo].[Conferences] ([Numbered_Title], [Location], [Date]) VALUES (5, N'Ekpaideutiria Fryganiwti', CAST(N'2016-05-01' AS Date))
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'Angola
', N'Middle and Western Africa
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'Armenia
', N'Western Asia
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'Austria
', N'Northern and Western Europe
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'Azerbaijan
', N'Western Asia
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'Belarus
', N'Southern and Eastern Europe
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'Cambodia
', N'South-Eastern Asia and Oceania
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'Canada
', N'Northern, Central and South America
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'Central African Republic
', N'Middle and Western Africa
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'Chad
', N'Middle and Western Africa
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'Chile
', N'Northern, Central and South America
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'China
', N'Eastern Asia
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'DPR Korea
', N'Eastern Asia
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'Egypt
', N'Northern Africa
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'Eritrea
', N'Southern and Eastern Africa
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'Estonia
', N'Northern and Western Europe
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'France
', N'Northern and Western Europe
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'Germany
', N'Northern and Western Europe
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'Guatemala
', N'Northern, Central and South America
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'Hungary
', N'Southern and Eastern Europe
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'India
', N'South-central Asia
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'Indonesia
', N'South-Eastern Asia and Oceania
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'Iran
', N'South-central Asia
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'Iraq
', N'Western Asia
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'Israel
', N'Western Asia
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'Japan
', N'Eastern Asia
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'Jordan
', N'Western Asia
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'Kazakhstan
', N'South-central Asia
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'Kenya
', N'Southern and Eastern Africa
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'Lithuania
', N'Northern and Western Europe
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'Malaysia
', N'South-Eastern Asia and Oceania
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'Mauritania
', N'Middle and Western Africa
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'New Zealand
', N'South-Eastern Asia and Oceania
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'Nigeria
', N'Middle and Western Africa
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'Norway
', N'Northern and Western Europe
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'Pakistan
', N'South-central Asia
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'Peru
', N'Northern, Central and South America
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'Rep. of Moldova
', N'Southern and Eastern Europe
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'Republic of Korea
', N'Eastern Asia
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'Russian Federation
', N'Southern and Eastern Europe
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'South Africa
', N'Southern and Eastern Africa
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'Spain
', N'Southern and Eastern Europe
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'Syria
', N'Western Asia
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'Turkey
', N'Western Asia
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'United Kingdom
', N'Northern and Western Europe
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'United States of America
', N'Northern, Central and South America
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'Venezuela
', N'Northern, Central and South America
')
INSERT [dbo].[Countries] ([Name], [Region]) VALUES (N'Yemen
', N'Western Asia
')
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Angola
', 4)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Angola
', 6)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Angola
', 7)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Armenia
', 1)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Armenia
', 2)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Armenia
', 3)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Armenia
', 4)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Armenia
', 5)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Austria
', 1)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Austria
', 5)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Azerbaijan
', 1)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Azerbaijan
', 2)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Azerbaijan
', 3)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Azerbaijan
', 4)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Azerbaijan
', 5)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Belarus
', 1)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Belarus
', 4)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Belarus
', 5)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Cambodia
', 5)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Cambodia
', 6)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Canada
', 2)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Canada
', 3)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Canada
', 5)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Canada
', 6)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Central African Republic
', 2)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Central African Republic
', 3)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Central African Republic
', 4)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Central African Republic
', 5)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Chad
', 4)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Chad
', 5)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Chad
', 6)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Chad
', 7)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Chile
', 1)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Chile
', 2)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Chile
', 3)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Chile
', 4)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Chile
', 7)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'China
', 1)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'China
', 2)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'China
', 3)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'China
', 4)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'China
', 5)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'China
', 6)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'China
', 7)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'DPR Korea
', 1)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'DPR Korea
', 2)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'DPR Korea
', 3)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'DPR Korea
', 4)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Egypt
', 1)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Egypt
', 2)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Egypt
', 4)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Eritrea
', 1)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Eritrea
', 4)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Estonia
', 2)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Estonia
', 4)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Estonia
', 6)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'France
', 1)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'France
', 2)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'France
', 3)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'France
', 4)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'France
', 5)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'France
', 6)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'France
', 7)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Germany
', 1)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Germany
', 2)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Germany
', 3)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Germany
', 5)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Germany
', 6)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Guatemala
', 1)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Guatemala
', 3)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Guatemala
', 6)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Hungary
', 2)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Hungary
', 3)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Hungary
', 6)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'India
', 1)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'India
', 2)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'India
', 3)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'India
', 4)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'India
', 5)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'India
', 6)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Indonesia
', 1)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Indonesia
', 2)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Indonesia
', 3)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Indonesia
', 4)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Indonesia
', 5)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Indonesia
', 6)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Iran
', 1)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Iran
', 2)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Iran
', 3)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Iraq
', 1)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Iraq
', 2)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Iraq
', 6)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Israel
', 1)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Israel
', 2)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Israel
', 3)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Japan
', 1)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Japan
', 2)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Japan
', 3)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Japan
', 5)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Japan
', 6)
GO
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Jordan
', 1)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Jordan
', 2)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Jordan
', 4)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Jordan
', 7)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Kazakhstan
', 4)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Kazakhstan
', 5)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Kazakhstan
', 6)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Kenya
', 1)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Kenya
', 4)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Lithuania
', 2)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Lithuania
', 3)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Lithuania
', 4)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Lithuania
', 6)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Lithuania
', 7)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Malaysia
', 1)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Malaysia
', 3)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Malaysia
', 4)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Malaysia
', 5)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Malaysia
', 6)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Malaysia
', 7)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Mauritania
', 2)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Mauritania
', 3)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'New Zealand
', 2)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'New Zealand
', 5)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'New Zealand
', 6)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'New Zealand
', 7)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Nigeria
', 1)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Nigeria
', 2)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Nigeria
', 3)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Nigeria
', 4)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Nigeria
', 7)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Norway
', 1)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Norway
', 3)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Norway
', 5)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Pakistan
', 1)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Pakistan
', 2)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Pakistan
', 3)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Pakistan
', 6)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Peru
', 1)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Peru
', 2)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Peru
', 4)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Rep. of Moldova
', 2)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Rep. of Moldova
', 3)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Rep. of Moldova
', 4)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Republic of Korea
', 2)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Republic of Korea
', 4)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Republic of Korea
', 5)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Russian Federation
', 1)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Russian Federation
', 2)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Russian Federation
', 3)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Russian Federation
', 4)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Russian Federation
', 5)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Russian Federation
', 6)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Russian Federation
', 7)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'South Africa
', 1)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'South Africa
', 2)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'South Africa
', 5)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'South Africa
', 6)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Spain
', 1)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Spain
', 2)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Spain
', 3)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Spain
', 4)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Spain
', 5)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Spain
', 6)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Spain
', 7)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Syria
', 1)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Syria
', 2)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Syria
', 3)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Turkey
', 2)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Turkey
', 3)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'United Kingdom
', 1)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'United Kingdom
', 2)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'United Kingdom
', 3)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'United Kingdom
', 4)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'United Kingdom
', 5)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'United Kingdom
', 6)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'United Kingdom
', 7)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'United States of America
', 1)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'United States of America
', 2)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'United States of America
', 3)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'United States of America
', 4)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'United States of America
', 5)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'United States of America
', 6)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'United States of America
', 7)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Venezuela
', 1)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Venezuela
', 4)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Venezuela
', 5)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Venezuela
', 6)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Venezuela
', 7)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Yemen
', 1)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Yemen
', 2)
INSERT [dbo].[Countries_in_Committees] ([Name], [Committee_ID]) VALUES (N'Yemen
', 4)
INSERT [dbo].[Delegates] ([Delegate_ID], [School]) VALUES (5, 3)
INSERT [dbo].[Delegates] ([Delegate_ID], [School]) VALUES (7, 3)
INSERT [dbo].[Delegates] ([Delegate_ID], [School]) VALUES (8, 4)
INSERT [dbo].[Delegates] ([Delegate_ID], [School]) VALUES (9, 5)
INSERT [dbo].[Delegates] ([Delegate_ID], [School]) VALUES (10, 6)
INSERT [dbo].[Delegates] ([Delegate_ID], [School]) VALUES (11, 7)
INSERT [dbo].[Delegates] ([Delegate_ID], [School]) VALUES (12, 7)
INSERT [dbo].[Delegates] ([Delegate_ID], [School]) VALUES (13, 7)
INSERT [dbo].[Delegates] ([Delegate_ID], [School]) VALUES (14, 7)
INSERT [dbo].[Delegates] ([Delegate_ID], [School]) VALUES (15, 8)
INSERT [dbo].[Delegates] ([Delegate_ID], [School]) VALUES (16, 1)
INSERT [dbo].[Delegates] ([Delegate_ID], [School]) VALUES (17, 1)
INSERT [dbo].[Delegates] ([Delegate_ID], [School]) VALUES (18, 1)
INSERT [dbo].[Delegates] ([Delegate_ID], [School]) VALUES (19, 2)
INSERT [dbo].[Delegates] ([Delegate_ID], [School]) VALUES (20, 2)
INSERT [dbo].[Delegates] ([Delegate_ID], [School]) VALUES (21, 2)
INSERT [dbo].[Delegates] ([Delegate_ID], [School]) VALUES (27, 9)
INSERT [dbo].[Delegates] ([Delegate_ID], [School]) VALUES (30, 9)
INSERT [dbo].[Delegates] ([Delegate_ID], [School]) VALUES (31, 9)
INSERT [dbo].[Delegates] ([Delegate_ID], [School]) VALUES (32, 10)
INSERT [dbo].[Delegates] ([Delegate_ID], [School]) VALUES (33, 10)
INSERT [dbo].[Delegates] ([Delegate_ID], [School]) VALUES (34, 11)
INSERT [dbo].[Delegates_in_Committees] ([Participant_ID], [Committee_ID]) VALUES (5, 1)
INSERT [dbo].[Delegates_in_Committees] ([Participant_ID], [Committee_ID]) VALUES (7, 1)
INSERT [dbo].[Delegates_in_Committees] ([Participant_ID], [Committee_ID]) VALUES (8, 1)
INSERT [dbo].[Delegates_in_Committees] ([Participant_ID], [Committee_ID]) VALUES (9, 1)
INSERT [dbo].[Delegates_in_Committees] ([Participant_ID], [Committee_ID]) VALUES (10, 2)
INSERT [dbo].[Delegates_in_Committees] ([Participant_ID], [Committee_ID]) VALUES (11, 2)
INSERT [dbo].[Delegates_in_Committees] ([Participant_ID], [Committee_ID]) VALUES (12, 2)
INSERT [dbo].[Delegates_in_Committees] ([Participant_ID], [Committee_ID]) VALUES (13, 3)
INSERT [dbo].[Delegates_in_Committees] ([Participant_ID], [Committee_ID]) VALUES (14, 3)
INSERT [dbo].[Delegates_in_Committees] ([Participant_ID], [Committee_ID]) VALUES (15, 3)
INSERT [dbo].[Delegates_in_Committees] ([Participant_ID], [Committee_ID]) VALUES (16, 3)
INSERT [dbo].[Delegates_in_Committees] ([Participant_ID], [Committee_ID]) VALUES (17, 4)
INSERT [dbo].[Delegates_in_Committees] ([Participant_ID], [Committee_ID]) VALUES (18, 4)
INSERT [dbo].[Delegates_in_Committees] ([Participant_ID], [Committee_ID]) VALUES (19, 4)
INSERT [dbo].[Delegates_in_Committees] ([Participant_ID], [Committee_ID]) VALUES (20, 5)
INSERT [dbo].[Delegates_in_Committees] ([Participant_ID], [Committee_ID]) VALUES (21, 5)
INSERT [dbo].[Delegates_in_Committees] ([Participant_ID], [Committee_ID]) VALUES (27, 2)
INSERT [dbo].[Delegates_in_Committees] ([Participant_ID], [Committee_ID]) VALUES (30, 5)
INSERT [dbo].[Delegates_in_Committees] ([Participant_ID], [Committee_ID]) VALUES (31, 6)
INSERT [dbo].[Delegates_in_Committees] ([Participant_ID], [Committee_ID]) VALUES (32, 6)
INSERT [dbo].[Delegates_in_Committees] ([Participant_ID], [Committee_ID]) VALUES (33, 6)
INSERT [dbo].[Delegates_in_Committees] ([Participant_ID], [Committee_ID]) VALUES (34, 6)
INSERT [dbo].[Delegates_in_Countries] ([Participant_ID], [Name]) VALUES (5, N'Germany
')
INSERT [dbo].[Delegates_in_Countries] ([Participant_ID], [Name]) VALUES (7, N'Eritrea
')
INSERT [dbo].[Delegates_in_Countries] ([Participant_ID], [Name]) VALUES (8, N'France
')
INSERT [dbo].[Delegates_in_Countries] ([Participant_ID], [Name]) VALUES (9, N'Indonesia
')
INSERT [dbo].[Delegates_in_Countries] ([Participant_ID], [Name]) VALUES (10, N'Estonia
')
INSERT [dbo].[Delegates_in_Countries] ([Participant_ID], [Name]) VALUES (11, N'Iran
')
INSERT [dbo].[Delegates_in_Countries] ([Participant_ID], [Name]) VALUES (12, N'Lithuania
')
INSERT [dbo].[Delegates_in_Countries] ([Participant_ID], [Name]) VALUES (13, N'Indonesia
')
INSERT [dbo].[Delegates_in_Countries] ([Participant_ID], [Name]) VALUES (14, N'Guatemala
')
INSERT [dbo].[Delegates_in_Countries] ([Participant_ID], [Name]) VALUES (15, N'China
')
INSERT [dbo].[Delegates_in_Countries] ([Participant_ID], [Name]) VALUES (16, N'DPR Korea
')
INSERT [dbo].[Delegates_in_Countries] ([Participant_ID], [Name]) VALUES (17, N'DPR Korea
')
INSERT [dbo].[Delegates_in_Countries] ([Participant_ID], [Name]) VALUES (18, N'Eritrea
')
INSERT [dbo].[Delegates_in_Countries] ([Participant_ID], [Name]) VALUES (19, N'Malaysia
')
INSERT [dbo].[Delegates_in_Countries] ([Participant_ID], [Name]) VALUES (20, N'Japan
')
INSERT [dbo].[Delegates_in_Countries] ([Participant_ID], [Name]) VALUES (21, N'Kazakhstan
')
INSERT [dbo].[Delegates_in_Countries] ([Participant_ID], [Name]) VALUES (27, N'Estonia
')
INSERT [dbo].[Delegates_in_Countries] ([Participant_ID], [Name]) VALUES (30, N'Germany
')
INSERT [dbo].[Delegates_in_Countries] ([Participant_ID], [Name]) VALUES (31, N'France
')
INSERT [dbo].[Delegates_in_Countries] ([Participant_ID], [Name]) VALUES (32, N'Iraq
')
INSERT [dbo].[Delegates_in_Countries] ([Participant_ID], [Name]) VALUES (33, N'Japan
')
INSERT [dbo].[Delegates_in_Countries] ([Participant_ID], [Name]) VALUES (34, N'Lithuania
')
INSERT [dbo].[Officers] ([Officer_ID], [Mail], [Phone], [Experience]) VALUES (22, N'zakhariad.phil@gmail.com', 6977085382, 2)
INSERT [dbo].[Officers] ([Officer_ID], [Mail], [Phone], [Experience]) VALUES (23, N'banou_anna@yahoo.com', 6985845658, 1)
INSERT [dbo].[Officers] ([Officer_ID], [Mail], [Phone], [Experience]) VALUES (24, N'christine.papazaiti@hotmail.com', 6985652352, 3)
INSERT [dbo].[Officers] ([Officer_ID], [Mail], [Phone], [Experience]) VALUES (26, N'vasi_fragios@yahoo.com', 6954236541, 2)
INSERT [dbo].[Officers] ([Officer_ID], [Mail], [Phone], [Experience]) VALUES (57, N'theo_apostol@hotmail.com', 6982456123, 2)
INSERT [dbo].[Officers] ([Officer_ID], [Mail], [Phone], [Experience]) VALUES (58, N'john_panago@hotmail.com', 6988564556, 1)
INSERT [dbo].[Officers] ([Officer_ID], [Mail], [Phone], [Experience]) VALUES (59, N'helenaki94@hotmail.com', 6945124565, 3)
INSERT [dbo].[Officers] ([Officer_ID], [Mail], [Phone], [Experience]) VALUES (60, N'p.eleutheriou@gmail.com', 6995356214, 1)
INSERT [dbo].[Officers] ([Officer_ID], [Mail], [Phone], [Experience]) VALUES (61, N'george_anagnwstou@gmail.com', 6954356214, 2)
INSERT [dbo].[Officers] ([Officer_ID], [Mail], [Phone], [Experience]) VALUES (62, N'greg_theo@yahoo.com', 6932565235, 2)
INSERT [dbo].[Officers] ([Officer_ID], [Mail], [Phone], [Experience]) VALUES (63, N'xatzipavlou.s@hotmail.com', NULL, 2)
INSERT [dbo].[Officers] ([Officer_ID], [Mail], [Phone], [Experience]) VALUES (64, N'swkrates_papatheo98@hotmail.com', 6945321654, 2)
INSERT [dbo].[Officers] ([Officer_ID], [Mail], [Phone], [Experience]) VALUES (65, N'eve.symeon@yahoo.com', 6935214412, 3)
INSERT [dbo].[Officers] ([Officer_ID], [Mail], [Phone], [Experience]) VALUES (66, N'dimosgryl@hotmail.com', NULL, 3)
INSERT [dbo].[Officers] ([Officer_ID], [Mail], [Phone], [Experience]) VALUES (67, N'kerk_mpouznakis@hotmail.com', 6978451278, 1)
SET IDENTITY_INSERT [dbo].[Participant] ON 

INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (1, N'Chrysoula', N'Papaioannou', CAST(N'1965-01-05' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (2, N'Despina', N'Avgerinou', CAST(N'1970-05-05' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (3, N'Avgi', N'Kokkinidou', CAST(N'1967-06-18' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (4, N'Dimitra', N'Anastasiadou', CAST(N'1975-11-12' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (5, N'Stamatia', N'Asprodini', CAST(N'1998-03-03' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (7, N'Ioannis', N'Biros', CAST(N'1999-02-06' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (8, N'Nikoleta', N'Chantzi', CAST(N'1999-06-01' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (9, N'Luisa-Iselin ', N'Huluba', CAST(N'1998-03-02' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (10, N'Maria-Nepheli ', N'Kardassi', CAST(N'1998-07-10' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (11, N'Ilias', N'Kofokotsios', CAST(N'1998-07-10' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (12, N'Stylianos ', N'Vogiatzoglou', CAST(N'2000-05-12' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (13, N'Magda', N'Petmeza', CAST(N'2000-07-02' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (14, N'Sofia-Rodanthi ', N'Pavlidou', CAST(N'2000-04-01' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (15, N'Mariliana', N'Papanikolaou', CAST(N'2000-02-10' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (16, N'Maria', N'Efthymiou', CAST(N'2001-01-02' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (17, N'Anna', N'Dimopoulou', CAST(N'2001-06-06' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (18, N'Giannis', N'Dontas', CAST(N'2001-02-10' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (19, N'Konstantinos', N'Tsirifas', CAST(N'2001-10-10' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (20, N'Eirini', N'Trigoni', CAST(N'2002-04-03' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (21, N'Stefanos', N'Keris', CAST(N'2001-02-11' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (22, N'Philip ', N'Zakhariadis', CAST(N'1997-08-29' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (23, N'Anna', N'Banou', CAST(N'1994-07-18' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (24, N'Christina ', N'Papazaiti', CAST(N'1995-07-09' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (26, N'Vasileios', N'Fragios', CAST(N'1998-01-03' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (27, N'Athina', N'Tzami', CAST(N'2000-12-15' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (30, N'Helen', N'Haritou', CAST(N'1999-05-23' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (31, N'Panagiota ', N'Stefanidou', CAST(N'1991-09-09' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (32, N'Manos', N'Anagnostopoulos', CAST(N'1993-02-13' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (33, N'Elena ', N'Nikoglou', CAST(N'1995-04-30' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (34, N'Gerasimos', N'Terzopoulos', CAST(N'1996-02-29' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (35, N'Kleanthis', N'Georgiou', CAST(N'1974-06-17' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (36, N'Maria', N'Glaraki', CAST(N'1969-10-15' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (37, N'Xaralampos', N'Tyropoulos', CAST(N'1978-08-26' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (38, N'Xaritini', N'Gousopoulou', CAST(N'1960-01-18' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (39, N'Marianna', N'Nikiforidou', CAST(N'1963-02-05' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (40, N'Georgia', N'Tanimanidou', CAST(N'1966-06-16' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (41, N'Philippos', N'Chloropoulos', CAST(N'1977-03-13' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (42, N'Adamantia', N'Rizou', CAST(N'1982-07-17' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (43, N'Kyriakos', N'Gerothanasis', CAST(N'1960-02-19' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (44, N'Glykeria', N'Sarafi', CAST(N'1955-01-26' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (45, N'Nikolaos', N'Papadimitriou', CAST(N'1978-09-10' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (46, N'Manolis', N'Papagiannis', CAST(N'1985-12-13' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (47, N'Giannis', N'Papatriantafyllou', CAST(N'1983-11-05' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (48, N'Nikos', N'Variammidis', CAST(N'1975-07-18' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (49, N'Athanasios', N'Mpismixos', CAST(N'2003-02-24' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (50, N'Panagiwta', N'Georgiou', CAST(N'2003-04-09' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (51, N'Anna-Maria', N'Xatzi', CAST(N'2003-11-26' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (52, N'Konstantina', N'Siatra', CAST(N'2004-04-16' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (53, N'Dimitrios', N'Aggelidakis', CAST(N'2001-05-04' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (54, N'Nikos', N'Tsopoglou', CAST(N'2002-12-06' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (55, N'Aleksia', N'Pasxalidi', CAST(N'2001-04-20' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (56, N'Apostolia ', N'Katsakiori', CAST(N'2004-06-13' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (57, N'Theofanis', N'Apostolidis', CAST(N'1998-07-06' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (58, N'Giannis', N'Panagopoulos', CAST(N'1997-06-24' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (59, N'Eleni', N'Panagakou', CAST(N'1999-02-28' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (60, N'Panagiwtis', N'Eleutheriou', CAST(N'1999-11-27' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (61, N'Giorgos', N'Anagnwstou', CAST(N'1999-10-05' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (62, N'Grigoris', N'Theofanous', CAST(N'1998-09-16' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (63, N'Savvas', N'Xatzipavlou', CAST(N'1999-06-04' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (64, N'Swkratis', N'Papatheodwrou', CAST(N'1998-07-12' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (65, N'Evelina', N'Symeonidou', CAST(N'1997-12-23' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (66, N'Dimosthenis', N'Grylakis', CAST(N'2000-05-09' AS Date))
INSERT [dbo].[Participant] ([Participant_ID], [Name], [Surname], [Date_of_birth]) VALUES (67, N'Kyriakos', N'Mpouznakis', CAST(N'2000-06-22' AS Date))
SET IDENTITY_INSERT [dbo].[Participant] OFF
INSERT [dbo].[Press] ([Press_ID], [Experience]) VALUES (49, 1)
INSERT [dbo].[Press] ([Press_ID], [Experience]) VALUES (50, 2)
INSERT [dbo].[Press] ([Press_ID], [Experience]) VALUES (51, 0)
INSERT [dbo].[Press] ([Press_ID], [Experience]) VALUES (52, 1)
INSERT [dbo].[Press] ([Press_ID], [Experience]) VALUES (53, 0)
INSERT [dbo].[Press] ([Press_ID], [Experience]) VALUES (54, 0)
INSERT [dbo].[Press] ([Press_ID], [Experience]) VALUES (55, 1)
INSERT [dbo].[Press] ([Press_ID], [Experience]) VALUES (56, 0)
SET IDENTITY_INSERT [dbo].[Schools] ON 

INSERT [dbo].[Schools] ([School_ID], [Name], [Address], [Postal_Code], [Payment_Info]) VALUES (1, N'14th High School of Thessaloniki
', N'Koufitsa 4', 54632, 0)
INSERT [dbo].[Schools] ([School_ID], [Name], [Address], [Postal_Code], [Payment_Info]) VALUES (2, N'1st Experimental Junior High School of Thessaloniki
', N'Gewrgioy kalamarioy 56', 55355, 0)
INSERT [dbo].[Schools] ([School_ID], [Name], [Address], [Postal_Code], [Payment_Info]) VALUES (3, N' 1st General High School of Mikra 
', N'Athwnos 3', 53624, 0)
INSERT [dbo].[Schools] ([School_ID], [Name], [Address], [Postal_Code], [Payment_Info]) VALUES (4, N'1st General Lyceum of Thermi
', N'Klimentionos 102', 56224, 0)
INSERT [dbo].[Schools] ([School_ID], [Name], [Address], [Postal_Code], [Payment_Info]) VALUES (5, N'1st Lyceum of Xanthi
', N'X.Trikoupi 48', 67100, 0)
INSERT [dbo].[Schools] ([School_ID], [Name], [Address], [Postal_Code], [Payment_Info]) VALUES (6, N'1st Senior  High School of Oraiokastro
', N'Ermou 23', 59874, 0)
INSERT [dbo].[Schools] ([School_ID], [Name], [Address], [Postal_Code], [Payment_Info]) VALUES (7, N'20th General Lyceum of Thessaloniki
', N'Iasonidou 89', 57013, 0)
INSERT [dbo].[Schools] ([School_ID], [Name], [Address], [Postal_Code], [Payment_Info]) VALUES (8, N'2nd General Lyceum of Mikra
', N'Ernestou ebrar 60', 51293, 0)
INSERT [dbo].[Schools] ([School_ID], [Name], [Address], [Postal_Code], [Payment_Info]) VALUES (9, N'3rd General Senior High School of Euosmos
', N'Marasli 12', 50032, 0)
INSERT [dbo].[Schools] ([School_ID], [Name], [Address], [Postal_Code], [Payment_Info]) VALUES (10, N'5th General Lykeio of Thessaloniki
', N'Manousou 9', 51036, -25)
INSERT [dbo].[Schools] ([School_ID], [Name], [Address], [Postal_Code], [Payment_Info]) VALUES (11, N'8th Lykeio of Thessaloniki
', N'Kanari 16', 54698, 0)
INSERT [dbo].[Schools] ([School_ID], [Name], [Address], [Postal_Code], [Payment_Info]) VALUES (12, N'American Farm School
', N'8o km Perifereiakis odou Thessalonikis-Thermis', 59003, 250)
INSERT [dbo].[Schools] ([School_ID], [Name], [Address], [Postal_Code], [Payment_Info]) VALUES (13, N'Anatolia College A Gymnasium
', N'Nikolaou Plastira 173', 58623, 50)
INSERT [dbo].[Schools] ([School_ID], [Name], [Address], [Postal_Code], [Payment_Info]) VALUES (14, N'Anatolia College A Lyceum
', N'Nikolaou Plastira 173', 58623, 0)
INSERT [dbo].[Schools] ([School_ID], [Name], [Address], [Postal_Code], [Payment_Info]) VALUES (15, N'Anatolia College B Gymnasium
', N'Nikolaou Plastira 173', 58623, 0)
INSERT [dbo].[Schools] ([School_ID], [Name], [Address], [Postal_Code], [Payment_Info]) VALUES (16, N'Arsakeio High School of Thessaloniki
', N'Perifereiaki odos Thessalonikis enanti Genesis', 59236, 0)
INSERT [dbo].[Schools] ([School_ID], [Name], [Address], [Postal_Code], [Payment_Info]) VALUES (17, N'Arsakeio Lykeio of Thessaloniki
', N'Perifereiaki odos Thessalonikis enanti Genesis', 59236, 0)
INSERT [dbo].[Schools] ([School_ID], [Name], [Address], [Postal_Code], [Payment_Info]) VALUES (18, N'Ekp. "Ap. Pavlos" Junior High School
', N'Agiou Louka 189', 59805, -15)
INSERT [dbo].[Schools] ([School_ID], [Name], [Address], [Postal_Code], [Payment_Info]) VALUES (19, N'Ekp. "Ap. Pavlos" Senior High School
', N'Agiou Louka 189', 59805, 0)
INSERT [dbo].[Schools] ([School_ID], [Name], [Address], [Postal_Code], [Payment_Info]) VALUES (20, N'Hellenic College of Thessaloniki - Gymnasium
', N'Perifereiaki odos Thessalonikis enanti dutikis eisodou Pulaias', 54635, 0)
INSERT [dbo].[Schools] ([School_ID], [Name], [Address], [Postal_Code], [Payment_Info]) VALUES (21, N'Hellenic College of Thessaloniki - Lyceum
', N'Perifereiaki odos Thessalonikis enanti dutikis eisodou Pulaias', 54635, 0)
INSERT [dbo].[Schools] ([School_ID], [Name], [Address], [Postal_Code], [Payment_Info]) VALUES (22, N'Hellenic-French School Kalamari Junior High School
', N'Perifereiaki odos Thessalonikis Enanti Noesis', 58264, 0)
INSERT [dbo].[Schools] ([School_ID], [Name], [Address], [Postal_Code], [Payment_Info]) VALUES (23, N'Hellenic-French School Kalamari Senior High School
', N'Perifereiaki odos Thessalonikis enanti Noesis', 58264, 0)
INSERT [dbo].[Schools] ([School_ID], [Name], [Address], [Postal_Code], [Payment_Info]) VALUES (24, N'Imerisio Geniko Lykeio Evropou
', N'Swkratous 50', 61007, 0)
INSERT [dbo].[Schools] ([School_ID], [Name], [Address], [Postal_Code], [Payment_Info]) VALUES (25, N'Lexicon Triandria
', N'Georgakopoulou 3', 51269, 0)
INSERT [dbo].[Schools] ([School_ID], [Name], [Address], [Postal_Code], [Payment_Info]) VALUES (26, N' Pinewood American International School of Thessaloniki Greece
', N'18o km Thessalonikis-Moudaniwn', 57001, 0)
SET IDENTITY_INSERT [dbo].[Schools] OFF
ALTER TABLE [dbo].[Advisors]  WITH CHECK ADD  CONSTRAINT [FK_Advisor_ID] FOREIGN KEY([Advisor_ID])
REFERENCES [dbo].[Participant] ([Participant_ID])
GO
ALTER TABLE [dbo].[Advisors] CHECK CONSTRAINT [FK_Advisor_ID]
GO
ALTER TABLE [dbo].[Advisors_in_Schools]  WITH CHECK ADD  CONSTRAINT [FK_Advisors_in_Schools_Advisors] FOREIGN KEY([Advisor_ID])
REFERENCES [dbo].[Advisors] ([Advisor_ID])
GO
ALTER TABLE [dbo].[Advisors_in_Schools] CHECK CONSTRAINT [FK_Advisors_in_Schools_Advisors]
GO
ALTER TABLE [dbo].[Advisors_in_Schools]  WITH CHECK ADD  CONSTRAINT [FK_Advisors_in_Schools_Schools] FOREIGN KEY([School_ID])
REFERENCES [dbo].[Schools] ([School_ID])
GO
ALTER TABLE [dbo].[Advisors_in_Schools] CHECK CONSTRAINT [FK_Advisors_in_Schools_Schools]
GO
ALTER TABLE [dbo].[Committees]  WITH CHECK ADD  CONSTRAINT [FK_Committees_Conferences] FOREIGN KEY([Conference])
REFERENCES [dbo].[Conferences] ([Numbered_Title])
GO
ALTER TABLE [dbo].[Committees] CHECK CONSTRAINT [FK_Committees_Conferences]
GO
ALTER TABLE [dbo].[Committees]  WITH CHECK ADD  CONSTRAINT [FK_Committees_Officer1] FOREIGN KEY([Officer1])
REFERENCES [dbo].[Officers] ([Officer_ID])
GO
ALTER TABLE [dbo].[Committees] CHECK CONSTRAINT [FK_Committees_Officer1]
GO
ALTER TABLE [dbo].[Committees]  WITH CHECK ADD  CONSTRAINT [FK_Committees_Officer2] FOREIGN KEY([Officer2])
REFERENCES [dbo].[Officers] ([Officer_ID])
GO
ALTER TABLE [dbo].[Committees] CHECK CONSTRAINT [FK_Committees_Officer2]
GO
ALTER TABLE [dbo].[Committees]  WITH CHECK ADD  CONSTRAINT [FK_Committees_Press] FOREIGN KEY([Press_Member])
REFERENCES [dbo].[Press] ([Press_ID])
GO
ALTER TABLE [dbo].[Committees] CHECK CONSTRAINT [FK_Committees_Press]
GO
ALTER TABLE [dbo].[Countries_in_Committees]  WITH CHECK ADD  CONSTRAINT [FK_Countries_in_Committees_Committees] FOREIGN KEY([Committee_ID])
REFERENCES [dbo].[Committees] ([Committee_ID])
GO
ALTER TABLE [dbo].[Countries_in_Committees] CHECK CONSTRAINT [FK_Countries_in_Committees_Committees]
GO
ALTER TABLE [dbo].[Countries_in_Committees]  WITH CHECK ADD  CONSTRAINT [FK_Countries_in_Committees_Countries] FOREIGN KEY([Name])
REFERENCES [dbo].[Countries] ([Name])
GO
ALTER TABLE [dbo].[Countries_in_Committees] CHECK CONSTRAINT [FK_Countries_in_Committees_Countries]
GO
ALTER TABLE [dbo].[Delegates]  WITH CHECK ADD  CONSTRAINT [FK_Delegate_ID] FOREIGN KEY([Delegate_ID])
REFERENCES [dbo].[Participant] ([Participant_ID])
GO
ALTER TABLE [dbo].[Delegates] CHECK CONSTRAINT [FK_Delegate_ID]
GO
ALTER TABLE [dbo].[Delegates]  WITH CHECK ADD  CONSTRAINT [FK_Delegates_Schools] FOREIGN KEY([School])
REFERENCES [dbo].[Schools] ([School_ID])
GO
ALTER TABLE [dbo].[Delegates] CHECK CONSTRAINT [FK_Delegates_Schools]
GO
ALTER TABLE [dbo].[Delegates_in_Committees]  WITH CHECK ADD  CONSTRAINT [FK_Delegates_in_Committees_Committees] FOREIGN KEY([Committee_ID])
REFERENCES [dbo].[Committees] ([Committee_ID])
GO
ALTER TABLE [dbo].[Delegates_in_Committees] CHECK CONSTRAINT [FK_Delegates_in_Committees_Committees]
GO
ALTER TABLE [dbo].[Delegates_in_Committees]  WITH CHECK ADD  CONSTRAINT [FK_Delegates_in_Committees_Delegates] FOREIGN KEY([Participant_ID])
REFERENCES [dbo].[Delegates] ([Delegate_ID])
GO
ALTER TABLE [dbo].[Delegates_in_Committees] CHECK CONSTRAINT [FK_Delegates_in_Committees_Delegates]
GO
ALTER TABLE [dbo].[Delegates_in_Countries]  WITH CHECK ADD  CONSTRAINT [FK_Delegates_in_Countries_Countries] FOREIGN KEY([Name])
REFERENCES [dbo].[Countries] ([Name])
GO
ALTER TABLE [dbo].[Delegates_in_Countries] CHECK CONSTRAINT [FK_Delegates_in_Countries_Countries]
GO
ALTER TABLE [dbo].[Delegates_in_Countries]  WITH CHECK ADD  CONSTRAINT [FK_Delegates_in_Countries_Delegates] FOREIGN KEY([Participant_ID])
REFERENCES [dbo].[Delegates] ([Delegate_ID])
GO
ALTER TABLE [dbo].[Delegates_in_Countries] CHECK CONSTRAINT [FK_Delegates_in_Countries_Delegates]
GO
ALTER TABLE [dbo].[Officers]  WITH CHECK ADD  CONSTRAINT [FK_Officers_ID] FOREIGN KEY([Officer_ID])
REFERENCES [dbo].[Participant] ([Participant_ID])
GO
ALTER TABLE [dbo].[Officers] CHECK CONSTRAINT [FK_Officers_ID]
GO
ALTER TABLE [dbo].[Press]  WITH CHECK ADD  CONSTRAINT [FK_Press_ID] FOREIGN KEY([Press_ID])
REFERENCES [dbo].[Participant] ([Participant_ID])
GO
ALTER TABLE [dbo].[Press] CHECK CONSTRAINT [FK_Press_ID]
GO
ALTER TABLE [dbo].[Schools]  WITH CHECK ADD  CONSTRAINT [FK_Schools_Cities_and_Postal_code_Map] FOREIGN KEY([Postal_Code])
REFERENCES [dbo].[Cities_and_Postal_code_Map] ([Postal_code])
GO
ALTER TABLE [dbo].[Schools] CHECK CONSTRAINT [FK_Schools_Cities_and_Postal_code_Map]
GO
ALTER TABLE [dbo].[Advisors]  WITH CHECK ADD  CONSTRAINT [CK_Advisors_1] CHECK  (([Phone]>=(6900000000.) AND [Phone]<=(6999999999.)))
GO
ALTER TABLE [dbo].[Advisors] CHECK CONSTRAINT [CK_Advisors_1]
GO
ALTER TABLE [dbo].[Cities_and_Postal_code_Map]  WITH CHECK ADD  CONSTRAINT [CK_Cities_and_Postal_code_Map] CHECK  (([Postal_code]>=(14000)))
GO
ALTER TABLE [dbo].[Cities_and_Postal_code_Map] CHECK CONSTRAINT [CK_Cities_and_Postal_code_Map]
GO
ALTER TABLE [dbo].[Conferences]  WITH CHECK ADD  CONSTRAINT [CK_Conferences] CHECK  (([Date]>='2000-01-01'))
GO
ALTER TABLE [dbo].[Conferences] CHECK CONSTRAINT [CK_Conferences]
GO
ALTER TABLE [dbo].[Conferences]  WITH CHECK ADD  CONSTRAINT [CK_Conferences_1] CHECK  (([Numbered_Title]>(0)))
GO
ALTER TABLE [dbo].[Conferences] CHECK CONSTRAINT [CK_Conferences_1]
GO
ALTER TABLE [dbo].[Officers]  WITH NOCHECK ADD  CONSTRAINT [CK_Officers] CHECK  (([Phone]>=(6900000000.) AND [Phone]<=(6999999999.)))
GO
ALTER TABLE [dbo].[Officers] NOCHECK CONSTRAINT [CK_Officers]
GO
ALTER TABLE [dbo].[Participant]  WITH CHECK ADD  CONSTRAINT [CK_Participant] CHECK  (([Date_of_birth]>='1950-01-01'))
GO
ALTER TABLE [dbo].[Participant] CHECK CONSTRAINT [CK_Participant]
GO
ALTER TABLE [dbo].[Press]  WITH CHECK ADD  CONSTRAINT [CK_Press] CHECK  (([Experience]>=(0)))
GO
ALTER TABLE [dbo].[Press] CHECK CONSTRAINT [CK_Press]
GO
ALTER TABLE [dbo].[Schools]  WITH CHECK ADD  CONSTRAINT [CK_Schools] CHECK  (([Postal_Code]>=(10400)))
GO
ALTER TABLE [dbo].[Schools] CHECK CONSTRAINT [CK_Schools]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[46] 4[19] 2[16] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Participant"
            Begin Extent = 
               Top = 77
               Left = 584
               Bottom = 207
               Right = 754
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "D_1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 2220
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Advisor_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Advisor_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Committees"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Committees_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Committees_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Participant"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 136
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Delegates_in_Committee_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Delegates_in_Committee_View'
GO
USE [master]
GO
ALTER DATABASE [HMUNO_DB] SET  READ_WRITE 
GO
