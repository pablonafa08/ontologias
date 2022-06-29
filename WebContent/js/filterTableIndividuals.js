"use strict";
$(loadTable());

const initTable = `<table class="table table-hover" id="dataTable">
<thead class="thead-default">
<tr style="text-align: center;">
    <th>Individuo</th>
    <th>Datos</th>
    <th>Relaciones</th>
    <th>Acciones</th>
  </tr>
</thead>
<tbody>`;

const endTable = `</tbody>
</table>`;

const editButton = (name, isDisabled) => {
  const disabledLabel = isDisabled ? "disabled" : "";

  return `<a href="#modificar-${name}" class="btn btn-sm btn-primary ${disabledLabel}" style="margin-right: 8px" data-toggle="modal">
  <i class="fas fa-pencil-alt"></i>
  </a>`;
};

const editModal = (name, clase, attributes, relationItems, relationsValue) => {
  const attributesInput = Object.keys(attributes).map((attr) => {
    return `<div class="form-group">
    <label style="font-weight: 600">${attr}</label>
    <input class="form-control" type="text" value="${attributes[attr]}" name="${attr}">
    </div>`;
  });

  const relationsSelect = Object.keys(relationItems).map((relation) => {
    const items = relationItems[relation];

    if (!items.length || !relationsValue[relation]) return "";

    const options = items.map(
      (option) =>
        `<option value="${option}" ${
          relationsValue[relation] === option ? "selected" : ""
        }>${option}</option>`
    );

    return `<div class="form-group">
    <label style="font-weight: 600">${relation}</label>
    <select class="form-control" name="${relation}">
    ${options.join(" ")}
    </select>
    </div>`;
  });

  return `<div class="modal fade" id="modificar-${name}">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header justify-content-center" style="text-align: center">
        <h5 class="modal-title">
           Editar individuo: ${name}
        </h5>
      </div>
      <form class="form-group" method="post" action="../ModificarAtributos">
        <div class="modal-body">
          <input type="hidden" value="${name}~~${clase}" name="nombre_individuo">
          ${attributesInput.join(" ")}
          ${relationsSelect.join(" ")}
        </div>
        <div class="modal-footer">
          <button type="submit" name="guardar" id="guardar" class="btn btn-primary">Guardar</button>
          <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
        </div>
      </form>
    </div>
  </div>
</div>`;
};

const deleteButton = (name, isDisabled) => {
  const disabledLabel = isDisabled ? "disabled" : "";

  return `<a href="#eliminar-${name}" class="btn btn-sm btn-danger ${disabledLabel}" data-toggle="modal">
  <i class="fas fa-trash-alt"></i>
  </a>`;
};

const deleteModal = (name) => {
  return `<div class="modal fade" id="eliminar-${name}">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header justify-content-center" style="text-align: center">
        <h5 class="modal-title">¿Estás seguro que quieres eliminar?</h5>
      </div>
      <div class="modal-body">
        <p style="text-align: center">
          Se eliminará el individuo: <b>${name}</b>
        </p>
      </div>
      <div class="modal-footer">
        <a href="../ModificarAtributos?individuo=${name}" class="btn btn-primary">Eliminar</a>
        <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
      </div>
    </div>
  </div>
</div>`;
};

function loadTable() {
  const params = new Proxy(new URLSearchParams(window.location.search), {
    get: (searchParams, prop) => searchParams.get(prop),
  });

  $.ajax({
    url: "../js/archivosBusquedas/filterIndividuals.jsp",
    type: "POST",
    dataType: "html",
    data: {
      id: params.id,
    },
  })
    .done(function (respuesta) {
      try {
        const res = JSON.parse(respuesta);

        // Listado de los valores que hay en las relaciones
        const itemsWithRelations = res.data
          .filter((item) => Object.keys(item.relations).length)
          .map((item) => Object.values(item.relations))
          .flat();

        // Listado estructurado (con HTML)
        const dataStructure = res.data.map((item) => {
          const attributes = Object.keys(item.attributes).map((attr) => {
            return `<strong>${attr}:</strong> ${item.attributes[attr]}`;
          });

          const relations = Object.keys(item.relations).map((relation) => {
            return `<strong>${relation}:</strong> ${item.relations[relation]}`;
          });

          // Deshabilitar botón de eliminar
          const finded = itemsWithRelations.find(
            (subItem) => subItem === item.name
          );
          const isDeleteDisabled = item.actions.isDeleteDisabled || !!finded;

          return `<tr>
          <td>${item.name}</td>
          <td>${attributes.join(" ")}</td>
          <td>${relations.join(" ")}</td>
          <td><div class="row justify-content-center">${editButton(
            item.name,
            item.actions.isEditDisabled
          )}
          ${deleteButton(item.name, isDeleteDisabled)}
          ${
            !item.actions.isEditDisabled
              ? editModal(
                  item.name,
                  item.clase,
                  item.attributes,
                  res.relationItems,
                  item.relations
                )
              : ""
          }
          ${!isDeleteDisabled ? deleteModal(item.name) : ""}
          <div>
          </td>
          </tr>
          `;
        });

        if (!res.data.length) {
          const noData =
            '<h4 style="text-align: center; margin-top: 30px">No se han registrado individuos</h4>';
          $("#contentTable").html(noData);
        } else {
          $("#contentTable").html(
            initTable + dataStructure.join(" ") + endTable
          );
        }
      } catch (error) {
        const messageError =
          '<h4 style="text-align: center; margin-top: 30px">Ha ocurrido un error al cargar los datos</h4>';
        $("#contentTable").html(messageError);
      }
    })
    .fail(function () {
      const messageError =
        '<h4 style="text-align: center; margin-top: 30px">Ha ocurrido un error al cargar los datos</h4>';
      $("#contentTable").html(messageError);
    });
}

function doSearch() {
  var tableReg = document.getElementById("dataTable");
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
    for (var j = 0; j < cellsOfRow.length - 1 && !found; j++) {
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

  if (contador == 0 && tableReg.rows.length != 1) {
    document.getElementById("contentTable").style.display = "none";
    document.getElementById("noMatches").style.display = "";
    document.getElementById("noDataRecorded").style.display = "none";
  } else if (tableReg.rows.length == 1) {
    document.getElementById("contentTable").style.display = "none";
    document.getElementById("noMatches").style.display = "none";
    document.getElementById("noDataRecorded").style.display = "";
  } else {
    document.getElementById("contentTable").style.display = "";
    document.getElementById("noMatches").style.display = "none";
    document.getElementById("noDataRecorded").style.display = "none";
  }
}
