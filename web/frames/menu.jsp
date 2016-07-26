<%-- 
    Document   : menu
    Created on : 18/04/2016, 06:18:13 PM
    Author     : Saul
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>
<%
      HttpSession nSesion= request.getSession();
    //String usr=request.getAttribute("Valido")== null ? "" : nSesion.getAttribute("Usuario").toString();
     String usr= nSesion.getAttribute("Valido") == null ? "" : nSesion.getAttribute("Usuario").toString();
     String tipoSesion="";
     int nota = 0;
     if(usr.equals(""))
     {
         response.sendRedirect("../login.html");
     }
     else
     {
         tipoSesion=nSesion.getAttribute("TipoUsr").toString();
     }
      String color=nSesion.getAttribute("ColorMenu").toString();
      
    Clases.cLogica gateito = new Clases.cLogica();
    ResultSet com = gateito.obtenComentarios();
    while (com.next())
    {
        if(com.getString("estado").equals("0"))
        {
            nota++;
        }
    }
%>
<!DOCTYPE html>
	
 <html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" type="image/png" href="imgs/icono.ico"/>
        <link href="../css/material.min.css" rel="stylesheet" type="text/css"/>
        <script src="../css/material.min.js" type="text/javascript"></script>
        <title>GeometryDrawtechBlog</title>
        <link href="../css/menu.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <style>
            body
            {
                background-color:<%=color%>;
            }
        </style>
        <div id="container">
            <% if(tipoSesion.equals("0"))
            {
            %>
            <br/><hr>
               <a href="../BLOG.jsp?taches=1" target="body"><button id="visual">&laquo;Blog&raquo;</button></a>
            <br/><br/>
                <a href="Principal.jsp" target="body"><button id="visual">&laquo;Descargas&raquo;</button></a>
            <br/><br/>
            <a href="grafica.jsp" target="body"><button id="visual">&laquo;Gráfica&raquo;</button></a>
            <br/><br/>
                <a href="galeria.jsp" target="body"><button id="visual">&laquo;Galeria&raquo;</button></a>
            <br/><hr>
                <a href="../postear.jsp" target="body"><button id="entradas">&laquo;Postear&raquo;</button></a>
            <br/><br/>
                <a href="../bandeja.jsp" target="body"><button id="entradas"><span id="nota" class="mdl-badge" data-badge="<%=nota%>"></span><font size="1">&laquo;Bandeja de Entrada&raquo;</button></a>
            <br/><hr>
                <a href="configuracion.jsp" target="body"><button id="confi"><font size="1">&laquo;Configuraci&oacute;n&raquo;</font></button></a>
            <br/><hr>
                <a href="salida.jsp" target="_top"><button id="cerrar">&laquo;SALIR&raquo;</button></a>
            <br/><hr><br/>
            <%
            }
            else
            {
            %>
            <br/><br/>
                <a href="../BLOG.jsp" target="body"><button id="confi">&laquo;BLOG&raquo;</button></a>
            <br/><hr>
                <a href="galeria.jsp" target="body"><button id="confi">&laquo;Galeria&raquo;</button></a>
            <br/><hr>
                <a href="Principal.jsp" target="body"><button id="confi">&laquo;DESCARGAS&raquo;</button></a>
            <br/><br/>
            <a href="grafica.jsp" target="body"><button id="confi">&laquo;GR&Aacute;FICA&raquo;</button></a>
            <link href="../css/menu.css" rel="stylesheet" type="text/css"/>
            <br/><br/>
                <a href="salida.jsp" target="_top"><button id="cerrar">&laquo;SALIR&raquo;</button></a>
            <%
            }
            %>
	</div>
    </body>
</html>

