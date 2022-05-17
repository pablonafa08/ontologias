
<%
	String usuario2 = (String) session.getAttribute("Usuario");
	if (usuario2 == null) {
		response.sendRedirect("/ontologias/login.jsp");
	} else {
%>
<%@page import="java.util.ArrayList"%>
<%@page import="models.Ontologia"%>
<%@page import="controllers.Ontologias"%>
<%@page import="controllers.Usuarios"%>
<%@page import="models.Usuario"%>
<%@page import="java.sql.*"%>
<%@page import="controllers.Conexion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Mis Ontolog�as</title>
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
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</head>
<body onload="doSearch();">
	<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
		<img src="../img/uasLogo.png" class="logo" alt="Logo" style="height: 50px; width: 50px;">
		<a class="navbar-brand" href="../index.jsp">Ontolog�as</a>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
			</ul>
			<form class="form-inline my-2 my-lg-0">
				<a class="navbar-brand" href="../categorias/categorias.jsp">Categor�as</a>
				<a class="navbar-brand" href="../categorias/ramas.jsp">Subcategor�as</a>
				<a class="navbar-brand" href="../ontologias/todas.jsp">Ontolog�as</a>
				<a class="navbar-brand" href="../usuarios/usuarios.jsp">
					<i class="fas fa-users"></i>
				</a>
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
	<br>
	<div class="container">
		<div class="row justify-content-between">
			<div class="col-2"></div>
			<div class="col-3">
				<a href="add.jsp" class="btn btn-primary" style="color: white;">
					A�adir ontolog�a
					<i class="fas fa-plus"></i>
				</a>
			</div>
		</div>
		<br>
		<div class="row justify-content-between align-items-center">
			<div class="col-4 ">Ontolog�as</div>
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
		<h3 id="datos3" style="display: none">No se han registrado ontolog�as</h3>
		<h3 id="datos2" style="display: none">No se encontraron coincidencias</h3>
		<table class="table table-hover" id="datos">
			<thead class="thead-default">
				<tr style="text-align: center;">
					<th>Id</th>
					<th>T�tulo o descripci�n</th>
					<th>Categor�a</th>
					<th>Subcategor�a</th>
					<th>Abrir</th>
				<tr>
			</thead>
			<tbody>
				<%
					Conexion cn = new Conexion();
						Connection conn = cn.GetConexion();
						Statement state = conn.createStatement();
						Ontologias control = new Ontologias();
						ArrayList<Ontologia> ontologias = control
								.listarXUsuario(request.getSession().getAttribute("UsuarioId").toString());
						for (Ontologia ontologia : ontologias) {
							ResultSet rs = state.executeQuery(
									"SELECT categorias.titulo AS tit, subcategorias.titulo AS tit2 FROM ontologias JOIN categorias ON categorias.id = ontologias.id_categoria JOIN subcategorias ON subcategorias.id = ontologias.id_subcategoria WHERE ontologias.id = "
											+ ontologia.getId());
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
					<%
						while (rs.next()) {
					%>
					<td style="text-align: center;">
						<%
							out.print(rs.getObject("tit"));
						%>
					</td>
					<td style="text-align: center;">
						<%
							out.print(rs.getObject("tit2"));
						%>
					</td>
					<%
						}
					%>
					<td style="text-align: center;">
						<a href="todos.jsp?id=<%out.print(ontologia.getId());%>" class="btn btn-secondary">
							<i class="fas fa-folder"></i>
						</a>
					</td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
	</div>
</body>
</html>
<%
	}
%>