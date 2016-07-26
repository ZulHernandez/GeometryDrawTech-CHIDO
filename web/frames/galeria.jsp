<%-- 
    Document   : galeria
    Created on : 24-may-2016, 10:00:37
    Author     : Alpine
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>
<%
    HttpSession nSesion = request.getSession();
    String usr = nSesion.getAttribute("Valido") == null ? "" : nSesion.getAttribute("Usuario").toString();

    if (usr.equals("")) {
        response.sendRedirect("../login.html");

    }
    int tipoSesion = Integer.parseInt(nSesion.getAttribute("TipoUsr").toString());
    String color = nSesion.getAttribute("Color").toString();

%>
<!DOCTYPE html>
<html>
    <head>
        <style>
            @font-face {
                font-family: "Roboto";
                src: url(../fuentes/Roboto-Regular.ttf) format("truetype");
            }
            body{
                background-color: rgb(25,25,25);
            }
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
                background: white;
            }

            ::-webkit-scrollbar-thumb:window-inactive {
                background: transparent;
            }

            #titulo
            {
                font-size: 30px;
                background-color: white;
                color: black;
            }
            #foot
            {
                text-align: center;
                font-size: 10px;
                background-color: black;
                font-family: "Roboto", verdana;
                color: white;
                width:100%;
                vertical-align: central;
            }
            td
            {
                padding: 10px;
            }
            .img
            {
                height: 112.4px;
                width: 200px;
            }
            .img:hover
            {
                cursor: pointer;
                -webkit-filter: blur(5px);
                -moz-filter: blur(5px);
                -o-filter: blur(5px);
                -ms-filter: blur(5px);
                filter: blur(5px);
                height: 122.4px;
                width: 210px;
            }
            th
            {
                font-size: 20px;
                color:white;
            }
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>galeria</title>
        <script>
            function show(link)
            {
                var lonk = "";
                var lonk = '<iframe width="80%" height="550" src="' + link + '" frameborder="0" allowfullscreen mozallowfullscreen="true" webkitallowfullscreen="true" onmousewheel="">'
                document.getElementById("frame").innerHTML = lonk;
                document.getElementById("frame").style.display = "block";
            }
        </script>
    </head>
    <body>
    <center>
        <div id="titulo">GALERIAS</div
        <br/>
        <div style="overflow-x: auto">
            <table>
                <tr>
                    <th>C&Oacute;NICAS</th>
                    <th>MODELOS</th>
                    <th>COLLAR&Iacute;N</th>
                    <th>OTROS</th>
                    <!--<th>ESCUDOS</th>-->
                </tr>
                <tr>
                    <td><img class="img" src="../imgs/conicas.png" alt="" onclick="show('https://sketchfab.com/playlists/embed?collection=8e4042ae07fd427d8d753dad0f82301a');"/></td>
                    <td><img class="img" src="../imgs/modelos.png" alt="" onclick="show('https://sketchfab.com/playlists/embed?collection=8757845302e140c18b661e64a6b46546');"/></td>
                    <td><img class="img" src="../imgs/collarin.png" alt="" onclick="show('https://sketchfab.com/playlists/embed?collection=d97b4f143f8c4ad89eb354e73e475894');"/></td>
                    <td><img class="img" src="../imgs/otros.png" alt="" onclick="show('https://sketchfab.com/playlists/embed?collection=c7c6b5ebc0bb4505bee96e64c482b3e4');"/></td>
                    <!--<td><img class="img" src="../imgs/escudos.png" alt="" onclick="show('https://sketchfab.com/playlists/embed?collection=896e1c8ec8b14ac4976586b8337ba42b');"/></td>-->
                </tr>
            </table>
        </div>
        <br/>
        <div id="frame" style="display: none"></div>
        <br/><br/>
    </center>
    <footer id="foot">
        <br/>
        Para ver más modelos dirigete al siguiente enlace:
        <br/><br/>
        <a href="https://sketchfab.com/bear59814/collections" target="_blanck"><img width="10%" id="sk" src="../imgs/sketchfab.jpg"/></a>
        <br/><br/>
    </footer>
</body>
</html>
