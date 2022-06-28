<%@page import="org.apache.jena.ontology.Individual"%>
<%@page import="org.apache.jena.util.iterator.ExtendedIterator"%>
<%@page import="org.apache.jena.rdf.model.ModelFactory"%>
<%@page import="org.apache.jena.ontology.OntModel"%>
<%@page import="org.apache.jena.ontology.OntModelSpec"%>
<%
	String usuario2 = (String) session.getAttribute("Usuario");
	String usuarioTipo = (String) session.getAttribute("UsuarioTipo");
	if (usuario2 == null || usuarioTipo == null) {
		response.sendRedirect("/ontologias/login.jsp");

	} else if (!usuarioTipo.equals("1")) {
		response.sendRedirect("/ontologias/login.jsp");
	} else {
%>
<%@page import="java.util.ArrayList"%>
<%@page import="models.Ontologia"%>
<%@page import="models.Utils"%>
<%@page import="controllers.Ontologias"%>
<%@page import="controllers.Usuarios"%>
<%@page import="models.Usuario"%>
<%@page import="java.sql.*"%>
<%@page import="controllers.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Ontologías</title>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../js/bootstrap.min.js" rel="stylesheet">
<link href="../style.css" rel="stylesheet">
<link href="../css/mycss.css" rel="stylesheet">
<script src="../js/popper.min.js"></script>
<script src="../js/jquery-3.3.1.slim.min.js"></script>
<script src="../js/bootstrap4.min.js"></script>
<script src="../js/fontsolid.js"></script>
<script src="../js/fontawesome.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="../js/buscarOntologia2.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<link href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet">
</head>
<body>
  <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <img src="../img/uasLogo.png" class="logo" alt="Logo" style="height: 50px; width: 50px;">
    <a class="navbar-brand" href="../index.jsp">Ontologías</a>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav mr-auto">
      </ul>
      <form class="form-inline my-2 my-lg-0">
        <a class="navbar-brand" href="../categorias/categorias.jsp">Categorías</a>
        <a class="navbar-brand" href="../categorias/ramas.jsp">Subcategorías</a>
        <a class="navbar-brand" href="../ontologias/todas.jsp">Ontologías</a>
        <a class="navbar-brand" href="../usuarios/usuarios.jsp">
          <i class="fas fa-users"></i>
        </a>
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
              %>
              <%
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
  <br>
  <div class="container">
    <div class="row justify-content-end m-0">
      <a href="add.jsp" class="btn btn-primary" style="color: white;">
        <i class="fas fa-plus"></i>
        Nueva ontología
      </a>
    </div>
    <br>
    <div class="row justify-content-between align-items-center">
      <div class="col-4">
        <h3>Ontologías</h3>
      </div>
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
    <h3 id="datos2" style="display: none">No se encontraron coincidencias</h3>
    <table class="table table-hover" id="datos">
      <thead class="thead-default">
        <tr style="text-align: center;">
          <th>Id</th>
          <th>Título o descripción</th>
          <th>Subida por usuario</th>
          <th>Acciones</th>
        <tr>
      </thead>
      <tbody>
        <%
        	Ontologias control = new Ontologias();
        		Utils utils = new Utils();
        		ArrayList<Ontologia> ontologias = control.listar();
        		for (Ontologia ontologia : ontologias) {

        			String ruta = utils.getRuta() + ontologia.getRuta();
        			OntModel model = ModelFactory.createOntologyModel(OntModelSpec.OWL_DL_MEM_RDFS_INF);
        			model.read(ruta, "RDF/XML");
        			int o = 0;
        			ExtendedIterator iteIndividuos = model.listIndividuals();
        			while (iteIndividuos.hasNext()) {
        				Individual indivi = (Individual) iteIndividuos.next();

        				if (indivi.getLocalName().length() > 0) {
        					o++;

        				}
        			}
        %>
        <tr>
          <td style="text-align: center;">
            <%
            	out.print(ontologia.getId());
            %>
          </td>
          <td style="text-align: center;">
            <%
            	out.print(ontologia.getTitulo());
            %>
          </td>
          <td style="text-align: center;">
            <%
            	out.print(ontologia.getUsuario());
            %>
          </td>
          <td>
            <div class="row justify-content-center">
              <a href="todos.jsp?id=<%out.print(ontologia.getId());%>" class="btn btn-sm btn-primary" style="margin-right: 8px">
                <i class="fas fa-folder"></i>
              </a>
              <%
              	if (o == 0) {
              %>
              <a href="#eliminar-<%out.print(ontologia.getId());%>" class="btn btn-sm btn-danger" data-toggle="modal">
                <i class="fas fa-trash-alt"></i>
              </a>
              <div class="modal fade" id="eliminar-<%out.print(ontologia.getId());%>">
                <div class="modal-dialog" role="document">
                  <div class="modal-content">
                    <div class="modal-header justify-content-center" style="text-align: center">
                      <h5 class="modal-title">¿Estás seguro que quieres eliminar?</h5>
                    </div>
                    <div class="modal-body">
                      <p style="text-align: center">
                        Se eliminará la ontología: <b> <%
 	out.print(ontologia.getTitulo());
 %>
                        </b>
                      </p>
                    </div>
                    <div class="modal-footer">
                      <a href="../EliminarOntologia?id=<%out.print(ontologia.getId());%>" class="btn btn-primary">Eliminar</a>
                      <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                    </div>
                  </div>
                </div>
              </div>
              <%
              	} else {
              %>
              <a href="#eliminar-<%out.print(ontologia.getId());%>" class="btn btn-sm btn-danger disabled" data-toggle="modal">
                <i class="fas fa-trash-alt"></i>
              </a>
              <%
              	}
              %>
            </div>
          </td>
        </tr>
        <%
        	}
        %>
      </tbody>
    </table>
  </div>
  <%
  	String respuesta = (String) session.getAttribute("respuesta");
  		if (respuesta != null) {
  			if (respuesta.equals("success")) {
  				out.print("<script>toastr.success('Se eliminó la ontología'); </script> ");
  			} else if (respuesta.equals("nosuccess")) {
  				out.print("<script>toastr.error('No se pudo eliminar la ontología'); </script> ");
  			} else if (respuesta.equals("error")) {
  				out.print("<script>toastr.error('Error al eliminar la ontología'); </script> ");
  			}
  			request.getSession().setAttribute("respuesta", null);
  		}
  %>
</body>
</html>
<%
	}
%>