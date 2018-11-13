use Module_2
use Training_19Sep18_Pune
go
create schema Shop_161743
go

create table Shop_161743.UserDetails
(
UserID int identity(1,1) primary key,
Username varchar(50) not null,
Password varchar(50) not null,
Name varchar(50) not null,
Email varchar(50) not null,
Country varchar(50) ,
State varchar(50) ,
City varchar(50) ,
Address varchar(50) ,
Security varchar(50) not null,
Answer varchar(50) not null
)
go

create table Shop_161743.CartDetails
(
UserID int not null references Shop_161743.UserDetails(UserID),
ProductID varchar(50) not null,
)
go

create proc Shop_161743.usp_AddUser
(
@name varchar(50),
@uname varchar(50),
@pass varchar(50),
@email varchar(50),
@security varchar(50),
@answer varchar(50)
)
as
begin
	insert into Shop_161743.UserDetails
	(Username,Password,Name,Email,Security,Answer)
	values(@uname,@pass,@name,@email,@security,@answer)
end
go

create proc Shop_161743.usp_Login
(
@uname varchar(50),
@pass varchar(50) output,
@cart varchar(50) output,
@name varchar(50) output,
@uid varchar(50) output
)
as
begin
	select @pass = Password, @name = Name, @uid = UserID from Shop_161743.UserDetails where Username = @uname
	select @cart = COUNT(UserID) from Shop_161743.CartDetails where UserID = (select UserID from Shop_161743.UserDetails where Username=@uname)
end
go

create proc Shop_161743.usp_GetQ
(
@uname varchar(50),
@security varchar(50) output
)
as
begin
	select @security = Security from Shop_161743.UserDetails where Username = @uname
end
go

create proc Shop_161743.usp_Forgot
(
@uname varchar(50),
@answer varchar(50)
)
as
begin
	select @answer = Answer from Shop_161743.UserDetails where Username = @uname
end
go

create proc Shop_161743.usp_Reset
(
@uname varchar(50),
@pass varchar(50)
)
as
begin
	update Shop_161743.UserDetails set Password = @pass where Username = @uname
end
go

create proc Shop_161743.usp_cartentry
(
@uid varchar(50),
@pid varchar(50)
)
as
begin
	insert into Shop_161743.CartDetails values(@uid,@pid)
end
go

drop procedure Shop_161743.usp_AddUser
GO
drop procedure Shop_161743.usp_Login  
GO 
drop procedure Shop_161743.usp_GetQ 
GO 
drop procedure Shop_161743.usp_Forgot 
GO 
drop procedure Shop_161743.usp_Reset 
GO 

select * from Shop_161743.UserDetails
select * from Shop_161743.CartDetails