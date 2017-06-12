<%-- 
    Document   : menu
    Created on : 18/04/2016, 06:18:13 PM
    Author     : Saul
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>
<%
    HttpSession nSesion = request.getSession();
    //String usr=request.getAttribute("Valido")== null ? "" : nSesion.getAttribute("Usuario").toString();
    String usr = nSesion.getAttribute("Valido") == null ? "" : nSesion.getAttribute("Usuario").toString();
    String tipoSesion = "";
    int nota = 0;
    if (usr.equals("")) {
        response.sendRedirect("../login.html");
    } else {
        tipoSesion = nSesion.getAttribute("TipoUsr").toString();
    }
    String color = nSesion.getAttribute("ColorMenu").toString();

    Clases.cLogica gateito = new Clases.cLogica();
    ResultSet com = gateito.obtenComentarios();
    while (com.next()) {
        if (com.getString("estado").equals("0")) {
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
        <script Language="JavaScript">
            function blanco(i)
            {
                var largo1 = window.innerWidth;
                if (<%=tipoSesion%> == "0")
                {
                    var blog = document.getElementById("blog");
                    var desc = document.getElementById("descargas");
                    var graf = document.getElementById("grafica");
                    var gale = document.getElementById("galeria");
                    var post = document.getElementById("postear");
                    var band = document.getElementById("bandeja");
                    var conf = document.getElementById("configuracion");
                    var sali = document.getElementById("salir");

                    if (largo1 < 135)
                    {
                        switch (i)
                        {
                            case 1:
                                blog.innerHTML = "<img src='../imgs/iconos/blogN.png' style='width:40px; padding-top:1px;'/>";
                                break;
                            case 2:
                                desc.innerHTML = "<img src='../imgs/iconos/downN.png' style='width:40px; padding-top:1px;'/>";
                                break;
                            case 3:
                                graf.innerHTML = "<img src='../imgs/iconos/grafN.png' style='width:40px; padding-top:1px;'/>";
                                break;
                            case 4:
                                gale.innerHTML = "<img src='../imgs/iconos/galeN.png' style='width:40px; padding-top:1px;'/>";
                                break
                            case 5:
                                post.innerHTML = "<img src='../imgs/iconos/postN.png' style='width:40px; padding-top:1px;'/>";
                                break;
                            case 6:
                                band.innerHTML = "<img src='../imgs/iconos/bandN.png' style='width:40px; padding-top:1px;'/>";
                                break;
                            case 7:
                                conf.innerHTML = "<img src='../imgs/iconos/confN.png' style='width:40px; padding-top:1px;'/>";
                                break;
                            case 8:
                                sali.innerHTML = "<img src='../imgs/iconos/salN.png' style='width:40px; padding-top:1px;'/>";
                                break;
                        }

                    }
                } else
                {
                    var blog = document.getElementById("blog");
                    var desc = document.getElementById("descargas");
                    var graf = document.getElementById("grafica");
                    var gale = document.getElementById("galeria");
                    var sali = document.getElementById("salir");

                    if (largo1 < 135)
                    {
                        switch (i)
                        {
                            case 1:
                                blog.innerHTML = "<img src='../imgs/iconos/blogN.png' style='width:40px; padding-top:1px;'/>";
                                break;
                            case 2:
                                desc.innerHTML = "<img src='../imgs/iconos/downN.png' style='width:40px; padding-top:1px;'/>";
                                break;
                            case 3:
                                graf.innerHTML = "<img src='../imgs/iconos/grafN.png' style='width:40px; padding-top:1px;'/>";
                                break;
                            case 4:
                                gale.innerHTML = "<img src='../imgs/iconos/galeN.png' style='width:40px; padding-top:1px;'/>";
                                break
                            case 8:
                                sali.innerHTML = "<img src='../imgs/iconos/salN.png' style='width:40px; padding-top:1px;'/>";
                                break;
                        }

                    }

                }
            }


            window.onload = function ()
            {
                if (<%=tipoSesion%> == "0")
                {
                    var largo1 = window.innerWidth;
                    var blog = document.getElementById("blog");
                    var desc = document.getElementById("descargas");
                    var graf = document.getElementById("grafica");
                    var gale = document.getElementById("galeria");
                    var post = document.getElementById("postear");
                    var band = document.getElementById("bandeja");
                    var conf = document.getElementById("configuracion");
                    var sali = document.getElementById("salir");

                    if (largo1 < 135)
                    {
                        blog.innerHTML = "<img src='../imgs/iconos/blogB.png' style='width:40px; padding-top:1px;'/>";
                        desc.innerHTML = "<img src='../imgs/iconos/downB.png' style='width:40px; padding-top:1px;'/>";
                        graf.innerHTML = "<img src='../imgs/iconos/grafB.png' style='width:40px; padding-top:1px;'/>";
                        gale.innerHTML = "<img src='../imgs/iconos/galeB.png' style='width:40px; padding-top:1px;'/>";
                        post.innerHTML = "<img src='../imgs/iconos/postB.png' style='width:40px; padding-top:1px;'/>";
                        band.innerHTML = "<img src='../imgs/iconos/bandB.png' style='width:40px; padding-top:1px;'/>";
                        conf.innerHTML = "<img src='../imgs/iconos/confB.png' style='width:40px; padding-top:1px;'/>";
                        sali.innerHTML = "<img src='../imgs/iconos/salB.png' style='width:40px; padding-top:1px;'/>";

                    } else
                    {
                        blog.innerHTML = "&laquo;Blog&raquo;";
                        desc.innerHTML = "&laquo;Descargas&raquo;";
                        graf.innerHTML = "&laquo;Gr&aacute;fica&raquo;";
                        gale.innerHTML = "&laquo;Galeria&raquo;";
                        post.innerHTML = "&laquo;Postear&raquo;";
                        band.innerHTML = "&laquo;Bandeja de Entrada&raquo;";
                        conf.innerHTML = "&laquo;Configuraci&oacute;n&raquo;";
                        sali.innerHTML = "&laquo;SALIR&raquo;";
                    }
                } else
                {
                    var largo1 = window.innerWidth;
                    var blog = document.getElementById("blog");
                    var desc = document.getElementById("descargas");
                    var graf = document.getElementById("grafica");
                    var gale = document.getElementById("galeria");
                    var sali = document.getElementById("salir");

                    if (largo1 < 135)
                    {
                        blog.innerHTML = "<img src='../imgs/iconos/blogB.png' style='width:40px; padding-top:1px;'/>";
                        desc.innerHTML = "<img src='../imgs/iconos/downB.png' style='width:40px; padding-top:1px;'/>";
                        graf.innerHTML = "<img src='../imgs/iconos/grafB.png' style='width:40px; padding-top:1px;'/>";
                        gale.innerHTML = "<img src='../imgs/iconos/galeB.png' style='width:40px; padding-top:1px;'/>";
                        conf.innerHTML = "<img src='../imgs/iconos/confB.png' style='width:40px; padding-top:1px;'/>";

                    } else
                    {
                        blog.innerHTML = "&laquo;Blog&raquo;";
                        desc.innerHTML = "&laquo;Descargas&raquo;";
                        graf.innerHTML = "&laquo;Gr&aacute;fica&raquo;";
                        gale.innerHTML = "&laquo;Galeria&raquo;";
                        sali.innerHTML = "&laquo;SALIR&raquo;";
                    }
                }
            }

            window.onresize = function ()
            {
                if (<%=tipoSesion%> == "0")
                {
                    var largo1 = window.innerWidth;
                    var blog = document.getElementById("blog");
                    var desc = document.getElementById("descargas");
                    var graf = document.getElementById("grafica");
                    var gale = document.getElementById("galeria");
                    var post = document.getElementById("postear");
                    var band = document.getElementById("bandeja");
                    var conf = document.getElementById("configuracion");
                    var sali = document.getElementById("salir");

                    if (largo1 < 135)
                    {
                        blog.innerHTML = "<img src='../imgs/iconos/blogB.png' style='width:40px; padding-top:1px;'/>";
                        desc.innerHTML = "<img src='../imgs/iconos/downB.png' style='width:40px; padding-top:1px;'/>";
                        graf.innerHTML = "<img src='../imgs/iconos/grafB.png' style='width:40px; padding-top:1px;'/>";
                        gale.innerHTML = "<img src='../imgs/iconos/galeB.png' style='width:40px; padding-top:1px;'/>";
                        post.innerHTML = "<img src='../imgs/iconos/postB.png' style='width:40px; padding-top:1px;'/>";
                        band.innerHTML = "<img src='../imgs/iconos/bandB.png' style='width:40px; padding-top:1px;'/>";
                        conf.innerHTML = "<img src='../imgs/iconos/confB.png' style='width:40px; padding-top:1px;'/>";
                        sali.innerHTML = "<img src='../imgs/iconos/salB.png' style='width:40px; padding-top:1px;'/>";

                    } else
                    {
                        blog.innerHTML = "&laquo;Blog&raquo;";
                        desc.innerHTML = "&laquo;Descargas&raquo;";
                        graf.innerHTML = "&laquo;Gr&aacute;fica&raquo;";
                        gale.innerHTML = "&laquo;Galeria&raquo;";
                        post.innerHTML = "&laquo;Postear&raquo;";
                        band.innerHTML = "&laquo;Bandeja de Entrada&raquo;";
                        conf.innerHTML = "&laquo;Configuraci&oacute;n&raquo;";
                        sali.innerHTML = "&laquo;SALIR&raquo;";
                    }
                } else
                {
                    var largo1 = window.innerWidth;
                    var blog = document.getElementById("blog");
                    var desc = document.getElementById("descargas");
                    var graf = document.getElementById("grafica");
                    var gale = document.getElementById("galeria");
                    var sali = document.getElementById("salir");

                    if (largo1 < 135)
                    {
                        blog.innerHTML = "<img src='../imgs/iconos/blogB.png' style='width:40px; padding-top:1px;'/>";
                        desc.innerHTML = "<img src='../imgs/iconos/downB.png' style='width:40px; padding-top:1px;'/>";
                        graf.innerHTML = "<img src='../imgs/iconos/grafB.png' style='width:40px; padding-top:1px;'/>";
                        gale.innerHTML = "<img src='../imgs/iconos/galeB.png' style='width:40px; padding-top:1px;'/>";
                        conf.innerHTML = "<img src='../imgs/iconos/confB.png' style='width:40px; padding-top:1px;'/>";

                    } else
                    {
                        blog.innerHTML = "&laquo;Blog&raquo;";
                        desc.innerHTML = "&laquo;Descargas&raquo;";
                        graf.innerHTML = "&laquo;Gr&aacute;fica&raquo;";
                        gale.innerHTML = "&laquo;Galeria&raquo;";
                        sali.innerHTML = "&laquo;SALIR&raquo;";
                    }
                }
            }

            function out()
            {
                if (<%=tipoSesion%> == "0")
                {
                    var largo1 = window.innerWidth;
                    var blog = document.getElementById("blog");
                    var desc = document.getElementById("descargas");
                    var graf = document.getElementById("grafica");
                    var gale = document.getElementById("galeria");
                    var post = document.getElementById("postear");
                    var band = document.getElementById("bandeja");
                    var conf = document.getElementById("configuracion");
                    var sali = document.getElementById("salir");

                    if (largo1 < 135)
                    {
                        blog.innerHTML = "<img src='../imgs/iconos/blogB.png' style='width:40px; padding-top:1px;'/>";
                        desc.innerHTML = "<img src='../imgs/iconos/downB.png' style='width:40px; padding-top:1px;'/>";
                        graf.innerHTML = "<img src='../imgs/iconos/grafB.png' style='width:40px; padding-top:1px;'/>";
                        gale.innerHTML = "<img src='../imgs/iconos/galeB.png' style='width:40px; padding-top:1px;'/>";
                        post.innerHTML = "<img src='../imgs/iconos/postB.png' style='width:40px; padding-top:1px;'/>";
                        band.innerHTML = "<img src='../imgs/iconos/bandB.png' style='width:40px; padding-top:1px;'/>";
                        conf.innerHTML = "<img src='../imgs/iconos/confB.png' style='width:40px; padding-top:1px;'/>";
                        sali.innerHTML = "<img src='../imgs/iconos/salB.png' style='width:40px; padding-top:1px;'/>";
                    } else
                    {
                        blog.innerHTML = "&laquo;Blog&raquo;";
                        desc.innerHTML = "&laquo;Descargas&raquo;";
                        graf.innerHTML = "&laquo;Gr&aacute;fica&raquo;";
                        gale.innerHTML = "&laquo;Galeria&raquo;";
                        post.innerHTML = "&laquo;Postear&raquo;";
                        band.innerHTML = "&laquo;Bandeja de Entrada&raquo;";
                        conf.innerHTML = "&laquo;Configuraci&oacute;n&raquo;";
                        sali.innerHTML = "&laquo;SALIR&raquo;";
                    }

                } else
                {
                    var largo1 = window.innerWidth;
                    var blog = document.getElementById("blog");
                    var desc = document.getElementById("descargas");
                    var graf = document.getElementById("grafica");
                    var gale = document.getElementById("galeria");
                    var sali = document.getElementById("salir");

                    if (largo1 < 135)
                    {
                        blog.innerHTML = "<img src='../imgs/iconos/blogB.png' style='width:40px; padding-top:1px;'/>";
                        desc.innerHTML = "<img src='../imgs/iconos/downB.png' style='width:40px; padding-top:1px;'/>";
                        graf.innerHTML = "<img src='../imgs/iconos/grafB.png' style='width:40px; padding-top:1px;'/>";
                        gale.innerHTML = "<img src='../imgs/iconos/galeB.png' style='width:40px; padding-top:1px;'/>";
                        sali.innerHTML = "<img src='../imgs/iconos/salB.png' style='width:40px; padding-top:1px;'/>";
                    } else
                    {
                        blog.innerHTML = "&laquo;Blog&raquo;";
                        desc.innerHTML = "&laquo;Descargas&raquo;";
                        graf.innerHTML = "&laquo;Gr&aacute;fica&raquo;";
                        gale.innerHTML = "&laquo;Galeria&raquo;";
                        sali.innerHTML = "&laquo;SALIR&raquo;";
                    }
                }
            }
        </script>
    </head>
    <body>
        <style>
            body
            {
                -webkit-box-shadow: inset 0px 18px 42px -6px rgba(0,0,0,0.32);
                -moz-box-shadow: inset 0px 18px 42px -6px rgba(0,0,0,0.32);
                box-shadow: inset 0px 18px 42px -6px rgba(0,0,0,0.32);
                background-color:black;
            }
        </style>
        <div id="container">
            <% if (tipoSesion.equals("0")) {
            %>
            <br/><hr>
            <a href="../BLOG.jsp?taches=1" target="body"><button id="visual" onmouseout="out();" onmouseover="blanco(1);"><span id="blog"></span></button></a>
            <br/><br/>
            <a href="Principal.jsp" target="body"><button id="visual" onmouseout="out();" onmouseover="blanco(2);"><span id="descargas"></span></button></a>
            <br/><br/>
            <a href="grafica.jsp" target="body"><button id="visual" onmouseout="out();" onmouseover="blanco(3);"><span id="grafica"></span></button></a>
            <br/><br/>
            <a href="galeria.jsp" target="body"><button id="visual" onmouseout="out();" onmouseover="blanco(4);"><span id="galeria"></span></button></a>
            <br/><hr>
            <a href="../postear.jsp" target="body"><button id="entradas" onmouseout="out();" onmouseover="blanco(5);"><span id="postear"></span></button></a>
            <br/><br/>
            <a href="../bandeja.jsp" target="body"><button id="entradas" onmouseout="out();" onmouseover="blanco(6);"><span id="nota" class="mdl-badge" data-badge="<%=nota%>"></span><font size="1"><span id="bandeja"></span></button></a>
            <br/><hr>
            <a href="configuracion.jsp" target="body"><button id="confi" onmouseout="out();" onmouseover="blanco(7);"><font size="1"><span id="configuracion"></span></font></button></a>
            <br/><hr>
            <a href="salida.jsp" target="_top"><button id="cerrar" onmouseout="out();" onmouseover="blanco(8);"><span id="salir"></span></button></a>
            <br/><hr><br/>
            <%
            } else {
            %>
            <br/><br/>
            <a href="../BLOG.jsp" target="body"><button id="confi" onmouseout="out();" onmouseover="blanco(1);"><span id="blog"></span></button></a>
            <br/><hr>
            <a href="galeria.jsp" target="body"><button id="confi" onmouseout="out();" onmouseover="blanco(4);"><span id="galeria"></span></button></a>
            <br/><hr>
            <a href="Principal.jsp" target="body"><button id="confi" onmouseout="out();" onmouseover="blanco(2);"><span id="descargas"></span></button></a>
            <br/><br/>
            <a href="grafica.jsp" target="body"><button id="confi" onmouseout="out();" onmouseover="blanco(3);"><span id="grafica"></span></button></a>
            <link href="../css/menu.css" rel="stylesheet" type="text/css"/>
            <br/><br/>
            <a href="salida.jsp" target="_top"><button id="cerrar" onmouseout="out();" onmouseover="blanco(8);"><span id="salir"></span></button></a>
                    <%
                        }
                    %>
        </div>
    </body>
</html>

