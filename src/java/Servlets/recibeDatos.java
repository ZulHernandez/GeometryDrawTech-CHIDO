package Servlets;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.URL;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
/**
 *
 * @author Daniel Castillo
 */
@WebServlet(urlPatterns = {"/recibeDatos"})
@MultipartConfig
public class recibeDatos extends HttpServlet {

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
            out.println("<title>Servlet recibeDatos</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet recibeDatos at " + request.getContextPath() + "</h1>");
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
                + "</head>"
                +"<link href=\"css/sweetalert-master/dist/sweetalert.css\" rel=\"stylesheet\" type=\"text/css\"/>" 
                +"<script src=\"css/sweetalert-master/dist/sweetalert.min.js\" type=\"text/javascript\"></script>"
                + "<body style= '"
                + "background-color: black;'>");        
        BD.cDatos sql = new BD.cDatos();
        String contenido = "";
        String autor = "";
        String rutaimagen = "";
        String rutaaudio = "";
        String tipo = "";
        String padre = "";
        String estado = "";
        URL rutaca = recibeDatos.class.getProtectionDomain().getCodeSource().getLocation(); // traigo dirreccion
       // System.out.println(rutaca);
        String rutama = rutaca.toString();
        String newruta = rutama.substring(6,rutama.length());
      //  System.out.println(newruta);
        String newnewruta = newruta.substring(0,newruta.length()-42);
      // System.out.println(newnewruta);
        String absolute = newnewruta.replace("%20"," ");
       // System.out.println(absolute);
        contenido = request.getParameter("contenido") != null ? request.getParameter("contenido") : "";
        tipo = request.getParameter("tipo") != null ? request.getParameter("tipo") : "";
        padre = request.getParameter("padre") != null ? request.getParameter("padre") : "";
        estado = request.getParameter("estado") != null ? request.getParameter("estado") : "";
        if(request.getParameter("autor") != null){
            autor = request.getParameter("autor");
        }
        Part imagen = request.getPart("imagen");
        if(!imagen.getContentType().equals("application/octet-stream")){
            String oculto1 = request.getParameter("oculto1");
            InputStream isimagen = imagen.getInputStream();
            File destinoimagen = new File(absolute+"\\imagenpost");
            //System.out.println(destinoimagen);
            if(!destinoimagen.exists()){
                destinoimagen.mkdirs();
            }
            File[] ficherosimagen = destinoimagen.listFiles();
            int numimagen = ficherosimagen.length + 1;
            //System.out.println(ficherosimagen.length);
            File fimagen = new File(destinoimagen+"\\imagen"+numimagen+"-"+oculto1);
            //System.out.println(fimagen);
            String xrutaimagen = "imagenpost\\imagen"+numimagen+"-"+oculto1;
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
        Part audio = request.getPart("audio");
        if(!audio.getContentType().equals("application/octet-stream")){
            String oculto2 = request.getParameter("oculto2");
            InputStream isaudio = audio.getInputStream();
            File destinoaudio = new File(absolute+"\\audiopost");
            if(!destinoaudio.exists()){
                destinoaudio.mkdirs();
            }        
            File[] ficherosaudio = destinoaudio.listFiles();
            int numaudio = ficherosaudio.length + 1;
            File faudio = new File(destinoaudio+"\\audio"+numaudio+"-"+oculto2);
            String xrutaaudio = "audiopost\\audio"+numaudio+"-"+oculto2;
            rutaaudio = xrutaaudio.replace("\\","\\\\");
            FileOutputStream outaudio = new FileOutputStream(faudio);
            int dataaudio = isaudio.read();
            while(dataaudio != -1){
                outaudio.write(dataaudio);
                dataaudio = isaudio.read();
            }
            isaudio.close();
            outaudio.close();
        }
        if(contenido != ""){
            if(autor != ""){
                try{
                    sql.conectar();
                   // ResultSet gatito = sql.consulta("call sp_registraParte('"+contenido+"','FelisaSS','"+rutaimagen+"','"+rutaaudio+"','"+tipo+"','"+padre+"','"+estado+"');");
                    ResultSet gatito = sql.consulta("call sp_registraParte('"+contenido+"','"+autor+"','"+rutaimagen+"','"+rutaaudio+"','"+tipo+"','"+padre+"','"+estado+"');");
                    if(gatito.next()){
                        out.println("<script>swal({title: 'EXITO',text: '"+gatito.getString("msj")+"',type: 'success',showConfirmButton: false,timer: 2000, html: false},function(){window.location='"+gatito.getString("url")+"'});</script>");
                    }
                   sql.cierraConexion(); 
                }catch (Exception e){
                    out.println("<script>swal({title: 'ERROR',text: \""+e.getMessage()+"\",type: 'success',showConfirmButton: true, html: false},function(){window.location='BLOG.jsp'});</script>");
                }
                finally{
                    try{
                  sql.cierraConexion(); 
                    }catch(Exception e)
                    {
                        
                    }
                }
              
            }else{
                out.println("<p><script>swal({title: 'Opss...',text: 'Autor Vacio',type: 'error',showConfirmButton: false,timer: 3000, html: false,allowEscapeKey:false},function(){window.location='BLOG.jsp'});</script>");
            }
        }else{
            out.println("<p><script>swal({title: 'Opss...',text: 'Contenido Vacio',type: 'error',showConfirmButton: false,timer: 3000, html: false,allowEscapeKey:false},function(){window.location='BLOG.jsp'});</script>");
        }
        //out.println("Redirigiendo a la pagina de confirmacion...");
        //response.sendRedirect("uploaded.html");
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
