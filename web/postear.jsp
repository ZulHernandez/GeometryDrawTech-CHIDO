<%-- 
    Document   : postear
    Created on : 16/04/2016, 04:58:33 PM
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
    String color = nSesion.getAttribute("Color").toString();
    Clases.cLogica gatito = new Clases.cLogica();
    ResultSet usuario = gatito.consultaUsuario(usr, 0);
    String autor = "";
    if (usuario.next()) {
        if (usuario.getString("nombre") != null) {
            autor = usuario.getString("nombre");
        } else {
            autor = usuario.getString("error");
        }
    } else {
        autor = "ni madres";
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <title>GeometryDrawtechBlog</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="text/html" charset=UTF-8">
        <link rel="icon" type="image/png" href="imgs/icono.ico"/>
        <link href="css/sweetalert-master/dist/sweetalert.css" rel="stylesheet" type="text/css"/>
        <script src="css/sweetalert-master/dist/sweetalert.min.js" type="text/javascript"></script>
        <style>
            ::-webkit-scrollbar{
                width: 10px;
                background-color: transparent;
            }

            ::-webkit-scrollbar-track{
                background-color:transparent;
                color: #999999
            }

            ::-webkit-scrollbar-thumb{
                background: rgba(99,99,99,0.8);
            }

            ::-webkit-scrollbar-thumb:hover{
                background: rgba(20,113,143,0.8);
            }

            ::-webkit-scrollbar-thumb:window-inactive {
                background: transparent;
            }
            html{
                -webkit-box-shadow: inset 20px 20px 55px -20px rgba(0,0,0,0.65);
                -moz-box-shadow: inset 20px 20px 55px -20px rgba(0,0,0,0.65);
                box-shadow: inset 20px 20px 55px -20px rgba(0,0,0,0.65);}
            body
            {
                background-color:<%=color%>;
                font-family: "Roboto",arial;
                
                overflow-x: hidden;
                width: 100%;
                height: 100%;
            }
            @font-face {
                font-family: "Roboto";
                src: url("/Geometry%20Drawtech%202.0/fuentes/Roboto-Regular.ttf") format("truetype");

            }
            .container
            {
                padding:1%;
                width:100%;
            }
            #avatar
            {
                float: left;
                margin-right: 20px;
            }
            #forma
            {
                display: inline-block;
                width:95%;
                padding: 10px;
                border-radius: 7px;
                background-color: white;
            }
            #imagenavatar
            {
                width: 64px;
                height: 64px;
            }
            #autor
            {
                margin: 10px;
            }
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
            #archivo
            {
                background-color: white;
                border-radius: 5px;
                padding:10px
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

            .archivo
            {
                cursor: pointer;
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

            #enviar,#boto
            {
                zoom:1.5;
            }    

        </style>
        <script src="js/postear.js" type="text/javascript"></script>
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
            /*function alerta()
             {
             swal({title:"¿Deseas enviar este post?",text:"Sera publicado directamente en el blog",type: "warning",showCancelButton: true,confirmButtonColor: "#DD6B55",confirmButtonText: "PUBLICAR",closeOnConfirm: false,closeOnCancel: false },function(isConfirm){if(isConfirm){swal("EXITO!","TU POST SERA PUBLICADO","success");}else{swal("CANCELADO!","TU POST NO SERA PUBLICADO AUN","error");}});
             }*/
        </script>
    </head>
    <body>
        <div class="container">
            <form id="posteo" action="recibeDatos" method="POST" enctype="multipart/form-data" name="formulario" onsubmit="return enviaForm(2);">
                <br/><br/>
                <div id="forma">
                    <div id="avatar">
                        <img src="<%=usuario.getString("foto")%>" id="imagenavatar" name="igamenavatar" alt="Felisa H. F."/>
                        <br/><br/>
                    </div>
                        <div id="autor" style="font-size: 30px; vertical-align: middle;">
                        <%=autor%>
                    </div>
                    <textarea id="contenido" rows="4" maxlength="500" name="contenido" placeholder="Escribe el contenido del post..."></textarea>
                    <div id="archivo">
                        <br/>
                        <button class="file-upload" id="enviar"><input type="file" id="imagen" name="imagen" class="file-input" onchange="validaImagen(this); txt2()"/>Agregar imagen:<div id="ext2"></div></button><br />
                        <input type="hidden" name="oculto1" id="oculto1"/><br/>
                        <button class="file-upload"  id="enviar"><input type="file" id="audio" name="audio" class="file-input" onchange="txt();"/>Agregar archivo:<div id="ext"></div></button>
                        <input type="hidden" name="oculto2" id="oculto2"/>
                        <input type="hidden" name="autor" id="autor" value="<%=autor%>" />
                        <input type="hidden" name="tipo" id="tipo" value="1" />
                        <input type="hidden" name="padre" id="padre" value="0" />
                        <input type="hidden" name="estado" id="estado" value="1" />
                    </div>
                    <div id="botones">
                        <input type="submit" id="boto"  name="enviar" style="float: right; margin: 5px;" class="boton"></input>
                    </div>
                </div>
            </form>
        </div>

    </body>
</html>
