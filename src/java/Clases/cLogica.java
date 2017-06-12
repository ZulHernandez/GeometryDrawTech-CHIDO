package Clases;
import java.io.File;
import java.net.URL;
import java.sql.ResultSet;

/**
 *
 * @author Daniel Castillo
 */
public class cLogica {
    public ResultSet consultaUsuario(String nom, int tipo){
        BD.cDatos sql = new BD.cDatos();
        ResultSet gatito = null;
        try{
            sql.conectar();
            gatito = sql.consulta("call sp_obtenUsuario('"+nom+"',"+tipo+");");
            //sql.cierraConexion();
        }catch(Exception e){
            System.out.println(e);
        }
        return gatito;
    }
        public ResultSet consultaUsuario(String nom, String tipo, String clave){
        BD.cDatos sql = new BD.cDatos();
        ResultSet gatito = null;
        try{
            sql.conectar();
            gatito = sql.consulta("call sp_obtenUsuarioo('"+nom+"','"+tipo+"','"+clave+"');");
            //sql.cierraConexion();
        }catch(Exception e){
            System.out.println(e);
        }
        return gatito;
    }
    public ResultSet obtenBlog(){
        BD.cDatos sql = new BD.cDatos();
        ResultSet gatito = null;
        try{
            sql.conectar();
            gatito = sql.consulta("call sp_obtenBlog()");
        }catch(Exception e){
            System.out.println(e);
        }
        return gatito;
    }
    public ResultSet obtenContenido(){
        BD.cDatos sql = new BD.cDatos();
        ResultSet gatito = null;
        try{
            sql.conectar();
            gatito = sql.consulta("call sp_obtenContenido();");
        }catch(Exception e){
            System.out.println(e);
        }
        return gatito;
    }
    public ResultSet obtenComentarios(){
        BD.cDatos sql = new BD.cDatos();
        ResultSet gatito = null;
        try{
            sql.conectar();
            gatito = sql.consulta("call sp_obtenComentarios();");
        }catch(Exception e){
            System.out.println(e);
        }
        return gatito;
    }
    public String autorizaParte(String comen){
        BD.cDatos sql = new BD.cDatos();
        ResultSet gatito = null;
        String mensaje = "lorolo";
        try{
            sql.conectar();
            gatito = sql.consulta("call sp_autorizaParte('"+comen+"');");
            if(gatito.next()){
                mensaje = gatito.getString("msj");
            }
        }catch(Exception e){
            System.out.println(e);
        }
        return mensaje;
    }
    public String eliminaParte(String comen){
        BD.cDatos sql = new BD.cDatos();
        ResultSet gatito = null;
        String mensaje = "";
        ResultSet pgatito = null;
        File rutaimagen = null;
        File rutaaudio = null;
        try{
            sql.conectar();
            URL rutaca = cLogica.class.getProtectionDomain().getCodeSource().getLocation(); // traigo dirreccion
            String rutama = rutaca.toString();
            String newruta = rutama.substring(6,rutama.length());
            String newnewruta = newruta.substring(0,newruta.length()-36);
            String absolute = newnewruta.replace("%20"," ");
            pgatito = sql.consulta("call sp_obtenContenido();");
            while(pgatito.next()){
                if(pgatito.getString("TipoCont").equals("1") && (pgatito.getString("idParte").equals(comen) || pgatito.getString("padre").equals(comen))){
                    rutaimagen = new File(absolute + "\\" + pgatito.getString("archivo"));
                    System.out.println(rutaimagen);
                    if(rutaimagen.exists()){
                        if(rutaimagen.delete()){
                           System.out.println("Archivo de la parte eliminado");
                        }else{
                            System.out.println("El archivo persiste");
                        }
                    }else{
                        System.out.println("El archivo no existe");
                    }
                }else{
                    if(pgatito.getString("TipoCont").equals("2") && (pgatito.getString("idParte").equals(comen) || pgatito.getString("padre").equals(comen))){
                        rutaaudio = new File(absolute + "\\" + pgatito.getString("archivo"));
                        System.out.println(rutaaudio);
                        if(rutaaudio.exists()){
                            if(rutaaudio.delete()){
                               System.out.println("Archivo de la parte eliminado");
                            }else{
                                System.out.println("El archivo persiste");
                            }
                        }else{
                            System.out.println("El archivo no existe");
                        }
                    }
                }
            }
            gatito = sql.consulta("call sp_eliminaParte('"+comen+"');");
            if(gatito.next()){
                mensaje = gatito.getString("msj");
            }
        }catch(Exception e){
            System.out.println(e);
        }
        return mensaje;
    }
}
  