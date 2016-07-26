
function validaNumeros(cadena)
{
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
function validaEspeciales(cadena,tipoValidacion)
{
	var valido=false;
			for(var i =0; i <cadena.length;i++)
		{
			//tipo 1= validacion de usuario
			//Cualquier otro tipo validacion de contraseña
			if(tipoValidacion==1)
				if( (cadena.charCodeAt(i)>=65 && cadena.charCodeAt(i)<=90) || (cadena.charCodeAt(i)>=97 && cadena.charCodeAt(i)<=122) || (cadena.charCodeAt(i)>=48 && cadena.charCodeAt(i)<=57))
				{
					valido=true;
				}
				else
				{
					valido=false;
					break;
				}
			else
				if((cadena.charCodeAt(i)>=65 && cadena.charCodeAt(i)<=90) || (cadena.charCodeAt(i)>=97 && cadena.charCodeAt(i)<=122) || (cadena.charCodeAt(i)>=48 && cadena.charCodeAt(i)<=57))
				{
					valido=true;
				}
				else
				{
					if( cadena.charCodeAt(i)==95 || cadena.charCodeAt(i)==32 || cadena.charCodeAt(i)==45 )
					{
						valido=true;
					}
					else
					{
						valido=false;
						break;
					}
					
				}


		};
	
	return valido;
}
function validaAdmin(cadena,tipe)
{
	alert('validaAdmin');
	var valido=false;
	if(cadena=="")
	{
		alert("Introduce un nombre de usuario ");
		document.getElementById('userAdmin').focus();
	}
	else
	{
		if(validaEspeciales(cadena,tipe)==false)
		{
			alert('No caracteres especiales');
			document.getElementById('userAdmin').value="";
			document.getElementById('userAdmin').focus();

		}
		else
		{
			valido=true;
		}
	}
	return valido;
		
}

function validaClave(clave)
{
	var valido=false;
	if(clave=="")
	{
		alert("Introduce una contrase\u00f1a");
		document.getElementById('pswAdmin').focus();
	}
	else
	{
		if(validaEspeciales(clave,2)==false)
		{
			alert('No caracteres especiales');
			document.getElementById('pswAdmin').value="";
			document.getElementById('pswAdmin').focus();

		}
		else
		{
			valido=true;
		}
	}
	return valido;
		
}
function valida(ti)
{

	var userAdmin="";
	var pswAdmin="";
	var pswUser="";
	alert('entreValidacion');
	var hola="holA";
	alert(hola.charCodeAt(0));
	var valido=false;
		

		if(ti==1)
		{
			alert('aquiN');
			if(document.getElementById("userAdmin").value==""|| document.getElementById("pswAdmin").value=="")
			{
				alert("Rellena los campos ");

				valido=false;

			}
			else
			{
						alert('aqui2');
					userAdmin=document.getElementById('userAdmin').value;
					 pswAdm=document.getElementById('pswAdmin').value;
				alert('aqui3');
				if(validaClave(pswAdm)==true)
				{
					alert('aqui4');
					if(validaAdmin(userAdmin,ti)==true)
						valido=true;
					
				}
				
			}
			

		}
		else
		{
			pswUser=document.getElementById('userU').value;
			if(document.getElementById("userU").value=="")
			{
				alert("Introduce la clave");
				document.getElementById("userU").focus();
				valido=false;
			}
			else
				if(validaClave(pswUser)==true)
				valido=true;
		}
		/*if(valido)
		{
			document.getElementById('tipoSesion').value=ti;
		}
	*/
		

	return valido;
}