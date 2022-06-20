
<%
	String usuario2 = (String) session.getAttribute("Usuario");
	if (usuario2 == null) {
		response.sendRedirect("/ontologias/login.jsp");
	} else {
		String password = request.getParameter("contra");
		String newpassword = request.getParameter("contra_nueva");
		String newpassword2 = request.getParameter("contra_nueva2");
%>
<%@include file="datosCambiar.jsp"%>
<%@page import="controllers.Usuarios"%>
<%@page import="models.Usuario"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="controllers.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Cambiar contraseña</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="js/bootstrap.min.js" rel="stylesheet">
<link href="./css/mycss.css" rel="stylesheet">
<link href="style.css" rel="stylesheet">
<link href="./css/boton.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script defer src="https://use.fontawesome.com/releases/v5.0.13/js/solid.js" integrity="sha384-tzzSw1/Vo+0N5UhStP3bvwWPq+uvzCMfrN1fEFe+xBmv1C/AtVX5K0uZtmcHitFZ" crossorigin="anonymous"></script>
<script defer src="https://use.fontawesome.com/releases/v5.0.13/js/fontawesome.js" integrity="sha384-6OIrr52G08NpOFSZdxxz1xdNSndlD4vdcf/q2myIUVO0VsqaGHJsB0RaBE01VTOY" crossorigin="anonymous"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<link href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet">
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
              <a class="dropdown-item" href="cambiar.jsp">Cambiar contraseña</a>
              <a class="dropdown-item" href="./salir.jsp">Cerrar sesión</a>
            </div>
          </li>
        </ul>
      </form>
    </div>
  </nav>
  <div class="container">
    <br>
    <div class="row">
      <div class="col-1 "></div>
      <div class="col">
        <h3>Cambiar contraseña</h3>
      </div>
      <div class="col-1"></div>
    </div>
    <br>
    <div class="row">
      <div class="col-1"></div>
      <div class="col">
        <%
        	Usuarios conexion = new Usuarios();
        		ArrayList<Usuario> usuarios = conexion
        				.buscarXId(request.getSession().getAttribute("UsuarioId").toString());
        		for (Usuario usuario : usuarios) {
        			if (request.getParameter("button") != null) {
        				if (request.getAttribute("respuesta") == "success") {
        					password = "";
        					newpassword = "";
        					newpassword2 = "";
        				}
        			}
        %>
        <div class="card" style="box-shadow: -4px 5px rgb(237, 234, 245, 0.5);">
          <div class="card-body ">
            <form action="cambiar.jsp" method="post">
              <div class="row justify-content-center">
                <div class="col-6">
                  <div class="form-group">
                    <label style="font-weight: 600">Usuario</label>
                    <input type="text" class="form-control" placeholder="Nombre(s)" name="nombres" value="<%out.print(usuario.getNombres() + " " + usuario.getApp() + " " + usuario.getApm());%>" readonly>
                  </div>
                  <div class="form-group">
                    <label style="font-weight: 600">Contraseña actual</label>
                    <input type="password" class="form-control" name="contra" value="<%if (password != null) {
						out.print(password);
					}%>">
                  </div>
                  <div class="form-group">
                    <label style="font-weight: 600">Contraseña nueva</label>
                    <input type="password" class="form-control" name="contra_nueva" value="<%if (newpassword != null) {
						out.print(newpassword);
					}%>">
                  </div>
                  <div class="form-group">
                    <label style="font-weight: 600">Repetir contraseña nueva</label>
                    <input type="password" class="form-control" name="contra_nueva2" value="<%if (newpassword2 != null) {
						out.print(newpassword2);
					}%>">
                  </div>
                  <button type="submit" class="btn btn-primary" name="button">
                    <i class="fas fa-save"></i>
                    Guardar
                  </button>
                </div>
              </div>
            </form>
          </div>
        </div>
        <%
        	}
        %>
      </div>
      <div class="col-1"></div>
    </div>
  </div>
  <%
  	if (request.getParameter("button") != null) {
  			if (request.getAttribute("respuesta") == "difpass") {
  				out.print("<script>toastr.error('Las contraseñas no son iguales'); </script> ");
  			} else if (request.getAttribute("respuesta") == "error") {
  				out.print("<script>toastr.error('Error al hacer el cambio de contraseña'); </script> ");
  			} else if (request.getAttribute("respuesta") == "wrongpass") {
  				out.print("<script>toastr.error('La contraseña actual es incorrecta'); </script> ");
  			} else if (request.getAttribute("respuesta") == "nosuccess") {
  				out.print("<script>toastr.error('No se ha podido cambiar la contraseña'); </script> ");
  			} else if (request.getAttribute("respuesta") == "success") {
  				out.print("<script>toastr.success('Se ha cambiado la contraseña exitosamente'); </script> ");
  			} else if (request.getAttribute("respuesta") == "error_notdata") {
  				out.print("<script>toastr.error('Llene todos los campos'); </script> ");
  			}
  		}
  %>
</body>
</html>
<%
	}
%>