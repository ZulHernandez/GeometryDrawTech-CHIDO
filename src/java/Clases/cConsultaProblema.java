/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Clases;

import java.sql.ResultSet;

/**
 *
 * @author Saul
 */
public class cConsultaProblema {
    
    String _Error;
    
    public cConsultaProblema()
    {
        _Error="";
    }

    public String getError() {
        return _Error;
    }
    public String [][] todo()
    {
        ResultSet todo=null;
        String dat [][]= new String [6][1];
        BD.cDatos sql= new BD.cDatos("user1","4","jdbc:mysql://localhost:3306/GDLocal","com.mysql.jdbc.Driver");
        try
        {
            sql.conectar();
            todo=sql.consulta("call sp_Todo();");
            sql.cierraConexion();
        }
        catch(Exception e)
        {
            _Error=e.getMessage();
        }
        for(int i=0;i<5;i++)
        {
            try
            {
                todo.relative(1);
                todo.relative(i+1);                           
                dat[i][0]=todo.getString("nombreProblema").toString();
                dat[i][1]=todo.getString("numConsultas").toString();
            }catch(Exception e)
            {
                System.out.println(e.getMessage());
            }
        }
        return dat;
    }
    /*public ResultSet [] obtenerDatosGrafic(int largoArr)
    {
        ResultSet datos[] = new ResultSet [largoArr];
        for(int i=0;i<largoArr;i++)
        {
            datos[i]=traerConsultas(i);
        }
        return datos;
    }*/
    public int totalRegistros()
    {
        ResultSet rsTotal=null;
        int registro=0;
        BD.cDatos sql= new BD.cDatos("user1","4","jdbc:mysql://localhost:3306/GDLocal","com.mysql.jdbc.Driver");
        try
        {
            sql.conectar();
            rsTotal=sql.consulta("call sp_TraerTotalRegistros();");
            if(rsTotal.next())
            {
                registro=Integer.parseInt(rsTotal.getString("Total"));
            }
           sql.cierraConexion();
        }
        catch(Exception e)
        {
            _Error=e.getMessage();
        }
        return registro;
    }
    public String [][] traerConsultas(int ide)
    {
        ResultSet rsConsult= null;
        String dato [][]=new String [1][3];
        BD.cDatos sql= new BD.cDatos("root","n0m3l0","jdbc:mysql://localhost:3306/GDLocal","com.mysql.jdbc.Driver");
        try
        {
           sql.conectar();
           rsConsult= sql.consulta("call sp_TraeConsultas("+ide+");");
           if(rsConsult.next())
           {
               dato[0][0]=rsConsult.getString("Nombre").toString();
               dato[0][1]=rsConsult.getString("Visitas").toString();
               dato[0][2]=rsConsult.getString("Descripcion").toString();
           }
           sql.cierraConexion();
        }
        catch(Exception e)
        {
            _Error=e.getMessage();
        }
        return dato;
    }
    public int raerConsultas(int ide)
    {
        int visitas=0;
        ResultSet rsConsult= null;
        BD.cDatos sql= new BD.cDatos("root","n0m3l0","jdbc:mysql://localhost:3306/GDLocal","com.mysql.jdbc.Driver");
        try
        {
            sql.conectar();
           rsConsult= sql.consulta("call sp_TraeConsultas("+ide+");");
           if(rsConsult.next())
           {
               visitas=Integer.parseInt(rsConsult.getString("Visitas"));
           }
           sql.cierraConexion();
        }
        catch(Exception e)
        {
            _Error=e.getMessage();
        }
        return visitas;
    }
    
    //Metodo desde la aplicación local
    public String aumentaConsulta(int ide)
    {
       String estado="";
        ResultSet rsAumenta=null;
        BD.cDatos sql=new BD.cDatos("user1","4","jdbc:mysql://localhost:3306/GDLocal","com.mysql.jdbc.Driver");
        try
        {
            sql.conectar();
            rsAumenta=sql.consulta("call sp_AgregaConsulta("+ide+");");
            if(rsAumenta.next())
            {
                estado=rsAumenta.getString("Regreso");
            }
            sql.cierraConexion();
        }
        catch(Exception e)
        {
            _Error=e.getMessage();
        }
        return estado;
    }
    
    public String [][] mayorConsulta(String data [][],int largo)
    {
        int mayor=0;
        int num=0;
        int todosCero=0;
        String mayores="";
        String may [][]= new String [1][2];
        for(int i=0;i<largo;i++)
        {
            if(Integer.parseInt(data[i][1])==mayor)
            {
                mayores+=","+data[i][0];
                num=i;
                mayor=Integer.parseInt(data[i][1]);
            }
            else
                if(Integer.parseInt(data[i][1])>mayor)
            {
                mayores=data[i][0];
                mayor=Integer.parseInt(data[i][1]);
                num=i;
            }
            todosCero+=Integer.parseInt(data[i][1]);
        }
        if(todosCero==0)
            mayores="No hay consultas";
        may[0][0]=mayores;
       // may[0][0]=data[num][0];
        may[0][1]=data[num][1];
        return may;
    }
    public String [][] menorConsulta(String data [][],int largo)
    {
        int menor=Integer.parseInt(data[0][1]);
        int num=0;
        int todosCero=0;
        String menores="";
        String men[][]=new String [1][2];
        for(int i=0;i<largo;i++)
        {
            if(Integer.parseInt(data[i][1])==menor)
            {
                menores+=","+data[i][0];
                num=i;
                menor=Integer.parseInt(data[i][1]);
            }
            else
            if(Integer.parseInt(data[i][1])< menor)
            {
                menores=data[i][0];
                menor=Integer.parseInt(data[i][1]);
                num=i;
            }
            todosCero+=Integer.parseInt(data[i][1]);
        }
        if(todosCero==0)
            menores="No hay consultas";
        men[0][0]=menores;
        //men[0][0]=data[num][0];
        men[0][1]=data[num][1];
        return men;
    }
}
