<%-- 
    Document   : acceso
    Created on : 13/04/2016, 06:30:06 PM
    Author     : Saul
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="true" %>

<%

    //Nota : Administrador es sesion tipo 0
    //Alumno es sesion tipo 1
    String claveA="";
    String claveU="";
    String usA="";
    String tipoSesion="";
    String scr="" ;
    String scr2="";
    String redirec="";
    String colorFondo="rgb(36,131,208)";
    //String campoEditado="";
    int tipoErr=0;
    String pase="";
    boolean valido=false;
    
    
    
  
   // valido=valida.validarBase(usA, claveA);
   /* if(valido==false)
    {
        scr="<script> alert('nel') </script>";
    }
    else
    {
        scr="<script> alert('Simon') </script>";
    }*/
  //Clases.cErrorAcceso valida = new Clases.cErrorAcceso();
 // pase=valida.prueba(usA, claveA);
  //pase=scr;
  
  /* pase=valida.consultarCuentaAdmin(usA, claveA);
   if(pase==1)
   {
       scr="<script>alert('funciono')</script>";
   }
   else
   {
       scr="<script>alert('nel')</script>";
   }*/
    //int cualPagina=0;
   Clases.cErrorAcceso valida = new Clases.cErrorAcceso();
 
   
   /*if(request.getParameter("campoEditado")==null)
   {*/
            tipoSesion=request.getParameter("tipoSesion");
          //scr="<script> alert('No hay campo editado');</script>";  
             if(tipoSesion.equals("0"))
            {
                    redirec="../blogP.jsp";
                    usA=request.getParameter("userAdmin");
                    claveA=request.getParameter("pswAdmin");
                    tipoErr=valida.validarDatosAdmin(claveA,usA);
                    //Si no hay error en cuanto a el tipo de datos, el boolean valido 
                    //toma el valor de el metodo que valida con BD
                    if(tipoErr==0)
                    {
                       Clases.StringMD md= new Clases.StringMD();
                       claveA=md.getStringMessageDigest(claveA,"MD5");
                       valido=valida.validarBase(usA,claveA,Integer.parseInt(tipoSesion));
                    }


            }
            else
            {
                         redirec="../blogP.jsp";           
                          claveU=request.getParameter("userU");
                         usA="Alumno";
                          tipoErr=valida.validarDatosUsr(claveU);
                          if(tipoErr==0)
                          {
                              Clases.StringMD md= new Clases.StringMD();
                              claveU=md.getStringMessageDigest(claveU,"MD5");
                              valido=valida.validarBase(usA,claveU,Integer.parseInt(tipoSesion));

                          }


            }
   //}
   
    
  //Si campoEditado no existe , quiere decir que no se trata de hacer un cambio en los datos  
  //Si no que se está llamando a acceso.jsp desde el login 
   /*if(request.getParameter("campoEditado")==null)
   {*/
       //Se valida que la sesion sea de administrador o de usuario
            if(tipoSesion.equals("0")|| tipoSesion.equals("1"))
      {
          //Se trabaja el tipo de error que haya habido en la validación de contraseñas y usuario
              switch(tipoErr)
          {
              case 0:
                  //pase=valida.consultarCuentaAdmin(usA, claveA);
                  //Si los datos coinciden con los de la BD , entonces se da acceso al blog
                  if(valido==true)
                  {
                    scr="<script>swal({title: 'EXITO!!',text: 'Redireccionando al blog...',"
                            + "type: 'success',showConfirmButton: false,timer: 2000, html: false,allowEscapeKey:false},"
                            + "function(){window.location='"+redirec+"'});</script>";
                   HttpSession nSesion=request.getSession();
                  Clases.cLogica gatito = new Clases.cLogica();             
                  ResultSet usuario = gatito.consultaUsuario(usA,Integer.parseInt(tipoSesion));
                    usuario.next();
                    String id=usuario.getString("idUsuario");
                    if(tipoSesion.equals("0"))
                    {
                        ResultSet usuari=gatito.consultaUsuario("Alumno",1);
                            usuari.next();
                        String idA=usuari.getString("idUsuario");
                        
                        colorFondo=usuario.getString("colorFondo");
                        nSesion.setAttribute("Alumnos",idA);
                   
                    }
                    else
                    {
                        
                        
                                usA=request.getParameter("nombre");
                            
                    }
                  //Aqui se añaden los atributos de sesion , usuario , tipo de usuari y si la sesion es valida
                 
                    nSesion.setAttribute("ID",id);
                    nSesion.setAttribute("Usuario",usA);
                    nSesion.setAttribute("Valido","Si");
                    nSesion.setAttribute("TipoUsr",tipoSesion);
                    nSesion.setAttribute("Color",colorFondo);
                    nSesion.setAttribute("ColorMenu","#0f3657"); 
                 
                 
                    
                  
                  
                  
                }
                  else
                  {
                        scr="<script>swal({title: 'Opss...',text: 'Acceso Denegado',"
                            + "type: 'error',showConfirmButton: false,timer: 3000, html: false,allowEscapeKey:false},"
                            + "function(){window.location='../login.html'});</script>";
                  }
                 
                  break;
              case 1:
                    scr="<script>swal({title: 'Opss...',text: 'Clave Vacia',"
                            + "type: 'error',showConfirmButton: false,timer: 3000, html: false,allowEscapeKey:false},"
                            + "function(){window.location='../login.html'});</script>";
                    break;
              case 2:
                    scr="<script>swal({title: 'Opss...',text: 'Clave con caracteres especiales no validos',"
                            + "type: 'error',showConfirmButton: false,timer: 3000, html: false,allowEscapeKey:false},"
                            + "function(){window.location='../login.html'});</script>";
                  break;
              case 3:
                    scr="<script>swal({title: 'Opss...',text: 'Usuario vacio',"
                            + "type: 'error',showConfirmButton: false,timer: 3000, html: false,allowEscapeKey:false},"
                            + "function(){window.location='../login.html'});</script>";
                  break;
              case 4:
                    scr="<script>swal({title: 'Opss...',text: 'Usuario con caracteres especiales',"
                            + "type: 'error',showConfirmButton: false,timer: 3000, html: false,allowEscapeKey:false},"
                            + "function(){window.location='../login.html'});</script>";
                  break;
          }
      }
      else
      {
          scr="<script>swal({title: 'Opss...',text: 'Sin identificador de sesion',"
                            + "type: 'error',showConfirmButton: false,timer: 3000, html: false,allowEscapeKey:false},"
                            + "function(){window.location='../login.html'});</script>";
      }
   //}
%>
<!DOCTYPE html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>GeometryDrawtechBlog</title>
        <script src="../js/validaEditar.js" type="text/javascript " ></script>
        <script src="../css/sweetalert-master/dist/sweetalert.min.js" type="text/javascript"></script>
        <link href="../css/sweetalert-master/dist/sweetalert.css" rel="stylesheet" type="text/css"/>
        <link rel="icon" type="image/png" href="../imgs/icono.ico"/>
    </head>
    <body style=" background: url('../imgs/porpoiseGif.gif') no-repeat top center; background-attachment: fixed; background-size: 100% 100%;">
        <%= scr%>
    </body>
</html>
       
    

