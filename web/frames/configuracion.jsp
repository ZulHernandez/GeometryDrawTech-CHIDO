<%-- 
    Document   : configuracion
    Created on : 24/04/2016, 08:55:36 AM
    Author     : Saul
--%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>
<%
    //Nota : Ignorar comentarios que tengan **!!!!

    //**String usr=request.getAttribute("Valido")== null ? "" : nSesion.getAttribute("Usuario").toString();
    //Se valida si el atributo de nSesion "Valido" es distinto de nulo , si es nulo usr vale "" y en el if 
    // Se valida si usr es "" para saber si se está tratando de acceder a la página por la url 
    HttpSession nSesion = request.getSession();
    String usr = nSesion.getAttribute("Valido") != null ? nSesion.getAttribute("Usuario").toString() : "";
    String color = nSesion.getAttribute("Color").toString();
    String colorMen = nSesion.getAttribute("ColorMenu").toString();
    String nombreAd = "";
    String claveAd = "";
    String claveAlum = "";
    String id = nSesion.getAttribute("ID").toString();
    String idA = nSesion.getAttribute("Alumnos").toString();
    String datos[] = new String[2];

    Clases.cErrorAcceso data = new Clases.cErrorAcceso();
    datos = data.traerDatos(id);
    nombreAd = datos[1];
    claveAd = datos[0];
    datos = data.traerDatos(idA);
    claveAlum = datos[0];
    /*datos=data.traerDatos("Alumno");
     if(datos.next())
     {
     claveAlum=datos.getString("Clave");
     }*/
    //String tipoSesion=request.getAttribute("TipoUsr").toString();
    /*if(usr.equals(""))
     {
     response.sendRedirect("../login.html");
     }*/

    Clases.cLogica gatito = new Clases.cLogica();
    ResultSet usuario = gatito.consultaUsuario(usr, 0);
    usuario.next();
