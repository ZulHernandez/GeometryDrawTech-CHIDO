
<%@page contentType="text/html" pageEncoding="UTF-8"  session="true"%>
<%
    HttpSession nSesion= request.getSession();
    
     String usA= nSesion.getAttribute("Valido")!=null ? nSesion.getAttribute("Usuario").toString() : "";
     //String tipoSesion=request.getAttribute("TipoUsr").toString();
     if(usA.equals(""))
     {
         response.sendRedirect("../login.html");
     } 
   //String tipoSesion=nSesion.getAttribute("TipoUsr").toString();
   //String usA="Felisa";
   int id=Integer.parseInt(nSesion.getAttribute("ID").toString());
   int idA=Integer.parseInt(nSesion.getAttribute("Alumnos").toString());
   
   String tipoSesion=nSesion.getAttribute("TipoUsr").toString();
    String campoEditado=request.getParameter("campoEditado");
   //String campoEditado="3";
    String nuevoDato=request.getParameter("nuevoDato");
    //String nuevoDato="3IM9";
    String redirec="";
    String claveA=request.getParameter("claveConfirmada");
    int tipoErr=0;
    //String claveU="";
    String scr="";
    boolean valido=false;
    
    
    Clases.cErrorAcceso valida = new Clases.cErrorAcceso();
    Clases.StringMD md= new Clases.StringMD();
    claveA=md.getStringMessageDigest(claveA,"MD5");
    valido=valida.validarBase(usA, claveA, Integer.parseInt(tipoSesion));
       //cualPagina=1;
    if(valido==false)
    {
        tipoErr=5;
        redirec="../frames/configuracion.jsp";
        
    }
    else
    {
                 //campoEditado=request.getParameter("campoEditado");
                 if(campoEditado.equals("1"))
                 {
                     redirec="../frames/configuracion.jsp";
                     // HttpSession nSesion=request.getSession();
                     //usA=nSesion.getAttribute("Usuario").toString();
                     tipoErr=valida.validarSoloUsuario(nuevoDato);
                     /*if(tipoErr==0)
                     {
                         valido=valida.editarNombre(nuevoDato);
                     }*/
                 }
                 else
                 {
                     if(campoEditado.equals("2"))
                     {
                         redirec="../frames/configuracion.jsp";
                         //claveA=request.getParameter("clave");
                         tipoErr=valida.validarSoloClave(nuevoDato);
                     }
                     else
                     {
                         if(campoEditado.equals("3"))
                         {
                             redirec="../frames/configuracion.jsp";
                             //claveU=request.getParameter("claveGral");
                             tipoErr=valida.validarSoloClave(nuevoDato);
                         }
                         else
                         {
                             if(campoEditado.equals("4")|| campoEditado.equals("5"))
                             {
                                 redirec="../frames/configuracion.jsp";
                                 tipoErr=0;
                             }
                         }
                     }
                 }

    }
                   if(campoEditado.equals("1")|| campoEditado.equals("2")|| campoEditado.equals("3")|| campoEditado.equals("4")|| campoEditado.equals("5"))
                {
                        switch(tipoErr)
                    {
                      
                        case  0: 
                            //scr="<script> alter('"+idA+",'"+id+");</script>";
                            if(campoEditado.equals("3"))
                                 valido=valida.editar(usA,claveA,Integer.parseInt(campoEditado),nuevoDato,2);                           
                            else
                                valido=valida.editar(usA,claveA,Integer.parseInt(campoEditado),nuevoDato,1);
                        
                            if(campoEditado.equals("4")|| campoEditado.equals("5"))
                            {
                                valido=true;
                                
                            }
                            if(valido==false)
                            {
                                scr="<script>swal({title: 'Opss...',text: 'Modificación Fallida',"
                                + "type: 'error',showConfirmButton: false,timer: 3000, html: false,allowEscapeKey:false},"
                                + "function(){window.location='"+redirec+"'});</script>";
                            }
                            else
                            {
                                scr="<script>swal({title: 'EXITO!!',text: 'Actualizando la información...',"
                                    + "type: 'success',showConfirmButton: false,timer: 2000, html: false,allowEscapeKey:false},"
                                    + "function(){window.location='"+redirec+"'});</script>";
                                if(campoEditado.equals("4"))
                                {
                                    nSesion.setAttribute("Color",nuevoDato);
                                }
                                else
                                {
                                    if(campoEditado.equals("5"))
                                    {
                                        nSesion.setAttribute("ColorMenu",nuevoDato);
                                        valida.editar(usA, claveA,Integer.parseInt(campoEditado), nuevoDato,id);
                                    }
                                }
                                if(Integer.parseInt(campoEditado)==1  )
                                {
                                    nSesion.setAttribute("Usuario",nuevoDato);
                                }
                            }
                            

                            break;
                        case 1:
                            scr="<script>swal({title: 'Opss...',text: 'Clave Vacia',"
                                + "type: 'error',showConfirmButton: false,timer: 3000, html: false,allowEscapeKey:false},"
                                + "function(){window.location='../frames/configuracion.jsp'});</script>";
                            break;
                        case 2:
                           scr="<script>swal({title: 'Opss...',text: 'Clave con caracteres especiales no validos',"
                                + "type: 'error',showConfirmButton: false,timer: 3000, html: false,allowEscapeKey:false},"
                                + "function(){window.location='../frames/configuracion.jsp'});</script>";
                            break;
                        case 3:
                            scr="<script>swal({title: 'Opss...',text: 'Usuario Vacio',"
                                + "type: 'error',showConfirmButton: false,timer: 3000, html: false,allowEscapeKey:false},"
                                + "function(){window.location='../frames/configuracion.jsp'});</script>";
                            break;
                        case 4:
                            scr="<script>swal({title: 'Opss...',text: 'Usuario con caracteres especiales',"
                                + "type: 'error',showConfirmButton: false,timer: 3000, html: false,allowEscapeKey:false},"
                                + "function(){window.location='../frames/configuracion.jsp'});</script>";
                            break;
                        case 5:
                           scr="<script>swal({title: 'Opss...',text: 'No tienes permiso para modificar esta información',"
                                + "type: 'error',showConfirmButton: false,timer: 3000, html: false,allowEscapeKey:false},"
                                + "function(){window.location='"+redirec+"'});</script>";
                           break;
                    }
                }
                else
                {
                   scr="<script>swal({title: 'Opss...',text: 'No hay campos que editar',"
                                + "type: 'error',showConfirmButton: false,timer: 3000, html: false,allowEscapeKey:false},"
                                + "function(){window.location='../frames/configuracion.jsp'});</script>";
                }
    
   
   
    
    
    
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="../css/sweetalert-master/dist/sweetalert.min.js" type="text/javascript"></script>
        <link href="../css/sweetalert-master/dist/sweetalert.css" rel="stylesheet" type="text/css"/>
        <title>GeometryDrawtechBlog</title>
        <link rel="icon" type="image/png" href="../imgs/icono.ico"/>
    </head>
    <body bgcolor="black">
        <%=scr%>
        <h1>Hello World!</h1>
    </body>
</html>
