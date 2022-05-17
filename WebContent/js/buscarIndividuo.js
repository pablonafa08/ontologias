'use strict'

function doSearch(){
    var tableReg = document.getElementById('datos');
    var searchText = document.getElementById('searchTerm').value.toLowerCase();
    var cellsOfRow = "";
    var found = false;
    var compareWith = "";
    var contador = 0;
    //console.log(tableReg.rows.length);
    //console.log(searchText);
    // Recorremos todas las filas con contenido de la tabla
    for (var i = 1; i < tableReg.rows.length; i++)
    {
        //console.log(1);
        cellsOfRow = tableReg.rows[i].getElementsByTagName('td');
        //console.log(cellsOfRow);
        found = false;
        // Recorremos todas las celdas
        for (var j = 0; j < cellsOfRow.length-1 && !found; j++)
        {
            //console.log(2);
            compareWith = cellsOfRow[j].innerHTML.toLowerCase();
            //console.log(compareWith);
            // Buscamos el texto en el contenido de la celda
            if (searchText.length == 0 || (compareWith.indexOf(searchText) > -1))
            {
                found = true;
                //console.log(3);
            }
        }
        if (found)
        {
            //console.log(4);
            contador++;
            tableReg.rows[i].style.display = '';
        } else {
            //console.log(5);
            // si no ha encontrado ninguna coincidencia, esconde la
            // fila de la tabla
            tableReg.rows[i].style.display = 'none';
        }
    }
    //console.log(contador);
    if(contador == 0 && tableReg.rows.length != 1){
    	document.getElementById('datos').style.display = "none";
    	document.getElementById('datos2').style.display = "";
    	document.getElementById('datos3').style.display = "none";
    }else if(tableReg.rows.length == 1){
    	document.getElementById('datos').style.display = "none";
    	document.getElementById('datos2').style.display = "none";
    	document.getElementById('datos3').style.display = "";
    }else{
    	document.getElementById('datos').style.display = "";
    	document.getElementById('datos2').style.display = "none";
    	document.getElementById('datos3').style.display = "none"
    }
    
}



