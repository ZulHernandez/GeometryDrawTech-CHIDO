/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.URL;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author Alpine
 */
@WebServlet(name = "modificaDatos", urlPatterns = {"/modificaDatos"})
@MultipartConfig
public class modificaDatos extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet modificaDatos</title>");   
            out.println("<link href='css/sweetalert-master/dist/sweetalert.css' rel='stylesheet' type='text/css'/>" );
            out.println("<script src='css/sweetalert-master/dist/sweetalert.min.js' type='text/javascript'></script>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet modificaDatos at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        out.println("<html>"
                + "<head>"
                + "<title>.:ServletRecibeDatos:.</title>"
                +"<link href=\"css/sweetalert-master/dist/sweetalert.css\" rel=\"stylesheet\" type=\"text/css\"/>" 
                +"<script src=\"css/sweetalert-master/dist/sweetalert.min.js\" type=\"text/javascript\"></script>"
                + "</head>"
                + "<body style='"
                + "background-color: RGB(31,89,120);"
                + "color: white;"
                
                + "padding: 25px 55px;"
                + "text-transform: uppercase;"
                + "font-family: arial;"
                + "'>");        
        BD.cDatos sql = new BD.cDatos();
        URL rutaca = recibeDatos.class.getProtectionDomain().getCodeSource().getLocation(); // traigo dirreccion
        System.out.println(rutaca);
        String rutama = rutaca.toString();
        String newruta = rutama.substring(6,rutama.length());
        System.out.println(newruta);
        String newnewruta = newruta.substring(0,newruta.length()-42);
        System.out.println(newnewruta);
        String absolute = newnewruta.replace("%20"," ");
        System.out.println(absolute);
        String archivo = "";
        String usuario = "";
        String rutaimagen = "";
        archivo = request.getParameter("archivo") == null ? "" : request.getParameter("archivo");
        usuario = request.getParameter("idUsuario") == null ? "" : request.getParameter("idUsuario");
        Part imagen = request.getPart("fotoUsr");
        if(!imagen.getContentType().equals("application/octet-stream")){
            InputStream isimagen = imagen.getInputStream();
            File destinoimagen = new File(absolute+"\\imagenusuario");
            if(!destinoimagen.exists()){
                destinoimagen.mkdirs();
            }
            File[] ficherosimagen = destinoimagen.listFiles();
            int numimagen = ficherosimagen.length + 1;
            System.out.println(ficherosimagen.length);
            File fimagen = new File(destinoimagen+"\\foto"+numimagen);
            String xrutaimagen = "imagenusuario\\foto"+numimagen;
            rutaimagen = xrutaimagen.replace("\\","\\\\");
            FileOutputStream outimagen = new FileOutputStream(fimagen);
            int dataimagen = isimagen.read();
            while(dataimagen != -1){
                outimagen.write(dataimagen);
                dataimagen = isimagen.read();
            }
            isimagen.close();
            outimagen.close();
        }
        if(archivo != ""){
            if(usuario != ""){
                try{
                    sql.conectar();
                    ResultSet gatito = sql.consulta("call sp_modificaFoto('"+usuario+"','"+rutaimagen+"')");
                    if(gatito.next()){
                        //out.println("<p>Mensaje de la pagina: " + gatito.getString("msj")+"</p>");
                        out.println("<script>swal({title: 'EXITO',text: '"+gatito.getString("msj")+"',type: 'success',showConfirmButton: false,timer: 2000, html: false},function(){window.location='BLOG.jsp?taches=1'});</script>");
                    }
                }catch(Exception e){
                    out.println(e);
                }
            }else{
                //out.println("<p>ERROR: usuario no especificado");
                out.println("<script>swal({title: '¡Error!',text: 'Uusario no especificado',type: 'error',showConfirmButton: false,timer: 2000, html: false});</script>");
                
            }
        }else{
           // out.println("<p>ERROR: nombre vacio");
           out.println("<script>swal({title: '¡Error!',text: 'Nombre vacío',type: 'error',showConfirmButton: false,timer: 2000, html: false});</script>");
        }
        out.println("</body></html>");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
