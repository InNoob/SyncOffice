

--create table [Managerfile]
--(
--	[MFID] int primary key identity(1,1),
--	[MID] int references [Managers]([MID]),
--	[FileHash] varchar(128) not null references [Files]([FileHash]),
--	[FileName] nvarchar(256) not null,
--	[FileUserPath] nvarchar(512) not null,
--	[FileRights] int not null,
--	[FileTag] nvarchar(256) null,
--	[CreateTime] varchar(128) not null default(CONVERT(varchar(16), getdate(), 20))
--)
--go


--create table [Managers]
--(
--	[MID] int primary key identity(10000,1),
--	[Username] varchar(20) unique not null,
--	[Password] varchar(20) not null,
--	[Name] nvarchar(10) not null,
--	[BirthDay] datetime not null,
--	[Gender] nvarchar(4) not null check([Gender] in (N'男',N'女')),
--	[Email] varchar(128) not null,
--	[PhoneNO] varchar(20) not null,
--	[QQNo] varchar(64) null,
--	[WhatsUp] nvarchar(512) null,
--	[JoinDate] datetime not null default(CONVERT(varchar(16), getdate(), 20)),
--	[UsedSize] bigint not null,
--	[UserAction] nvarchar(512) null
--)
--go

--create table [ManagerGroup]
--(
--	[MID] int not null references [Managers]([MID]),
--	[GID] int not null references [Groups]([GID]),
--	[ManagerTag]  nvarchar(128) not null
--)
--go



--go
--drop proc proc_getManagerGroup
--go
--create proc proc_getManagerGroup(@MID int)
--as
--	select [Name],[GroupName],[ManagerTag] from [Groups] as G 
--	inner join [ManagerGroup] as MG on G.[GID] = MG.[GID]
--	inner join [Managers] as M on MG.[MID] = M.[MID]
--	where MG.[MID] = @MID
--go

--go
--drop proc proc_getManagerUser
--go
--create proc proc_getManagerUser(@MID int)
--as
--	select M.[Name],U.[Name],MG.[ManagerTag] from [Managers] as M
--	inner join [ManagerGroup] as MG on MG.[MID] = M.[MID]
--	inner join [Users] as U on U.[GroupNo] = MG.[GID]
--	where MG.[MID] = @MID
--go

--go
--drop proc proc_getGroupManager
--go
--create proc proc_getGroupManager(@GID int)
--as
--	select [Name],[GroupName],[ManagerTag] from [Groups] as G 
--	inner join [ManagerGroup] as MG on G.[GID] = MG.[GID]
--	inner join [Managers] as M on MG.[MID] = M.[MID]
--	where MG.[GID] = @GID and MG.[ManagerTag] = N'班主任' 
--go


use [master]
go
if exists(select 1 from sys.databases where name='CodeCloud')
drop database CodeCloud
go

create database CodeCloud
on primary(
	name='CodeCloud',
	filename='D:\DB\CodeCloud.mdf'
)log on(
	name='CodeCloud_log',
	filename='D:\DB\CodeCloud_log.ldf'
)
go

use CodeCloud
go


create table [Users]
(
	[UID] int primary key identity(123456,1),
	[Username] varchar(20) unique not null,
	[Password] varchar(20) not null,
	[NickName] nvarchar(128) not null,
	[Name] nvarchar(10) not null,
	[BirthDay] datetime not null,
	[Gender] nvarchar(4) not null check([Gender] in (N'男',N'女')),
	[IDCard] varchar(18) unique not null,
	[Email] varchar(128) not null,
	[PhoneNO] varchar(20) not null,
	[ParentPhoneNO] varchar(20) null,
	[QQNo] varchar(64) null,
	[WhatsUp] nvarchar(512) null,
	[JoinDate] datetime not null default(CONVERT(varchar(16), getdate(), 20)),
	[SpaceSize] bigint not null,
	[UsedSize] bigint not null,
	[UserAction] nvarchar(512) null
)
go

create table [Groups]
(
	[GID] int not null primary key identity(1,1),
	[GroupName] nvarchar(128) not null,
	[GroupCreateTime] datetime not null default(CONVERT(varchar(16), getdate(), 20)),
	[GroupParent] int not null,
	[GroupWork] nvarchar(512) null,
	[GroupTag] nvarchar(512) null
)
go


create table [UserGroup]
(
	[UGID] int primary key IDENTITY(1,1),
	[UID] int not null references [Users]([UID]),
	[GID] int NOT NULL REFERENCES [Groups]([GID]),
	[UserRights] int not null,
	[UserGroupRights] int not null,
	[UserTag] nvarchar(512) null
)
go

create table [Files]
(
	[FileHash] varchar(128) not null primary key,
	[FileSize] bigint not null,
	[FilePath] nvarchar(512) not null,
	[FileType] varchar(128) not null
)
go


