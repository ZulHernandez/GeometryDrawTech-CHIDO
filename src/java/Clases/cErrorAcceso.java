package Clases;
import java.sql.ResultSet;
public class cErrorAcceso {    
    private String _clave;
    private String _usuario;
    private int _tipoError;
    private String err;
    public cErrorAcceso()
    {
        _clave="";
        _usuario="";
    }
    public cErrorAcceso(String clv,String usr){
        _clave=clv;
        _usuario=usr;           
    }
    public String getClave() {
        return _clave;
    }
    public void setClave(String _clave) {
        this._clave = _clave;
    }
    public String getUsuario() {
        return _usuario;
    }
    public void setUsuario(String _usuario) {
        this._usuario = _usuario;
    }
    public int getTipoError() {
        return _tipoError;
    }

    public void setTipoError(int _tipoError) {
        this._tipoError = _tipoError;
    }

    
    public boolean encontrarNumeros(String cadena){
        boolean valido=false;
        
        for(int i=0;i<cadena.length();i++)
        {
            if( cadena.codePointAt(i)>=48 && cadena.codePointAt(i)<=57 )
            {
                valido=true;
                break;
            }
        }
        
        return valido;
    }
    
    public boolean encontrarLetras(String cadena){
        boolean valido=false;
        
            for(int i=0;i<cadena.length();i++)
            {
                if( (cadena.codePointAt(i)>=65 && cadena.codePointAt(i)<=90) || (cadena.codePointAt(i)>=97 && cadena.codePointAt(i)<=122 )  )
                {
                    valido=true;
                    break;
                }
            }
        return valido;
    }
    
    public boolean encontrarEspeciales(String cadena,int tipo){
        boolean valido=false;
        //tipo 1 : validacion de tipo usuario
        //tipo 2: validacion de tipo contraseña
        for(int i=0;i<cadena.length();i++)
        {
            //Se evalua si el carácter tiene letras o números
            if( (cadena.codePointAt(i)>=48 && cadena.codePointAt(i)<=57) || (cadena.codePointAt(i)>=65 && cadena.codePointAt(i)<=90)||(cadena.codePointAt(i)>=97 && cadena.codePointAt(i)<=122) )
            {
                valido=false;
            }
            //En caso de contener otro carácter que no sean letras o números
            //Se procede a identificar si es un caracter especial permitido
            //Segun el topo de validacion requerida
            else
            {
                    if(tipo==2)
                    {
                        if( cadena.codePointAt(i)==95 || cadena.codePointAt(i)==45 || cadena.codePointAt(i)==32 )
                        {
                            valido=false;
                        }
                        else
                        {
                            valido=true;
                            break;
                        }
                    }
                    else
                    {
                        valido=true;
                        break;
                    }
                
            }
        }
        return valido;
    }
    
    public boolean validarClave(String clave){
        boolean valido=true;
            if(clave.equals(""))
            {
                valido=false;
                //tipo de erro 1 : clave vacía
                _tipoError=1;
            }
            else
            {
                if(encontrarEspeciales(clave,2))
                {
                    valido=false;
                    //tipo de error 2: clave con caracteres especiales no validos
                    _tipoError=2;
                }
            }
        return valido;
    }
    
    public boolean validarUsuario(String usu){
        boolean valido=true;
        
        if(usu.equals(""))
        {
            valido=false;
            //tipo de error 3: usuario vacío
            _tipoError=3;
        }
        else
        {
            if(encontrarEspeciales(usu,1))
            {
                valido=false;
                //tipo error 4: usuario con especiales
                _tipoError=4;
            }
        }
        return valido;
    }
      public int validarSoloUsuario(String usu){
        
        if(usu.equals(""))
        {
           // valido=false;
            //tipo de error 3: usuario vacío
            _tipoError=3;
        }
        else
        {
            if(encontrarEspeciales(usu,1))
            {
                //valido=false;
                //tipo error 4: usuario con especiales
                _tipoError=4;
            }
        }
        return _tipoError;
    }
      public int validarSoloClave(String clave){
        
            if(clave.equals(""))
            {
                //valido=false;
                //tipo de erro 1 : clave vacía
                _tipoError=1;
            }
            else
            {
                if(encontrarEspeciales(clave,2)==true)
                {
                    //valido=false;
                    //tipo de error 2: clave con caracteres especiales no validos
                    _tipoError=2;
                }
                else
                {
                   _tipoError=0;
                }
            }
        return ubicarError();
    }
     
