
function refre()
{
   window.parent.frames[0].location.reload(); 
   window.parent.frames[1].location.reload();
}
function encontrarNumeros(cadena){
	var valido=false;
	for(var i=0;i<cadena.length;i++)
	{
		if(isNaN(cadena.charAt(i)))
		{
			valido=true;
		}
		else
		{
			valido=false;
			break;
		}
	};
	return valido;
}
/* function encontrarLetras(cadena){
	var valido=true;
	for(var i=0;i<cadena.length;i++)
	{
		if(isNaN(cadena.charAt(i)))
		{
			valido=false;
			break;
		}
	};
	return valido;
}*/
function encontrarEspeciales(cadena,tipoValidacion){
	var valido=true;
	for(var i=0;i<cadena.length;i++)
	{
		if(tipoValidacion==1)
		{
				if( (cadena.charCodeAt(i)>=65 && cadena.charCodeAt(i)<=90) || (cadena.charCodeAt(i)>=97 && cadena.charCodeAt(i)<=122) || (cadena.charCodeAt(i)>=48 && cadena.charCodeAt(i)<=57))
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
				if((cadena.charCodeAt(i)>=65 && cadena.charCodeAt(i)<=90) || (cadena.charCodeAt(i)>=97 && cadena.charCodeAt(i)<=122) || (cadena.charCodeAt(i)>=48 && cadena.charCodeAt(i)<=57))
				{
					valido=false;
				}
				else
				{
					if( cadena.charCodeAt(i)==95 || cadena.charCodeAt(i)==32 || cadena.charCodeAt(i)==45 )
					{
						valido=false;
					}
					else
					{
						valido=true;
						break;
					}
					
				}
		}
	}
	return valido;
}
function validaAdmin(cadena,tipo){
	var valido=false;
	if(cadena=="")
	{
		alert("Introduce un nombre de usuario ");
		document.getElementById('nombre').focus();
	}
	else
	{
		if(encontrarEspeciales(cadena,tipo)==true)
		{
			alert('No caracteres especiales');
			document.getElementById('nombre').value="";
			document.getElementById('nombre').focus();

		}
		else
		{
			valido=true;
		}
	}
	return valido;
}
function validaClave(cadena,tipo){
	var valido=false;
	var id="";
	switch(tipo)
	{
		case 1:
		id="nombre";
		break;
		case 2:
		id="clave";
		break;
		case 3:
		id="claveGral";
                break;
	}
	if(cadena=="")
	{
		alert("Introduce una contrase\u00f1a");
		document.getElementById(id).focus();
	}
	else
	{
		if(encontrarEspeciales(cadena,2)==true)
		{
			alert('No caracteres especiales');
			document.getElementById(id).value="";
			document.getElementById(id).focus();

		}
		else
		{
			valido=true;
		}
	}
	return valido;
}