create table [Userfile]
(
	[UFID] int primary key identity(1,1),
	[UID] int references [Users]([UID]),
	[FileHash] varchar(128) not null references [Files]([FileHash]),
	[FileName] nvarchar(256) not null,
	[CreateTime] varchar(128) not null default(CONVERT(varchar(16), getdate(), 20)),
	[FileUserPath] nvarchar(512) not null,
	[FileRights] int not null,
	[FileTag] nvarchar(256) null
)
go


go
drop proc proc_addUser
go
create proc proc_addUser(@Username varchar(20),@Password varchar(20),@NickName nvarchar(128),@Name nvarchar(10),@BirthDay datetime,@Gender nvarchar(4),@IDCard varchar(18),@Email varchar(128),@PhoneNO varchar(20),@ParentPhoneNO varchar(20),@QQNo varchar(64),@WhatsUp nvarchar(512),@SpaceSize bigint,@UsedSize bigint,@UserAction nvarchar(512))
as
	insert into [Users] values(@Username,@Password,@NickName,@Name,@BirthDay,@Gender,@IDCard,@Email,@PhoneNO,@ParentPhoneNO,@QQNo,@WhatsUp,default,@SpaceSize,@UsedSize,@UserAction)
go

go
drop proc proc_addGroup
go
create proc proc_addGroup(@GroupName nvarchar(128), @GroupParent int,@GroupWork nvarchar(512),@GroupTag nvarchar(512))
as
	insert into [Groups] values(@GroupName,default,@GroupParent,@GroupWork,@GroupTag)
go

go
drop proc proc_addUserGroup
go
create proc proc_addUserGroup(@UID int,@GID int,@UserRights int,@UserGroupRights int,@UserTag nvarchar(512))
as
	insert into [UserGroup] values(@UID,@GID,@UserRights,@UserGroupRights,@UserTag)
go

go
drop proc proc_addFile
go
create proc proc_addFile(@FileHash varchar(128),@FileSize bigint,@FilePath nvarchar(512),@FileType varchar(128))
as
	insert into [Files] values(@FileHash,@FileSize,@FilePath,@FileType)
go

go
drop proc proc_addUserFile
go
create proc proc_addUserFile(@UID int,@FileHash varchar(128),@FileName nvarchar(256),@FileUserPath nvarchar(512),@FileRights int,@FileTag nvarchar(256))
as
	begin tran
	begin try  
		declare @filesize bigint
		select @filesize = [FileSize] from [Files] where [FileHash] = @FileHash
		declare @fname nvarchar(256) =@FileName,@count int=1,@tag int =0
		while (select count(1) from [UserFile] where [FileName]= @fname and [UID] = @UID and [FileUserPath]=@FileUserPath)=1
		begin
			set @count+=1
			set @fname = @FileName + N'('+cast(@count as nvarchar)+N')'
		end
--------Change UsedSize by @uid----------------
		insert into [UserFile] values(@UID,@FileHash,@fname,default,@FileUserPath,@FileRights,@FileTag)
		update [Users] set [UsedSize]+=@filesize where [UID] = @UID
	end try
	begin catch
	   select Error_number() as ErrorNumber, 
			  Error_severity() as ErrorSeverity,  
			  Error_state() as ErrorState , 
			  Error_Procedure() as ErrorProcedure , 
			  Error_line() as ErrorLine,
			  Error_message() as ErrorMessage
	   if(@@trancount>0)
		  rollback tran
	end catch
	if(@@trancount>0)
	commit tran
go

------Use transaction to delete table Userfile's recard by UFID------
go
drop proc proc_delUserFileByUFID
go
create proc proc_delUserFileByUFID(@UFID int)
as
	begin tran
	begin try 
		declare @filesize bigint,@uid int
		select @filesize =F.[FileSize],@uid =UF.[UID] 
		from [Userfile] as UF inner join [Files] as F 
		on UF.[FileHash] = F.[FileHash]
		where UF.[UFID] = @UFID

		delete from [UserFile] where [UFID] = @UFID
		update [Users] set [UsedSize] -= @filesize  where [UID] = @uid
	end try
	begin catch
	   select Error_number() as ErrorNumber, 
			  Error_severity() as ErrorSeverity,  
			  Error_state() as ErrorState , 
			  Error_Procedure() as ErrorProcedure , 
			  Error_line() as ErrorLine,
			  Error_message() as ErrorMessage
	   if(@@trancount>0)
		  rollback tran
	end catch
	if(@@trancount>0)
	commit tran
go

go
drop proc proc_getGroupUser
go
create proc proc_getGroupUser(@GID int)
as
	select * from [UserGroup] where [GID] = @GID
go

go
drop proc proc_getUserFile
go
create proc proc_getUserFile(@Username varchar(20))
as
	select UF.[UFID],UF.[Filename],F.[FileSize],UF.[CreateTime] from [Userfile] as UF
	inner join [Users] as U on UF.[UID] = U.[UID]
	inner join [Files] as F on F.[FileHash] = UF.[FileHash]
	where U.[Username] = @Username
