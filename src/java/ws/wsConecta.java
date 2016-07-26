/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ws;

import java.sql.ResultSet;
import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;

/**
 *
 * @author Alumno
 */
@WebService(serviceName = "wsConecta")
public class wsConecta {

    /**
     * This is a sample web service operation
     */
    @WebMethod(operationName = "hello")
    public String hello(@WebParam(name = "name") String txt) {
        return "Hello " + txt + " !";
    }
    @WebMethod(operationName="aumentarConsultas")
    public String aumentarConsultas(@WebParam(name="problema")String problem)
    {
        String regreso="";
        if(!problem.equals(""))
        {
           Clases.cConsultaProblema consulta= new Clases.cConsultaProblema();
           regreso=consulta.aumentaConsulta(Integer.parseInt(problem));
        }
        else
        {
            regreso="Hola!";
        }
        return regreso;
    }
    

}
