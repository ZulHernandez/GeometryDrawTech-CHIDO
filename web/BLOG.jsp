<%-- 
    Document   : BLOG
    Created on : 16/04/2016, 07:54:25 PM
    Author     : Daniel Castillo
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>
<%
    HttpSession nSesion = request.getSession();
    String usr = nSesion.getAttribute("Valido") == null ? "" : nSesion.getAttribute("Usuario").toString();
    int tipoSesion = Integer.parseInt(nSesion.getAttribute("TipoUsr").toString());
    if (usr.equals("")) {
        response.sendRedirect("../login.html");

    }
    Clases.cLogica gatito = new Clases.cLogica();
    String taches = "";
    String eliminar = "n";
    String mensaje = "";
    taches = request.getParameter("taches") == null ? "0" : request.getParameter("taches");
    eliminar = request.getParameter("eliminar") == null ? "n" : request.getParameter("eliminar");
    String color = nSesion.getAttribute("Color").toString();
    if (!eliminar.equals("n")) {
        mensaje = gatito.eliminaParte(eliminar);
    }
    ResultSet blog = gatito.obtenBlog();
    ResultSet contenido = gatito.obtenContenido();
    ResultSet comentarios = gatito.obtenComentarios();
%>
<!DOCTYPE html>
<html>
    <head>
        <title>GeometryDrawtechBlog</title>
        <link href="css/blog.css" rel="stylesheet" type="text/css"/>
        <link rel="icon" type="image/png" href="imgs/icono.ico"/>
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <script src="css/material.min.js" type="text/javascript"></script>
        <link href="css/material.min.css" rel="stylesheet" type="text/css"/>
        <link href="css/sweetalert-master/dist/sweetalert.css" rel="stylesheet" type="text/css"/>
        <script src="css/sweetalert-master/dist/sweetalert.min.js" type="text/javascript"></script>
        <script>
            function confirma(idparte, tipo) {
                swal({
                    title: "¿Estas seguro?",
                    text: "Este cambio no puede ser reversible",
                    type: "warning",
                    showCancelButton: true,
                    closeOnConfirm: false,
                    closeOnCancel: true,
                    confirmButtonText: "Sí , eliminar",
                    cancelButtonText: "Cancelar",
                    animation: "slide-from-top",
                },
                        function (isConfirm) {
                            if (isConfirm) {
                                swal({title: "Eliminado", showConfirmButton: false, text: tipo + " eliminado", type: "success", timer: 3000}, function () {
                                    window.location = 'BLOG.jsp?taches=1&eliminar=' + idparte
                                });
                            }/*else{
                             swal("Cancelado","Post no eliminado","error");
                             }*/
                        });
            }
            function refre()
            {
                window.parent.frames[0].location.reload();
                window.parent.frames[1].location.reload();
            }
            /*var a = 0;
            function show()
            {
                if (a % 2 == 0) {
                    a++;
                    document.getElementById("coments").style.display='block';
                    document.getElementById("mostrar").value='OCULTAR COMENTARIOS';
                } else {
                    a++;
                    document.getElementById("coments").style.display='none';
                    document.getElementById("mostrar").value='MOSTRAR COMENTARIOS';
                }
            }*/
        </script>    
        <style> 
            body
            {
                font-family: "Roboto", Verdana;
                background-color:<%=color%>;
                padding: 15px;
                overflow-x: hidden;
            }
            #tache
            {
                width:32px;
                height: 32px;
            }
        </style>
        <script type="text/javascript">
            function comentar(id) {
                location.href = "comentar.jsp?idPadre=" + id;
            }
        </script>
    </head>
    <body style="width: 95%" onload="refre()">

        <%while (blog.next()) {
                if (blog.getString("tipo").equals("1")) {
        %> 
        <div class="container" >
            <div class="post">
                <%if (taches.equals("1")) {%>
                <img src="imgs/tache.png" id="tache" onclick="confirma(<%=blog.getString("idParte")%>, 'Post');"/><br>
                <div class="mdl-tooltip" for="tache">
                    ELIMINAR 
                </div>
                <%}%>
                <br/>
                <img src="<%=blog.getString("foto")%>" width="45px" heigt="45px" align="middle">
                &nbsp;&nbsp;&nbsp;<gatito><%=blog.getString("autor")%></gatito>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=blog.getString("fecha").replace("-", "/")%>
                <hr/>
                <div class="content">
                    <p><%=blog.getString("contEscrito").replace("&", "&amp;").replace("<", "&lt;")%></p><br /><br />
                    <%while (contenido.next()) {
                            if (contenido.getString("TipoCont").equals("1") && contenido.getString("idParte").equals(blog.getString("idParte"))) {
                    %>
                    <div class="image">
                        <center><img src="<%=contenido.getString("archivo")%>" width="70%"/></center>
                    </div>
                    <%} else {
                        if (contenido.getString("TipoCont").equals("2") && contenido.getString("idParte").equals(blog.getString("idParte"))) {
                    %>
                    <div class="archivo">
                        <center><a style="color:white; text-decoration: none;" href="<%=contenido.getString("archivo")%>" download="<%=contenido.getString("archivo").substring(17, contenido.getString("archivo").length())%>">ARCHIVO ADJUNTO</a></center>
                    </div>
                    <%}
                            }
                        }
                        contenido.beforeFirst();%>
                </div>
                <br/>
                <button id="comentar" onclick="comentar(<%=blog.getString("idParte")%>);" width="20%">COMENTAR</button>
                <!--<br/>
                <hr/>
                <br/>
                <input type="button" onclick="show();" id="mostrar" value="MOSTRAR COMENTARIOS" style=" width: 100%"/>
                <br/>-->
            </div>
                <div class="coments"><!--id="coments" style="display: none"-->
                <%while (comentarios.next()) {
                            if (blog.getString("idParte").equals(comentarios.getString("padre")) && comentarios.getString("estado").equals("1")) {%>
                <div class="comment1">
                    <div class="user1">
                        <%if (taches.equals("1")) {%>
                        <img src="imgs/tache.png" id="tache" onclick="confirma(<%=comentarios.getString("idParte")%>, 'Comentario');"/><br/><br>
                        <div class="mdl-tooltip" for="tache">
                            ELIMINAR 
                        </div>
                        <%}%>
                        <img src="<%=comentarios.getString("foto")%>" width="40px" heigt="40px">
                        &nbsp;&nbsp;&nbsp;&nbsp;<gatito><%=comentarios.getString("autor")%></gatito>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=comentarios.getString("fecha").replace("-", "/")%>
                    </div><hr>
                    <div class="text1"><p><font size="2"><%=comentarios.getString("contEscrito").replace("&", "&amp;").replace("<", "&lt;")%></font></p></div>

                    <%while (contenido.next()) {
                            if (contenido.getString("TipoCont").equals("1") && contenido.getString("idParte").equals(comentarios.getString("idParte"))) {
                    %>
                    <div class="image">
                        <center><img src="<%=contenido.getString("archivo")%>" style="width:25%" /></center>
                    </div> 
                    <%} else {
                        if (contenido.getString("TipoCont").equals("2") && contenido.getString("idParte").equals(comentarios.getString("idParte"))) {
                    %>
                    <div class="archivo">
                        <center><a style="color:white; text-decoration: none;" id="lonk" href="<%=contenido.getString("archivo")%>" download="<%=contenido.getString("archivo").substring(17, contenido.getString("archivo").length())%>"><tex id="lonk">ARCHIVO ADJUNTO</tex></a></center>
                    </div>
                    <%}
                                }
                            }
                            contenido.beforeFirst();%>
                </div>
                <%}%>
                <%}
                        comentarios.beforeFirst();%>
            </div>
            <hr />
            <%}
                }%>
        </div>
    </body>
</html>