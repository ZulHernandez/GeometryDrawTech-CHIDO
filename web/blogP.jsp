<%-- 
    Document   : blog
    Created on : 18/04/2016, 05:42:48 PM
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
         response.sendRedirect("login.html");
     }
        String url=nSesion.getAttribute("TipoUsr").toString().equals("0")? "BLOG.jsp?taches=1" : "BLOG.jsp";
%>
<html>
<head>
	<title>GeometryDrawtechBlog</title>
        <link rel="icon" type="image/png" href="imgs/icono.ico"/>
        <script Language="JavaScript">
            window.onload = function () 
            {
                if (typeof history.pushState === "function") {
                    history.pushState("jibberish", null, null);
                    window.onpopstate = function () {
                        history.pushState('newjibberish', null, null);
                        // Handle the back (or forward) buttons here
                        // Will NOT handle refresh, use onbeforeunload for this.
                    };
                }
                else {
                    var ignoreHashChange = true;
                    window.onhashchange = function () {
                        if (!ignoreHashChange) {
                            ignoreHashChange = true;
                            window.location.hash = Math.random();
                            // Detect and redirect change here
                            // Works in older FF and IE9
                            // * it does mess with your hash symbol (anchor?) pound sign
                            // delimiter on the end of the URL
                        }
                        else {
                            ignoreHashChange = false;   
                        }
                    };
                }
            }
            window.onload = function ()
            {
                var largo1 = window.innerWidth;
                var coluis = document.getElementById("hola");
                
                if (largo1 > 975)
                {
                    coluis.cols = "135px,*%";  
                } else
                {
                    coluis.cols = "65px,*%";
                }
            }
            window.onresize = function ()
            {
                var largo1 = window.innerWidth;
                var coluis = document.getElementById("hola");
                
                if (largo1 > 975)
                {
                    coluis.cols = "135px,*%";  
                } else
                {
                    coluis.cols = "65px,*%";
                }
            }
        </script>
        <style>
            #hola
            {
                -webkit-transition:all .2s ease; /* Safari y Chrome */
                -moz-transition:all .2s ease; /* Firefox */
                -o-transition:all .2s ease; /* IE 9 */
                -ms-transition:all .2s ease; /* Opera */
            }
        </style>
</head>
	<frameset noresize rows="60px,*%" frameborder="0">
		<frame src="frames/head.jsp" frameborder="0"  name="head">
		<frameset id="hola" cols="135px,*%" frameborder="0">
			<frame src="frames/menu.jsp" frameborder="0" name="menu">
			<frame src="<%=url%>" frameborder="0" name="body" scrolling="yes">
		</frameset>
	</frameset>
</html>
