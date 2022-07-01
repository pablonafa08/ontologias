
<%
	String usuario2 = (String) session.getAttribute("Usuario");
	String usuarioTipo = (String) session.getAttribute("UsuarioTipo");
	if (usuario2 == null || usuarioTipo == null) {
		response.sendRedirect("/ontologias/login.jsp");
	} else if (!usuarioTipo.equals("1")) {
		response.sendRedirect("/ontologias/login.jsp");
	} else {
		request.getSession().setMaxInactiveInterval(60 * 60);
%>
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
<script src="../js/navbar.js"></script>
<script>
	loadNavBar({
		src : '../'
	});
</script>
</head>
<body onload="doSearch();">
  <nav id="navBarContent" class="navbar navbar-expand-lg navbar-dark bg-primary" style="justify-content: flex-start; min-height: 66px"></nav>

  <br>
  <div class="container">
    <div class="row justify-content-end m-0">
      <a href="add.jsp" class="btn btn-primary" style="color: white;">
        <i class="fas fa-plus"></i>
        Nuevo usuario
      </a>
    </div>
    <br>
    <div class="row justify-content-between align-items-center">
      <div class="col-4">
        <h3>Usuarios</h3>
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
    <h4 id="datos3" style="display: none; text-align: center; margin-top: 30px">No se han registrado usuarios</h4>
    <h4 id="datos2" style="display: none; text-align: center; margin-top: 30px">No se encontraron coincidencias</h4>
    <table class="table table-hover" id="datos">
      <thead class="thead-default">
        <tr style="text-align: center;">
          <th>Nombres</th>
          <th>Correo</th>
          <th>Usuario</th>
          <th>Ontologías subidas</th>
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
          <td>
            <div class="row justify-content-center">
              <a href="#modificar-<%out.print(usuario.getId());%>" class="btn btn-sm btn-primary" style="margin-right: 8px" data-toggle="modal">
                <i class="fas fa-pencil-alt"></i>
              </a>
              <a href="#eliminar-<%out.print(usuario.getId());%>" class="btn btn-sm btn-danger" data-toggle="modal">
                <i class="fas fa-trash-alt"></i>
              </a>
            </div>
            <!-- Modificar -->
            <div class="modal fade" id="modificar-<%out.print(usuario.getId());%>">
              <div class="modal-dialog" role="document">
                <div class="modal-content">
                  <div class="modal-header justify-content-center" style="text-align: center">
                    <h5 class="modal-title">Editar usuario</h5>
                  </div>
                  <form action="../ModificarUsuario" method="post">
                    <div class="modal-body">
                      <input type="hidden" class="form-control" name="id_usu" value="<%out.print(usuario.getId());%>">
                      <div class="form-group">
                        <label style="font-weight: 600">Nombre(s)</label>
                        <input type="text" class="form-control" placeholder="Nombre(s)" name="nombres" value="<%out.print(usuario.getNombres());%>">
                      </div>
                      <div class="form-group">
                        <label style="font-weight: 600">Apellido paterno</label>
                        <input type="text" class="form-control" placeholder="Apellido paterno" name="app" value="<%out.print(usuario.getApp());%>">
                      </div>
                      <div class="form-group">
                        <label style="font-weight: 600">Apellido materno</label>
                        <input type="text" class="form-control" placeholder="Apellido materno" name="apm" value="<%out.print(usuario.getApm());%>">
                      </div>
                    </div>
                    <div class="modal-footer">
                      <button type="submit" name="guardar" id="guardar" class="btn btn-primary">Guardar</button>
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
                  <div class="modal-header justify-content-center" style="text-align: center">
                    <h5 class="modal-title">¿Estás seguro que quieres eliminar?</h5>
                  </div>
                  <div class="modal-body">
                    <p style="text-align: center">
                      Se eliminará el usuario: <b> <%
 	out.print(usuario.getNombres() + " " + usuario.getApp() + " " + usuario.getApm());
 %>
                      </b>
                    </p>
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
  <%
  	String respuesta = (String) session.getAttribute("respuesta");
  		if (respuesta != null) {

  			if (respuesta.equals("success_e")) {
  				out.print("<script>toastr.success('Se eliminó el usuario'); </script> ");
  			} else if (respuesta.equals("nosuccess_e")) {
  				out.print("<script>toastr.error('No se pudo eliminar el usuario'); </script> ");
  			} else if (respuesta.equals("error_e")) {
  				out.print("<script>toastr.error('Error al eliminar el usuario'); </script> ");
  			} else if (respuesta.equals("success_m")) {
  				out.print("<script>toastr.success('Se modificó el usuario'); </script> ");
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