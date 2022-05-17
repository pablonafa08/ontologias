
<%
	String usuario2 = (String) session.getAttribute("Usuario");
	String usuarioTipo = (String) session.getAttribute("UsuarioTipo");
	if (usuario2 == null || usuarioTipo == null) {
		response.sendRedirect("/ontologias/login.jsp");

	} else if (!usuarioTipo.equals("1")) {
		response.sendRedirect("/ontologias/login.jsp");
	} else {
%>
<%@page import="controllers.Usuarios"%>
<%@page import="models.Usuario"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="controllers.Conexion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Usuarios</title>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../js/bootstrap.min.js" rel="stylesheet">
<link href="../style.css" rel="stylesheet">
<link href="../css/mycss.css" rel="stylesheet">
<script src="../js/popper.min.js"></script>
<script src="../js/jquery-3.3.1.slim.min.js"></script>
<script src="../js/bootstrap4.min.js"></script>
<script src="../js/fontsolid.js"></script>
<script src="../js/fontawesome.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="../js/buscarUsuario.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<link href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet">
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
	<br>
	<div class="container">
		<div class="row justify-content-between">
			<div class="col-2"></div>
			<div class="col-3">
				<a href="add.jsp" class="btn btn-primary" style="color: white;">
					A�adir usuarios
					<i class="fas fa-plus"></i>
				</a>
			</div>
		</div>
		<br>
		<div class="row justify-content-between align-items-center">
			<div class="col-4 ">Usuarios</div>
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
		<div id="tabla_usuarios">
			<h3 id="datos3" style="display: none">No se han registrado ontologias</h3>
			<h3 id="datos2" style="display: none">No se encontraron coincidencias</h3>
			<table class="table table-hover" id="datos">
				<thead class="thead-default">
					<tr style="text-align: center;">
						<th>Nombres</th>
						<th>Correo</th>
						<th>Usuario</th>
						<th>Ontolog�as subidas</th>
						<th>Acciones</th>
					<tr>
				</thead>
				<tbody>
					<%
						Conexion cn = new Conexion();
							Connection conn = cn.GetConexion();
							Statement state = conn.createStatement();
							Usuarios conexion = new Usuarios();
							ArrayList<Usuario> usuarios = conexion.listar();
							for (Usuario usuario : usuarios) {
								ResultSet rs = state.executeQuery(
										"SELECT count(*) as total FROM ontologias WHERE estatus = 'A' AND id_usuario = "
												+ usuario.getId());
					%>
					<tr>
						<td style="text-align: center;">
							<%
								out.print(usuario.getNombres() + " " + usuario.getApp() + " " + usuario.getApm());
							%>
						</td>
						<td style="text-align: center;">
							<%
								out.print(usuario.getCorreo());
							%>
						</td>
						<td style="text-align: center;">
							<%
								out.print(usuario.getUsuario());
							%>
						</td>
						<td style="text-align: center;">
							<%
								while (rs.next()) {
											out.print(rs.getObject("total"));
										}
							%>
						</td>
						<td style="text-align: center;">
							<a href="#modificar-<%out.print(usuario.getId());%>" class="btn btn-secondary" data-toggle="modal">
								<i class="fas fa-pencil-alt"></i>
							</a>
							<a href="#eliminar-<%out.print(usuario.getId());%>" class="btn btn-danger" data-toggle="modal">
								<i class="fas fa-trash-alt"></i>
							</a>
							<!-- Modificar -->
							<div class="modal fade" id="modificar-<%out.print(usuario.getId());%>">
								<div class="modal-dialog" role="document">
									<div class="modal-content">
										<div class="modal-header">
											<h4 class="modal-title">
												Modificar Usuario
												<%
												out.print(usuario.getNombres());
											%>
											</h4>
										</div>
										<form action="../ModificarUsuario" method="post">
											<div class="modal-body">
												<input type="hidden" class="form-control" name="id_usu" value="<%out.print(usuario.getId());%>">
												<div class="form-group">
													<label for="">Nombre(s)</label>
													<input type="text" class="form-control" placeholder="Nombre(s)" name="nombres" value="<%out.print(usuario.getNombres());%>">
												</div>
												<div class="form-group">
													<label for="">Apellido Paterno</label>
													<input type="text" class="form-control" placeholder="Apellido Paterno" name="app" value="<%out.print(usuario.getApp());%>">
												</div>
												<div class="form-group">
													<label for="">Apellido Materno</label>
													<input type="text" class="form-control" placeholder="Apellido Materno" name="apm" value="<%out.print(usuario.getApm());%>">
												</div>
											</div>
											<div class="modal-footer">
												<button type="submit" name="guardar" id="guardar" class="btn btn-primary">Guardar Cambios</button>
												<button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
											</div>
										</form>
									</div>
								</div>
							</div>
							<!-- Eliminar -->
							<div class="modal fade" id="eliminar-<%out.print(usuario.getId());%>">
								<div class="modal-dialog" role="document">
									<div class="modal-content">
										<div class="modal-header">
											<h4 class="modal-title">�Est�s seguro que quieres eliminar?</h4>
										</div>
										<div class="modal-body">
											<h5>
												Se eliminar� el usuario:
												<%
												out.print(usuario.getNombres() + " " + usuario.getApp() + " " + usuario.getApm());
											%>
											</h5>
										</div>
										<div class="modal-footer">
											<a href="../ModificarUsuario?id=<%out.print(usuario.getId());%>" class="btn btn-primary">Eliminar</a>
											<button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
										</div>
									</div>
								</div>
							</div>
						</td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
		</div>
	</div>
	<%
		String respuesta = (String) session.getAttribute("respuesta");
			if (respuesta != null) {

				if (respuesta.equals("success_e")) {
					out.print("<script>toastr.success('Se elimin� el usuario'); </script> ");
				} else if (respuesta.equals("nosuccess_e")) {
					out.print("<script>toastr.error('No se pudo eliminar el usuario'); </script> ");
				} else if (respuesta.equals("error_e")) {
					out.print("<script>toastr.error('Error al eliminar el usuario'); </script> ");
				} else if (respuesta.equals("success_m")) {
					out.print("<script>toastr.success('Se modific� el usuario'); </script> ");
				} else if (respuesta.equals("nosuccess_m")) {
					out.print("<script>toastr.error('No se pudo modificar el usuario'); </script> ");
				} else if (respuesta.equals("error_m")) {
					out.print("<script>toastr.error('Error al modificar el usuario'); </script> ");
				}
				request.getSession().setAttribute("respuesta", null);
			}
	%>
</body>
</html>
<%
	}
%>