<%@page import="controllers.SubCategorias"%>
<%@page import="models.SubCategoria"%>
<%@page import="java.util.ArrayList"%>

<%
	String salida = "";
	String id = request.getSession().getAttribute("id_categoria").toString();
	SubCategorias conexion = new SubCategorias();
	ArrayList<SubCategoria> subcategorias;
	if (request.getParameter("consulta") == null) {
		subcategorias = conexion.listarXCategoria(id);
	} else {
		subcategorias = conexion.listarXCategoriaXFiltro(request.getParameter("consulta"), id);
	}
	if (subcategorias.size() == 0 && request.getParameter("consulta") != null) {
		salida = "<h3>No se encontraron coincidencias</h3>";
	} else if (subcategorias.size() == 0 && request.getParameter("consulta") == null) {
		salida = "<h3>No hay subcategorias registradas</h3>";
	}
	for (SubCategoria subcategoria : subcategorias) {
		if (subcategoria.getImagen() != null) {

			salida += "<div style=\"margin-right: 8%; margin-bottom: 3%;\" class=\"col-2 \">";
			salida += "<a href=\"ontologias/ontologias.jsp?id=" + subcategoria.getId()
					+ "\" style=\"color:inherit; hover:'text-decoration: none;'\">";
			salida += "<div class=\"card\" style=\"width: 11rem; height: 10rem; background-image: url('data:image/png;base64,"
					+ subcategoria.getImagen()
					+ "'); background-color: rgb(167, 161, 161,0.5);  background-size: cover; box-shadow: -4px 5px rgb(237,234,245,0.5); \">";
			salida += "<div class=\"card-body\">";
			salida += "<p style=\"text-align: center; padding-top: 32%; color:white; text-shadow: 1px 1px 10px #343a40\" class=\"card-text\">"
					+ subcategoria.getTitulo() + "</p>";
			salida += "</div>";
			salida += "</div>";
			salida += "</a>";
			salida += "</div>";

		} else {

			salida += "<div style=\"margin-right: 8%; margin-bottom: 3%;\" class=\"col-2 \">";
			salida += "<a href=\"ontologias/ontologias.jsp?id=" + subcategoria.getId()
					+ "\" style=\"color:inherit; hover:'text-decoration: none;'\">";
			salida += "<div class=\"card\" style=\"width: 11rem; height: 10rem; background-image: url('img/fondoCat.png'); background-color: rgb(167, 161, 161,0.5);  background-size: cover; box-shadow: -4px 5px rgb(237,234,245,0.5); \">";
			salida += "<div class=\"card-body\">";
			salida += "<p style=\"text-align: center; padding-top: 32%; color:white; text-shadow: 1px 1px 10px #343a40\" class=\"card-text\">"
					+ subcategoria.getTitulo() + "</p>";
			salida += "</div>";
			salida += "</div>";
			salida += "</a>";
			salida += "</div>";

		}
	}
	out.print(salida);
%>