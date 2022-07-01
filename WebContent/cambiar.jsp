
<%
	String usuario2 = (String) session.getAttribute("Usuario");
	if (usuario2 == null) {
		response.sendRedirect("/ontologias/login.jsp");
	} else {
		request.getSession().setMaxInactiveInterval(60 * 60);
		String password = request.getParameter("contra");
		String newpassword = request.getParameter("contra_nueva");
		String newpassword2 = request.getParameter("contra_nueva2");
%>
<%@include file="datosCambiar.jsp"%>
<%@page import="controllers.Usuarios"%>
<%@page import="models.Usuario"%>
<%@page import="java.util.ArrayList"%>
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
<script src="js/navbar.js"></script>
<script>
	loadNavBar({
		src : ''
	});
</script>
</head>
<body>
  <nav id="navBarContent" class="navbar navbar-expand-lg navbar-dark bg-primary" style="justify-content: flex-start; min-height: 66px"></nav>

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