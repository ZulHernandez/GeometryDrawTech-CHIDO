<%-- 
    Document   : salida
    Created on : 24/04/2016, 09:04:05 AM
    Author     : Saul
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>
<%
   
    HttpSession nSesion = request.getSession();
    String tipoS=nSesion.getAttribute("TipoUsr").toString();
    if(tipoS.equals("1"))
    {
        String ide=nSesion.getAttribute("ID").toString();
        Clases.cErrorAcceso valida = new Clases.cErrorAcceso();
        valida.editarAlumno(Integer.parseInt(ide),"Alumno");
    }
    nSesion.invalidate();
    response.sendRedirect("../login.html");
    
%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="icon" type="image/png" href="imgs/icono.ico"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>GeometryDrawtechBlog</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