      public int ubicarError(){
        int err=0;
        switch(getTipoError())
        {
            case 0:
                err=0;
                break;
            case 1:
                   //tipo de erro 1 : clave vacía
                err=1;
                break;
            case 2:
                err=2;
                //tipo de error 2: clave con caracteres especiales no validos
                break;
            case 3:
                 //tipo de error 3: usuario vacío
                err=3;
                break;
            case 4:
                   //tipo error 4: usuario con especiales
                err=4;
                break;
        }
        return err;
    }
    public int validarDatosAdmin(String clv,String usr){
        boolean valido=true;
        int err=0;
        if(validarClave(clv))
        {
            if(validarUsuario(usr))
                valido=true;
            else
                valido=false;
        }
        else
        {
            valido=false;
        }
        return ubicarError();
    }
    public int validarDatosUsr(String clv){
        boolean valido=false;
        int err=0;
        if(validarClave(clv))
        {
            valido=true;
        }
        else
        {
            valido=false;
        }
        return ubicarError();
    }
    /*
    public int consultarCuentaAdmin(String usr,String clave){
        int coincidencia=0;
        ResultSet rsCoincide=null;
        BD.cDatos sql= new BD.cDatos();
        try
        {
            sql.conectar();
            rsCoincide=sql.consulta("call sp_ConsultarAdmin('"+usr+"','"+clave+"')");
            if(rsCoincide.getString("Regreso").equals("Si"))
            {
                coincidencia=1;
            }
        }catch(Exception exe)
        {
            err=exe.getMessage();
        }
        
       return coincidencia; 
    }*/
  public String prueba(String usr,String clave)
  {
       ResultSet rsCoincide=null;
       boolean t=false;
       BD.cDatos sql= new BD.cDatos();
        String prueb="";
       try{
     sql.conectar();
      //prueb="call sp_ConsultarAdmin('"+usr+"','"+clave+"')";
      //t=sql.consulta(usr,clave);
       //rsCoincide.consulta("{call sp_ConsultarAdmin('"+usr+"','"+clave+"')}");
       //rsCoincide=sql.consulta("{call sp_ConsultarAdmin("+usr+","+clave+")}");
        sql.cierraConexion();
        //prueb=sql.consulta(usr, clave);
           System.out.println(prueb);
       }
      catch(Exception e)
       {
           err=e.getMessage();
       }
     
      return prueb;
  }
  
  public boolean validarBase(String usuario , String clave,int tipo)
  {
      boolean valido=false;
      ResultSet rsCoincide=null;
      BD.cDatos sql= new BD.cDatos();
      String resultadoConsulta="";
      try
      {
          sql.conectar();
          //rsCoincide=sql.consulta("call sp_ConsultarAdmin('Felisa','FelisaHF');");
         rsCoincide=sql.consulta("call sp_ConsultarAdmin('"+usuario+"','"+clave+"',"+tipo+");");
         // rsCoincide=sql.consulta("call sp_ConsultarAdmin('"+usuario+"','"+clave+"');");
        if(rsCoincide.next()){
          resultadoConsulta=rsCoincide.getString("Coincide");
          if(resultadoConsulta.equals("Correcto"))
          {
              valido=true;
          }
        }
          sql.cierraConexion();
      }catch(Exception err)
      {
          resultadoConsulta=err.getMessage();
          System.out.println(resultadoConsulta);
      }
      
      
      return valido;
      
  }
  public boolean editar(String usuario,String claveA , int tipoEdicion , String nuevoDat,int ID){
      boolean valido=false;
        ResultSet rsEdicion=null;
        BD.cDatos sql= new BD.cDatos();
        String resultadoEdicion="";
       try
       {
           
          sql.conectar();
         rsEdicion= sql.consulta("call sp_Editar('"+usuario+"','"+claveA+"',"+tipoEdicion+",'"+nuevoDat+"',"+ID+");");
         if(rsEdicion.next())
         {
             resultadoEdicion=rsEdicion.getString("Modificacion");
             if(resultadoEdicion.equals("Exitosa"))
             {
                 valido=true;
             }
         }
         sql.cierraConexion();
       }
       catch(Exception e)
       {
           resultadoEdicion=e.getMessage();
          System.out.println(resultadoEdicion);
       }
        
      return valido;
  }  
   public boolean editarAlumno(int ID,String nuevo){
      boolean valido=false;
        ResultSet rsEdicion=null;
        BD.cDatos sql= new BD.cDatos();
        String resultadoEdicion="";
       try
       {
           
          sql.conectar();
         rsEdicion= sql.consulta("call sp_EditarAl("+ID+",'"+nuevo+"');");
         if(rsEdicion.next())
         {
             resultadoEdicion=rsEdicion.getString("Modificacion");
             if(resultadoEdicion.equals("Exitosa"))
             {
                 valido=true;
             }
         }
         sql.cierraConexion();
       }
       catch(Exception e)
       {
           resultadoEdicion=e.getMessage();
          System.out.println(resultadoEdicion);
       }
        
      return valido;
  } 
  public String [] traerDatos(String Usuario) {
     
      ResultSet rsConsulta=null;
      BD.cDatos sql= new BD.cDatos();
      String datos[]= new String [2];
       try
       {
           sql.conectar();
           rsConsulta= sql.consulta("call sp_vista("+Integer.parseInt(Usuario)+");");
           if(rsConsulta.next())
           {
               datos[0]=rsConsulta.getString("Clave").substring(0,5);
               datos[1]=rsConsulta.getString("Users");
           }
           sql.cierraConexion();
       }
       catch(Exception e)
       {
           e.getMessage();
       }
      
      return datos;
  }   
}