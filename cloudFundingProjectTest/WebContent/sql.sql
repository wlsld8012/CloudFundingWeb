create table member (
	no int auto_increment primary key,
	id varchar(30) not null,
	password varchar(15) not null,
	name varchar(15) not null,
	email varchar(25) not null,
	privilege varchar(15) not null
) engine innodb default charset=euckr;

drop table member;

create table funding (
	no int auto_increment primary key,
	title varchar(15) not null,
	writer varchar(15) not null,
	content varchar(200) not null,
	goalMoney int not null,
	currentMoney int not null,
	image varchar(20) not null
) engine innodb default charset=euckr;

drop table funding;

create table comment (
	no int auto_increment primary key,
	writer varchar(20) not null,
	likes int not null,
	dislikes int not null,
	floor int not null,
	date varchar(20) not null,
	content varchar(500) not null,
	origin int not null	
) engine innodb default charset=euckr;

drop table comment;