    var si = 1;
    function enviaForm(tipo){
                var def = true;
                def = validaContenido(tipo);
                if(def){
                    //var alerta=swal({title: "¿PUBLICAR?",text:"Sera publicado en el blog",type:"warning",showCancelButton: true,confirmButtonColor: "#DD6B55",confirmButtonText:"Adelante",closeOnConfirm:false},function(isConfirm){if(isConfirm){si= 1;}else{si=0}});
                    if(si ==1){
                        var imagen = document.getElementById("imagen");
                        var audio = document.getElementById("audio");
                        var oculto1 = document.getElementById("oculto1");
                        var oculto2 = document.getElementById("oculto2");
                        if(imagen.value != ""){
                            var ximagen = imagen.files[0];
                            oculto1.value = ximagen.name;
                        }
                        if(audio.value != ""){
                            var xaudio = audio.files[0];
                            oculto2.value = xaudio.name;
                        }
                        document.forms[0].submit();
                    }
                    else
                        def=false;
                }
                return def;
            }
            function validaContenido(tipo){
                var valido = true;
                var contenido = document.getElementById("contenido");
                if(contenido.value == ""){
                swal({title: 'ERROR!',text: 'No has escrito nada',type: 'error',showConfirmButton: false,timer: 2000, html: false},function(){window.location= tipo == 1 ? "postear.jsp" : ""});
                    valido= false;
                    contenido.focus();
                }
                return valido;
            }
            function prueba(){
                alert("prueba");
            }
            function validaImagen(f){
                var ext=['gif','jpg','jpeg','png'];
                var v=f.value.split('.').pop().toLowerCase();
                for(var i=0,n;n=ext[i];i++){
                    if(n.toLowerCase()==v)
                        return
                }
                var t=f.cloneNode(true);
                t.value='';
                f.parentNode.replaceChild(t,f);
                swal({title: 'ARCHIVO INCORRECTO',text: 'Seleccione una imagen',type: 'error',showConfirmButton: false,timer: 3000, html: false});
            }
            function validaAudio(f){
                var ext=['mp3','avi'];
                var v=f.value.split('.').pop().toLowerCase();
                for(var i=0,n;n=ext[i];i++){
                    if(n.toLowerCase()==v)
                        return
                }
                var t=f.cloneNode(true);
                t.value='';
                f.parentNode.replaceChild(t,f);
                swal({title: 'ARCHIVO INCORRECTO',text: 'Seleccione un auido',type: 'error',showConfirmButton: false,timer: 3000, html: false});
            }