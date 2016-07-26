<%--
    Document   : bandeja
    Created on : 27-abr-2016, 17:39:34
    Author     : Alpine
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>
<%
    HttpSession nSesion=request.getSession();
    Clases.cLogica gatito = new Clases.cLogica();
    String log = "";
    String coment = "ni madres";
    String mensaje = "";
    String color=nSesion.getAttribute("Color").toString();
    if(request.getParameter("log") != null){
        if(request.getParameter("coment") != null){
            log = request.getParameter("log");
            coment = request.getParameter("coment");
            if(log.equals("1")){
                //Autorizar post
                mensaje = gatito.autorizaParte(coment);
            }else{
                if(log.equals("0")){
                    mensaje = gatito.eliminaParte(coment);
                }else{
                    response.sendRedirect("http://www.interpol.int/es/Internet");
                }
            }
        }
    }
    
    ResultSet comentarios = gatito.obtenComentarios();
    ResultSet contenido = gatito.obtenContenido();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/sweetalert-master/dist/sweetalert.css" rel="stylesheet" type="text/css"/>
        <script src="css/sweetalert-master/dist/sweetalert.min.js" type="text/javascript"></script>
        <title>GeometryDrawtechBlog</title>
        <link href="css/blog.css" rel="stylesheet" type="text/css"/>
        <link rel="icon" type="image/png" href="imgs/icono.ico"/>
        <script>
        function refre()
            {
               window.parent.frames[0].location.reload(); 
               window.parent.frames[1].location.reload();
            }
        </script> 
        <style>
            body
            {
                font-family: "Roboto", Verdana;
                background-color:<%=color%>;
                padding: 15px;
            }
            a:link, a:visited, a:hover, a:active
            {
                color: white;
                text-decoration: underline;
                cursor: context-menu;
            }
            button
            {
                width: 40%;
                background-color: RGB(21,133,183);
                color: white;
                border-color: transparent;
                -webkit-transition-duration: 0.2s; 
                transition: all 0.2s;
                display: inline-block;
                cursor: pointer;

            }

            #a:hover 
            {
               background-color: rgb(0,159,0); 
            }
            #e:hover 
            {
                background-color: rgb(128,0,0); 
            }
        </style>
    </head>
    <body onload="refre()">
        <%if(mensaje.equals("autorizado")){%>
            <script>
                swal({title: "Comentario Autorizado",timer: 2000,showConfirmButton: false });
            </script>
        <%}else
        if(mensaje.equals("eliminado")){%>
            <script>
                swal({title: "Comentario Eliminado",timer: 2000,showConfirmButton: false });
            </script>
        <%}else
        if(mensaje.equals("error")){%>
            <script>
                swal({title: "No me Hackees papu",timer: 2000,showConfirmButton: false });
            </script>
        <%}%>
        <div class="post">
            <center><h2>BANDEJA DE ENTRADA</h2><BR/>
                <p>Aqui llegaran los comentarios realizados por los alumnos antes de ser mostrados en el blog.</p></center>
        <div class="coments">
        <%while(comentarios.next()){
            if(comentarios.getString("estado").equals("0")){
        %>
        <hr>
		<div class="comment1">
                    <div class="user1">
			<img src="imgs/male.jpg" width="40px" heigt="40px">
                        &nbsp;&nbsp;&nbsp;&nbsp;<gatito><%=comentarios.getString("autor")%></gatito>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=comentarios.getString("fecha").replace("-","/")%>
                    </div><hr>
			<div class="text1"><p><%=comentarios.getString("contEscrito").replace("<","&lt;")%></p></div>
                    
                    <%while(contenido.next()){
                    if(contenido.getString("TipoCont").equals("1") && contenido.getString("idParte").equals(comentarios.getString("idParte"))){
                %>
                <div class="image">
                    <center><img src="<%=contenido.getString("archivo")%>" width="60%"/></center>
                </div>
                <%}else{
                    if(contenido.getString("TipoCont").equals("2") && contenido.getString("idParte").equals(comentarios.getString("idParte"))){
                %>
                <!--La opcion para subir archivos esta bloqueada para los alumnos-->
                <div class="archivo">
                    <center><a style="color:white; text-decoration: none;" href="<%=contenido.getString("archivo")%>" download="<%=contenido.getString("archivo").substring(17,contenido.getString("archivo").length())%>">ARCHIVO ADJUNTO</a></center>
                </div>
                <%}}}contenido.beforeFirst();%>
                </div>
                <hr>
                    <p>Post a comentar: <a href="mostrar.jsp?idParte=<%=comentarios.getString("padre")%>">POST (<%=comentarios.getString("fecha")%>)</a>
                    <br>
                    <center><a href="bandeja.jsp?log=1&coment=<%=comentarios.getString("idParte")%>"><button id="a">AUTORIZAR</button></a> &nbsp;&nbsp;&nbsp;
                    <a href="bandeja.jsp?log=0&coment=<%=comentarios.getString("idParte")%>"><button id="e">ELIMINAR</button></a></center>
                <%}%>
            <%}%>
            </div>
        </div>
    </body>
</html>
