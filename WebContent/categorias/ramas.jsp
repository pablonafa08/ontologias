
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
<%@page import="controllers.SubCategorias"%>
<%@page import="models.SubCategoria"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="controllers.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Subcategorías</title>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../js/bootstrap.min.js" rel="stylesheet">
<link href="../style.css" rel="stylesheet">
<script src="../js/popper.min.js"></script>
<script src="../js/jquery-3.3.1.slim.min.js"></script>
<script src="../js/bootstrap4.min.js"></script>
<script src="../js/fontsolid.js"></script>
<script src="../js/fontawesome.js"></script>
<link href="../css/boton.css" rel="stylesheet">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="../js/BuscarSubCategoria2.js"></script>
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
      <a href="add.jsp" class="btn btn-primary" style="color: white; margin-right: 10px;">
        <i class="fas fa-plus"></i>
        Nueva categoría
      </a>
      <a href="addramas.jsp" class="btn btn-primary" style="color: white;">
        <i class="fas fa-plus"></i>
        Nueva subcategoría
      </a>
    </div>
    <br>
    <div class="row justify-content-between align-items-center">
      <div class="col-4">
        <h3>Subcategorías</h3>
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
    <h4 id="datos3" style="display: none; text-align: center; margin-top: 30px">No se han registrado subcategorías</h4>
    <h4 id="datos2" style="display: none; text-align: center; margin-top: 30px">No se encontraron coincidencias</h4>
    <table class="table table-hover" id="datos">
      <thead class="thead-default">
        <tr style="text-align: center;">
          <th>Id</th>
          <th>Subcategoría</th>
          <th>Ontologías</th>
          <th>Acciones</th>
        <tr>
      </thead>
      <tbody>
        <%
        	Conexion cn = new Conexion();
        		Connection conn = cn.GetConexion();
        		Statement state = conn.createStatement();
        		SubCategorias conexion = new SubCategorias();
        		long ontologias = 0;
        		ArrayList<SubCategoria> subcategorias = conexion.listar();
        		for (SubCategoria subcategoria : subcategorias) {

        			ResultSet rs = state.executeQuery(
        					"SELECT count(*) as total FROM ontologias WHERE estatus = 'A' AND id_subcategoria = "
        							+ subcategoria.getId());
        			while (rs.next()) {
        				ontologias = (long) rs.getObject("total");
        			}
        %>
        <tr>
          <td style="text-align: center;">
            <%
            	out.print(subcategoria.getId());
            %>
          </td>
          <td style="text-align: center;">
            <%
            	out.print(subcategoria.getTitulo());
            %>
          </td>
          <td style="text-align: center;">
            <%
            	out.print(ontologias);
            %>
          </td>
          <td>
            <div class="row justify-content-center">
              <a href="modificarsubcategoria.jsp?id=<%out.print(subcategoria.getId());%>" class="btn btn-sm btn-primary" style="margin-right: 8px">
                <i class="fas fa-pencil-alt"></i>
              </a>
              <%
              	if (ontologias == 0) {
              %>
              <a href="#eliminar-<%out.print(subcategoria.getId());%>" class="btn btn-sm btn-danger" data-toggle="modal">
                <i class="fas fa-trash-alt"></i>
              </a>
              <%
              	} else {
              %>
              <a href="#eliminar-<%out.print(subcategoria.getId());%>" class="btn btn-sm btn-danger disabled" data-toggle="modal">
                <i class="fas fa-trash-alt"></i>
              </a>
              <%
              	}
              %>
            </div>
            <!-- Eliminar -->
            <div class="modal fade" id="eliminar-<%out.print(subcategoria.getId());%>">
              <div class="modal-dialog" role="document">
                <div class="modal-content">
                  <div class="modal-header justify-content-center" style="text-align: center">
                    <h5 class="modal-title">¿Estás seguro que quieres eliminar?</h5>
                  </div>
                  <form class="form-group" method="post" action="#">
                    <div class="modal-body">
                      <p style="text-align: center">
                        Se eliminará la subcategoría: <b> <%
 	out.print(subcategoria.getTitulo());
 %>
                        </b>
                      </p>
                    </div>
                    <div class="modal-footer">
                      <a href="../ModificarSubCategoria?id=<%out.print(subcategoria.getId());%>" class="btn btn-primary">Eliminar</a>
                      <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                    </div>
                  </form>
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
  			if (respuesta.equals("success")) {
  				out.print("<script>toastr.success('Se eliminó la subcategoría'); </script> ");
  			} else if (respuesta.equals("nosuccess")) {
  				out.print("<script>toastr.error('No se pudo eliminar la subcategoría'); </script> ");
  			} else if (respuesta.equals("error")) {
  				out.print("<script>toastr.error('Error al eliminar la subcategoría'); </script> ");
  			} else if (respuesta.equals("success_m")) {
  				out.print("<script>toastr.success('Se modificó la subcategoría'); </script> ");
  			} else if (respuesta.equals("nosuccess_m")) {
  				out.print("<script>toastr.error('No se pudo modificar la subcategoría'); </script> ");
  			} else if (respuesta.equals("error_m")) {
  				out.print("<script>toastr.error('Error al modificar la subcategoría'); </script> ");
  			}
  			request.getSession().setAttribute("respuesta", null);
  		}
  %>
</body>
</html>
<%
	}
%>