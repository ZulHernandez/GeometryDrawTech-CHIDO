drop database if exists Marsoft;
create database Marsoft;
use Marsoft;



create table usuario(
	idUsuario int (3) not null primary key,
	nombre nvarchar(50) not null,
	clave nvarchar(50) not null,
	tipo int(1) not null,
    foto nvarchar(50) not null,
    colorFondo nvarchar(10) not null
);

create table blog(
	idParte int (3) not null primary key,
    idUsuario int (3) not null,
	contEscrito nvarchar(500) not null,
    autor nvarchar(60)not null,
	fecha datetime,
	tipo int(2) not null,
	padre int(3) not null,
	estado int(2) not null,
	foreign key(idUsuario) references usuario(idUsuario)
);

create table relPartCont(
	idRel int(3) not null primary key,
	archivo nvarchar(500) not null,
	idParte int (3) not null,
	TipoCont int(3) not null,
	foreign key(idParte) references blog(idParte) on delete cascade on update cascade
);

insert into usuario(idUsuario, nombre,clave,tipo,foto,colorFondo)
values(1,'Felisa','93b35de54bc25d1292b25f89aba9269f', 0,'img/avatar1.jpg','#004466'),
(2,'Alumno','1df3e671833a0bb863a6e0fa94b62e61', 1,'img/avatares.jpg','#004466');

#--------------------------------------------Vistas de cada tabla
create view vw_usuario as
select * from usuario;

drop view if exists vw_blog;
create view vw_blog as
select blog.*,usuario.foto from blog inner join usuario on blog.idUsuario = usuario.idUsuario;

drop view if exists vw_relPartCont;
create view vw_relPartCont as
select relPartCont.*,blog.padre from relPartCont inner join blog on blog.idParte = relPartCont.idParte;

create view vw_contBlog as
select blog.idParte, blog.contEscrito, blog.fecha, blog.autor, usuario.nombre, usuario.foto, blog.tipo, blog.padre, blog.estado from blog inner join usuario where blog.idUsuario=usuario.idUsuario;

# -------------------------------------------PROCEDIMIENTOS 


#Procedimiento para obtener datos del usuario
drop procedure if exists sp_obtenUsuario;
delimiter //
create procedure sp_obtenUsuario(in nom nvarchar(50), in tip int)
begin
declare existe int;
declare msj nvarchar(20);
set existe = (select count(*) from vw_usuario where nombre = nom and tipo = tip);
if existe = 1 then
	select * from vw_usuario where nombre = nom and tipo = tip;
else
	set msj = "error";
    select msj as error;
end if;
end //
delimiter ;

#procedimiento para registrar una parte en la base de datos
drop procedure if exists sp_registraParte;
delimiter gatito
create procedure sp_registraParte(in conten nvarchar(500), in nautor nvarchar(50), in rutaimagen nvarchar(250), in rutaaudio nvarchar(250), in tip int(2), in pad int(3), in stat int(3))
begin
declare existe int;
declare msj nvarchar(500);
declare nidparte int(3);
declare nidusuario int(3);
declare nidrel int(3);
declare url nvarchar (50);
set nidparte = (select ifnull(max(idParte),0)+1 from vw_blog);
set existe = (select count(*) from vw_usuario where nombre = nautor);
if tip = 1 then
	if existe = 1 then
		set nidusuario = (select idUsuario from vw_usuario where nombre = nautor);
		insert into blog (idParte, contEscrito, autor, fecha, idUsuario, tipo, padre, estado) values
		(nidparte, conten, nautor, current_timestamp, nidusuario, tip, pad, stat);
		if rutaimagen != '' or rutaimagen != null then
			set nidrel = (select ifnull(max(idRel),0)+1 from vw_relPartCont);
			insert into relPartCont (idRel, archivo, idParte, TipoCont) values
			(nidrel,rutaimagen,nidparte,1);
		end if;
		if rutaaudio != '' or rutaaudio != null then
			set nidrel = (select ifnull(max(idRel),0)+1 from vw_relPartCont);
			insert into relPartCont (idRel, archivo, idParte, TipoCont) values
			(nidrel,rutaaudio,nidparte,2);
		end if;
		set msj = "POST PUBLICADO";
	else
		set msj = "error: usuario no autorizado para postear";
	end if;
