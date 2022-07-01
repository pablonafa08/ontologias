
<%
	String usuario2 = (String) session.getAttribute("Usuario");
	if (usuario2 == null) {
		response.sendRedirect("/ontologias/login.jsp");
	} else {
		request.getSession().setMaxInactiveInterval(60 * 60);
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Datos de la ontología</title>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../js/bootstrap.min.js" rel="stylesheet">
<link href="../style.css" rel="stylesheet">
<link href="../css/mycss.css" rel="stylesheet">
<script src="../js/popper.min.js"></script>
<script src="../js/jquery-3.3.1.slim.min.js"></script>
<script src="../js/bootstrap4.min.js"></script>
<script src="../js/fontsolid.js"></script>
<script src="../js/fontawesome.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<link href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet">
<script src="../js/filterTableIndividuals.js"></script>
<script src="../js/navbar.js"></script>
<script>
	loadNavBar({
		src : '../'
	});
</script>
</head>
<body>
  <nav id="navBarContent" class="navbar navbar-expand-lg navbar-dark bg-primary" style="justify-content: flex-start; min-height: 66px"></nav>

  <br>
  <div class="container">
    <div class="row justify-content-between m-0">
      <%
      	String id_subcategoria = (String) session.getAttribute("id_subcategoria");
      		if (id_subcategoria != null) {
      %>
      <a href="ontologias.jsp?id=<%out.print(id_subcategoria);%>" class="btn btn-primary" style="color: white;">
        <i class="fas fa-mouse-pointer"></i>
        Seleccionar ontología
      </a>
      <%
      	}
      %>
      <a href="ver.jsp" class="btn btn-primary" style="color: white;">
        <i class="fas fa-plus"></i>
        Nuevo individuo
      </a>
    </div>
    <br>
    <div class="row justify-content-between align-items-center">
      <div class="col-4">
        <h3>Datos de la ontología</h3>
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
    <h4 id="noMatches" style="display: none; text-align: center; margin-top: 30px">No se encontraron coincidencias</h4>
    <h4 id="noDataRecorded" style="display: none; text-align: center; margin-top: 30px">No se han registrado individuos</h4>
    <div id="contentTable" style="padding-bottom: 100px">
      <%-- Los datos se muestran desde el archivo filterIndividuals.js --%>
      <div style="display: flex; justify-content: center;">
        <div class="spinner-border text-primary" style="width: 50px; height: 50px;"></div>
      </div>
    </div>
  </div>
  <%
  	String respuesta = (String) session.getAttribute("respuesta");

  		if (respuesta != null) {
  			if (respuesta.equals("success_i")) {
  				out.print("<script>toastr.success('Se insertó el individuo'); </script> ");
  			} else if (respuesta.equals("success_e")) {
  				out.print(
  						"<script>toastr.success('Se ha puesto en pendiente para su eliminación'); </script> ");
  			} else if (respuesta.equals("nosuccess_e")) {
  				out.print(
  						"<script>toastr.error('No se pudo pudo poner en pendiente para su eliminación'); </script> ");
  			} else if (respuesta.equals("error_e")) {
  				out.print("<script>toastr.error('Error al cambiar estatus'); </script> ");
  			} else if (respuesta.equals("success_m")) {
  				out.print(
  						"<script>toastr.success('Se ha puesto en pendiente para su modificación'); </script> ");
  			} else if (respuesta.equals("nosuccess_m")) {
  				out.print(
  						"<script>toastr.error('No se pudo pudo poner en pendiente para su modificación'); </script> ");
  			} else if (respuesta.equals("error_m")) {
  				out.print("<script>toastr.error('Error al cambiar estatus'); </script> ");
  			}
  			request.getSession().setAttribute("respuesta", null);
  		}
  %>
</body>
</html>
<%
	}
%>