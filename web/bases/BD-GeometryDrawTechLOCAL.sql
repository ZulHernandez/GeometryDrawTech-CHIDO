drop database if exists GDLocal;
create database GDLocal;
use GDLocal;





create table problemas(
idProblema int(1) primary key not null,
nombreProblema nvarchar(50) not null,
numConsultas int(4) default 0 ,
descripcion nvarchar(300));


drop procedure if exists sp_TraerTotalRegistros;
delimiter **
create procedure sp_TraerTotalRegistros()
begin
	declare  total int;
    set total=(select count(idProblema) from problemas);
    
select total as Total;
end;**
delimiter ;

drop procedure if exists sp_AgregaConsulta;
delimiter **
create procedure sp_AgregaConsulta(in ide int(1))
begin
	declare msj nvarchar(30);
    declare existe int(1);
    set existe=(select count(*) from problemas where idProblema=ide);
    if existe= 1 then
		update problemas set numConsultas=numConsultas+1 where idProblema=ide;
		set msj='Aumentado';
    else
		set msj='Error';
    end if;
select msj as Regreso;
end; **
delimiter ;

drop procedure if exists sp_TraeConsultas;
delimiter **
create procedure sp_TraeConsultas(in ide int(1))
begin 
	declare msj nvarchar(20);
    declare existe int(1);
    declare consulta int(4);
    declare nomPr nvarchar(50);
    declare descrip nvarchar(300);
    
    set existe=(select count(*) from problemas where idProblema=ide);
    if existe=1 then
		set msj='Mandado';
        set consulta=(select numConsultas from problemas where idProblema= ide);
        set nomPr=(select nombreProblema from problemas where idProblema=ide);
        set descrip=(select descripcion from problemas where idProblema=ide);
    else
		set msj='Error';
    end if;
select msj as Estado , consulta as Visitas , nomPr as Nombre, descrip as Descripcion;
end ; **
delimiter ;

drop procedure if exists sp_Todo;
delimiter **
create procedure sp_Todo()
begin
	select * from problemas;
end; **
delimiter ;

insert into problemas (idProblema , nombreProblema,descripcion) values
(1,'Polígonos de N lados','Mediante una circunferencia trazar un  polígono de N lados inscrito en ella'),
(2,'Enlaces','Enlazar un segmento de curva con un segmento  de recta dado mediante un arco y un radio'),
(3,'Elipses','Trazar una elipse por el método de los cuatro puntos'),
(4,'Parábolas','Dadas dos rectas concurrentes trazar una parábola'),
(5,'División de una recta en N partes','Dados dos puntos A y B que forman una recta  dividir esta en N segmentos iguales'),
(6,'Cortes','Corte Longitudinal de un isométrico');


update problemas set numConsultas=20 where idProblema=1;
update problemas set numConsultas=30 where idProblema=2;
update problemas set numConsultas=40 where idProblema=3;
update problemas set numConsultas=50 where idProblema=4;
update problemas set numConsultas=60 where idProblema=5;
update problemas set numConsultas=70 where idProblema=6;

select * from problemas;