go

exec proc_addFile 'jhgJH234GT3K45H234G5J345H34JHG','65435430','admin/files','.iso'
exec proc_addFile 'JHGJH234JHGJHFJ234G5J345H34JHG','35405','admin/files','.mp3'
exec proc_addFile 'JHYTDGFVBGGK45H234G5J345H34JHG','412','admin/files','.java'
exec proc_addFile 'JHGJH234GT3K45H234ACCES5H34JHG','316','admin/files','.c'
exec proc_addFile 'JHGJH2OIFGFHJ5H234G5J345H34JHG','617','admin/files','.html'

exec proc_addUser 'peijianxiang','123456','Code_Dog',N'裴鉴湘','1999-10-15',N'男','430321199910151055','287276013@qq.com','15200363980',null,'287276013',N'明天又是美好的一天','2048000','0',null
exec proc_addUser 'lilongwei','123456','lilongwei',N'李隆威','1999-10-15',N'男','430321200001161055','287276013@qq.com','15200363980',null,'287276013',N'明天又是美好的一天','2048000','0',null
exec proc_addUser 'yiyongjie','123456','yiyongjie',N'易永杰','1999-10-15',N'男','430321200010151055','287276013@qq.com','15200363980',null,'287276013',N'明天又是美好的一天','2048000','0',null
exec proc_addUser 'zengchangyu','123456','zengchangyu',N'曾长玉','1987-06-06',N'女',430321200010150000,'111111111@qq.com','1111111111111',null,'111111111',null,2048000,'0',null
exec proc_addUser 'liuwei','123456','liuwei',N'刘威','1985-06-06',N'男',430321200010156544,'111111111@qq.com','1111111111111',null,'111111111',null,2048000,'0',null
exec proc_addUser 'hejin','123456','hejin',N'贺靖','1985-06-06',N'男',430321200010152639,'111111111@qq.com','1111111111111',null,'111111111',null,2048000,'0',null
exec proc_addUser 'liaoyu','123456','liaoyu',N'廖玉','1985-06-06',N'女',430321200010150961,'111111111@qq.com','1111111111111',null,'111111111',null,2048000,'0',null

exec proc_addUserFile 123456,'JHYTDGFVBGGK45H234G5J345H34JHG',N'java项目源码',default,N'jasonbourne/java作业/',0,N'星期四交'
exec proc_addUserFile 123456,'JHGJH2OIFGFHJ5H234G5J345H34JHG',N'html项目'    ,default,N'jasonbourne/java作业/',0,N'星期四交'
exec proc_addUserFile 123456,'JHGJH234JHGJHFJ234G5J345H34JHG',N'蓝莲花'      ,default,N'jasonbourne/files',0,N'我的收藏' 
exec proc_addUserFile 123457,'JHGJH2OIFGFHJ5H234G5J345H34JHG',N'html项目'    ,default,N'jasonbourne/java作业/',0,N'星期四交'
exec proc_addUserFile 123458,'JHGJH2OIFGFHJ5H234G5J345H34JHG',N'html项目'    ,default,N'jasonbourne/java作业/',0,N'星期四交'
exec proc_addUserFile 123461,'JHGJH2OIFGFHJ5H234G5J345H34JHG',N'html项目'    ,default,N'jasonbourne/java作业/',0,N'星期四交'


select * from [UserFile]

exec proc_getManagerGroup 10000

exec proc_getGroupManager 1

exec proc_getGroupUser 1

exec proc_getManagerUser 10001

exec proc_getUserFile 'peijianxiang'


--update [Users] set [SpaceSize] = 2147483648 where [UID]=123456
--update [Users] set [UsedSize] = 0 where [UID]=123456
select * from [Managers]
select * from [Groups]
select * from [ManagerGroup]
select * from [Users]
select * from [Files]
select * from [UserFile]
select * from [Managerfile]


exec proc_delUserFileByUFID 1




insert into [Groups] values ('15C1NA','.net',N'初中班')
insert into [Groups] values ('15C2NA','.net',N'初中班')
insert into [Groups] values ('1621JA','java',N'高中班')
insert into [Groups] values ('1610JA','java',N'高中班')


insert into [ManagerGroup] values('10000','1',N'班主任')
insert into [ManagerGroup] values('10000','2',N'班主任')
insert into [ManagerGroup] values('10000','3',N'班主任')
insert into [ManagerGroup] values('10001','1',N'.net讲师')
insert into [ManagerGroup] values('10001','4',N'.net讲师')
insert into [ManagerGroup] values('10002','1',N'html讲师')
insert into [ManagerGroup] values('10002','3',N'java讲师')
insert into [ManagerGroup] values('10003','1',N'js讲师')
insert into [ManagerGroup] values('10003','4',N'java讲师')




insert into [Managerfile] values('10002','JHYTDGFVBGGK45H234G5J345H34JHG',N'java项目源码',N'hejin/java项目/',0,N'星期四交',default)

