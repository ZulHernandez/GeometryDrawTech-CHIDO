<%-- 
    Document   : head
    Created on : 18/04/2016, 05:22:32 PM
    Author     : Saul
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>
<%
    
    HttpSession nSesion= request.getSession();
    String usr = nSesion.getAttribute("Valido")== null ? "" : nSesion.getAttribute("Usuario").toString(); 
    int tipoSesion= Integer.parseInt(nSesion.getAttribute("TipoUsr").toString());
    if(usr.equals("")){
        response.sendRedirect("../login.html");
    }
    Clases.cLogica gatito = new Clases.cLogica();
    ResultSet usuario = null;
    if(tipoSesion == 1){
        usuario = gatito.consultaUsuario("Alumno",tipoSesion);
    }else{
        usuario = gatito.consultaUsuario(usr,tipoSesion);
    }
    String bienvenida = "";
    if(usuario.next()){
        try{
            bienvenida = usuario.getString("error");
        }catch(Exception e){
            bienvenida = usuario.getString("foto");
        }
    }else{
        bienvenida = "no se recibio Usuario";
    }
    %>
<!DOCTYPE html>
<html>
    <head>
	<title>GeometryDrawtechBlog</title>
	<link rel="icon" type="image/png" href="imgs/icono.ico"/>
        <link href="../css/head.css" rel="stylesheet" type="text/css"/>
    </head>
    <body  topmargin="0">
	<div id="container">
            <img id="img" src="../img/MS.jpg" width= "80px" height="60px" align="middle"/>
            <img id="img" src="../img/gdb.png" width="342px" heigth="60px" align="middle" />
            <img id="img" src="../img/GDT.JPG" width= "80px" height="60px" align="middle" />
            <img id="img" src="../img/espacio.png" width="27%" height="60px" align="middle"/>
            <span id="saludo" align="rigth" >
                <img src="../<%=bienvenida%>" width="50px" height="50px" align="middle"/> ¡Hola! <%=usr%>
            </span>
	</div>
    </body>
</html>