else
	set existe=(select count(*) from vw_usuario where nombre=nautor);
    if existe=1 then
	set nidusuario = (select idUsuario from vw_usuario where nombre =nautor);
    else
    set nidusuario = (select idUsuario from vw_usuario where nombre ='Alumno');
    end if;
    insert into blog (idParte, contEscrito, autor, fecha, idUsuario, tipo, padre, estado) values
    (nidparte, conten, nautor, current_timestamp, nidusuario, tip, pad, stat);
    if rutaimagen != '' or rutaimagen != null then
		set nidrel = (select ifnull(max(idRel),0)+1 from vw_relPartCont);
		insert into relPartCont (idRel, archivo, idParte, TipoCont) values
		(nidrel,rutaimagen,nidparte,1);
	end if;
		if rutaaudio != '' or rutaaudio != null then
		set nidrel = (select ifnull(max(idRel),0)+1 from vw_relPartCont);
		insert into relPartCont (idRel, archivo, idParte, TipoCont) values
		(nidrel,rutaaudio,nidparte,2);
	end if;
    set msj = "COMENTARIO ENVIADO";
end if;
	if (nautor = (select nombre from usuario where tipo = 0)) then
		set url = 'BLOG.jsp?taches=1';
	else
		set url = 'BLOG.jsp';
    end if;    
select msj,url;
end gatito
delimiter ;

#otro metodo para obtener datos del usuario
drop procedure if exists sp_obtenUsuarioo;
delimiter //
create procedure sp_obtenUsuarioo(in nom nvarchar(50), in tip nvarchar(20), in clav varchar(50))
begin
declare existe int;
declare msj nvarchar(20);
set existe = (select count(*) from vw_usuario where nombre = nom and tipo = tip and clave = clav);
if existe = 1 then
	select * from vw_usuario where nombre = nom and tipo = tip and clave = clav;
else
	set msj = "error";
    select msj as erro;
end if;
end //
delimiter ;

#Porceidminto consultar admin
drop procedure if exists sp_ConsultarAdmin;
delimiter **
create procedure sp_ConsultarAdmin(in us nvarchar(30), clav nvarchar(50), tip int(1))
begin
declare existe nvarchar(2);
declare consulta nvarchar(10);
if tip=0 then
	set existe=(select count(*) from vw_usuario where md5(nombre)=md5(us) and clave = clav and tipo = 0);
else
	set existe=(select count(*) from vw_usuario where md5(nombre)=md5(us) and clave = clav and tipo=1);
end if;
if existe=1 then
	set consulta='Correcto';
else
	set consulta='Incorrecto';
end if;
select consulta as Coincide;
end; **
delimiter ;

#Proc editar
drop procedure if exists sp_Editar;
delimiter **
CREATE  PROCEDURE sp_Editar(in usr nvarchar(30), clav nvarchar(50), tipo int(1), nuevoDato nvarchar(30), ide int(2))
begin
declare existencia int(2);
declare notifEdicion nvarchar(20);
set notifEdicion='NO';
if tipo=1 then
	update usuario set nombre = nuevoDato where idUsuario=ide;
    set notifEdicion='Exitosa';
else
	if tipo=2 then
		update usuario set clave = md5(nuevoDato) where  idUsuario=ide;
        set notifEdicion='Exitosa';
    else
		##set existencia=(select count(*) from vw_usuarios where claveUsuario=clav and Usuario=usr and tipoUsuario=0);
       ## if existencia=1 then
       if tipo=3 then
		update usuario set clave = MD5(nuevoDato) where  idUsuario=ide ;
        set notifEdicion='Exitosa';
		else
			update usuario set colorFondo= nuevoDato where idUsuario=ide;
            set notifEdicion='color';
		end if;
        ##else
			##set notifEdicion='No eres admin';
        ##end if;
    end if;
