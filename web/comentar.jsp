<%-- 
    Document   : comentar
    Created on : 23-abr-2016, 20:12:53
    Author     : Alpine
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>
<%
    HttpSession nSesion= request.getSession();
    String usr= nSesion.getAttribute("Valido")!=null ? nSesion.getAttribute("Usuario").toString() : "";
    if(usr.equals("")){
        response.sendRedirect("../login.html");
    }
    String idParte = "";
    if(request.getParameter("idPadre") == null){
        idParte = "lol";
    }else{
        idParte = request.getParameter("idPadre");
    }
    String color=nSesion.getAttribute("Color").toString();
    Clases.cLogica gatito = new Clases.cLogica();
    ResultSet blog = gatito.obtenBlog();
    ResultSet contenido = gatito.obtenContenido();
    ResultSet usuario = gatito.consultaUsuario(usr, 0);
    String nombre = "";
    if(usuario.next()){
        try{
            nombre = usuario.getString("error");
            //nombre="";
            nombre =usr;
        }catch(Exception e){
            nombre = usuario.getString("nombre");
        }
    }else{
        //nombre="";
        nombre = usr;
    }
    
   /* Clases.nota obj2 = new Clases.nota();
    obj2.setNumero(1);*/
%>
<!DOCTYPE html>
<html>
    <head>
        <title>GeometryDrawtechBlog</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/postear.css" rel="stylesheet" type="text/css"/>
        <link href="css/blog.css" rel="stylesheet" type="text/css"/>
        <script src="css/sweetalert-master/dist/sweetalert.min.js" type="text/javascript"></script>
        <link href="css/sweetalert-master/dist/sweetalert.css" rel="stylesheet" type="text/css"/>
        <link rel="icon" type="image/png" href="imgs/icono.ico"/>
        <script>
            function txt()
            {
                var str = document.getElementById("audio").value;
                document.getElementById("ext").innerHTML = str;
            }
            function txt2()
            {
                var str = document.getElementById("imagen").value;
                document.getElementById("ext2").innerHTML = str;
                validaImagen(document.getElementById("imagen"));
            }
            
        </script>
        <style>
            #contenido
            {
                background-color: #121D24;
                color: white;
                padding: 10px;
                display: block;
                border: none;
                width: 95%;
                overflow: none;
                font-family: inherit;
                height: 150px;
                resize: none;
            }
            #forma
            {
                width:95%;
            }
            #enviar
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
            #enviar,#boto
            {
                zoom:1.5;
            } 
            #boto
            {
                width: 20%;
                background-color: RGB(21,133,183);
                color: white;
                border-color: transparent;
                -webkit-transition-duration: 0.2s; 
                transition: all 0.2s;
                display: inline-block;
                cursor: pointer;
            }

            #enviar:hover,#boto:hover
            {
                background-color: rgb(68,183,234); 
                color:black;
            }
            body
            {
                font-family: "Roboto", Verdana;
                background-color:<%=color%>;
                padding: 15px;
            }
            .file-upload {
                position: relative;
                overflow: hidden;
                margin: 10px; }

            .file-upload input.file-input {
                position: absolute;
                top: 0;
                right: 0;
                margin: 0;
                padding: 0;
                font-size: 20px;
                cursor: pointer;
                opacity: 0;
                filter: alpha(opacity=0); }
        </style>
        <script src="js/postear.js" type="text/javascript"></script>
        <title>JSP Page</title>
    </head>
    <body>
    <%while(blog.next()){
        if(blog.getString("tipo").equals("1") && blog.getString("idParte").equals(idParte)){
    %>
    <div class="container">
	<div class="post">
            <img src="<%=blog.getString("foto")%>" width="45px" heigt="45px" align="middle">
            &nbsp;&nbsp;&nbsp;<gatito><%=blog.getString("nombre")%></gatito>
            <hr/>
            <div class="content">
		<%=blog.getString("contEscrito").replace("&","&amp;").replace("<","&lt;")%><br /><br />
                <%while(contenido.next()){
                    if(contenido.getString("TipoCont").equals("1") && contenido.getString("idParte").equals(blog.getString("idParte"))){
                %>
                <div class="image">
                    <center><img src="<%=contenido.getString("archivo")%>" width="70%" /></center>
                </div>
                <%}else{
                    if(contenido.getString("TipoCont").equals("2") && contenido.getString("idParte").equals(blog.getString("idParte"))){
                %>
                <div class="archivo">
                    <center><a style="color:white; text-decoration: none;" href="<%=contenido.getString("archivo")%>" download="<%=contenido.getString("archivo").substring(17,contenido.getString("archivo").length())%>">ARCHIVO ADJUNTO</a></center>
                </div>
                <%}}}contenido.beforeFirst();%>
            </div>
        <hr />
        <%}
    }%>
        <br><br>
        <div id="forma">
            <form action="recibeDatos" enctype="multipart/form-data" method="POST">
            <div id="autor">
                <%=nombre%>
                <input type="hidden" id="autor" name="autor" placeholder="Escribe tu nombre" value="<%=nombre%>"/>
            </div>
                <textarea id="contenido" rows="4" maxlength="500" name="contenido" placeholder="Escribe el contenido de tu comentario"></textarea>
                <button class="file-upload" id="enviar"><input type="file" id="imagen" name="imagen" class="file-input" onchange="validaImagen(this); txt2()"/>Agregar imagen:<div id="ext2"></div></button><br />
                <input type="hidden" name="oculto1" id="oculto1"/><br />
                <!--opcion de subir archivo ya no oculta para los comentarios-->
                <button class="file-upload"  id="enviar"><input type="file" id="audio" name="audio" class="file-input" onchange="txt();"/>Agregar archivo:<div id="ext"></div></button><br />
                <input type="hidden" name="oculto2" id="oculto2"/>
                <input type="hidden" name="tipo" id="tipo" value="0" />
                <input type="hidden" name="padre" id="padre" value="<%=idParte%>" />
                <input type="hidden" name="estado" id="estado" value="0" />
            <div id="botones">
                <input type="button" id="boto" name="enviar" value="Enviar" onclick="enviaForm();"  style="float: right; margin: 5px;" class="boton"/>
            </div>
            </form>
        </div>
    </body>
</html>
