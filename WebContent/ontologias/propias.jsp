
<%
	String usuario2 = (String) session.getAttribute("Usuario");
	if (usuario2 == null) {
		response.sendRedirect("/ontologias/login.jsp");
	} else {
		request.getSession().setMaxInactiveInterval(60 * 60);
%>
<%@page import="java.util.ArrayList"%>
<%@page import="models.Ontologia"%>
<%@page import="controllers.Ontologias"%>
<%@page import="java.sql.*"%>
<%@page import="controllers.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Mis ontologías</title>
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
        Nueva ontología
      </a>
    </div>
    <br>
    <div class="row justify-content-between align-items-center">
      <div class="col-4 ">
        <h3>Mis ontologías</h3>
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
    <h4 id="datos3" style="display: none; text-align: center; margin-top: 30px">No se han registrado ontologías</h4>
    <h4 id="datos2" style="display: none; text-align: center; margin-top: 30px">No se encontraron coincidencias</h4>
    <table class="table table-hover" id="datos">
      <thead class="thead-default">
        <tr style="text-align: center;">
          <th>Id</th>
          <th>Título o descripción</th>
          <th>Categoría</th>
          <th>Subcategoría</th>
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
            <a href="todos.jsp?id=<%out.print(ontologia.getId());%>" class="btn btn-sm btn-primary">
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