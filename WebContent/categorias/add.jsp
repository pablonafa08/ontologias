
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
<title>Agregar Categoría</title>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../js/bootstrap.min.js" rel="stylesheet">
<link href="../style.css" rel="stylesheet">
<script src="../js/popper.min.js"></script>
<script src="../js/jquery-3.3.1.slim.min.js"></script>
<script src="../js/bootstrap4.min.js"></script>
<script src="../js/fontsolid.js"></script>
<script src="../js/fontawesome.js"></script>
<link href="../css/boton.css" rel="stylesheet">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
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
				<a class="navbar-brand" href="../usuarios/add.jsp">
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
		<div class="row">
			<div class="col-1"></div>
			<div class="col align-self-center">
				<div class="card" style="box-shadow: -4px 5px rgb(237, 234, 245, 0.5);">
					<div class="card-body align-self-center">
						<form action="../InsertarCategoria" method="post" enctype="multipart/form-data">
							<div class="form-group">
								<label for="">Añadir Título</label>
								<input type="text" class="form-control" placeholder="Título" name="titulo">
							</div>
							<div class="form-group">
								<label for="">Añadir Imágen</label>
								<br>
								<!-- button class="btn btn-primary btn-block"> Subir imágen<input type="file"></button-->
								<input type="file" name="file-1" id="file-1" class="inputfile inputfile-1" data-multiple-caption="{count} archivos seleccionados" multiple />
								<label for="file-1">
									<svg xmlns="http://www.w3.org/2000/svg" class="iborrainputfile" width="20" height="17" viewBox="0 0 20 17">
										<path
											d="M10 0l-5.2 4.9h3.3v5.1h3.8v-5.1h3.3l-5.2-4.9zm9.3 11.5l-3.2-2.1h-2l3.4 2.6h-3.5c-.1 0-.2.1-.2.1l-.8 2.3h-6l-.8-2.2c-.1-.1-.1-.2-.2-.2h-3.6l3.4-2.6h-2l-3.2 2.1c-.4.3-.7 1-.6 1.5l.6 3.1c.1.5.7.9 1.2.9h16.3c.6 0 1.1-.4 1.3-.9l.6-3.1c.1-.5-.2-1.2-.7-1.5z"></path></svg>
									<span class="iborrainputfile">Seleccionar imágen</span>
								</label>
							</div>
							<button type="submit" class="btn btn-primary">
								<i class="fas fa-plus"></i>
								Agregar
							</button>
						</form>
					</div>
				</div>
			</div>
			<div class="col-1"></div>
		</div>
	</div>
	<%
		String respuesta = (String) session.getAttribute("respuesta");
			if (respuesta != null) {

				if (respuesta.equals("success")) {
					out.print("<script>toastr.success('Se insertó la categoría'); </script> ");
				} else if (respuesta.equals("nosuccess")) {
					out.print("<script>toastr.error('No se pudo insertar'); </script> ");
				} else if (respuesta.equals("error")) {
					out.print("<script>toastr.error('Error al insertar'); </script> ");
				} else if (respuesta.equals("error_nodata")) {
					out.print("<script>toastr.error('Ingrese el título de la categoría'); </script> ");
				}
				request.getSession().setAttribute("respuesta", null);
			}
	%>
	<script>
		var inputs = document.querySelectorAll('.inputfile');
		Array.prototype.forEach
				.call(
						inputs,
						function(input) {
							var label = input.nextElementSibling, labelVal = label.innerHTML;

							input
									.addEventListener(
											'change',
											function(e) {
												var fileName = '';
												if (this.files
														&& this.files.length > 1)
													fileName = (this
															.getAttribute('data-multiple-caption') || '')
															.replace(
																	'{count}',
																	this.files.length);
												else
													fileName = e.target.value
															.split("\\").pop();

												if (fileName)
													label.querySelector('span').innerHTML = fileName;
												else
													label.innerHTML = labelVal;
											});
						});
	</script>
</body>
</html>
<%
	}
%>