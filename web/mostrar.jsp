<%-- 
    Document   : mostrar
    Created on : 27-abr-2016, 17:57:27
    Author     : Alpine
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>
<%
     HttpSession nSesion= request.getSession();
    String usr = nSesion.getAttribute("Valido")== null ? "" : nSesion.getAttribute("Usuario").toString(); 
    int tipoSesion= Integer.parseInt(nSesion.getAttribute("TipoUsr").toString());
    if(usr.equals(""))
    {
        response.sendRedirect("../login.html");
        
    }
    String color=nSesion.getAttribute("Color").toString();
    String idParte = "";
    if(request.getParameter("idParte") == null){
        idParte = "error";
    }else{
        idParte = request.getParameter("idParte");
    }
    Clases.cLogica gatito = new Clases.cLogica();
    ResultSet blog = gatito.obtenBlog();
    ResultSet contenido = gatito.obtenContenido();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>GeometryDrawtechBlog</title>
        <link href="css/blog.css" rel="stylesheet" type="text/css"/>
        <link rel="icon" type="image/png" href="imgs/icono.ico"/>
        <style>
        body
            {
                font-family: "Roboto", Verdana;
                background-color:<%=color%>;
                padding: 15px;
            }
       </style>
    </head>
    <body>
        <%if(!idParte.equals("error"))while(blog.next()){
        if(blog.getString("tipo").equals("1") && blog.getString("idParte").equals(idParte)){
    %>
    <div class="container">
	<div class="post">
            <img src="<%=blog.getString("foto")%>" width="45px" heigt="45px" align="middle">
            &nbsp;&nbsp;&nbsp;<gatito><%=blog.getString("autor")%></gatito>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=blog.getString("fecha").replace("-","/")%>
            <hr/>
            <div class="content">
		<p><%=blog.getString("contEscrito").replace("&","&amp;").replace("<","&lt;")%></p><br /><br />
                <%while(contenido.next()){
                    if(contenido.getString("TipoCont").equals("1") && contenido.getString("idParte").equals(blog.getString("idParte"))){
                %>
                <div class="image">
                    <center><img src="<%=contenido.getString("archivo")%>" width="70%"/></center>
                </div>
                <%}else{
                    if(contenido.getString("TipoCont").equals("2") && contenido.getString("idParte").equals(blog.getString("idParte"))){
                %>
                <div class="archivo">
                            <center><a style="color:white; text-decoration: none;" id="lonk" href="<%=contenido.getString("archivo")%>" download="<%=contenido.getString("archivo").substring(17,contenido.getString("archivo").length())%>"><tex id="lonk">ARCHIVO ADJUNTO</tex></a></center>
                        </div>
                <%}}}contenido.beforeFirst();%>
            </div>
            <br/>
            <a href="bandeja.jsp"><button id="comentar">VOLVER</button></a>
            </div>
        <%}
    }%>
    </body>
</html>
