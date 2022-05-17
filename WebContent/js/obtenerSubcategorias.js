'use strict'

function buscar_datos(consulta){
    $.ajax({
       url: '../js/archivosBusquedas/obtenerSubcategoria.jsp',
       type: 'POST',
       dataType: 'html',
       data: {consulta:consulta}
    })
    .done(function(respuesta){
        $("#subcategoria").html(respuesta);
        console.log($("#subcategoria").html(respuesta));
        //alert($("#resultado").html(respuesta));
    })
    .fail(function(){
        console.log("error");
        alert("error");
    })
    ;
}

$(document).on('focus','#categoria',function(){
	this.selectedIndex = -1;
});

$(document).on('change','#categoria',function(){
	 var valor = $(this).val();
	 this.blur();
	   if(valor != ""){
	       buscar_datos(valor);
		   console.log(valor);
	   }else{
	       buscar_datos();
		   console.log("error");
	   }
});

