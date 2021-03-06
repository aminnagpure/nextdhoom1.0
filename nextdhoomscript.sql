USE [nextdhoomEmpty]
GO
/****** Object:  Table [dbo].[Photos]    Script Date: 07/02/2015 15:41:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Photos](
	[photoname] [varchar](150) NOT NULL,
	[passw] [varchar](60) NOT NULL,
	[uploaddate] [smalldatetime] NOT NULL,
	[mainphoto] [varchar](1) NOT NULL,
	[isapproved] [varchar](1) NOT NULL,
	[memsid] [bigint] NOT NULL,
	[photoid] [bigint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Photos] PRIMARY KEY CLUSTERED 
(
	[photoid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NewsCatmaster]    Script Date: 07/02/2015 15:41:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[NewsCatmaster](
	[catid] [int] NOT NULL,
	[category] [varchar](250) NOT NULL,
 CONSTRAINT [PK_NewsCatmaster] PRIMARY KEY CLUSTERED 
(
	[catid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Mems]    Script Date: 07/02/2015 15:41:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Mems](
	[memsid] [bigint] IDENTITY(1,1) NOT NULL,
	[fname] [varchar](50) NOT NULL,
	[lname] [varchar](50) NOT NULL,
	[gender] [varchar](1) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[passw] [varchar](50) NOT NULL,
	[photoid] [bigint] NOT NULL,
	[countryid] [smallint] NOT NULL,
	[stateid] [smallint] NOT NULL,
	[cityid] [smallint] NOT NULL,
	[gurl] [varchar](550) NOT NULL,
	[gimg] [varchar](650) NOT NULL,
	[aboutme] [varchar](450) NOT NULL,
	[susp] [varchar](1) NOT NULL,
	[regDate] [smalldatetime] NOT NULL,
	[isJobseeker] [varchar](1) NOT NULL,
	[designation] [varchar](250) NULL,
	[jobcategoryid] [smallint] NULL,
	[sponsoremail] [varchar](1) NOT NULL,
 CONSTRAINT [PK_Mems] PRIMARY KEY CLUSTERED 
(
	[memsid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[meminvites]    Script Date: 07/02/2015 15:41:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[meminvites](
	[inviteid] [bigint] IDENTITY(1,1) NOT NULL,
	[memsid] [bigint] NOT NULL,
	[useremail] [varchar](50) NOT NULL,
	[fname] [varchar](50) NOT NULL,
	[lname] [varchar](50) NOT NULL,
	[email] [varchar](50) NOT NULL,
 CONSTRAINT [PK_candireg_1] PRIMARY KEY CLUSTERED 
(
	[inviteid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[memberbySearch]    Script Date: 07/02/2015 15:41:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[memberbySearch]
@startRowIndex int=1,
@maximumRows int,
@crteria varchar(max),
@Count int = 0 output
as
declare @sqlst nvarchar(max),@MaxRow int,@startRow int



set @startRow = ((@startRowIndex -1)  * @maximumRows) + 1
set @MaxRow= (@startRowIndex * @maximumRows) + 1;

declare @tempTbl table(
memsid bigint,
gimg varchar(650),
fname varchar(50),
lname varchar(50),
gender varchar(1),
aboutme varchar(450), 
countryname varchar(250),
statename varchar(250),
cityname varchar(250),
regdate smalldatetime,
susp varchar(1), 
rowid int
)

select @sqlst ='select * from
(
select 
Distinct(Mems.memsid),
Mems.gimg,
Mems.fname,
Mems.lname,
Mems.gender,
Mems.aboutme, 
country.countryname,
states.statename,
citytable.cityname,
mems.regdate,
mems.susp,
ROW_NUMBER() OVER(ORDER BY mems.memsid DESC) AS rowid
from Mems
join citytable on mems.cityid = citytable.cityid  
join states on mems.stateid = states.stateid
join Country on mems.countryid = country.COUNTRYID  

where '+ @crteria +'

) as kk'
print @startRow;
print @maxRow;

insert into @tempTbl EXEC(@sqlst + ' where rowid >= '+@startRow +' AND rowid < ('+ @MaxRow + ')')

select @sqlst='select @Count = Count(*) from [mems] where '+ @crteria 

EXEC sp_executesql @sqlst,N'@Count numeric(20,0) OUTPUT', @Count OUTPUT

select * from @tempTbl

--declare @Count int
--EXEc memberbySearch 172,10,'Susp= ''N'',@Count out
--select @Count
GO
/****** Object:  Table [dbo].[Jokescatmaster]    Script Date: 07/02/2015 15:41:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Jokescatmaster](
	[catid] [int] NOT NULL,
	[category] [varchar](250) NOT NULL,
 CONSTRAINT [PK_Jokescatmaster] PRIMARY KEY CLUSTERED 
(
	[catid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Country]    Script Date: 07/02/2015 15:41:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Country](
	[COUNTRYID] [smallint] IDENTITY(1,1) NOT NULL,
	[countryname] [varchar](255) NOT NULL,
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[COUNTRYID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Country] ON
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (1, N'India')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (2, N'Afghanistan')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (3, N'Albania')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (4, N'Algeria')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (5, N'American Samoa')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (6, N'Andorra')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (7, N'Angola')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (8, N'Anguilla')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (9, N'Antartica')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (10, N'Antigua and Barbuda')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (11, N'Argentina')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (12, N'Armenia')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (13, N'Aruba')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (14, N'Australia')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (15, N'Austria')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (16, N'Azerbaidjan')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (17, N'Bahamas')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (18, N'Bahrain')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (19, N'Bangladesh')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (20, N'Barbados')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (21, N'Belarus')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (22, N'Belgium')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (23, N'Belize')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (24, N'Benin')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (25, N'Bermuda')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (26, N'Bhutan')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (27, N'Bolivia')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (28, N'Bosnia-Herzegovina')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (29, N'Botswana')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (30, N'Bouvet Island')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (31, N'Brazil')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (32, N'British Indian Ocea')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (33, N'Brunei Darussalam')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (34, N'Bulgaria')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (35, N'Burkina Faso')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (36, N'Burundi')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (37, N'Cambodia')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (38, N'Cameroon')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (39, N'Canada')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (40, N'Cape Verde')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (41, N'Cayman Islands')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (42, N'Central African Rep')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (43, N'Chad')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (44, N'Chile')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (45, N'China')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (46, N'Christmas Island')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (47, N'Cocos (Keeling) Isl')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (48, N'Colombia')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (49, N'Comoros')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (50, N'Congo')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (51, N'Cook Islands')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (52, N'Costa Rica')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (53, N'Croatia')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (54, N'Cyprus')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (55, N'Czech Republic')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (56, N'Denmark')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (57, N'Djibouti')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (58, N'Dominica')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (59, N'Dominican Republic')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (60, N'East Timor')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (61, N'Ecuador')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (62, N'Egypt')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (63, N'El Salvador')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (64, N'Equatorial Guinea')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (65, N'Eritrea')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (66, N'Estonia')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (67, N'Ethiopia')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (68, N'Falkland Islands')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (69, N'Faroe Islands')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (70, N'Fiji')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (71, N'Finland')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (72, N'Former USSR')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (73, N'France')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (74, N'France (European Te')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (75, N'French Guyana')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (76, N'French Southern Ter')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (77, N'Gabon')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (78, N'Gambia')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (79, N'Georgia')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (80, N'Germany')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (81, N'Ghana')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (82, N'Gibraltar')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (83, N'Greece')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (84, N'Greenland')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (85, N'Grenada')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (86, N'Guadeloupe (French)')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (87, N'Guam')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (88, N'Guatemala')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (89, N'Guinea')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (90, N'Guinea Bissau')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (91, N'Guyana')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (92, N'Haiti')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (93, N'Heard and McDonald')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (94, N'Honduras')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (95, N'Hong Kong')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (96, N'Hungary')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (97, N'Iceland')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (98, N'Indonesia')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (99, N'Iraq')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (100, N'Ireland')
GO
print 'Processed 100 total records'
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (101, N'Israel')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (102, N'Italy')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (103, N'Ivory Coast')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (104, N'Jamaica')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (105, N'Japan')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (106, N'Jordan')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (107, N'Kazakhstan')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (108, N'Kenya')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (109, N'Kiribati')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (110, N'Kuwait')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (111, N'Kyrgyzstan')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (112, N'Laos')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (113, N'Latvia')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (114, N'Lebanon')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (115, N'Lesotho')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (116, N'Liberia')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (117, N'Liechtenstein')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (118, N'Lithuania')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (119, N'Luxembourg')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (120, N'Macau')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (121, N'Macedonia')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (122, N'Madagascar')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (123, N'Malawi')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (124, N'Malaysia')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (125, N'Maldives')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (126, N'Mali')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (127, N'Malta')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (128, N'Marshall Islands')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (129, N'Martinique (French)')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (130, N'Mauritania')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (131, N'Mauritius')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (132, N'Mayotte')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (133, N'Mexico')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (134, N'Micronesia')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (135, N'Moldavia')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (136, N'Monaco')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (137, N'Mongolia')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (138, N'Montserrat')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (139, N'Morocco')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (140, N'Mozambique')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (141, N'Namibia')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (142, N'Nauru')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (143, N'Nepal')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (144, N'Netherlands')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (145, N'Netherlands Antille')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (146, N'Neutral Zone')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (147, N'New Caledonia (Fren')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (148, N'New Zealand')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (149, N'Nicaragua')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (150, N'Niger')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (151, N'Nigeria')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (152, N'Niue')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (153, N'Norfolk Island')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (154, N'Northern Mariana Is')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (155, N'Oman')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (156, N'Pakistan')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (157, N'Palau')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (158, N'Panama')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (159, N'Papua New Guinea')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (160, N'Paraguay')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (161, N'Peru')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (162, N'Philippines')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (163, N'Pitcairn Island')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (164, N'Poland')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (165, N'Polynesia (French)')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (166, N'Portugal')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (167, N'Qatar')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (168, N'Reunion (French)')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (169, N'Romania')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (170, N'Russian Federation')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (171, N'Rwanda')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (172, N'S. Georgia &amp; S.')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (173, N'Saint Helena')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (174, N'Saint Kitts &amp; N')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (175, N'Saint Lucia')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (176, N'Saint Pierre and Mi')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (177, N'Saint Tome and Prin')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (178, N'Saint Vincent &amp;')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (179, N'Samoa')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (180, N'San Marino')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (181, N'Saudi Arabia')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (182, N'Senegal')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (183, N'Seychelles')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (184, N'Sierra Leone')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (185, N'Singapore')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (186, N'Slovakia')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (187, N'Slovenia')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (188, N'Solomon Islands')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (189, N'Somalia')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (190, N'South Africa')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (191, N'South Korea')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (192, N'Spain')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (193, N'Sri Lanka')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (194, N'Suriname')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (195, N'Svalbard and Jan Ma')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (196, N'Swaziland')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (197, N'Sweden')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (198, N'Switzerland')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (199, N'Tadjikistan')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (200, N'Taiwan')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (201, N'Tanzania')
GO
print 'Processed 200 total records'
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (202, N'Thailand')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (203, N'Togo')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (204, N'Tokelau')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (205, N'Tonga')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (206, N'Trinidad and Tobago')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (207, N'Tunisia')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (208, N'Turkey')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (209, N'Turkmenistan')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (210, N'Turks and Caicos Is')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (211, N'Tuvalu')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (212, N'Uganda')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (213, N'UK')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (214, N'Ukraine')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (215, N'United Arab Emirate')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (216, N'Uruguay')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (217, N'United States')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (218, N'US Minor Outlying I')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (219, N'Uzbekistan')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (220, N'Vanuatu')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (221, N'Vatican City')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (222, N'Venezuela')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (223, N'Vietnam')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (224, N'Virgin Islands (Bri')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (225, N'Virgin Islands (US)')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (226, N'Wallis and Futuna I')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (227, N'Western Sahara')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (228, N'Yemen')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (229, N'Yugoslavia')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (230, N'Zaire')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (231, N'Zambia')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (232, N'Zimbabwe')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (233, N'Singapore')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (234, N'Saudi Arabia')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (235, N'Oman')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (236, N'Singapore')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (237, N'Thailand')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (238, N'Indonesia')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (239, N'China')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (240, N'Pakistan')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (241, N'Italy')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (242, N'Bangladesh')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (243, N'Nepal')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (244, N'Srilanka')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (245, N'Work From home')
INSERT [dbo].[Country] ([COUNTRYID], [countryname]) VALUES (246, N'Qatar')
SET IDENTITY_INSERT [dbo].[Country] OFF
/****** Object:  StoredProcedure [dbo].[ComplaintsPaged]    Script Date: 07/02/2015 15:41:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[ComplaintsPaged]
@startRowIndex int,
@maximumRows int,
@Count int = 0 output
as
declare @sqlst nvarchar(max),@MaxRow int,@startRow int
if(@startRowIndex >0)
begin
set @MaxRow= (@startRowIndex + 1) * @maximumRows;
set @startRow = (@startRowIndex  * @maximumRows) 
end
else
begin
set @MaxRow= (@startRowIndex + 1) * @maximumRows;
set @startRow = @startRowIndex  * @maximumRows 
end

declare @tempTbl table
(
ComplaintID bigint,
UserMobile varchar(20),
EmailID varchar(250),
UserName varchar(250),
ComplaintHead varchar(500),
ComplaintDesc varchar(5000), 
ComplaintDate datetime, 
IsResolved varchar(1),
rowid int   
)
select @sqlst ='select * from
(
select 
ComplaintID,
UserMobile,
EmailID,
UserName,
ComplaintHead,
ComplaintDesc, 
ComplaintDate, 
IsResolved,
ROW_NUMBER() over(order by complaintID desc) as rowid   

from User_Complaints 
) as kk'
insert into @tempTbl EXEC(@sqlst + ' where rowid > '+@startRow+' AND rowid <= ('+ @MaxRow + ')')

select @sqlst='select @Count = Count(*) from [User_Complaints] '

EXEC sp_executesql @sqlst,N'@Count numeric(20,0) OUTPUT', @Count OUTPUT
select * from @tempTbl
Return
GO
/****** Object:  Table [dbo].[citytable]    Script Date: 07/02/2015 15:41:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[citytable](
	[cityname] [varchar](250) NOT NULL,
	[cityid] [smallint] IDENTITY(1,1) NOT NULL,
	[stateid] [smallint] NOT NULL,
 CONSTRAINT [PK_citytable_1] PRIMARY KEY CLUSTERED 
(
	[cityid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[citytable] ON
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Disney MGM Studios', 1, 0)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Ireland', 2, 1)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Israel', 3, 2)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Italy', 4, 3)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Japan', 5, 4)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Kuwait', 6, 6)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Cuddapah', 7, 5)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Guntur', 8, 5)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Kakinda', 9, 5)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Machilipatnam ', 10, 5)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Ongole', 11, 5)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Secundarabad', 12, 5)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Tirumala', 13, 5)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Vijayawada', 14, 5)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Vishakapatanam', 15, 5)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Itanagar', 16, 7)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'MALAYSIA', 17, 8)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'New Delhi', 18, 9)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Dispur', 19, 10)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Guwahati ', 20, 10)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Jorhat ', 21, 10)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Dibrugarh ', 22, 10)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'North Lakhimpur ', 23, 10)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Silchar ', 24, 10)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Sonitpur ', 25, 10)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Tezpur ', 26, 10)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bhagalpur', 27, 11)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Dhanabad', 28, 11)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Gaya', 29, 11)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Jamshedpur', 30, 11)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Kathmandu', 31, 12)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Nepal', 32, 12)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'patna', 33, 11)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Australia', 34, 13)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bhilai ', 35, 14)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Raipur ', 36, 14)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Muscat', 37, 15)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Oman', 38, 15)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Quetta', 39, 16)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Peshawar', 40, 16)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Lahore', 41, 18)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Karachi', 42, 19)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Peshawar', 43, 20)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Islamabad', 44, 21)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Gilgit', 45, 22)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Lahore', 46, 23)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Islamabad', 47, 23)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Pakistan', 48, 23)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Philippines', 49, 25)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Makati City ', 50, 25)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Boracay Island ', 51, 25)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Calapan City', 52, 25)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Cebu', 53, 25)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Clark Field Pampanga', 54, 25)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Coron', 55, 25)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Davao', 56, 25)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'General Trias Cavite', 57, 25)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Iloilo City', 58, 25)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Lapu Lapu', 59, 25)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Makati ', 60, 25)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Caloocan city', 61, 25)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Quezon City', 62, 25)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Mandaluyong City', 63, 25)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Armm', 64, 25)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bicol Region', 65, 25)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'C.A.R', 66, 25)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Cagayan Valley', 67, 25)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Central Luzon', 68, 25)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Central Mindanao', 69, 25)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Caraga', 70, 25)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Central Visayas', 71, 25)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Eastern Visayas', 72, 25)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Ilocos Region', 73, 25)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Northern Mindanao', 74, 25)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Southern Mindanao', 75, 25)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Southern Tagalog', 76, 25)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Western Mindanao', 77, 25)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Western Visayas', 78, 25)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'National Capital', 79, 25)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Arpora ', 80, 24)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bicholim ', 81, 24)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Panji', 82, 24)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Qatar', 83, 26)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Doha', 84, 26)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Romania', 85, 27)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Baroda', 86, 28)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Gurgaon', 87, 28)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Ankleshwar', 88, 28)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bharuch', 89, 28)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bhavnagar', 90, 28)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Gir', 91, 28)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Kandla', 92, 28)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Anand ', 93, 28)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bhuj-rudramata ', 94, 28)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N' Bulsar ', 95, 28)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Dharmpur ', 96, 28)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Dohad ', 97, 28)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Dwarka ', 98, 28)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Gandhinagar ', 99, 28)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Jamnagar ', 100, 28)
GO
print 'Processed 100 total records'
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Nadiad ', 101, 28)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Porbandar ', 102, 28)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Rajkot ', 103, 28)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Surat ', 104, 28)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Vadodara ', 105, 28)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Valsad ', 106, 28)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Vapi ', 107, 28)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Veraval ', 108, 28)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Ahmedabad', 109, 28)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Saudi Arabia', 110, 30)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Hisar', 111, 29)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Karnal', 112, 29)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Kurukshetra', 113, 29)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Panipat', 114, 29)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Chandigarh', 115, 29)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Rohtak', 116, 29)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Baharin', 117, 31)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bahrain', 118, 31)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'singapore', 119, 32)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Ambala ', 120, 29)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Faridabad ', 121, 29)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Gurgaon ', 122, 29)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Hissar ', 123, 29)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Panambur ', 124, 29)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Panchkula', 125, 29)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Dhaka', 126, 34)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Chitigong', 127, 35)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Sylhet', 128, 36)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Rajshahi', 129, 37)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Khulna', 130, 38)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Barisal', 131, 39)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Dalhousie', 132, 33)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Dharmasala', 133, 33)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Kulu/Manali', 134, 33)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Shimla', 135, 33)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bangladesh', 136, 40)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Dhaka', 137, 40)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Kandy', 138, 41)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Trincomalee', 139, 42)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Anuradhapura', 140, 43)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Jaffna', 141, 44)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Kurunegala', 142, 45)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Ratnapura', 143, 46)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Galle', 144, 47)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Badulla', 145, 48)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Colombo', 146, 49)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Colombo', 147, 50)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Sri Lanka', 148, 50)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bangladesh', 149, 52)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bangla', 150, 52)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Thailand', 151, 54)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Jammu', 152, 53)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Srinagar', 153, 53)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Turkey', 154, 56)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bokaro', 155, 57)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Dhanbad', 156, 57)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Jamshedpur', 157, 57)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Ranchi', 158, 57)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'United Kingdom', 159, 58)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Abu Dhabi', 160, 59)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Ajmân', 161, 59)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Al Ain', 162, 59)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Al Awdah', 163, 59)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Al Fahlayn', 164, 59)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Al Fulayyah', 165, 59)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Al Fara', 166, 59)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Al Ghabah', 167, 59)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Al Ghabam', 168, 59)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Al Ghashban', 169, 59)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Al Hamraniyah', 170, 59)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Al Hamriyah', 171, 59)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Al Haybah', 172, 59)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Al Hayl', 173, 59)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Al Hayr', 174, 59)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Dubai', 175, 59)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Sharjah', 176, 59)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Ras Al Khaimah', 177, 59)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Fujairah', 178, 59)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Um Al Quwain', 179, 59)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Khor Fakkan', 180, 59)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Ajman', 181, 59)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Dombivli', 182, 117)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Dubai', 183, 60)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'United States', 184, 61)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Montgomery', 185, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bessemer', 186, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bay Minette', 187, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Abbeville', 188, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Alabaster', 189, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Albertville', 190, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Alexander City', 191, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Andalusia', 192, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Anniston', 193, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Athens', 194, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Atmore', 195, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Attalla', 196, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bayou La Batre', 197, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Boaz', 198, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Brent', 199, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Brewton', 200, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Cahaba Heights', 201, 62)
GO
print 'Processed 200 total records'
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Calera', 202, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Camden', 203, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Center Point', 204, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Chickasaw', 205, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Childersburg', 206, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Clanton', 207, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Collinsville', 208, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Cottondale', 209, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Cullman', 210, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Daleville', 211, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Daphne', 212, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Decatur', 213, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Demopolis', 214, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Dothan', 215, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Eufaula', 216, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Evergreen', 217, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Fairfield', 218, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Alabama Adventure', 219, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Arab', 220, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Auburn', 221, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Enterprise', 222, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Fairhope', 223, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Florence', 224, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Foley', 225, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Forestdale', 226, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Fort Payne', 227, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Fort Rucker', 228, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Fultondale', 229, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Gadsden', 230, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Gardendale', 231, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Glencoe', 232, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Greenville', 233, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Grove Hill', 234, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Gulf Shores', 235, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Guntersville', 236, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Haleyville', 237, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Hamilton', 238, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Hartselle', 239, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Heflin', 240, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Helena', 241, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Homewood', 242, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Hoover', 243, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Hope Hull', 244, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Horseshoe Bend National Military', 245, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Hueytown', 246, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Huntsville', 247, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Irondale', 248, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Jackson', 249, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Jacksonville', 250, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Jasper', 251, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Lanett', 252, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Leeds', 253, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Lincoln', 254, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Livingston', 255, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Loxley', 256, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Madison', 257, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Marion', 258, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Marshall Space Flight Center', 259, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Maxwell-Gunter AFB', 260, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Midfield', 261, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Millbrook', 262, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Mobile', 263, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Monroeville', 264, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Montevallo', 265, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Moody', 266, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Moulton', 267, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Mountain Brook', 268, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Muscle Shoals', 269, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'North Mobile', 270, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Northport', 271, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Oneonta', 272, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Opelika', 273, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Opp', 274, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Orange Beach', 275, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Oxford', 276, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Ozark', 277, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Pelham', 278, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Pell City', 279, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Phenix City', 280, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Pinson', 281, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Pisgah', 282, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Pleasant Grove', 283, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Point Clear', 284, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Prattville', 285, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Priceville', 286, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Prichard', 287, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Rainbow City', 288, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Redstone Arsenal', 289, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Riverside', 290, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Roanoke', 291, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Russellville', 292, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Saks', 293, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Saraland', 294, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Satsuma', 295, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Scottsboro', 296, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Selma', 297, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Sheffield', 298, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Shorter', 299, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Smiths', 300, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Southside', 301, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Spanish Fort', 302, 62)
GO
print 'Processed 300 total records'
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Sylacauga', 303, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Talladega', 304, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Theodore', 305, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Thomasville', 306, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Tillmans Corner', 307, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Troy', 308, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Trussville', 309, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Tuscaloosa', 310, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Tuscumbia', 311, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Tuskegee', 312, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Valley', 313, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Vance', 314, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Vestavia Hills', 315, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Visionland Amusement Park', 316, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Wetumpka', 317, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'York', 318, 62)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Juneau', 319, 63)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Phoenix', 320, 64)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Little Rock', 321, 65)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Jonesboro', 322, 65)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Sacramento', 323, 66)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Santa Clara', 324, 66)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'San Francisco', 325, 66)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Culver City', 326, 66)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Manhattan Beach', 327, 66)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'La Jolla', 328, 66)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Santa Rosa', 329, 66)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'San Diego', 330, 66)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'El Segundo', 331, 66)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Long Beach', 332, 66)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Irvine', 333, 66)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Denver', 334, 67)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Colorado Springs', 335, 67)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Hartford', 336, 68)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Danbury', 337, 68)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Dover', 338, 69)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Tallahassee', 339, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'West Palm Beach', 340, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Jacksonville', 341, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Alachua', 342, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Altamonte Springs', 343, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Amelia Island', 344, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Apalachicola', 345, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Apollo Beach', 346, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Apopka', 347, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Arcadia', 348, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Atlantic Beach', 349, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Auburndale', 350, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Aventura', 351, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Avon Park', 352, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Azalea Park', 353, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bal Harbour', 354, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bartow', 355, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Baldwin', 356, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bay Harbor Islands', 357, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bay Hill', 358, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bay Lake', 359, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bayonet Point', 360, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bayshore Gardens', 361, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bee Ridge', 362, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bellair', 363, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Belle Glade', 364, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bell Isle', 365, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bellview', 366, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Big Pine Key', 367, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Biscayne National Park', 368, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bloomingdale', 369, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Boca Grande', 370, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Boca Raton', 371, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bonifay', 372, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bonita Beach', 373, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bonita Springs', 374, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bowling Green', 375, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Boyette', 376, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Boynton Beach', 377, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Brandon', 378, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Brent', 379, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Brooksville', 380, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Buena Ventura Lakes', 381, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bunnell', 382, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Busch Gardens', 383, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bushnell', 384, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Callaway', 385, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Cape Canaveral', 386, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Cape Coral', 387, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Cape Haze', 388, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Captiva Island', 389, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Carol City', 390, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Carrollwood', 391, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Casselberry', 392, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Cedar Grove', 393, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Celebration', 394, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Championsgate', 395, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Charlotte Harbour', 396, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Chiefland', 397, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Chipley', 398, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Citrus Park', 399, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Clearwater', 400, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Clermont', 401, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Clewiston', 402, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Cocoa', 403, 70)
GO
print 'Processed 400 total records'
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Coconut Creek', 404, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Coconut Grove', 405, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Conway', 406, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Cooper City', 407, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Coral Gables', 408, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Coral Springs', 409, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Crestview', 410, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Crystal River', 411, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Cutler Ridge', 412, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Cypress Gardens', 413, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Park', 414, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Dania Beach', 415, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Davenport', 416, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Davie', 417, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Daytona Beach', 418, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Debary', 419, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Deerfield Beach', 420, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Defuniak Springs', 421, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Deland', 422, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Delray Beach', 423, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Deltona', 424, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Destin Beach', 425, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Discovery Cove', 426, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Disney MGM Studios', 427, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Disney Epcot Center', 428, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Dry Tortugas National Park', 429, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Duck Key', 430, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Dundee', 431, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Dunedin', 432, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'East Naples', 433, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'East Palatka', 434, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Eglin AFB ', 435, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Elkton', 436, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Ellenton', 437, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Englewood', 438, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Ensley', 439, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Estero', 440, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Eustis', 441, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Everglades City', 442, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Everglades National Park', 443, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Fairview', 444, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Fern Park', 445, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Fernandina Beach', 446, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Ferry Pass', 447, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Fisher Island', 448, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Florida City', 449, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Florida Keys', 450, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Forest City', 451, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Fort Lauderdale', 452, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Fort Myers', 453, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Fort Pierce', 454, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Fort Walton Beach', 455, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Fruit Cove', 456, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Fruitville', 457, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Gainesville', 458, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Gibsonton', 459, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Gifford', 460, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Golden Beach', 461, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Golden Gate', 462, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Goldenrod', 463, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Gonzalez', 464, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Goulds', 465, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Greenacres', 466, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Gulf Breeze', 467, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Gulfport', 468, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Haines City', 469, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Hallandale', 470, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Heathrow', 471, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Hernando', 472, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Hialeah', 473, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Hialeah Gardens', 474, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Highland Beach', 475, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Hillsboro Beach', 476, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Hobe Sound', 477, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Holiday', 478, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Hollywood', 479, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Holly Hill', 480, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Holy Land Experience', 481, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Homestead', 482, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Homosassa', 483, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Hudson', 484, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Hurlburt Field', 485, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Hutchinson Island', 486, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Immokalee', 487, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Indialantic', 488, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Indian Harbor Beach', 489, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Indian Rocks Beach', 490, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Indian Shores', 491, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Inverness', 492, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Islamorada', 493, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Jasmine Estates', 494, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Jasper', 495, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Jennings', 496, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Jensen Beach', 497, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Juno Beach', 498, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Jupiter', 499, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Melbourne', 500, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Kendall', 501, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Key Biscayne', 502, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Key Largo', 503, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Key West', 504, 70)
GO
print 'Processed 500 total records'
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Kissimmee', 505, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Lady Lake', 506, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Lake Buena Vista', 507, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Lake Mary', 508, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Lake City', 509, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Lake Park', 510, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Lake Placid', 511, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Lake Wales', 512, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Lake Worth', 513, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Lakeland', 514, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Lakewood', 515, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Lamont', 516, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Land O Lakes', 517, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Lantana', 518, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Largo', 519, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Lauderdale Lakes', 520, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Lauderhill', 521, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Laurel', 522, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Lealman', 523, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Leesburg', 524, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Leisure City', 525, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Little Palm Island', 526, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Little Torch Key', 527, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Live Oak', 528, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Lockhart', 529, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Long Key', 530, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Longboat Key', 531, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Longwood', 532, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Lutz', 533, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Lynn Haven', 534, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'MacClenny', 535, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'MacDill AFB', 536, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Madeira Beach', 537, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Madison', 538, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Maitland', 539, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Manalapan', 540, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Mango', 541, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Marathon', 542, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Marco Island', 543, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Margate', 544, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Marianna', 545, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Mary Esther', 546, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Mayport Naval Station', 547, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Merritt Island', 548, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Miami', 549, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Miami Lakes', 550, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Micanopy', 551, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Micco', 552, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Middleburg', 553, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Midway', 554, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Milton', 555, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Mims', 556, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Miramar', 557, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Monticello', 558, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Mossy Head', 559, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Mount Dora', 560, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Mulberry', 561, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Myrtle Grove', 562, 70)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Atlanta', 563, 71)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Honolulu', 564, 72)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Boise', 565, 73)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Batavia', 566, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Beach Park', 567, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Belleville', 568, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bellwood', 569, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Belvidere', 570, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bensenville', 571, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Berwyn', 572, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bloom', 573, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bloomingdale', 574, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bloomington', 575, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Blue Island', 576, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bolingbrook', 577, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bourbonnais', 578, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bradley', 579, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bremen', 580, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bridgeview', 581, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Brookfield', 582, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bruce', 583, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Buffalo Grove', 584, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Burbank', 585, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Burr Ridge', 586, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Cahokia', 587, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Calumet', 588, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Campton', 589, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Canteen', 590, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Canton', 591, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Capital', 592, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Carbondale', 593, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Carol Stream', 594, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Carpentersville', 595, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Cary', 596, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Centralia', 597, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Champaign', 598, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Channahon', 599, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Charleston', 600, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Cicero', 601, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Collinsville', 602, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Coloma', 603, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Country Club Hills', 604, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Crest Hill', 605, 74)
GO
print 'Processed 600 total records'
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Crestwood', 606, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Crystal Lake', 607, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Springfield', 608, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Chicago', 609, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Addison', 610, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Algonquin', 611, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Alsip', 612, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Alton', 613, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Antioch', 614, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Arlington Heights', 615, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Aurora', 616, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Barrington', 617, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bartlett', 618, 74)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Indianapolis', 619, 75)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Alexandria', 620, 75)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Dale', 621, 75)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Ferdinand', 622, 75)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Fort Wayne', 623, 75)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Frankfort', 624, 75)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Rising Sun', 625, 75)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Saint John', 626, 75)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Scottsburg', 627, 75)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Des Moines', 628, 76)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Topeka', 629, 77)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Frankfort', 630, 78)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Baton Rouge', 631, 79)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Augusta', 632, 80)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Annapolis', 633, 82)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Silver Spring', 634, 82)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Silver Hill', 635, 82)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'St. Charles', 636, 82)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Stevensville', 637, 82)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Walker Mill', 638, 82)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Landover', 639, 82)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Boston', 640, 83)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Hopkington', 641, 83)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Hadley', 642, 83)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Hancock', 643, 83)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Danvers', 644, 83)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Dedham', 645, 83)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Andover', 646, 83)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Lansing', 647, 84)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Albany', 648, 81)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'New York City - NYC', 649, 81)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Detroit', 650, 84)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Saint Paul', 651, 85)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Plymouth', 652, 85)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Jackson', 653, 86)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Jefferson City', 654, 87)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'nevada', 655, 81)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Helena', 656, 88)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Lincoln', 657, 89)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Jackson', 658, 81)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Carson City', 659, 90)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Concord', 660, 91)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Trenton', 661, 92)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Hopewell', 662, 92)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Santa Fe', 663, 93)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Raleigh', 664, 94)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bismarck', 665, 95)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Columbus', 666, 96)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Cleveland', 667, 96)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Oklahoma City', 668, 97)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Salem', 669, 98)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Philadelphia', 670, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Abington', 671, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Adams', 672, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Aliquippa', 673, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Allegheny', 674, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Allentown', 675, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Altoona', 676, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Ambler', 677, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Ambridge', 678, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Amity', 679, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Antis', 680, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Antrim', 681, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Archbald', 682, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Arnold', 683, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Aston', 684, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Avalon', 685, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Baldwin', 686, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bangor', 687, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Beaver Falls', 688, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bellefonte', 689, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bellevue', 690, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Benner', 691, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bensalem', 692, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bern', 693, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Berwick', 694, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bethel', 695, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bethel Park', 696, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bethlehem', 697, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Birdsboro', 698, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Blakely', 699, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bloomsburg', 700, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bradford', 701, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Brecknock', 702, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Brentwood', 703, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bridgeville', 704, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Brighton', 705, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bristol', 706, 99)
GO
print 'Processed 700 total records'
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Brookhaven', 707, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Buckingham', 708, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Buffalo', 709, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bullskin', 710, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bushkill', 711, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Butler', 712, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'California', 713, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Caln', 714, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Cambria', 715, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Camp Hill', 716, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Canonsburg', 717, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Carbondale', 718, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Carlisle', 719, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Carnegie', 720, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Carroll', 721, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Castle Shannon', 722, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Catasauqua', 723, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Center', 724, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Chambersburg', 725, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Chanceford', 726, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Chartiers', 727, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Cheltenham', 728, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Chester', 729, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Chestnuthill', 730, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Chippewa', 731, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Clairton', 732, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Clarion', 733, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Clarks Summit', 734, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Clay', 735, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Clearfield', 736, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Clifton Heights', 737, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Coal', 738, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Coatesville', 739, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Colebrookdale', 740, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'College', 741, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Collier', 742, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Collingdale', 743, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Columbia', 744, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Concord', 745, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Conemaugh', 746, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Conewago', 747, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Connellsville', 748, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Conshohocken', 749, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Coolbaugh', 750, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Coraopolis', 751, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Corry', 752, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Crafton', 753, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Cranberry', 754, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Cumberland', 755, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Cumru', 756, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Harrisburg', 757, 99)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Providence', 758, 100)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Columbia', 759, 101)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Pierre', 760, 102)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Nashville', 761, 103)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Memphis', 762, 103)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Austin', 763, 104)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Richardson', 764, 104)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Plano', 765, 104)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Salt Lake City', 766, 105)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Montpelier', 767, 106)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Richmond', 768, 0)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Reston', 769, 0)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Raphine', 770, 0)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Radford', 771, 0)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Ridgeway', 772, 0)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Roanoke', 773, 0)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Rocky Mount', 774, 0)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Rose Hill', 775, 0)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Rosslyn', 776, 0)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Ruther Glen', 777, 0)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Fairfax', 778, 0)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Alexandria', 779, 0)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Abingdon', 780, 0)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'La Crosse', 781, 0)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Lakeside', 782, 0)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Olympia', 783, 0)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Seattle', 784, 0)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Washington', 785, 0)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Charleston', 786, 107)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Madison', 787, 108)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Hartford', 788, 108)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Cheyenne', 789, 109)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Kolar', 790, 110)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Belgaum ', 791, 110)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bellary ', 792, 110)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Chitradurga ', 793, 110)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Gulbarga ', 794, 110)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Honavar ', 795, 110)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Hubli ', 796, 110)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N' Karwar ', 797, 110)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Madikeri', 798, 110)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Mandya ', 799, 110)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Mangalore ', 800, 110)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Tumkur ', 801, 110)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Udupi ', 802, 110)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Yemen', 803, 111)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'KORMANGALA', 804, 110)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Trivandrum ', 805, 112)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Angamaly', 806, 112)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Thiruvananthapuram ', 807, 112)
GO
print 'Processed 800 total records'
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Kochi', 808, 112)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Kollam', 809, 112)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Alapuzha ', 810, 112)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Alleppey ', 811, 112)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Aluva ', 812, 112)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Calicut ', 813, 112)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Cannanore ', 814, 112)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Cherpalcheri ', 815, 112)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Cochin ', 816, 112)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Indonesia', 817, 114)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Idukki ', 818, 112)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Kalamassery ', 819, 112)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Kottayam ', 820, 112)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Kukkundur', 821, 112)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Malappuram ', 822, 112)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Palakkad ', 823, 112)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Kannur', 824, 112)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Pathanamthitta ', 825, 112)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Perumbavoor ', 826, 112)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Quilon ', 827, 112)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'KOZHIKODE', 828, 112)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Palarivattom', 829, 112)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Edappally', 830, 112)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Trichur ', 831, 112)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bhopal ', 832, 115)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bilaspur ', 833, 115)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Guna ', 834, 115)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Gwalior ', 835, 115)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Jagdalpur ', 836, 115)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Khajuraho ', 837, 115)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Khandwa ', 838, 115)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Pendra ', 839, 115)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Satna ', 840, 115)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Sidhi ', 841, 115)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Umaria ', 842, 115)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Indore', 843, 115)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Jabalpur', 844, 115)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Work From Home', 845, 116)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'mumbai', 846, 117)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Dhule', 847, 117)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Solapur', 848, 117)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Nasik', 849, 117)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'pune', 850, 117)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'amravati', 851, 117)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'new mumbai', 852, 117)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'amravati', 853, 117)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'jalgaon', 854, 117)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'aurangabad', 855, 117)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'satara', 856, 117)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Imphal ', 857, 118)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Shillong', 858, 119)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Aizawal', 859, 120)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Dimapur', 860, 121)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'nagpur', 861, 117)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'nashik', 862, 117)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Balasore ', 863, 123)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bhubaneswar ', 864, 123)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Cuttack ', 865, 123)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Gopalpur ', 866, 123)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Jharsuguda ', 867, 123)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Kalingapatnam ', 868, 123)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Puri ', 869, 123)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Hyderabad', 870, 5)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bengaluru', 871, 110)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Mysore', 872, 110)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Amritsar', 873, 124)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bathinda', 874, 124)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Jalandhar', 875, 124)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Ludhiana', 876, 124)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Mohali', 877, 124)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Pathankot', 878, 124)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Patiala', 879, 124)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Ajmer ', 880, 125)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Alwar ', 881, 125)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bhilwara ', 882, 125)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Bikaner ', 883, 125)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Jaipur ', 884, 125)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Jaisalmer', 885, 125)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Jodhpur', 886, 125)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Kota', 887, 125)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Udaipur', 888, 125)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Tennur', 889, 127)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Coimbatore', 890, 127)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Sivakasi', 891, 127)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Madurai', 892, 127)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Trichy', 893, 127)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'chennai', 894, 127)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Agartala', 895, 128)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Noida', 896, 129)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Ghaziabad', 897, 129)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Meerut', 898, 129)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Agra', 899, 129)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Kanpur', 900, 129)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Lucknow', 901, 129)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Dehradun', 902, 130)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'haridwar', 903, 130)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'roorkee', 904, 130)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Nainital', 905, 130)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Asansol', 906, 131)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Durgapur', 907, 131)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Haldia', 908, 131)
GO
print 'Processed 900 total records'
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Kharagpur', 909, 131)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Siliguri', 910, 131)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Kolkatta', 911, 131)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Edmonton', 912, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Airdrie', 913, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Athabasca', 914, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Banff', 915, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Brooks', 916, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Calgary', 917, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Canmore', 918, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Clairmont', 919, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Claresholm', 920, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Cochrane', 921, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Cold Lake', 922, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Didsbury', 923, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Drayton Valley', 924, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Drumheller', 925, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Edson', 926, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Fort McMurray', 927, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Fort Saskatchewan', 928, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Grande Cache', 929, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Grande Prairie', 930, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Hanna', 931, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'High Level', 932, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'High River', 933, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Hinton', 934, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Jasper', 935, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Kananaskis Village', 936, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Lake Louise', 937, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Leduc', 938, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Lethbridge', 939, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Lloydminster', 940, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Medicine Hat', 941, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Nisku', 942, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Okotoks', 943, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Olds', 944, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Pincher Creek', 945, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Red Deer', 946, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Rocky Mountain House', 947, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Sherwood Park', 948, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Slave Lake', 949, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Stettler', 950, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Stony Plain', 951, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Strathmore', 952, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Taber', 953, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Three Hills', 954, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Vermilion', 955, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Waterton Park', 956, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Wetaskiwin', 957, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Whitecourt', 958, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Comox', 959, 132)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Victoria', 960, 133)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Vancouver', 961, 133)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Richmond', 962, 133)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Abbotsford', 963, 133)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Aldergrove', 964, 133)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Blue River', 965, 133)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Burnaby', 966, 133)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Burns Lake', 967, 133)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Cache Creek', 968, 133)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Campbell River', 969, 133)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Castlegar', 970, 133)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Chilliwack', 971, 133)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Clearbrook', 972, 133)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Clearwater', 973, 133)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Coquitlam', 974, 133)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Courtenay', 975, 133)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Cowichan Bay', 976, 133)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Cranbrook', 977, 133)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Dawson Creek', 978, 133)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Delta', 979, 133)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Duncan', 980, 133)
INSERT [dbo].[citytable] ([cityname], [cityid], [stateid]) VALUES (N'Enderby', 981, 133)
SET IDENTITY_INSERT [dbo].[citytable] OFF
/****** Object:  Table [dbo].[jobcategory]    Script Date: 07/02/2015 15:41:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[jobcategory](
	[jobcategoryid] [smallint] IDENTITY(1,1) NOT NULL,
	[category] [varchar](255) NOT NULL,
 CONSTRAINT [PK_jobcategory] PRIMARY KEY CLUSTERED 
(
	[jobcategoryid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[jobcategory] ON
INSERT [dbo].[jobcategory] ([jobcategoryid], [category]) VALUES (1, N'IT - Software')
INSERT [dbo].[jobcategory] ([jobcategoryid], [category]) VALUES (3, N'Call Centre/ ITES/ BPO')
INSERT [dbo].[jobcategory] ([jobcategoryid], [category]) VALUES (4, N'Marketing / Sales')
INSERT [dbo].[jobcategory] ([jobcategoryid], [category]) VALUES (5, N'Accounts / Finance')
INSERT [dbo].[jobcategory] ([jobcategoryid], [category]) VALUES (6, N'Engg / Production / QC')
INSERT [dbo].[jobcategory] ([jobcategoryid], [category]) VALUES (7, N'HR / Admin / Personnel')
INSERT [dbo].[jobcategory] ([jobcategoryid], [category]) VALUES (8, N'Advertising / PR')
INSERT [dbo].[jobcategory] ([jobcategoryid], [category]) VALUES (9, N'Purchasing / Supply Chain')
INSERT [dbo].[jobcategory] ([jobcategoryid], [category]) VALUES (10, N'Legal / Law / CS')
INSERT [dbo].[jobcategory] ([jobcategoryid], [category]) VALUES (11, N'Export / Import / Liason')
INSERT [dbo].[jobcategory] ([jobcategoryid], [category]) VALUES (12, N'Others')
INSERT [dbo].[jobcategory] ([jobcategoryid], [category]) VALUES (15, N'Pharmaceutical/ Biotech')
INSERT [dbo].[jobcategory] ([jobcategoryid], [category]) VALUES (16, N'Hotels / Restaurants')
INSERT [dbo].[jobcategory] ([jobcategoryid], [category]) VALUES (19, N'Content /  Journalism')
INSERT [dbo].[jobcategory] ([jobcategoryid], [category]) VALUES (20, N'Shipping / Marine')
INSERT [dbo].[jobcategory] ([jobcategoryid], [category]) VALUES (21, N'Teaching / Education')
INSERT [dbo].[jobcategory] ([jobcategoryid], [category]) VALUES (22, N'Travel / Tourism / Airlines')
INSERT [dbo].[jobcategory] ([jobcategoryid], [category]) VALUES (23, N'Telecom / RF')
INSERT [dbo].[jobcategory] ([jobcategoryid], [category]) VALUES (24, N'Hospitals / Health')
INSERT [dbo].[jobcategory] ([jobcategoryid], [category]) VALUES (25, N' Banking / Insurance')
INSERT [dbo].[jobcategory] ([jobcategoryid], [category]) VALUES (26, N'Security / Army / Navy')
INSERT [dbo].[jobcategory] ([jobcategoryid], [category]) VALUES (27, N'Secretary /Office Staff')
INSERT [dbo].[jobcategory] ([jobcategoryid], [category]) VALUES (28, N'Financial Services')
INSERT [dbo].[jobcategory] ([jobcategoryid], [category]) VALUES (29, N'Retail Chains/ Shops')
INSERT [dbo].[jobcategory] ([jobcategoryid], [category]) VALUES (30, N'Distribution / Delivery')
INSERT [dbo].[jobcategory] ([jobcategoryid], [category]) VALUES (31, N'Architects / Construction')
INSERT [dbo].[jobcategory] ([jobcategoryid], [category]) VALUES (32, N'Fashion / Garments')
INSERT [dbo].[jobcategory] ([jobcategoryid], [category]) VALUES (36, N'Top / Senior Mgmt')
INSERT [dbo].[jobcategory] ([jobcategoryid], [category]) VALUES (37, N'NGOs/Govt Jobs/Defence')
INSERT [dbo].[jobcategory] ([jobcategoryid], [category]) VALUES (38, N'CAD / CAM')
INSERT [dbo].[jobcategory] ([jobcategoryid], [category]) VALUES (39, N'IT- Hardware / Networking')
INSERT [dbo].[jobcategory] ([jobcategoryid], [category]) VALUES (40, N'Graphic / Web Design')
INSERT [dbo].[jobcategory] ([jobcategoryid], [category]) VALUES (41, N'Packaging')
INSERT [dbo].[jobcategory] ([jobcategoryid], [category]) VALUES (42, N'Businessman')
INSERT [dbo].[jobcategory] ([jobcategoryid], [category]) VALUES (43, N'BioTech/R&D/Scientist')
SET IDENTITY_INSERT [dbo].[jobcategory] OFF
/****** Object:  StoredProcedure [dbo].[jobbySearchnpage]    Script Date: 07/02/2015 15:41:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[jobbySearchnpage]
@startRowIndex int = 1,
@maximumRows int,
@crteria varchar(max),
@Count int = 0 output
as
declare @sqlst nvarchar(max),@MaxRow int,@startRow int


select @sqlst='select @Count = Count(*) from [joblistn] where '+ @crteria 

EXEC sp_executesql @sqlst,N'@Count numeric(20,0) OUTPUT', @Count OUTPUT


set @startRow = ((@startRowIndex -1)  * @maximumRows) + 1
set @MaxRow= (@startRowIndex * @maximumRows) + 1;


declare @tempTbl table(
Jobid bigint,
memsid bigint,
designation varchar(250) ,
jobdescription varchar(2000),
minexp int,
maxexp  int,
sysentrydate datetime, 
category varchar(255),
cityname varchar(250),
countryname varchar(250),
statename varchar(250),
fname varchar(50),
gimg varchar(650),
rowid int  
)

select @sqlst ='select * from
(

select 
joblistn.Jobid,
joblistn.memsid,
joblistn.designation,
joblistn.jobdescription,
joblistn.minexp ,
joblistn.maxexp  ,
joblistn.sysentrydate, 
jobcategory.category ,
citytable.cityname,
Country.countryname,
states.statename,
Mems.fname,Mems.gimg ,    
 ROW_NUMBER() OVER(ORDER BY joblistn.jobid DESC) AS rowid
from joblistn  
join jobcategory  on joblistn.jobcategoryid = jobcategory.jobcategoryid 
join citytable  on joblistn.cityid = citytable.cityid
join Country  on joblistn.countryid = Country.COUNTRYID
join states  on joblistn.stateid = states.stateid
join Mems  on joblistn.memsid = Mems.memsid    

where '+ @crteria +'

) as kk'

insert into @tempTbl EXEC(@sqlst + ' where rowid >= '+@startRow+' AND rowid < ('+ @MaxRow + ')')


select * from @tempTbl

--declare @Count int
--EXEc jobbySearchnpage 245,10,'isApproved =''Y'' AND joblistn.memsid = 14',@Count out
--select @Count
GO
/****** Object:  StoredProcedure [dbo].[Job_Search]    Script Date: 07/02/2015 15:41:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Job_Search]
@criteria varchar(MAX)

as

SET NOCOUNT ON;

Declare @sqlst as nvarchar(MAX)


set @sqlst= 'select Jobid
      ,memsid
      ,jobcategoryid
      ,sysentrydate
      ,designation
      ,jobdescription
      ,minexp
      ,maxexp
      ,salary
      ,countryid
      ,stateid
      ,cityid
      ,contact
      ,telephone
      ,email
      ,website
      ,isApproved from joblistn where ' + @criteria  

EXEC sp_executesql @sqlst
GO
/****** Object:  StoredProcedure [dbo].[insertNewCar]    Script Date: 07/02/2015 15:41:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[insertNewCar]
@memsid bigint,
@Makeid bigint,
@ModelID bigint,
@Version nvarchar(500),
@Price bigint,
@Pname nvarchar(50),
@Email nvarchar(50),
@Stateid smallint,
@cityid smallint,
@Mobile nvarchar(500),
@Ldate date=getdate,
@countryId smallint
as
declare @carId bigint

INSERT INTO [nextdhoom].[dbo].[NewCar]
           ([memsid]
           ,[Makeid]
           ,[ModelID]
           ,[Version]
           ,[Price]
           ,[Pname]
           ,[Email]
           ,[Stateid]
           ,[cityid]
           ,[Mobile]
           ,[Ldate]
           ,[countryId]
           )
     VALUES
           (@memsid ,
@Makeid ,
@ModelID ,
@Version ,
@Price ,
@Pname ,
@Email ,
@Stateid ,
@cityid ,
@Mobile ,
@Ldate ,
@countryId )

select @@IDENTITY 

set @carId = SCOPE_IDENTITY()

return @carId
GO
/****** Object:  StoredProcedure [dbo].[GetJSON]    Script Date: 07/02/2015 15:41:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetJSON] (
@ParameterSQL AS VARCHAR(MAX)
)
AS
BEGIN

DECLARE @SQL NVARCHAR(MAX)
DECLARE @XMLString VARCHAR(MAX)
DECLARE @XML XML
DECLARE @Paramlist NVARCHAR(1000)
SET @Paramlist = N'@XML XML OUTPUT'
SET @SQL = 'WITH PrepareTable (XMLString) '
SET @SQL = @SQL + 'AS ( '
SET @SQL = @SQL + @ParameterSQL+ ' FOR XML RAW, TYPE, ELEMENTS '
SET @SQL = @SQL + ') '
SET @SQL = @SQL + 'SELECT @XML = XMLString FROM PrepareTable '
EXEC sp_executesql @SQL, @Paramlist, @XML=@XML OUTPUT
SET @XMLString = CAST(@XML AS VARCHAR(MAX))

DECLARE @JSON VARCHAR(MAX)
DECLARE @Row VARCHAR(MAX)
DECLARE @RowStart INT
DECLARE @RowEnd INT
DECLARE @FieldStart INT
DECLARE @FieldEnd INT
DECLARE @KEY VARCHAR(MAX)
DECLARE @Value VARCHAR(MAX)

DECLARE @StartRoot VARCHAR(100); SET @StartRoot = '<row>'
DECLARE @EndRoot VARCHAR(100); SET @EndRoot = '</row>'
DECLARE @StartField VARCHAR(100); SET @StartField = '<'
DECLARE @EndField VARCHAR(100); SET @EndField = '>'

SET @RowStart = CharIndex(@StartRoot, @XMLString, 0)
SET @JSON = ''
WHILE @RowStart > 0
BEGIN
	SET @RowStart = @RowStart+Len(@StartRoot)
	SET @RowEnd = CharIndex(@EndRoot, @XMLString, @RowStart)
	SET @Row = SubString(@XMLString, @RowStart, @RowEnd-@RowStart)
	SET @JSON = @JSON+'{'

	-- for each row
	SET @FieldStart = CharIndex(@StartField, @Row, 0)
	WHILE @FieldStart > 0
	BEGIN
		-- parse node key
		SET @FieldStart = @FieldStart+Len(@StartField)
		SET @FieldEnd = CharIndex(@EndField, @Row, @FieldStart)
		SET @KEY = SubString(@Row, @FieldStart, @FieldEnd-@FieldStart)
		SET @JSON = @JSON+'"'+@KEY+'":'

		-- parse node value
		SET @FieldStart = @FieldEnd+1
		SET @FieldEnd = CharIndex('</',@Row,@FieldStart)
		SET @Value = SubString(@Row,@FieldStart,@FieldEnd-@FieldStart)
		SET @JSON = @JSON+'"'+@Value+'",'

		SET @FieldStart = @FieldStart+Len(@StartField)
		SET @FieldEnd = CharIndex(@EndField,@Row,@FieldStart)
		SET @FieldStart = CharIndex(@StartField,@Row,@FieldEnd)
	END	
	IF LEN(@JSON)>0 SET @JSON = SubString(@JSON, 0, LEN(@JSON))
	SET @JSON =@JSON+'},  '
	--/ for each row

	SET @RowStart = CharIndex(@StartRoot,@XMLString,@RowEnd)
END
IF LEN(@JSON)>0 SET @JSON = SubString(@JSON, 0, LEN(@JSON))
SET @JSON = '['+@JSON+']'
SELECT @JSON
print @JSON
END

--EXEC GetJSON 'SELECT * FROM citytable'
GO
/****** Object:  Table [dbo].[ForumTopicAnswer]    Script Date: 07/02/2015 15:41:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ForumTopicAnswer](
	[AnsId] [bigint] IDENTITY(1,1) NOT NULL,
	[TopicId] [bigint] NOT NULL,
	[TopicAns] [varchar](5000) NOT NULL,
	[AnsDate] [datetime] NOT NULL,
	[IsApproved] [varchar](50) NOT NULL,
	[memsid] [bigint] NOT NULL,
 CONSTRAINT [PK_ForumTopicAnswer] PRIMARY KEY CLUSTERED 
(
	[AnsId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ForumTopic]    Script Date: 07/02/2015 15:41:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ForumTopic](
	[TopicId] [bigint] IDENTITY(1,1) NOT NULL,
	[TopicTitle] [nvarchar](500) NOT NULL,
	[TopicDesc] [nvarchar](max) NULL,
	[catid] [bigint] NOT NULL,
	[SubCatId] [bigint] NOT NULL,
	[UpdateCandiName] [varchar](250) NULL,
	[UpdateCandiId] [bigint] NULL,
	[StartDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NULL,
	[LastAnsId] [bigint] NULL,
	[IsApproved] [varchar](1) NOT NULL,
	[TotalView] [bigint] NOT NULL,
	[memsid] [bigint] NOT NULL,
 CONSTRAINT [PK_ForumTopic] PRIMARY KEY CLUSTERED 
(
	[TopicId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ForumSubCategory]    Script Date: 07/02/2015 15:41:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ForumSubCategory](
	[SubCatId] [bigint] IDENTITY(1,1) NOT NULL,
	[CatId] [bigint] NOT NULL,
	[SubCatTitle] [varchar](250) NOT NULL,
	[SubCatDesc] [varchar](500) NOT NULL,
	[StartedBy] [bigint] NOT NULL,
	[UpdatedBy] [bigint] NULL,
	[LastTopic] [bigint] NULL,
	[StartDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NULL,
	[IsApprover] [varchar](1) NOT NULL,
	[TotalView] [bigint] NOT NULL,
	[memsid] [bigint] NOT NULL,
 CONSTRAINT [PK_ForumSubCategory] PRIMARY KEY CLUSTERED 
(
	[SubCatId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ForumMainCategory]    Script Date: 07/02/2015 15:41:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ForumMainCategory](
	[catid] [bigint] IDENTITY(1,1) NOT NULL,
	[Category] [varchar](500) NOT NULL,
	[descrip] [varchar](500) NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[memsid] [bigint] NOT NULL,
 CONSTRAINT [PK_ForumMainCategory] PRIMARY KEY CLUSTERED 
(
	[catid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[User_Complaints]    Script Date: 07/02/2015 15:41:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[User_Complaints](
	[ComplaintID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserMobile] [varchar](20) NOT NULL,
	[EmailID] [varchar](250) NOT NULL,
	[UserName] [varchar](250) NOT NULL,
	[ComplaintHead] [varchar](500) NOT NULL,
	[ComplaintDesc] [varchar](5000) NOT NULL,
	[ComplaintDate] [datetime] NOT NULL,
	[IsResolved] [varchar](1) NOT NULL,
	[ResolvedDate] [datetime] NULL,
	[ResolvedBy] [bigint] NOT NULL,
	[ResolvedByName] [varchar](250) NOT NULL,
 CONSTRAINT [PK_User_Complaints] PRIMARY KEY CLUSTERED 
(
	[ComplaintID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[states]    Script Date: 07/02/2015 15:41:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[states](
	[countryid] [smallint] NOT NULL,
	[statename] [varchar](255) NOT NULL,
	[stateid] [smallint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_states] PRIMARY KEY CLUSTERED 
(
	[stateid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[states] ON
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (100, N'Ireland', 1)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (101, N'Israel', 2)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (102, N'Italy', 3)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (105, N'Japan', 4)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (1, N'Andhra Pradesh', 5)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (110, N'Kuwait', 6)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (1, N'Arunachal', 7)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (124, N'Malaysia', 8)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (1, N'Delhi', 9)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (1, N'Assam', 10)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (1, N'Bihar', 11)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (143, N'Nepal', 12)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (14, N'Australia', 13)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (1, N'Chhattisgarh', 14)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (155, N'Oman', 15)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (156, N'Balochistan', 16)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (156, N'North-West Frontier Province', 17)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (156, N'Punjab', 18)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (156, N'Sindh', 19)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (156, N'Federally Administered Tribal Areas', 20)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (156, N'Capital Territory', 21)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (156, N'Northern Areas', 22)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (156, N'Pakistan', 23)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (1, N'Goa', 24)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (162, N'Philippines', 25)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (167, N'Qatar', 26)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (169, N'Romania', 27)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (1, N'Gujarat', 28)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (1, N'Haryana', 29)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (181, N'Saudi Arabia', 30)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (18, N'Baharin', 31)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (185, N'singapore', 32)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (1, N'Himachal Pradesh', 33)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (19, N'Dhaka Div', 34)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (19, N'Chitigong Div', 35)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (19, N'Sylhet Div', 36)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (19, N'Rajshahi Div', 37)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (19, N'Khulna Div', 38)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (19, N'Barisal Div', 39)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (19, N'Banglades', 40)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (193, N'Central', 41)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (193, N'Eastern', 42)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (193, N'North Central', 43)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (193, N'Northern', 44)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (193, N'North Western', 45)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (193, N'Sabaragamuwa', 46)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (193, N'Southern', 47)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (193, N'Uva', 48)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (193, N'Western', 49)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (193, N'Sri Lanka', 50)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (1, N'Albania', 51)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (19, N'Bangladesh', 52)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (1, N'Jammu & Kashmir', 53)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (202, N'Thailand', 54)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (202, N'bangkok', 55)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (208, N'Turkey', 56)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (1, N'Jharkhand', 57)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (213, N'United Kingdom', 58)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (215, N'UAE', 59)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (215, N'dubai', 60)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'USA', 61)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'Alabama', 62)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'Alaska', 63)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'Arizona', 64)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'Arkansas', 65)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'California', 66)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'Colorado', 67)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'Connecticut', 68)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'Delaware', 69)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'Florida', 70)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'Georgia', 71)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'Hawaii', 72)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'Idaho', 73)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'Illinois', 74)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'Indiana', 75)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'Iowa', 76)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'Kansas', 77)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'Kentucky', 78)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'Louisiana', 79)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'Maine', 80)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'New York', 81)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'Maryland', 82)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'Massachusetts', 83)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'Michigan', 84)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'Minnesota', 85)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'Mississippi', 86)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'Missouri', 87)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'Montana', 88)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'Nebraska', 89)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'Nevada', 90)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'New Hampshire', 91)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'New Jersey', 92)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'New Mexico', 93)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'North Carolina', 94)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'North Dakota', 95)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'Ohio', 96)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'Oklahoma', 97)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'Oregon', 98)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'Pennsylvania', 99)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'Rhode Island', 100)
GO
print 'Processed 100 total records'
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'South Carolina', 101)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'South Dakota', 102)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'Tennessee', 103)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'Texas', 104)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'Utah', 105)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'Vermont', 106)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'West Virginia', 107)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'Wisconsin', 108)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (217, N'Wyoming', 109)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (1, N'Karnataka', 110)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (228, N'Yemen', 111)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (1, N'Kerala', 112)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (235, N'Oman', 113)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (238, N'Indonesia', 114)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (1, N'Madhya Pradesh', 115)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (245, N'Work From home', 116)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (1, N'Maharashtra', 117)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (1, N'Manipur', 118)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (1, N'Meghalaya', 119)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (1, N'Mizoram', 120)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (1, N'Nagaland', 121)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (2, N'Afghanistan', 122)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (1, N'Orissa', 123)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (1, N'Punjab', 124)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (1, N'Rajasthan', 125)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (1, N'Sikkim', 126)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (1, N'Tamil Nadu', 127)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (1, N'Tripura', 128)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (1, N'Uttar Pradesh', 129)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (1, N'Uttaranchal', 130)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (1, N'West Bengal', 131)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (39, N'Alberta', 132)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (39, N'British Columbia', 133)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (39, N'Manitoba', 134)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (39, N'New Brunswick', 135)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (39, N'Newfoundland', 136)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (39, N'Northwest Territories', 137)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (39, N'Nova Scotia', 138)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (39, N'Nunavut', 139)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (39, N'Ontario', 140)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (39, N'Prince Edward Island', 141)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (39, N'Quebec', 142)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (39, N'Saskatchewan', 143)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (39, N'Yukon', 144)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (45, N'China', 145)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (62, N'Egypt', 146)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (70, N'Fiji', 147)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (95, N'Hong Kong', 148)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (98, N'Indonesia', 149)
INSERT [dbo].[states] ([countryid], [statename], [stateid]) VALUES (99, N'Iraq', 150)
SET IDENTITY_INSERT [dbo].[states] OFF
/****** Object:  Table [dbo].[User_Complaints_Comments]    Script Date: 07/02/2015 15:41:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[User_Complaints_Comments](
	[CommentsID] [bigint] IDENTITY(1,1) NOT NULL,
	[ComplaintsID] [bigint] NOT NULL,
	[Comments] [varchar](5000) NOT NULL,
	[CommentsBy] [bigint] NOT NULL,
	[CommentsByName] [varchar](250) NOT NULL,
	[IsAdmin] [varchar](1) NOT NULL,
	[CommentsDate] [datetime] NOT NULL,
 CONSTRAINT [PK_User_Complaints_Comments] PRIMARY KEY CLUSTERED 
(
	[CommentsID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[usp_Delete_ClassifiedAdComments]    Script Date: 07/02/2015 15:41:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_Delete_ClassifiedAdComments]
@id  bigint
as

Delete from updateactivity where pk_id=@id and actType='ClassC'
Delete from adcomments where adcommentid= @id
GO
/****** Object:  StoredProcedure [dbo].[Usp_delete_AddPosted_Comments_ByMod]    Script Date: 07/02/2015 15:41:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[Usp_delete_AddPosted_Comments_ByMod]
@AdId Varchar(60)

as


Delete from updateactivity where pk_Id in (@AdId) and actType='Class'
Delete from updateactivity where pk_Id in (Select adcommentid from adcomments where adid=@AdId) and actType='ClassC'
Delete from adcomments where adid=@AdId
GO
/****** Object:  StoredProcedure [dbo].[viewprofilemem]    Script Date: 07/02/2015 15:41:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[viewprofilemem]
 @memsid bigint
As
select fname,lname,countryname,statename,cityname from mems mm left join Country cn
on mm.countryid=cn.countryid
left join states st
on mm.stateid=st.stateid
left join citytable ct
on mm.cityid=ct.cityid

where memsid=@memsid
GO
/****** Object:  Table [dbo].[joblistn]    Script Date: 07/02/2015 15:41:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[joblistn](
	[Jobid] [bigint] IDENTITY(1,1) NOT NULL,
	[memsid] [bigint] NOT NULL,
	[jobcategoryid] [smallint] NOT NULL,
	[sysentrydate] [datetime] NOT NULL,
	[designation] [varchar](250) NOT NULL,
	[jobdescription] [varchar](2000) NOT NULL,
	[minexp] [int] NOT NULL,
	[maxexp] [int] NOT NULL,
	[salary] [varchar](50) NOT NULL,
	[countryid] [smallint] NOT NULL,
	[stateid] [smallint] NOT NULL,
	[cityid] [smallint] NOT NULL,
	[contact] [varchar](150) NOT NULL,
	[telephone] [varchar](50) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[website] [varchar](4000) NOT NULL,
	[isApproved] [varchar](1) NOT NULL,
 CONSTRAINT [PK_joblistn] PRIMARY KEY CLUSTERED 
(
	[Jobid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[UserComplaints_Delete]    Script Date: 07/02/2015 15:41:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UserComplaints_Delete]
@ComplaintsID bigint
AS
Delete from User_Complaints_Comments Where ComplaintsID=@ComplaintsID
Delete from User_Complaints Where ComplaintID=@ComplaintsID
GO
/****** Object:  StoredProcedure [dbo].[UserComplaints_Comments_Delete]    Script Date: 07/02/2015 15:41:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UserComplaints_Comments_Delete]
@CommentID bigint
AS
Delete from User_Complaints_Comments Where CommentsID=@CommentID
GO
/****** Object:  StoredProcedure [dbo].[User_Complaints_VerifyUser]    Script Date: 07/02/2015 15:41:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[User_Complaints_VerifyUser]
@mobile varchar(20)='',
@EmailID varchar(250)='',
@ComplaintsID bigint=0
AS
if @mobile='' AND @EmailID=''
Select * from User_Complaints where ComplaintID=@ComplaintsID
else
BEGIN
Select * from User_Complaints where UserMobile=@mobile and EmailID=@EmailID 
Select * from User_Complaints where UserMobile=@mobile and EmailID=@EmailID AND ComplaintID=@ComplaintsID
END
GO
/****** Object:  StoredProcedure [dbo].[User_Complaints_Comments_Add]    Script Date: 07/02/2015 15:41:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[User_Complaints_Comments_Add]
@ComplaintsID bigint,
@Comments varchar(5000),
@CommentsBy bigint=0,
@CommentsByName varchar(250),
@IsAdmin varchar(1)='N',
@CommentsDate datetime,
@Resolved varchar(1)='N'
AS

INSERT INTO [User_Complaints_Comments]
           ([ComplaintsID]
           ,[Comments]
           ,[CommentsBy]
           ,[CommentsByName]
           ,[IsAdmin]
           ,[CommentsDate])
     VALUES
(
@ComplaintsID,
@Comments, 
@CommentsBy,
@CommentsByName,
@IsAdmin, 
@CommentsDate)

	Update User_Complaints set IsResolved=@Resolved Where ComplaintID=@ComplaintsID
GO
/****** Object:  StoredProcedure [dbo].[User_Complaints_Add]    Script Date: 07/02/2015 15:41:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[User_Complaints_Add]
@UserMobile varchar(20),
@EmailID varchar(250),
@UserName varchar(250),
@ComplaintHead varchar(500),
@ComplaintDesc varchar(5000)
AS
if Not Exists(Select * from User_Complaints Where UserMobile=@UserMobile AND EmailID=@EmailID AND ComplaintHead=@ComplaintHead)
BEGIN
INSERT INTO [User_Complaints]
           (
				[UserMobile]
				,[EmailID]
				,[UserName]
				,[ComplaintHead]
				,[ComplaintDesc]				
           )
     VALUES
           (
				@UserMobile,
				@EmailID,
				@UserName,
				@ComplaintHead,
				@ComplaintDesc
				
			) select @@IDENTITY
END
else
	Select 0 as 'AlreadyReg'
GO
/****** Object:  StoredProcedure [dbo].[ResumeMem]    Script Date: 07/02/2015 15:41:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create Proc [dbo].[ResumeMem]
@memsid bigint

as

update Mems set susp = 'N' where memsid = @memsid
GO
/****** Object:  Table [dbo].[tbl_Jokes]    Script Date: 07/02/2015 15:41:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[tbl_Jokes](
	[Jokesid] [bigint] NOT NULL,
	[memsid] [bigint] NOT NULL,
	[Jokesdate] [datetime] NOT NULL,
	[Jokessub] [varchar](100) NOT NULL,
	[JokesDesc] [varchar](8000) NOT NULL,
	[Jokespic] [varchar](100) NOT NULL,
	[ipaddress] [varchar](250) NOT NULL,
	[IsApproved] [varchar](1) NOT NULL,
	[categoryId] [int] NOT NULL,
	[TotalView] [int] NOT NULL,
 CONSTRAINT [PK_tbl_Jokes] PRIMARY KEY CLUSTERED 
(
	[Jokesid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[SuspendMem]    Script Date: 07/02/2015 15:41:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create Proc [dbo].[SuspendMem]
@memsid bigint

as

update Mems set susp = 'Y' where memsid = @memsid
GO
/****** Object:  StoredProcedure [dbo].[forumInsertTopic]    Script Date: 07/02/2015 15:41:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[forumInsertTopic]
@TopicTitle varchar(500),
@TopicDesc varchar(max),
@CatId bigint,
@SubCatId bigint,
@memsid bigint,
@UpdateCandiName varchar(250),
@UpdateCandiId bigint,
@StartDate dateTime,
@UpdateDate Datetime

AS
BEGIN
DECLARE @TopicId bigint , @approve varchar(1)= 'N', @countTp bigint

set @countTp = (select COUNT(*) from ForumTopic where memsid = @memsid  And IsApproved = 'Y');

if @countTp >= 10
begin
set @approve = 'Y' 
end


 INSERT INTO [forumTopic]([TopicTitle],[TopicDesc],[CatId],[SubCatId],[memsid] ,[UpdateCandiName],[UpdateCandiId],[StartDate],[UpdateDate],IsApproved)
            VALUES(@TopicTitle,@TopicDesc,@CatId,@SubCatId,@memsid,@UpdateCandiName,@UpdateCandiId,@StartDate,@UpdateDate,@approve) 
 select @@identity
Set @TopicId =  SCOPE_IDENTITY()            
update dbo.forumSubCategory set LastTopic=@TopicId,UpdatedBy=@memsid,UpdatedDate=@UpdateDate Where SubCatId=@SubCatId
 
Return @TopicId
END
GO
/****** Object:  StoredProcedure [dbo].[forumInsertSubCat]    Script Date: 07/02/2015 15:41:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[forumInsertSubCat]
@CatId bigint,
@SubCatTitle varchar(250),
@SubCatDesc varchar(500),
@StartDate datetime=GETDATE,
@StartedBy bigint,
@memsid bigint,
@RowEffect int output

as
BEGIN
Declare @c int
Select @c=COUNT(SubCatTitle) from ForumSubCategory  where SubCatTitle=@SubCatTitle;
set @RowEffect =0;
SET NOCOUNT ON;

	if @c=0
	BEGIN
		insert into ForumSubCategory(CatId,SubCatTitle,SubCatDesc,StartDate,StartedBy,memsid,[UpdatedDate],UpdatedBy,LastTopic) 
		values(@CatId, @SubCatTitle,@SubCatDesc,@StartDate,@StartedBy,@memsid,@StartDate,@StartedBy,0) 
		set @RowEffect= 1;
END
	ELSE
	set @RowEffect= -2;

	return @RowEffect;
END
GO
/****** Object:  StoredProcedure [dbo].[forumInsertAnswer]    Script Date: 07/02/2015 15:41:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[forumInsertAnswer]
@TopicId bigint ,
@TopicAns varchar(5000),
@memsid bigInt,
@AnsDate DateTime,
@UpdateyByName varchar(250)
AS
BEGIN
Declare @NewAnsId bigint, @approve varchar(1)= 'N', @countTp bigint

set @countTp = (select COUNT(*) from ForumTopicAnswer  where memsid = @memsid  And IsApproved = 'Y');

if @countTp >= 10
begin
set @approve = 'Y' 
end

INSERT INTO [forumTopicAnswer]([TopicId],[TopicAns],memsid,[AnsDate],IsApproved )
     VALUES
           (@TopicId,@TopicAns,@memsid,@AnsDate,@approve ) select @@IDENTITY;
Set @NewAnsId =SCOPE_IDENTITY()
Update dbo.forumTopic set LastAnsId=@NewAnsId, UpdateDate=@AnsDate,UpdateCandiId=@memsid,
UpdateCandiName=@UpdateyByName Where TopicId=@TopicId

Return @NewAnsId
END
GO
/****** Object:  StoredProcedure [dbo].[ForumgetUnApproveTopics]    Script Date: 07/02/2015 15:41:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[ForumgetUnApproveTopics]
@startRowIndex int,
@maximumRows int,
@criteria varchar(MAX)
as
select * from 
(
select TopicId,CatId,TopicTitle,TopicDesc,T.memsid ,
cn.fname ,
CONVERT(varchar(10),StartDate,103) as
starteddate,UpdateCandiId,convert(varchar(10),
UpdateDate,103) as
updatedate,
(Select COUNT(AnsId) From ForumTopicAnswer Where ForumTopicAnswer.TopicId=T.TopicId) as 'ReplayCount',
UpdateCandiName, gimg ,
CONVERT(varchar(10),UpdateDate,103)as updateddate,ROW_NUMBER() OVER(ORDER BY UpdateDate DESC) AS rowid
 from ForumTopic as T left join Mems  as cn on
T.memsid =cn.memsid   where T.IsApproved=@criteria

) as kk
where rowid >@startRowIndex AND rowid <= (@startRowIndex + @maximumRows)
GO
/****** Object:  StoredProcedure [dbo].[ForumgetUnApproveAnswer]    Script Date: 07/02/2015 15:41:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ForumgetUnApproveAnswer] --0,20,'Y'
@startRowIndex int,
@maximumRows int,
@criteria varchar(max)
AS
 select * from( Select AnsId,TopicAns,TA.memsid ,TA.TopicId, 
CONVERT(VARCHAR(20), AnsDate, 100) as AnsDate,
T.TopicTitle,
CN.fname ,ROW_NUMBER() over(order by AnsDate) as rowid,CN.gimg 
from ForumTopic T Left Outer Join ForumTopicAnswer TA ON T.TopicId = TA.TopicId LEFT JOIN Mems  CN
ON  TA.memsid =CN.memsid  Where TA.IsApproved=@criteria
) as DT 
where rowid >@startRowIndex AND rowid <= @startRowIndex + @maximumRows
GO
/****** Object:  StoredProcedure [dbo].[ForumgetTopics]    Script Date: 07/02/2015 15:41:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[ForumgetTopics]

@criteria varchar(50)

as

select TopicId,CatId,TopicTitle,TopicDesc,T.memsid ,
cn.fname ,
CONVERT(varchar(10),StartDate,103) as
starteddate,UpdateCandiId,convert(varchar(20),
UpdateDate,100) as
updatedate,
(Select COUNT(AnsId) From ForumTopicAnswer Where ForumTopicAnswer.TopicId=T.TopicId) as 'ReplayCount',
UpdateCandiName, 
(select photoname from Photos where t.memsid = photos.memsid )as Photo,
CONVERT(varchar(10),UpdateDate,103)as updateddate,ROW_NUMBER() OVER(ORDER BY UpdateDate DESC) AS rowid
 from ForumTopic as T left join Mems as cn on
T.memsid =cn.memsid   where SubCatId=@criteria
GO
/****** Object:  StoredProcedure [dbo].[ForumgetTopicDetails]    Script Date: 07/02/2015 15:41:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ForumgetTopicDetails]
@TopicId as bigint
AS
Select T.TopicId,T.TopicTitle ,T.TopicDesc,T.CatId,T.SubCatId,
T.memsid,CAN.fname  ,
T.UpdateCandiId,T.UpdateCandiName,
CONVERT(VARCHAR(20), T.StartDate, 100) AS StartDate,
CONVERT(VARCHAR(20),T.UpdateDate, 100) AS  UpdateDate,
T.LastAnsId ,
(Select COUNT(TopicTitle) from ForumTopic WHere ForumTopic.memsid =CAN.memsid ) as TotalThread,
(Select COUNT(AnsId) from ForumTopicAnswer WHere ForumTopicAnswer.TopicId=T.TopicId) as TotalReplay,isnull(CAN.gimg,'') as photo
from ForumTopic T LEFt JOIN mems CAN ON T.memsid  = CAN.memsid Where TopicId=@TopicId
GO
/****** Object:  StoredProcedure [dbo].[ForumgetTopicAnswer]    Script Date: 07/02/2015 15:41:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ForumgetTopicAnswer]
@startRowIndex int,
@maximumRows int,
@criteria bigint
AS
 select * from( Select AnsId,TopicAns,TA.memsid ,TopicId, 
CONVERT(VARCHAR(20), AnsDate, 100) as AnsDate,
CN.fname ,ROW_NUMBER() over(order by AnsDate) as rowid,CN.gimg 
from ForumTopicAnswer TA LEFT JOIN Mems  CN
ON TA.memsid =CN.memsid  Where TopicId=@criteria
) as DT 
where rowid >@startRowIndex AND rowid <= @startRowIndex + @maximumRows
GO
/****** Object:  StoredProcedure [dbo].[ForumgetSubCategory]    Script Date: 07/02/2015 15:41:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ForumgetSubCategory] 
	@mid int 
AS
Select SC.SubCatId,SC.SubCatTitle,SC.UpdatedBy,SC.LastTopic
,Sc.CatId ,Sc.SubCatDesc,
CONVERT(VARCHAR(20), sc.UpdatedDate, 100) AS  lastupdate ,
(Select SUBSTRING ( TopicTitle ,1 , 60 ) as TopicTitle from ForumTopic Where TopicId=Sc.LastTopic) as TopicTitle,
CAN.memsid ,
CAN.fname ,
CAN.lname ,
(Select photoname from Photos where memsid =Sc.UpdatedBy) as photo,
(Select passw from Photos where memsid =Sc.UpdatedBy) as photopassw,
'' + (Select fname  from Mems where memsid =Sc.UpdatedBy) as UpdatedByName,
'' + Convert(varchar(50),(Select count(TopicTitle) from ForumTopic where SC.SubCatId=ForumTopic.SubCatId)) as TopicsCount,
'' + Convert(varchar(50),(select COUNT(TA.AnsId) from ForumTopicAnswer TA inner join forumTopic on TA.TopicId= ForumTopic.TopicId where 
ForumTopic.SubCatId=SC.SubCatId)) as ReplyCount
from dbo.ForumSubCategory SC LEFT OUTER JOIN Mems  CAN
ON SC.CatId=CAN.memsid  
Where  Sc.CatId=@mid
GO
/****** Object:  StoredProcedure [dbo].[forumgetAllCategory]    Script Date: 07/02/2015 15:41:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[forumgetAllCategory]
@id int =0
AS
if @id = 0
	Select catid,Category,descrip from dbo.forumMainCategory
else
	Select catid,Category,descrip from dbo.forumMainCategory where catid=@id
GO
/****** Object:  StoredProcedure [dbo].[forumdeleteTopic]    Script Date: 07/02/2015 15:41:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[forumdeleteTopic]
@TopicId bigint
AS
BEGIN
Declare @SubCatId bigint, @NewTopic bigint 
Delete From forumTopicAnswer Where TopicId=@TopicId
Select @SubCatId= SubCatId from forumTopic Where TopicId=@TopicId
Delete From forumTopic Where TopicId=@TopicId
Select @NewTopic = COUNT(TopicId) from dbo.forumTopic Where SubCatId=@SubCatId
Print @NewTopic
if @NewTopic > 0
	BEGIN
		Select @NewTopic = MAX(TopicId) from dbo.forumTopic Where SubCatId=@SubCatId
		Print @NewTopic
		Update dbo.forumSubCategory set LastTopic=@NewTopic Where SubCatId=@SubCatId
	END
ELSE
	Update dbo.forumSubCategory set LastTopic=NUll Where SubCatId=@SubCatId

END
GO
/****** Object:  StoredProcedure [dbo].[ForumDeleteCategory]    Script Date: 07/02/2015 15:41:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ForumDeleteCategory]
@catid bigint
AS
BEGIN

Delete from ForumTopicAnswer Where TopicId in (Select TopicId from Topic where SubCatId in 
(Select SubCatId from ForumSubCategory where CatId=@catid))
Delete from ForumTopic where SubCatId in (
Select SubCatId from ForumSubCategory where CatId=@catid)
Delete from ForumSubCategory where CatId =@catid
Delete from  ForumMainCategory Where catid=@catid

END
GO
/****** Object:  StoredProcedure [dbo].[ForumdeleteAnswer]    Script Date: 07/02/2015 15:41:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ForumdeleteAnswer]
@AnsId bigint
AS
BEGIN
Declare @TopicId1 bigint, @NewAns bigint 

Select @TopicId1= TopicId from ForumTopicAnswer Where AnsId= @AnsId
Delete From ForumTopicAnswer Where AnsId=@AnsId
Select @NewAns = COUNT(AnsId) from dbo.ForumTopicAnswer Where TopicId=@TopicId1

if @NewAns > 0
	BEGIN
		Select @NewAns = MAX(Ansid) from dbo.ForumTopicAnswer Where TopicId=@TopicId1
		
		Update dbo.ForumTopic set LastAnsId=@NewAns Where TopicId=@TopicId1
	END
ELSE
	Update dbo.ForumTopic set LastAnsId=NUll Where TopicId=@TopicId1

END
GO
/****** Object:  StoredProcedure [dbo].[forumCheckSubCat]    Script Date: 07/02/2015 15:41:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[forumCheckSubCat]
@CAtId int,
@SubCAtTitle varchar(250)
as
Select COUNT(SubCatId) as 'COUNT' from dbo.forumSubCategory Where SubCatTitle = @SubCAtTitle and CatId=@CAtId
GO
/****** Object:  StoredProcedure [dbo].[ForumAproveTopicAns]    Script Date: 07/02/2015 15:41:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[ForumAproveTopicAns]
@AnsId bigint 

as

update ForumTopicAnswer  set IsApproved = 'Y' where AnsId  = @AnsId
GO
/****** Object:  StoredProcedure [dbo].[ForumAproveTopic]    Script Date: 07/02/2015 15:41:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[ForumAproveTopic]
@topicId bigint 

as

update ForumTopic set IsApproved = 'Y' where TopicId = @topicId
GO
/****** Object:  StoredProcedure [dbo].[ForumAddCategory]    Script Date: 07/02/2015 15:41:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ForumAddCategory]
	
	@forumcategoryn varchar(250),
	@descrip varchar(500),
	@Memsid bigint =0,
	@RowEffect int output,
	@StartDate dateTime=GETDATE
	
	
AS
BEGIN
Declare @c int
Select @c=COUNT(Category) from forumMainCategory  where Category=@forumcategoryn;
set @RowEffect =0;
SET NOCOUNT ON;

	if @c=0
	BEGIN
			insert into forumMainCategory(Category,descrip,memsid,StartDate) values(@forumcategoryn,@descrip,@Memsid,@StartDate)
			set @RowEffect= 1;
	END
	ELSE
	set @RowEffect= -2;

	return @RowEffect;
END
GO
/****** Object:  StoredProcedure [dbo].[forsponsorsall]    Script Date: 07/02/2015 15:41:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[forsponsorsall]
as
select  memsid ,email ,fname ,Passw from 
 Mems   where -- emailaddress like '%aminnagpure%'
  sponsoremail='Y'-- and emailaddress like '%aminnagpure%'
and Susp='N' and countryid=1 order by memsid desc

--alter table [Mems] add [sponsoremail] [varchar](1) NOT NULL DEFAULT ('Y')
GO
/****** Object:  StoredProcedure [dbo].[Editmem]    Script Date: 07/02/2015 15:41:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Editmem]
@memsid bigint,
@fname varchar(50),
@lname varchar(50),
@passw varchar(50),
@gender varchar(1),
@countryid smallint,
@stateid smallint,
@cityid smallint,
@aboutme varchar(450),
@isJobseeker varchar(1)='N',
@jobcategoryid smallint = 0,
@designation varchar(250)=''
as
update Mems set fname=@fname
,lname=@lname,passw=@passw
,gender=@gender,
countryid=@countryid,
stateid=@stateid,
cityid=@cityid,
aboutme = @aboutme,
isJobseeker =@isJobseeker,
jobcategoryid = @jobcategoryid,
designation=@designation
where memsid=@memsid
GO
/****** Object:  StoredProcedure [dbo].[ForumUnAproveTopicAns]    Script Date: 07/02/2015 15:41:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[ForumUnAproveTopicAns]
@AnsId bigint 

as

update ForumTopicAnswer  set IsApproved = 'N' where AnsId  = @AnsId
GO
/****** Object:  StoredProcedure [dbo].[ForumUnAproveTopic]    Script Date: 07/02/2015 15:41:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[ForumUnAproveTopic]
@TopicId bigint 

as

update ForumTopic  set IsApproved = 'N' where TopicId   = @TopicId
GO
/****** Object:  StoredProcedure [dbo].[jobUnApprove]    Script Date: 07/02/2015 15:41:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[jobUnApprove]
	-- Add the parameters for the stored procedure here
	@jobid bigint
AS
BEGIN
	update joblistn set isApproved = 'N' where Jobid = @jobid 
END
GO
/****** Object:  StoredProcedure [dbo].[jobApprove]    Script Date: 07/02/2015 15:41:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[jobApprove]
	-- Add the parameters for the stored procedure here
	@jobid bigint
AS
BEGIN
	update joblistn set isApproved = 'Y' where Jobid = @jobid 
END
GO
/****** Object:  Default [DF_citytable_stateid]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[citytable] ADD  CONSTRAINT [DF_citytable_stateid]  DEFAULT ((0)) FOR [stateid]
GO
/****** Object:  Default [DF_Country_countryname]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[Country] ADD  CONSTRAINT [DF_Country_countryname]  DEFAULT ('') FOR [countryname]
GO
/****** Object:  Default [DF_ForumMainCategory_memsid]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[ForumMainCategory] ADD  CONSTRAINT [DF_ForumMainCategory_memsid]  DEFAULT ((1)) FOR [memsid]
GO
/****** Object:  Default [DF_ForumSubCategory_IsApprover]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[ForumSubCategory] ADD  CONSTRAINT [DF_ForumSubCategory_IsApprover]  DEFAULT ('Y') FOR [IsApprover]
GO
/****** Object:  Default [DF_ForumSubCategory_TotalView]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[ForumSubCategory] ADD  CONSTRAINT [DF_ForumSubCategory_TotalView]  DEFAULT ((0)) FOR [TotalView]
GO
/****** Object:  Default [DF_SubCategory_memsid]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[ForumSubCategory] ADD  CONSTRAINT [DF_SubCategory_memsid]  DEFAULT ((1)) FOR [memsid]
GO
/****** Object:  Default [DF_ForumTopic_StartDate]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[ForumTopic] ADD  CONSTRAINT [DF_ForumTopic_StartDate]  DEFAULT (getdate()) FOR [StartDate]
GO
/****** Object:  Default [DF_ForumTopic_IsApproved]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[ForumTopic] ADD  CONSTRAINT [DF_ForumTopic_IsApproved]  DEFAULT ('N') FOR [IsApproved]
GO
/****** Object:  Default [DF_ForumTopic_TotalView]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[ForumTopic] ADD  CONSTRAINT [DF_ForumTopic_TotalView]  DEFAULT ((0)) FOR [TotalView]
GO
/****** Object:  Default [DF_ForumTopic_memsid]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[ForumTopic] ADD  CONSTRAINT [DF_ForumTopic_memsid]  DEFAULT ((1)) FOR [memsid]
GO
/****** Object:  Default [DF_ForumTopicAnswer_IsApproved]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[ForumTopicAnswer] ADD  CONSTRAINT [DF_ForumTopicAnswer_IsApproved]  DEFAULT ('N') FOR [IsApproved]
GO
/****** Object:  Default [DF_ForumTopicAnswer_memsid]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[ForumTopicAnswer] ADD  CONSTRAINT [DF_ForumTopicAnswer_memsid]  DEFAULT ((1)) FOR [memsid]
GO
/****** Object:  Default [DF_jobcategory_category]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[jobcategory] ADD  CONSTRAINT [DF_jobcategory_category]  DEFAULT ('') FOR [category]
GO
/****** Object:  Default [DF_joblistn_sysentrydate]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[joblistn] ADD  CONSTRAINT [DF_joblistn_sysentrydate]  DEFAULT (getdate()) FOR [sysentrydate]
GO
/****** Object:  Default [DF_joblistn_email]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[joblistn] ADD  CONSTRAINT [DF_joblistn_email]  DEFAULT ('') FOR [email]
GO
/****** Object:  Default [DF_joblistn_website]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[joblistn] ADD  CONSTRAINT [DF_joblistn_website]  DEFAULT ('') FOR [website]
GO
/****** Object:  Default [DF_joblistn_isApproved]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[joblistn] ADD  CONSTRAINT [DF_joblistn_isApproved]  DEFAULT ('N') FOR [isApproved]
GO
/****** Object:  Default [DF_Mems_fname]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[Mems] ADD  CONSTRAINT [DF_Mems_fname]  DEFAULT ('') FOR [fname]
GO
/****** Object:  Default [DF_Mems_lname]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[Mems] ADD  CONSTRAINT [DF_Mems_lname]  DEFAULT ('') FOR [lname]
GO
/****** Object:  Default [DF_Mems_gender]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[Mems] ADD  CONSTRAINT [DF_Mems_gender]  DEFAULT ('M') FOR [gender]
GO
/****** Object:  Default [DF_Mems_passw]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[Mems] ADD  CONSTRAINT [DF_Mems_passw]  DEFAULT ('1234') FOR [passw]
GO
/****** Object:  Default [DF_Mems_photoid]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[Mems] ADD  CONSTRAINT [DF_Mems_photoid]  DEFAULT ((1)) FOR [photoid]
GO
/****** Object:  Default [DF_Mems_countryid]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[Mems] ADD  CONSTRAINT [DF_Mems_countryid]  DEFAULT ((1)) FOR [countryid]
GO
/****** Object:  Default [DF_Mems_stateid]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[Mems] ADD  CONSTRAINT [DF_Mems_stateid]  DEFAULT ((1)) FOR [stateid]
GO
/****** Object:  Default [DF_Mems_cityid]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[Mems] ADD  CONSTRAINT [DF_Mems_cityid]  DEFAULT ((1)) FOR [cityid]
GO
/****** Object:  Default [DF_Mems_gurl]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[Mems] ADD  CONSTRAINT [DF_Mems_gurl]  DEFAULT ('') FOR [gurl]
GO
/****** Object:  Default [DF_Mems_gimg]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[Mems] ADD  CONSTRAINT [DF_Mems_gimg]  DEFAULT ('') FOR [gimg]
GO
/****** Object:  Default [DF_Mems_aboutme]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[Mems] ADD  CONSTRAINT [DF_Mems_aboutme]  DEFAULT ('') FOR [aboutme]
GO
/****** Object:  Default [DF_Mems_susp]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[Mems] ADD  CONSTRAINT [DF_Mems_susp]  DEFAULT ('N') FOR [susp]
GO
/****** Object:  Default [DF_Mems_regDate]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[Mems] ADD  CONSTRAINT [DF_Mems_regDate]  DEFAULT (getdate()) FOR [regDate]
GO
/****** Object:  Default [DF_Mems_isJobseeker]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[Mems] ADD  CONSTRAINT [DF_Mems_isJobseeker]  DEFAULT ('N') FOR [isJobseeker]
GO
/****** Object:  Default [DF_Mems_sponsoremail]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[Mems] ADD  CONSTRAINT [DF_Mems_sponsoremail]  DEFAULT ('Y') FOR [sponsoremail]
GO
/****** Object:  Default [DF_User_Complaints_UserMobile]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[User_Complaints] ADD  CONSTRAINT [DF_User_Complaints_UserMobile]  DEFAULT ('') FOR [UserMobile]
GO
/****** Object:  Default [DF_User_Complaints_EmailID]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[User_Complaints] ADD  CONSTRAINT [DF_User_Complaints_EmailID]  DEFAULT ('') FOR [EmailID]
GO
/****** Object:  Default [DF_User_Complaints_UserName]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[User_Complaints] ADD  CONSTRAINT [DF_User_Complaints_UserName]  DEFAULT ('') FOR [UserName]
GO
/****** Object:  Default [DF_User_Complaints_ComplaintHead]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[User_Complaints] ADD  CONSTRAINT [DF_User_Complaints_ComplaintHead]  DEFAULT ('') FOR [ComplaintHead]
GO
/****** Object:  Default [DF_User_Complaints_ComplaintDesc]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[User_Complaints] ADD  CONSTRAINT [DF_User_Complaints_ComplaintDesc]  DEFAULT ('') FOR [ComplaintDesc]
GO
/****** Object:  Default [DF_User_Complaints_ComplaintDate]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[User_Complaints] ADD  CONSTRAINT [DF_User_Complaints_ComplaintDate]  DEFAULT (getdate()) FOR [ComplaintDate]
GO
/****** Object:  Default [DF_User_Complaints_IsResolved]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[User_Complaints] ADD  CONSTRAINT [DF_User_Complaints_IsResolved]  DEFAULT ('N') FOR [IsResolved]
GO
/****** Object:  Default [DF_User_Complaints_ResolvedBy]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[User_Complaints] ADD  CONSTRAINT [DF_User_Complaints_ResolvedBy]  DEFAULT ((0)) FOR [ResolvedBy]
GO
/****** Object:  Default [DF_User_Complaints_ResolvedByName]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[User_Complaints] ADD  CONSTRAINT [DF_User_Complaints_ResolvedByName]  DEFAULT ('') FOR [ResolvedByName]
GO
/****** Object:  Default [DF_User_Complaints_Comments_ComplaintsID]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[User_Complaints_Comments] ADD  CONSTRAINT [DF_User_Complaints_Comments_ComplaintsID]  DEFAULT ((0)) FOR [ComplaintsID]
GO
/****** Object:  Default [DF_User_Complaints_Comments_Comments]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[User_Complaints_Comments] ADD  CONSTRAINT [DF_User_Complaints_Comments_Comments]  DEFAULT ('') FOR [Comments]
GO
/****** Object:  Default [DF_User_Complaints_Comments_CommentsBy]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[User_Complaints_Comments] ADD  CONSTRAINT [DF_User_Complaints_Comments_CommentsBy]  DEFAULT ((0)) FOR [CommentsBy]
GO
/****** Object:  Default [DF_User_Complaints_Comments_CommentsByName]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[User_Complaints_Comments] ADD  CONSTRAINT [DF_User_Complaints_Comments_CommentsByName]  DEFAULT ('') FOR [CommentsByName]
GO
/****** Object:  Default [DF_User_Complaints_Comments_IsAdmin]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[User_Complaints_Comments] ADD  CONSTRAINT [DF_User_Complaints_Comments_IsAdmin]  DEFAULT ('Y') FOR [IsAdmin]
GO
/****** Object:  Default [DF_User_Complaints_Comments_CommentsDate]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[User_Complaints_Comments] ADD  CONSTRAINT [DF_User_Complaints_Comments_CommentsDate]  DEFAULT (getdate()) FOR [CommentsDate]
GO
/****** Object:  ForeignKey [FK_joblistn_citytable]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[joblistn]  WITH CHECK ADD  CONSTRAINT [FK_joblistn_citytable] FOREIGN KEY([cityid])
REFERENCES [dbo].[citytable] ([cityid])
GO
ALTER TABLE [dbo].[joblistn] CHECK CONSTRAINT [FK_joblistn_citytable]
GO
/****** Object:  ForeignKey [FK_joblistn_Country]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[joblistn]  WITH CHECK ADD  CONSTRAINT [FK_joblistn_Country] FOREIGN KEY([countryid])
REFERENCES [dbo].[Country] ([COUNTRYID])
GO
ALTER TABLE [dbo].[joblistn] CHECK CONSTRAINT [FK_joblistn_Country]
GO
/****** Object:  ForeignKey [FK_joblistn_jobcategory]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[joblistn]  WITH CHECK ADD  CONSTRAINT [FK_joblistn_jobcategory] FOREIGN KEY([jobcategoryid])
REFERENCES [dbo].[jobcategory] ([jobcategoryid])
GO
ALTER TABLE [dbo].[joblistn] CHECK CONSTRAINT [FK_joblistn_jobcategory]
GO
/****** Object:  ForeignKey [FK_joblistn_states]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[joblistn]  WITH CHECK ADD  CONSTRAINT [FK_joblistn_states] FOREIGN KEY([stateid])
REFERENCES [dbo].[states] ([stateid])
GO
ALTER TABLE [dbo].[joblistn] CHECK CONSTRAINT [FK_joblistn_states]
GO
/****** Object:  ForeignKey [FK_tbl_Jokes_Jokescatmaster]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[tbl_Jokes]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Jokes_Jokescatmaster] FOREIGN KEY([categoryId])
REFERENCES [dbo].[Jokescatmaster] ([catid])
GO
ALTER TABLE [dbo].[tbl_Jokes] CHECK CONSTRAINT [FK_tbl_Jokes_Jokescatmaster]
GO
/****** Object:  ForeignKey [FK_tbl_Jokes_Jokescatmaster1]    Script Date: 07/02/2015 15:41:51 ******/
ALTER TABLE [dbo].[tbl_Jokes]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Jokes_Jokescatmaster1] FOREIGN KEY([categoryId])
REFERENCES [dbo].[Jokescatmaster] ([catid])
GO
ALTER TABLE [dbo].[tbl_Jokes] CHECK CONSTRAINT [FK_tbl_Jokes_Jokescatmaster1]
GO
