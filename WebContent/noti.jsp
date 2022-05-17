
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
<title>Notificaciones</title>
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
<script src="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<link href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet">
</head>
<body>
  <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <img src="img/uasLogo.png" class="logo" alt="Logo" style="height: 50px; width: 50px;">
    <a class="navbar-brand" href="./index.jsp">Ontolog�as</a>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav mr-auto">
      </ul>
      <form class="form-inline my-2 my-lg-0">
        <%
        	if (request.getSession().getAttribute("UsuarioTipo").toString().equals("1")) {
        %>
        <a class="navbar-brand" href="categorias/categorias.jsp">Categor�as</a>
        <a class="navbar-brand" href="categorias/ramas.jsp">Subcategor�as</a>
        <a class="navbar-brand" href="ontologias/todas.jsp">Ontolog�as</a>
        <a class="navbar-brand" href="usuarios/usuarios.jsp">
          <i class="fas fa-users"></i>
        </a>
        <%
        	}
        %>
        <a class="navbar-brand" href="ontologias/propias.jsp">Mis Ontolog�as</a>
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
              <a class="dropdown-item" href="cambiar.jsp">Cambiar Contrase�a</a>
              <a class="dropdown-item" href="./salir.jsp">Cerrar sesi�n</a>
            </div>
          </li>
        </ul>
      </form>
    </div>
  </nav>
  <div class="container">
    <br> <br>
    <table class="table table-hover" id="datos">
      <thead class="thead-default">
        <tr style="text-align: center;">
          <th>Id</th>
          <th>Ontolog�a</th>
          <th>Individuo a eliminar</th>
          <th>Acciones</th>
        <tr>
      </thead>
      <tbody>
        <%
        	Conexion cn = new Conexion();
        		Connection conn = cn.GetConexion();
        		Statement state = conn.createStatement();
        		String UsuarioCategoria = (String) session.getAttribute("UsuarioCategoria").toString();
        		String query;
        		if (UsuarioCategoria.equals("0")) {
        			query = "SELECT * FROM eliminar_individuos JOIN ontologias ON ontologias.id = eliminar_individuos.id_ontologia WHERE eliminar_individuos.estatus = 'P'";
        		} else {
        			query = "SELECT * FROM eliminar_individuos JOIN ontologias ON ontologias.id = eliminar_individuos.id_ontologia WHERE eliminar_individuos.estatus = 'P' AND id_categoria = "
        					+ UsuarioCategoria;
        		}

        		ResultSet rs = state.executeQuery(query);
        		while (rs.next()) {
        %>
        <tr>
          <td style="text-align: center;">
            <%
            	out.print(rs.getString("eliminar_individuos.id"));
            %>
          </td>
          <td style="text-align: center;">
            <%
            	out.print(rs.getString("titulo"));
            %>
          </td>
          <td style="text-align: center;">
            <%
            	out.print(rs.getString("individuo"));
            %>
          </td>
          <td style="text-align: center;">
            <a href="#eliminar-<%out.print(rs.getString("eliminar_individuos.id"));%>" class="btn btn-sm btn-danger" data-toggle="modal">
              <i class="fas fa-trash-alt"></i>
            </a>
            <a href="#rechazar-<%out.print(rs.getString("eliminar_individuos.id"));%>" class="btn btn-sm btn-danger" data-toggle="modal">
              <i class="fas fa-times"></i>
            </a>
            <div class="modal fade" id="eliminar-<%out.print(rs.getString("eliminar_individuos.id"));%>">
              <div class="modal-dialog" role="document">
                <div class="modal-content">
                  <div class="modal-header">
                    <h4 class="modal-title">�Est�s seguro que quieres eliminar?</h4>
                  </div>
                  <div class="modal-body">
                    <h5>
                      Se eliminar� el individuo:
                      <%
                    	out.print(rs.getString("individuo"));
                    %>
                    </h5>
                  </div>
                  <div class="modal-footer">
                    <a
                      href="ModificarAtributosConfirmacion?id=<%out.print(rs.getString("id_ontologia"));%>&individuo=<%out.print(rs.getString("individuo"));%>&ruta=<%out.print(rs.getString("ruta_archivo"));%>&id_e=<%out.print(rs.getString("eliminar_individuos.id"));%>&estatus=A&opcion=eliminar"
                      class="btn btn-primary">Eliminar</a>
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                  </div>
                </div>
              </div>
            </div>
            <div class="modal fade" id="rechazar-<%out.print(rs.getString("eliminar_individuos.id"));%>">
              <div class="modal-dialog" role="document">
                <div class="modal-content">
                  <div class="modal-header">
                    <h4 class="modal-title">�Est�s seguro que quieres rechazar?</h4>
                  </div>
                  <div class="modal-body">
                    <h5>
                      Se rechazar� la eliminaci�n del individuo:
                      <%
                    	out.print(rs.getString("individuo"));
                    %>
                    </h5>
                  </div>
                  <div class="modal-footer">
                    <a
                      href="ModificarAtributosConfirmacion?id=<%out.print(rs.getString("id_ontologia"));%>&individuo=<%out.print(rs.getString("individuo"));%>&ruta=<%out.print(rs.getString("ruta_archivo"));%>&id_e=<%out.print(rs.getString("eliminar_individuos.id"));%>&estatus=B&opcion=eliminar"
                      class="btn btn-primary">Rechazar</a>
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
    <table class="table table-hover" id="datos2">
      <thead class="thead-default">
        <tr style="text-align: center;">
          <th>Id</th>
          <th>Ontolog�a</th>
          <th>Individuo</th>
          <th>Nuevos datos</th>
          <th>Acciones</th>
        <tr>
      </thead>
      <tbody>
        <%
        	Connection conn3 = cn.GetConexion();
        		Statement states = conn.createStatement();
        		String UsuarioCategoria2 = (String) session.getAttribute("UsuarioCategoria").toString();
        		String query2;
        		if (UsuarioCategoria.equals("0")) {
        			query = "SELECT * FROM modificar_individuos JOIN ontologias ON ontologias.id = modificar_individuos.id_ontologia WHERE modificar_individuos.estatus = 'P'";
        		} else {
        			query = "SELECT * FROM modificar_individuos JOIN ontologias ON ontologias.id = modificar_individuos.id_ontologia WHERE modificar_individuos.estatus = 'P' AND id_categoria = "
        					+ UsuarioCategoria;
        		}

        		ResultSet rs1 = state.executeQuery(query);
        		while (rs1.next()) {
        %>
        <tr>
          <td style="text-align: center;">
            <%
            	out.print(rs1.getString("modificar_individuos.id"));
            %>
          </td>
          <td style="text-align: center;">
            <%
            	out.print(rs1.getString("titulo"));
            %>
          </td>
          <td style="text-align: center;">
            <%
            	out.print(rs1.getString("individuo"));
            %>
          </td>
          <%
          	
          %>
          <td style="text-align: center;">
            <%
            	int y = 0;
            			String atributosSplit[] = rs1.getString("atributos").split("��");

            			int existe = atributosSplit.length;
            			if (atributosSplit[existe - 1].substring(0, 1).equals("~")) {
            				for (y = 0; y < atributosSplit.length - 1; y++) {
            					out.print(" " + atributosSplit[y] + " ");
            				}
            			} else {
            				for (y = 0; y < atributosSplit.length; y++) {
            					out.print(" " + atributosSplit[y] + " ");
            				}
            			}

            			String relacionesSplit[] = rs1.getString("atributos").split("~~");
            			for (y = 1; y < relacionesSplit.length; y++) {
            				out.print(relacionesSplit[y] + " ");
            			}
            %>
          </td>
          <td style="text-align: center;">
            <a href="#modificar-<%out.print(rs1.getString("modificar_individuos.id"));%>" class="btn btn-sm btn-secondary" data-toggle="modal">
              <i class="fas fa-pencil-alt"></i>
            </a>
            <a href="#rechazarc-<%out.print(rs1.getString("modificar_individuos.id"));%>" class="btn btn-sm btn-danger" data-toggle="modal">
              <i class="fas fa-times"></i>
            </a>
            <div class="modal fade" id="modificar-<%out.print(rs1.getString("modificar_individuos.id"));%>">
              <div class="modal-dialog" role="document">
                <div class="modal-content">
                  <div class="modal-header">
                    <h4 class="modal-title">
                      Se modificara el individuo:
                      <%
                    	out.print(rs1.getString("individuo"));
                    %>
                    </h4>
                  </div>
                  <form method="post" action="ModificarAtributosConfirmacion">
                    <div class="modal-body">
                      <h5>Nuevos datos:</h5>
                      <%
                      	String atributosSplit2[] = rs1.getString("atributos").split("��");

                      			if (atributosSplit2[existe - 1].substring(0, 1).equals("~")) {
                      				for (y = 0; y < atributosSplit2.length - 1; y++) {
                      %>
                      <label class="form-control">
                        <%
                        	out.print(" " + atributosSplit2[y] + " ");
                        %>
                      </label>
                      <%
                      	}
                      			} else {
                      				for (y = 0; y < atributosSplit2.length; y++) {
                      %>
                      <label class="form-control">
                        <%
                        	out.print(" " + atributosSplit2[y] + " ");
                        %>
                      </label>
                      <%
                      	}
                      			}
                      %>
                      <%
                      	String relacionesSplit2[] = rs1.getString("atributos").split("~~");
                      			for (y = 1; y < relacionesSplit2.length; y++) {
                      %>
                      <label class="form-control">
                        <%
                        	out.print(relacionesSplit2[y] + " ");
                        %>
                      </label>
                      <%
                      	}
                      %>
                      <input type="hidden" name="elid" value="<%out.print(rs1.getString("modificar_individuos.id"));%>">
                    </div>
                    <div class="modal-footer">
                      <button type="submit" class="btn btn-primary">Modificar</button>
                      <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                    </div>
                  </form>
                </div>
              </div>
            </div>
            <div class="modal fade" id="rechazarc-<%out.print(rs1.getString("modificar_individuos.id"));%>">
              <div class="modal-dialog" role="document">
                <div class="modal-content">
                  <div class="modal-header">
                    <h4 class="modal-title">�Est�s seguro que quieres rechazar?</h4>
                  </div>
                  <div class="modal-body">
                    <h5>
                      Se rechazar� la modificaci�n del individuo:
                      <%
                    	out.print(rs1.getString("individuo"));
                    %>
                    </h5>
                  </div>
                  <div class="modal-footer">
                    <a href="ModificarAtributosConfirmacion?id=<%out.print(rs1.getString("modificar_individuos.id"));%>&opcion=modificar" class="btn btn-primary">Rechazar</a>
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
  				out.print("<script>toastr.success('Se elimin� el individuo'); </script> ");
  			} else if (respuesta.equals("nosuccess_e")) {
  				out.print("<script>toastr.error('No se pudo eliminar el individuo'); </script> ");
  			} else if (respuesta.equals("error_e")) {
  				out.print("<script>toastr.error('Error'); </script> ");
  			} else if (respuesta.equals("success_r")) {
  				out.print("<script>toastr.success('Se rechaz� la petici�n de eliminaci�n'); </script> ");
  			} else if (respuesta.equals("nosuccess_r")) {
  				out.print("<script>toastr.error('No se pudo rechazar la petici�n de eliminaci�n'); </script> ");
  			} else if (respuesta.equals("success_m")) {
  				out.print("<script>toastr.success('Se modific� el individuo'); </script> ");
  			} else if (respuesta.equals("nosuccess_m")) {
  				out.print("<script>toastr.error('No se pudo modificar el individuo'); </script> ");
  			} else if (respuesta.equals("success_rm")) {
  				out.print("<script>toastr.success('Se rechaz� la petici�n de modificacion'); </script> ");
  			} else if (respuesta.equals("nosuccess_rm")) {
  				out.print(
  						"<script>toastr.error('No se pudo rechazar la petici�n de modificacion'); </script> ");
  			} else if (respuesta.equals("error_m")) {
  				out.print("<script>toastr.error('Error'); </script> ");
  			}
  			request.getSession().setAttribute("respuesta", null);
  		}
  %>
</body>
</html>
<%
	}
%>