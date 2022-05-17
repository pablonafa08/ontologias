"use strict";

function doSearch() {
  var tableReg = document.getElementById("datos");
  var searchText = document.getElementById("searchTerm").value.toLowerCase();
  var cellsOfRow = "";
  var found = false;
  var compareWith = "";
  var contador = 0;

  // Recorremos todas las filas con contenido de la tabla
  for (var i = 1; i < tableReg.rows.length; i++) {
    cellsOfRow = tableReg.rows[i].getElementsByTagName("td");
    found = false;

    // Recorremos todas las celdas
    for (var j = 0; j < cellsOfRow.length - 2 && !found; j++) {
      compareWith = cellsOfRow[j].innerHTML.toLowerCase();
      // Buscamos el texto en el contenido de la celda
      if (searchText.length == 0 || compareWith.indexOf(searchText) > -1) {
        found = true;
      }
    }
    if (found) {
      contador++;
      tableReg.rows[i].style.display = "";
    } else {
      // si no ha encontrado ninguna coincidencia, esconde la
      // fila de la tabla
      tableReg.rows[i].style.display = "none";
    }
  }

  if (contador == 0 && tableReg.rows.length != 2) {
    document.getElementById("datos").style.display = "none";
    document.getElementById("datos2").style.display = "";
    document.getElementById("datos3").style.display = "none";
  } else if (tableReg.rows.length == 2) {
    document.getElementById("datos").style.display = "none";
    document.getElementById("datos2").style.display = "none";
    document.getElementById("datos3").style.display = "";
  } else {
    document.getElementById("datos").style.display = "";
    document.getElementById("datos2").style.display = "none";
    document.getElementById("datos3").style.display = "none";
  }
}

/*'use strict'
$(buscar_datos());

function buscar_datos(consulta){
    $.ajax({
       url: '../js/archivosBusquedas/buscarUsuario.jsp',
       type: 'POST',
       dataType: 'html',
       data: {consulta:consulta}
    })
    .done(function(respuesta){
        $("#tabla_usuarios").html(respuesta);
        console.log($("#tabla_usuarios").html(respuesta));
        //alert($("#resultado").html(respuesta));
    })
    .fail(function(){
        console.log("error");
        alert("error");
    })
    ;
}

$(document).on('keyup','#buscar',function(){
   var valor = $(this).val();
   if(valor != ""){
       buscar_datos(valor);
   }else{
       buscar_datos();
   }
});*/
