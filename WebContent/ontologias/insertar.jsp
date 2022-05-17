
<%
	String usuario2 = (String) session.getAttribute("Usuario");
	if (usuario2 == null) {
		response.sendRedirect("/ontologias/login.jsp");
	} else {
%>
<%@page import="controllers.ClasesLectura"%>
<%@page import="controllers.ClasesConsultar"%>
<%@page import="org.apache.jena.ontology.DatatypeProperty"%>
<%@page import="controllers.Usuarios"%>
<%@page import="models.Usuario"%>
<%@page import="models.Utils"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="controllers.Conexion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insertar</title>
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
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
		<img src="../img/uasLogo.png" class="logo" alt="Logo" style="height: 50px; width: 50px;">
		<a class="navbar-brand" href="../index.jsp">Ontolog�as</a>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
			</ul>
			<form class="form-inline my-2 my-lg-0">
				<%
					if (request.getSession().getAttribute("UsuarioTipo").toString().equals("1")) {
				%>
				<a class="navbar-brand" href="../categorias/categorias.jsp">Categor�as</a>
				<a class="navbar-brand" href="../categorias/ramas.jsp">Subcategor�as</a>
				<a class="navbar-brand" href="../ontologias/todas.jsp">Ontolog�as</a>
				<a class="navbar-brand" href="../usuarios/usuarios.jsp">
					<i class="fas fa-users"></i>
				</a>
				<%
					}
				%>
				<a class="navbar-brand" href="../ontologias/propias.jsp">Mis Ontolog�as</a>
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
							<a class="dropdown-item" href="../cambiar.jsp">Cambiar Contrase�a</a>
							<a class="dropdown-item" href="../salir.jsp">Cerrar sesi�n</a>
						</div>
					</li>
				</ul>
			</form>
		</div>
	</nav>
	<%
		String clase_s = request.getSession().getAttribute("clase_e").toString();
	%>
	<center>
		<h2>
			<%
				out.print(clase_s);
			%>
		</h2>
	</center>
	<div class="container row">
		<div class="col-1"></div>
		<div class="col-3">
			<%
				String id_ontologia = request.getSession().getAttribute("id_ontologia").toString();
			%>
			<a href="ver.jsp" class="btn btn-primary" style="color: white;">
				<i class="fas fa-mouse-pointer"></i>
				Seleccionar Clase
			</a>
			<br> <br>
			<a href="todos.jsp?id=<%out.print(id_ontologia);%>" class="btn btn-primary" style="color: white;">
				<i class="fas fa-search"></i>
				Consultar
			</a>
		</div>
		<div class="container col-8">
			<form class="form-group" method="post" action="../InsertarAtributos">
				<label>Nombre de Individuo</label>
				<input class="form-control" type="text" name="nombre_individuo">
				<%
					ClasesLectura clases = new ClasesLectura();
						Utils utils = new Utils();
						ClasesConsultar consulta = new ClasesConsultar();

						int i = 0;
						String nombre = request.getSession().getAttribute("ruta").toString();
						String ruta = utils.getRuta() + nombre;
						String clase = request.getSession().getAttribute("clase_e").toString();
						String[] NSySimbolo = consulta.consultarNSySimbolo(ruta);
						String NS = NSySimbolo[0];
						String simbolo = NSySimbolo[1];
						String objetos[] = clases.leerObjetos(ruta, clase, simbolo, NS);
						DatatypeProperty atributoss[] = consulta.consultarAtributos(ruta, clase, simbolo, NS);
						for (DatatypeProperty atributo : atributoss) {
				%>
				<label>
					<%
						out.print(atributo.getLocalName());
					%>
				</label>
				<%
					if (atributo.getRange().getLocalName().equals("decimal")) {
				%>
				<input class="form-control" type="number" step="any" name="<%out.print(atributo.getLocalName());%>">
				<%
					} else if (atributo.getRange().getLocalName().equals("integer")
									|| atributo.getRange().getLocalName().equals("int")) {
				%>
				<input class="form-control" type="number" name="<%out.print(atributo.getLocalName());%>">
				<%
					} else {
				%>
				<input class="form-control" type="text" name="<%out.print(atributo.getLocalName());%>">
				<%
					}
				%>
				<%
					}
				%>
				<%
					for (String objeto : objetos) {
				%>
				<label>
					<%
						out.print(objeto);
					%>
				</label>
				<select class="form-control" name="<%out.print(objeto);%>">
					<%
						String individuals[][] = clases.leerIndividual(ruta, objeto);
								for (String individual[] : individuals) {
					%>
					<option value="<%out.print(individual[0]);%>">
						<%
							out.print(individual[0] + " - " + individual[1]);
						%>
					</option>
					<%
						i++;
					%>
					<%
						}
					%>
				</select>
				<%
					//out.print(i);
							i = 0;
				%>
				<%
					}
				%>
				<button type="submit" style="margin-top: 1%" class="btn btn-primary">
					<i class="fas fa-save"></i>
					Guardar
				</button>
			</form>
		</div>
	</div>
</body>
</html>
<%
	}
%>