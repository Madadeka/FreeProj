-- ������
create table product (
	id serial not null primary key,
	name varchar(200) not null,
	price int
);

-- ��������
create table store (
	id serial not null primary key,
	name varchar(200) not null,
	address varchar(200) not null
);

-- ��������� �������
create table table_linc (
	id serial not null primary key,
	id_store int,
	id_product int
);

-- product data
insert into product (name, price) 
	values('����� �����', 5);
insert into product (name, price) 
	values('����� ������', 5);
insert into product (name, price) 
	values('������� � ������', 15);
insert into product (name, price) 
	values('������� � �������', 10);
insert into product (name, price) 
	values('����', 1500);
insert into product (name, price) 
	values('����', 999);

-- store data
insert into store (name, address) 
	values('����������', '�. ���������, ��. ��������������, �. 2');
insert into store (name, address) 
	values('������', '�. ����������, ��. �������������, �. 20');

-- table_linc data
insert into table_linc (id_store, id_product) 
	values(1, 1);
insert into table_linc (id_store, id_product) 
	values(1, 2);
insert into table_linc (id_store, id_product) 
	values(1, 3);
insert into table_linc (id_store, id_product) 
	values(1, 4);
insert into table_linc (id_store, id_product) 
	values(2, 5);
insert into table_linc (id_store, id_product) 
	values(2, 6);


