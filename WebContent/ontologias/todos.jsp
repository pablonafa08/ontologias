<%@page import="java.util.Date"%>
<%@page import="org.apache.jena.ontology.ObjectProperty"%>
<%@page import="org.apache.jena.ontology.DatatypeProperty"%>
<%@page import="org.apache.jena.ontology.Individual"%>
<%@page import="controllers.ClasesConsultar"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%
	String usuario2 = (String) session.getAttribute("Usuario");
	if (usuario2 == null) {
		response.sendRedirect("/ontologias/login.jsp");
	} else {
%>
<%@page import="controllers.ClasesLectura"%>
<%@page import="java.sql.*"%>
<%@page import="controllers.Conexion"%>
<%@page import="controllers.Usuarios"%>
<%@page import="models.Usuario"%>
<%@page import="models.Utils"%>
<%@page import="models.TodosIndividuosYOtros"%>
<%@page import="models.IndividuosTodos"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.commons.lang3.ArrayUtils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Consultar</title>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../js/bootstrap.min.js" rel="stylesheet">
<link href="../style.css" rel="stylesheet">
<link href="../css/mycss.css" rel="stylesheet">
<script src="../js/popper.min.js"></script>
<script src="../js/jquery-3.3.1.slim.min.js"></script>
<script src="../js/bootstrap4.min.js"></script>
<script src="../js/fontsolid.js"></script>
<script src="../js/fontawesome.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<link href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet">
<script src="../js/filterTableIndividuals.js"></script>
</head>
<body>
  <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <img src="../img/uasLogo.png" class="logo" alt="Logo" style="height: 50px; width: 50px;">
    <a class="navbar-brand" href="../index.jsp">Ontologías</a>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav mr-auto">
      </ul>
      <form class="form-inline my-2 my-lg-0">
        <%
        	if (request.getSession().getAttribute("UsuarioTipo").toString().equals("1")) {
        %>
        <a class="navbar-brand" href="../categorias/categorias.jsp">Categorías</a>
        <a class="navbar-brand" href="../categorias/ramas.jsp">Subcategorías</a>
        <a class="navbar-brand" href="../ontologias/todas.jsp">Ontologías</a>
        <a class="navbar-brand" href="../usuarios/usuarios.jsp">
          <i class="fas fa-users"></i>
        </a>
        <%
        	}
        %>
        <a class="navbar-brand" href="../ontologias/propias.jsp">Mis Ontologías</a>
        <a class="navbar-brand" href="../noti.jsp">
          <i class="fas fa-bell"></i>
        </a>
        <ul class="navbar-nav mr-auto">
          <li class="nav-item dropdown">
            <a style="color: white;" class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              <%
              	Conexion cn2 = new Conexion();
              		Connection conn2 = cn2.GetConexion();
              		Statement state4 = conn2.createStatement();
              		Usuarios conexion2 = new Usuarios();
              		ArrayList<Usuario> usuarios2 = conexion2
              				.buscarXId(request.getSession().getAttribute("UsuarioId").toString());
              		for (Usuario usuario : usuarios2) {
              %>
              <%
              	if (usuario.getFoto() != null) {
              %>
              <img src="data: image/png;base64,<%out.print(usuario.getFoto());%>" style="width: 2rem; height: 2rem; object-fit: cover;">
              <%
              	} else {
              %>
              <img src="../img/face2.png" style="width: 2rem; height: 2rem; object-fit: cover;">
              <%
              	}
              		}
              %>
            </a>
            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
              <a class="dropdown-item" href="../perfil.jsp">Ver Perfil</a>
              <a class="dropdown-item" href="../cambiar.jsp">Cambiar Contraseña</a>
              <a class="dropdown-item" href="../salir.jsp">Cerrar sesión</a>
            </div>
          </li>
        </ul>
      </form>
    </div>
  </nav>
  <div class="container">
    <br>
    <div class="row justify-content-between">
      <div class="col-3">
        <%
        	String id_subcategoria = (String) session.getAttribute("id_subcategoria");
        		if (id_subcategoria != null) {
        %>
        <a href="ontologias.jsp?id=<%out.print(id_subcategoria);%>" class="btn btn-primary" style="color: white;">
          <i class="fas fa-mouse-pointer"></i>
          Seleccionar Ontologia
        </a>
        <br> <br>
        <%
        	}
        %>
      </div>
      <div class="col-3">
        <a href="ver.jsp" class="btn btn-primary" style="color: white;">
          Añadir individuo
          <i class="fas fa-plus"></i>
        </a>
      </div>
    </div>
    <br>
    <div class="row justify-content-between align-items-center">
      <div class="col-4 "></div>
      <div class="col-4">
        <div class="input-group">
          <div class="input-group-prepend">
            <div class="input-group-text" id="btnGroupAddon">
              <i class="fas fa-search"></i>
            </div>
          </div>
          <input type="text" class="form-control" placeholder="Buscar" id="searchTerm" onkeyup="doSearch();" aria-label="Buscar" aria-describedby="btnGroupAddon">
        </div>
      </div>
    </div>
    <br>
    <div id="contentTable" style="padding-bottom: 100px">
      <div style="display: flex; justify-content: center;">
        <div class="spinner-border text-primary" style="width: 50px; height: 50px;"></div>
      </div>
    </div>
    <h3 id="noMatches" style="display: none">No se encontraron coincidencias</h3>
    <h3 id="noDataRecorded" style="display: none">No se han registrado individuos</h3>
  </div>
  <%
  	String respuesta = (String) session.getAttribute("respuesta");

  		if (respuesta != null) {
  			if (respuesta.equals("success_i")) {
  				out.print("<script>toastr.success('Se insertï¿½ el individuo'); </script> ");
  			} else if (respuesta.equals("success_e")) {
  				out.print(
  						"<script>toastr.success('Se ha puesto en pendiente para su eliminaciï¿½n'); </script> ");
  			} else if (respuesta.equals("nosuccess_e")) {
  				out.print(
  						"<script>toastr.error('No se pudo pudo poner en pendiente para su eliminaciï¿½n'); </script> ");
  			} else if (respuesta.equals("error_e")) {
  				out.print("<script>toastr.error('Error al cambiar estatus'); </script> ");
  			} else if (respuesta.equals("success_m")) {
  				out.print(
  						"<script>toastr.success('Se ha puesto en pendiente para su modificaciï¿½n'); </script> ");
  			} else if (respuesta.equals("nosuccess_m")) {
  				out.print(
  						"<script>toastr.error('No se pudo pudo poner en pendiente para su modificaciï¿½n'); </script> ");
  			} else if (respuesta.equals("error_m")) {
  				out.print("<script>toastr.error('Error al cambiar estatus'); </script> ");
  			}
  			request.getSession().setAttribute("respuesta", null);
  		}
  %>
</body>
</html>
<%
	}
%>