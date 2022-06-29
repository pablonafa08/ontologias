"use strict";

function buscar_datos(consulta) {
  $.ajax({
    url: "../js/archivosBusquedas/obtenerSubcategoria.jsp",
    type: "POST",
    dataType: "html",
    data: { consulta: consulta },
  })
    .done(function (respuesta) {
      $("#subcategoria").html(respuesta);
    })
    .fail(function () {
      alert("Error al obtener las subcategorías");
    });
}

$(document).on("focus", "#categoria", function () {
  this.selectedIndex = -1;
});

$(document).on("change", "#categoria", function () {
  var valor = $(this).val();
  this.blur();
  if (valor != "") {
    buscar_datos(valor);
  } else {
    buscar_datos();
  }
});
