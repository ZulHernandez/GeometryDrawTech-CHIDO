<%-- 
    Document   : Principal
    Created on : 24/04/2016, 08:52:36 AM
    Author     : Saul
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>
<%
    //Nota : Ignorar comentarios que tengan **!!!!
   
    //**String usr=request.getAttribute("Valido")== null ? "" : nSesion.getAttribute("Usuario").toString();
    
    
    //Se valida si el atributo de nSesion "Valido" es distinto de nulo , si es nulo usr vale "" y en el if 
    // Se valida si usr es "" para saber si se está tratando de acceder a la página por la url 
       HttpSession nSesion= request.getSession();
     String usr= nSesion.getAttribute("Valido")!=null ? nSesion.getAttribute("Usuario").toString() : "";
     //String tipoSesion=request.getAttribute("TipoUsr").toString();
     if(usr.equals(""))
     {
         response.sendRedirect("../login.html");
     }
    
%>
<!DOCTYPE html>
<html>
    <head>
	<title>GeometryDrawtechBlog</title>
        <link rel="icon" type="image/png" href="imgs/icono.ico"/>
        <link href="../css/principal.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <script src="../css/material.min.js" type="text/javascript"></script>
    <link href="../css/material.min.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <div id="todo">
            <div id="txt">
                <center>
                    <br/><br/><txt>
                        <h1>Descarga aqu&iacute; la aplicaci&oacute;n local.</h1>
                        <a href="../imgs/DRAWTECH.zip" download="DRAWTECH.zip">
                            <img src="../imgs/fondo.jpg" id="fondo"/>
                        </a>    
                        <br/><br/><br/><br/>
                        Click en la imagen para iniciar la descarga de la aplicaci&oacute;n.<br/><br/><br/><br/>
                    </txt> 
                    <br/>
                </center>
            </div>
        </div>
    </body>
</html>