%>
<!DOCTYPE html>
<html>
    <head>
        <title>GeometryDrawtechBlog</title>
        <link rel="icon" type="image/png" href="imgs/icono.ico"/>
        <script src="../js/validaEditar.js" type="text/javascript"></script>
        <script src="../js/postear.js" type="text/javascript"></script>
        <link href="../css/sweetalert-master/dist/sweetalert.css" rel="stylesheet" type="text/css"/>
        <script src="../css/sweetalert-master/dist/sweetalert.min.js" type="text/javascript"></script>
        <script>
            function txt2()
            {
                var str = document.getElementById("fotoUsr").value;
                document.getElementById("ext2").innerHTML = str;
                validaImagen(document.getElementById("fotoUsr"));
            }
        </script>
        <style type="text/css">
            @font-face {
                font-family: "Roboto";
                src: url("/Geometry%20Drawtech%202.0/fuentes/Roboto-Regular.ttf") format("truetype");

            }
            html{
                -webkit-box-shadow: inset 20px 20px 55px -20px rgba(0,0,0,0.65);
                -moz-box-shadow: inset 20px 20px 55px -20px rgba(0,0,0,0.65);
                box-shadow: inset 20px 20px 55px -20px rgba(0,0,0,0.65);
            }
            body
            {
                font-family: "Roboto", Verdana;
                background: url("../imgs/codigo1.png") no-repeat top center;
                background-attachment: fixed;
                padding: 15px;
                color: white;
                
            }
            td
            {
                padding: 10px;
                border-bottom: 1px solid black;
                object-position: left;
            }
            #container
            { 
                background-color: rgba(0,0,0,.8);
                padding: 20px;
            }
            gatito
            {
                text-transform: uppercase;
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
            .boto,.file-upload
            {
                background-color: white;
                color: black;
                border-color: transparent;
                -webkit-transition-duration: 0.2s; 
                transition: all 0.2s;
                display: inline-block;
                cursor: pointer;
                text-transform: uppercase;
            }

            .file-upload:hover,.boto:hover
            {
                background-color: #002233; 
                color:white;
                text-transform: uppercase;
            }
        </style>
    </head>
    <body onload="refre();">
        <div id="container">
            <form id="editaDatos" name="editaDatos" action="../jsp/actualiza.jsp" method="POST"/>
            <gatito>CONFIGURACI&Oacute;N GENERAL DE DATOS</gatito>
            <hr/>
            <table style="width: 70%">
                <input type="hidden" id="campoEditado" name="campoEditado" value="0" />
                <input type="hidden" id="nuevoDato" name="nuevoDato" value=" "/>
                <input type="hidden" id="claveConfirmada" name="claveConfirmada" value=" " />
                <tr>
                    <td style="width: 30%"><gatito>NOMBRE</gatito></td>
                <td class="espacio" style="width: 35%"><input style="width: 130px" type="text" id="nombre" name="nombre"  value="<%=nombreAd%>" /></td>
                <td class="espacio" style="width: 35%"><input style="width: 130px" class="boto" type="button" id="editNombre0" name="editNombre" value="Cambiar" onclick="verificarContra(1)" /></td>
                </tr>
                <tr>
                    <td style="width: 30%"><gatito>Contrase&ntilde;a </gatito></td>
                <td class="espacio" style="width: 35%"><input style="width: 130px" type="password" id="clave" name="clave" value="<%=claveAd%>"  /></td>
                <td class="espacio" style="width: 35%"><input style="width: 130px" class="boto" type="button" id="editClave" name="editClave" value="Cambiar" onclick="verificarContra(2)" /></td>
                </tr>
                <tr id="revelde">
                    <td style="width: 30%"><gatito>Contrase&ntilde;a del Sitio</gatito></td>
                <td class="espacio" style="width: 35%"><input style="width: 130px" type="password" id="claveGral" name="claveGral" value="<%=claveAlum%>"  /></td>
                <td class="espacio" style="width: 35%"><input style="width: 130px" class="boto" type="button" id="editClaveGral" name="editClaveGral" value="Cambiar" onclick="verificarContra(3)" /></td>
                </tr>
            </table>
            <br/><br/>
            <gatito>PERSONALIZACI&Oacute;N</gatito>
            <hr/>
            <table style="width: 70%">
                <tr>
                    <td style="width: 30%"><gatito>Color de fondo</gatito></td>
                <td class="espacio" style="width: 35%"><input style="width: 130px" type="color" id="colorGral" list="colors" value="<%=color%>" name="colorGral"/></td>
                <datalist id="colors">
                    <option>#000000</option>
                    <option>#002233</option>
                    <option>#004466</option>
                    <option>#006699</option>
                    <option>#0088cc</option>
                    <option>#00aaff</option>
                    <option>#33bbff</option>
                    <option>#66ccff</option>
                    <option>#99ddff</option>
                    <option>#cceeff</option>
                </datalist>
                <td class="espacio" style="width: 35%"><input style="width: 130px" class="boto" type="button" id="editColorGral" name="editColorGral" value="Cambiar" onclick="verificarContra(4)"/></td>

                </tr>
                </form>
                <form id="editaIm" name="editaIm" action="../jsp/actualiza.jsp" method="POST" enctype="multipart/form-data" />
                <tr>
                    <td style="width: 30%" rowspan="2"><gatito>Foto de perfil</gatito></td>
                <td class="espacio" style="width: 35%" rowspan="2" >
                    <img src="../<%=usuario.getString("foto")%>" width="60" height="60" /><br />
                </td>
                <td>
                    <button class="file-upload" id="enviar"><input type="file" id="fotoUsr" name="fotoUsr" class="file-input" onchange="validaImagen(this); txt2()"/>Agregar imagen:<div id="ext2"></div></button>
                    <input type="hidden" id="archivo" name="archivo">
                    <input type="hidden" name="idUsuario" value="<%=usuario.getString("idUsuario")%>">
                </td>
                <tr>
                    <td class="espacio" style="width: 35%"><input style="width: 130px" type="button" class="boto" id="editaFoto" name="editaFoto" value="Editar" onclick="verificarContra(6)" /></td>
                </tr>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>
