<%@page import="controllers.SubCategorias"%>
<%@page import="models.SubCategoria"%>
<%@page import="java.util.ArrayList"%>

<%
	String salida = "";
	SubCategorias conexion = new SubCategorias();
	ArrayList<SubCategoria> subcategorias;
	if (request.getParameter("consulta") == null) {
		subcategorias = conexion.listar();
	} else {
		subcategorias = conexion.listarXCategoria(request.getParameter("consulta"));
	}
	salida += "<select class=\"form-control\" name=\"subcategoria\" id=\"subcategoria\">";
	for (SubCategoria subcategoria : subcategorias) {

		salida += "<option value=" + subcategoria.getId() + ">" + subcategoria.getTitulo() + "</option>";

	}
	salida += "</select>";
	out.print(salida);
%>