function vn()
{
    swal({title: "Escribe tu Nombre",
        text:"No uses espacios",
        type:"input",
        showCancelButton:true,
        closeOnConfirm:false,
        animation:"slide-from-top",
        inputPlaceholder:"Nombre..." ,
    },
    function(inputValue){  
       
        if(inputValue ===false)
          return false;
        if (inputValue===""){  
          swal.showInputError("Escribe Algo!");    
          return false
         }
         else
         {
             if(encontrarEspeciales(inputValue,1)==true)
             {
                 swal.showInputError("No especiales");
                 return false
             }
         }
         if(true)
         {
           var form=document.getElementById("user");
           document.getElementById("nombre").value=inputValue;
           form.submit();
       }
       
        });
    
    
    
}
function verificarContra(tipo)
{
    //var v=false;
    swal({
        title:"Contraseña del Administrador",
        text:"Confirma contraseña",
        type:"input",
        inputType:"password",
        showCancelButton:true,
        closeOnConfirm:false,
        animation:"slide-from-top",
        inputPlaceholder:"",
    },
            function(inputValue){
            if(inputValue===false)
                return false;
            if(inputValue===""){
                swal.showInputError("Escribe algo");
                return false
                }
                else    
                {   
                    if(encontrarEspeciales(inputValue,1)==true)
                    {
                        swal.showInputError("No especiales");
                        return false
                    }
                }
             if(true)
             {
                document.getElementById("claveConfirmada").value=inputValue;
                 validacionDatos(tipo);
             }
            });
}
/*function verificarContra(tipo)
{
    var contra= prompt("Introduzca clave de admin","");
    if(contra==null)
    {
        location.reload();
    }
    else
    {
        if(encontrarEspeciales(contra,2)==true)
        {
            alert('No caracteres especiales');
            verificarContra();
        }
        {
            document.getElementById("claveConfirmada").value=contra;
            validacionDatos(tipo);
        }
    }
}*/
function pedirUsuario()
{
    var valido=false;
    var contra = prompt('Escribe tu nombre','');
    if(contra==null)
    {
       document.getElementById("userU").value="";
       document.getElementById("userU").focus();
    }
    else
    {
        if(encontrarEspeciales(contra,1)==true)
        {
            alert('No caracteres especiales');
            document.getElementById("userU").value="";
            document.getElementById("userU").focus();
        }
        else
        {
           document.getElementById("nombre").value=contra;
           valido=true;
        }
    }
    return valido;
}

function validacionDatos(tipo)
{
	
	var valido=false;
        var claveGeneral=document.getElementById("claveGral").value;
        var nombreProfesor=document.getElementById("nombre").value;
        var claveProfesor=document.getElementById("clave").value;
        var colorGral=document.getElementById("colorGral").value;
        
        
	if(tipo==1)
	{
		
		if(validaAdmin(nombreProfesor,tipo)==true)
		{
			document.getElementById("campoEditado").value=1;
                        document.getElementById("nuevoDato").value=nombreProfesor;
			valido=true;
		}
		else
		{
			alert('Nombre de usuario no valido');
			document.getElementById("nombre").value="";
			document.getElementById("nombre").focus();
		}
	}
	else
	{
		if(tipo==2)
		{
			
			if(validaClave(claveProfesor,tipo))
			{
				document.getElementById("campoEditado").value=2;
                                document.getElementById("nuevoDato").value=claveProfesor;
				valido=true;
			}
			else
			{
				alert("Clave no valida");
				document.getElementById("clave").value="";
				document.getElementById("clave").focus();
			}
		}
		else
		{
                    if(tipo==3)
                    {
			
			if(validaClave(claveGeneral,3)== true)
			{
				document.getElementById("campoEditado").value=3;
                                document.getElementById("nuevoDato").value=claveGeneral;
				valido=true;
			}
			else
			{
				alert("Clave de acceso general no valida");
				document.getElementById("claveGral").value="";
				document.getElementById("claveGral").focus();
			}
                    }
                    else
                        if(tipo==4)
                        {
                            
                            document.getElementById("campoEditado").value=4;
                            document.getElementById("nuevoDato").value=colorGral;
                            valido=true;
                        }
                        else
                        {
                           
                                foto();
                           
                                
                        }
		}
	}
	if(valido)
	{
            //Confirm('¿Seguro que quiere editar?');
             //alert(document.getElementById("nuevoDato").value);
            //alert(document.getElementById("claveConfirmada").value);
            //alert(document.getElementById("campoEditado").value);
		document.forms[0].submit();
	}
	
}
function foto(){
    var contra = document.getElementById("clave");
    var archivo = document.getElementById("archivo");
    var nfoto = document.getElementById("fotoUsr");
    var formu = document.getElementById("editaIm");
    if(nfoto.value != ""){
        var ximagen = nfoto.files[0];
        archivo.value = ximagen.name;
            formu.action =  "../modificaDatos";
            formu.submit();
        } 
    else{
        swal({title: "ERROR",
        text:"Selecciona una foto a subir",
        type:"error",
        showConfirmButton:true,
        closeOnConfirm:false,
        animation:"slide-from-top",
        });
    }
} 