<%@page import="controllers.Categorias"%>
<%@page import="models.Categoria"%>
<%@page import="java.util.ArrayList"%>

<%
	String salida = "";

	Categorias conexion = new Categorias();
	ArrayList<Categoria> categorias;
	if (request.getParameter("consulta") == null) {
		categorias = conexion.listar();
	} else {
		categorias = conexion.listarXFiltro(request.getParameter("consulta"));
	}
	if (categorias.size() == 0 && request.getParameter("consulta") != null) {
		salida = "<h4 style=\"text-align: center; margin-top: 30px\">No se encontraron coincidencias</h4>";
	} else if (categorias.size() == 0 && request.getParameter("consulta") == null) {
		salida = "<h4 style=\"text-align: center; margin-top: 30px\">No hay categorias registradas</h4>";
	} else {
		salida = "<div class=\"row\">";
	}

	for (Categoria categoria : categorias) {
		if (categoria.getImagen() != null) {
			salida += "<div style=\"margin-right: 8%; margin-bottom: 3%;\" class=\"col-2 \">";
			salida += "<a href=\"subcat.jsp?id=" + categoria.getId()
					+ "\" style=\"color:inherit; hover:'text-decoration: none;'\">";
			salida += "<div class=\"card\" style=\"width: 11rem; height: 10rem; background-image: url('data:image/png;base64,"
					+ categoria.getImagen()
					+ "'); background-color: rgb(167, 161, 161,0.5);  background-size: cover; box-shadow: -4px 5px rgb(237,234,245,0.5); \">";
			salida += "<div class=\"card-body\">";
			salida += "<p style=\"text-align: center; padding-top: 32%; color:white; text-shadow: 1px 1px 10px #343a40\" class=\"card-text\">"
					+ categoria.getTitulo() + "</p>";
			salida += "</div>";
			salida += "</div>";
			salida += "</a>";
			salida += "</div>";

		} else {
			salida += "<div style=\"margin-right: 8%; margin-bottom: 3%;\" class=\"col-2 \">";
			salida += "<a href=\"subcat.jsp?id=" + categoria.getId()
					+ "\" style=\"color:inherit; hover:'text-decoration: none;'\">";
			salida += "<div class=\"card\" style=\"width: 11rem; height: 10rem; background-image: url('img/fondoCat.png'); background-color: rgb(167, 161, 161,0.5);  background-size: cover; box-shadow: -4px 5px rgb(237,234,245,0.5); \">";
			salida += "<div class=\"card-body\">";
			salida += "<p style=\"text-align: center; padding-top: 32%; color:white; text-shadow: 1px 1px 10px #343a40\" class=\"card-text\">"
					+ categoria.getTitulo() + "</p>";
			salida += "</div>";
			salida += "</div>";
			salida += "</a>";
			salida += "</div>";

		}
	}

	if (categorias.size() > 0) {
		salida += "</div>";
	}
	out.print(salida);
%>