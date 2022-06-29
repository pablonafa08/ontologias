"use strict";
$(buscar_datos());

function buscar_datos(consulta) {
  $.ajax({
    url: "./js/archivosBusquedas/buscarCategoria.jsp",
    type: "POST",
    dataType: "html",
    data: {
      consulta: consulta,
    },
  })
    .done(function (respuesta) {
      $("#categorias").html(respuesta);
    })
    .fail(function () {
      $("#categorias").html(
        '<h4 style="text-align: center; margin-top: 30px">Ha ocurrido un error al cargar los datos</h4>'
      );
    });
}

$(document).on("keyup", "#buscar", function () {
  var valor = $(this).val();
  if (valor != "") {
    buscar_datos(valor);
  } else {
    buscar_datos();
  }
});