end if;
select notifEdicion as Modificacion;
end;**
delimiter ;


##Procedimiento vista que regresa la clave y el nombre de usuario 
drop procedure if exists sp_vista;
delimiter **
create procedure sp_vista(in  usu nvarchar(30))
begin 
	declare existe int(1);
    declare aviso nvarchar(20);
    declare clav nvarchar(50);
    declare us nvarchar(30);
    set existe=(select count(*) from vw_usuario where idUsuario = usu);
if existe=1 then
		set aviso='Existe';
        set clav=(select clave from vw_usuario where idUsuario= usu);
        set us=(select nombre from vw_usuario where idUsuario = usu);
else 
	set aviso = 'No existe';
end if;
select clav as Clave , us as Users;
end; **
delimiter ;


#procedimiento para obtener comentarios
drop procedure if exists sp_obtenComentarios;
delimiter gatito
create procedure sp_obtenComentarios()
begin
	select * from vw_blog where padre > 0;
end gatito
delimiter ;

#procedimiento para eliminar partes
drop procedure if exists sp_eliminaParte
delimiter gatito
create procedure sp_eliminaParte(in nidparte int)
begin
declare existe int;
declare msj nvarchar(20);
declare npadre int;
set existe = (select count(*) from vw_blog where idParte = nidparte);
if (existe = 1) then
	set npadre = (select padre from vw_blog where idParte = nidparte);
    if (npadre > 0) then
		delete from blog where idParte = nidparte;
        delete from relPartCont where idParte = nidparte;
	else
		delete from blog where idParte = nidparte;
        delete from blog where padre = nidparte;
        delete from relPartCont where idParte = nidparte;
    end if;
    set msj = 'eliminado';
else
	set msj = 'error';
end if;
select msj;
end gatito
delimiter ;

#procedimiento para autorizar comentarios
drop procedure if exists sp_autorizaParte;
delimiter gatito
create procedure sp_autorizaParte(in nidparte int)
begin
declare existe int;
declare msj nvarchar(20);
set existe = (select count(*) from vw_blog where idParte = nidparte and estado = 0 and padre > 0);
if (existe = 1) then
	update blog set estado = 1 where idParte = nidparte;
    set msj = 'autorizado';
else
	set msj = 'error';
end if;
select msj;
end gatito
delimiter ;

#procedimiento para obtener el contenido de las partes
drop procedure if exists sp_obtenContenido;
delimiter gatito
create procedure sp_obtenContenido()
begin
	select * from vw_relPartCont;
end gatito
delimiter ;

#procedimiento para obtener el blog
drop procedure if exists sp_obtenBlog;
delimiter gatito
create procedure sp_obtenBlog()
begin
	select * from vw_contBlog;
end gatito
delimiter ;

#procedimiento para modificar foto de usuario
drop procedure if exists sp_modificaFoto;
delimiter gatito
create procedure sp_modificaFoto(in nidusuario int, in rutaimagen nvarchar(500))
begin
declare existe int;
declare msj nvarchar(30);
set existe = (select count(*) from vw_usuario where idUsuario = nidusuario);
if (existe = 1) then
	update usuario set foto = rutaimagen where idUsuario = nidusuario;
    set msj = 'Foto de perfil modificada';
else
	set msj = 'Usuario no existe';
end if;
select msj;
end gatito
delimiter ;

#Procedmiento para cambair el nombre de el registro de alumno 
drop procedure if exists sp_EditarAl;
delimiter **
create procedure sp_EditarAl(in ide int(3),nuevoname nvarchar(50))
begin
	declare exist int(1);
    declare msj nvarchar(50);
    set exist=(select count(*) from usuario where idUsuario=ide);
    if exist=1 then
		set msj='Exitosa';
        update usuario set nombre=nuevoname where idUsuario=ide;
    else
		set msj='Error';
    end if;
select  msj as Modificacion;
end; **
delimiter ;

select * from blog;
select * from usuario;
