
<%
	String usuario2 = (String) session.getAttribute("Usuario");
	if (usuario2 == null) {
		response.sendRedirect("/ontologias/login.jsp");
	} else {
%>
<%@page import="controllers.Categorias"%>
<%@page import="models.Categoria"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="controllers.Conexion"%>
<%@page import="controllers.Usuarios"%>
<%@page import="models.Usuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Inicio</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="js/bootstrap.min.js" rel="stylesheet">
<link href="./css/mycss.css" rel="stylesheet">
<link href="style.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script defer src="https://use.fontawesome.com/releases/v5.0.13/js/solid.js" integrity="sha384-tzzSw1/Vo+0N5UhStP3bvwWPq+uvzCMfrN1fEFe+xBmv1C/AtVX5K0uZtmcHitFZ" crossorigin="anonymous"></script>
<script defer src="https://use.fontawesome.com/releases/v5.0.13/js/fontawesome.js" integrity="sha384-6OIrr52G08NpOFSZdxxz1xdNSndlD4vdcf/q2myIUVO0VsqaGHJsB0RaBE01VTOY" crossorigin="anonymous"></script>
<script src="js/buscarCategoria.js"></script>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
		<img src="img/uasLogo.png" class="logo" alt="Logo" style="height: 50px; width: 50px;">
		<a class="navbar-brand" href="./index.jsp">Ontologías</a>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
			</ul>
			<form class="form-inline my-2 my-lg-0">
				<%
					if (request.getSession().getAttribute("UsuarioTipo").toString().equals("1")) {
				%>
				<a class="navbar-brand" href="categorias/categorias.jsp">Categorías</a>
				<a class="navbar-brand" href="categorias/ramas.jsp">Subcategorías</a>
				<a class="navbar-brand" href="ontologias/todas.jsp">Ontologías</a>
				<a class="navbar-brand" href="usuarios/usuarios.jsp">
					<i class="fas fa-users"></i>
				</a>
				<%
					}
				%>
				<a class="navbar-brand" href="ontologias/propias.jsp">Mis Ontologías</a>
				<a class="navbar-brand" href="noti.jsp">
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
							<img src="img/face2.png" style="width: 2rem; height: 2rem; object-fit: cover;">
							<%
								}
							%>
							<%
								}
							%>
						</a>
						<div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
							<a class="dropdown-item" href="perfil.jsp">Ver Perfil</a>
							<a class="dropdown-item" href="cambiar.jsp">Cambiar Contraseña</a>
							<a class="dropdown-item" href="./salir.jsp">Cerrar sesión</a>
						</div>
					</li>
				</ul>
			</form>
		</div>
	</nav>
	<div class="container">
		<br> <br>
		<div class="row justify-content-between align-items-center">
			<div class="col-4 ">Categorías</div>
			<div class="col-4">
				<div class="input-group">
					<div class="input-group-prepend">
						<div class="input-group-text" id="btnGroupAddon">
							<i class="fas fa-search"></i>
						</div>
					</div>
					<input type="text" class="form-control" placeholder="Buscar" id="buscar" aria-label="Buscar" aria-describedby="btnGroupAddon">
				</div>
			</div>
		</div>
		<br>
		<div class="row" id="categorias">
			<%
				Categorias conexion = new Categorias();
					ArrayList<Categoria> categorias = conexion.listar();
					for (Categoria categoria : categorias) {
						if (categoria.getImagen() != null) {
			%>
			<div style="margin-right: 8%; margin-bottom: 3%;" class="col-2 ">
				<a href="subcat.jsp?id=<%out.print(categoria.getId());%>" style="color: inherit; hover: 'text-decoration: none;'">
					<div class="card"
						style="width: 11rem; height: 10rem; background-image: url('data:image/png;base64,<%out.print(categoria.getImagen());%>'); background-color: rgb(167, 161, 161,0.5);  background-size: cover; box-shadow: -4px 5px rgb(237,234,245,0.5); ">
						<div class="card-body">
							<p style="text-align: center; padding-top: 32%; color: white" class="card-text">
								<%
									out.print(categoria.getTitulo());
								%>
							</p>
						</div>
					</div>
				</a>
			</div>
			<%
				} else {
			%>
			<div style="margin-right: 8%; margin-bottom: 3%;" class="col-2 ">
				<a href="subcat.jsp?id=<%out.print(categoria.getId());%>" style="color: inherit; hover: 'text-decoration: none;'">
					<div class="card" style="width: 11rem; height: 10rem; background-image: url('img/fondoCat.png'); background-color: rgb(167, 161, 161, 0.5); background-size: cover; box-shadow: -4px 5px rgb(237, 234, 245, 0.5);">
						<div class="card-body">
							<p style="text-align: center; padding-top: 32%; color: white" class="card-text">
								<%
									out.print(categoria.getTitulo());
								%>
							</p>
						</div>
					</div>
				</a>
			</div>
			<%
				}
					}
			%>
		</div>
	</div>
</body>
</html>
<%
	}
%>