<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="controllers.Conexion"%>
<%@page import="controllers.Usuarios"%>
<%@page import="models.Usuario"%>

<%
	String salida = "";
	salida += "{\"isAdmin\": " + request.getSession().getAttribute("UsuarioTipo").toString().equals("1") + ",";

	Conexion cn2 = new Conexion();
	Connection conn2 = cn2.GetConexion();
	Statement state4 = conn2.createStatement();
	Usuarios conexion2 = new Usuarios();
	ArrayList<Usuario> usuarios2 = conexion2
			.buscarXId(request.getSession().getAttribute("UsuarioId").toString());
	for (Usuario usuario : usuarios2) {
		if (usuario.getFoto() != null) {
			salida += "\"foto\": \"" + usuario.getFoto() + "\"}";
		} else {
			salida += "\"foto\": \"\"}";
		}
	}

	out.print(salida);
%>