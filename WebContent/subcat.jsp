
<%
	String usuario2 = (String) session.getAttribute("Usuario");
	if (usuario2 == null) {
		response.sendRedirect("/ontologias/login.jsp");
	} else {
		String id = request.getParameter("id").toString();
		request.getSession().setAttribute("id_categoria", id);
		request.getSession().setMaxInactiveInterval(60 * 60);
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1" />
<title>Subcategoría</title>
<link href="css/bootstrap.min.css" rel="stylesheet" />
<link href="js/bootstrap.min.js" rel="stylesheet" />
<link href="./css/mycss.css" rel="stylesheet" />
<link href="style.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script defer src="https://use.fontawesome.com/releases/v5.0.13/js/solid.js" integrity="sha384-tzzSw1/Vo+0N5UhStP3bvwWPq+uvzCMfrN1fEFe+xBmv1C/AtVX5K0uZtmcHitFZ" crossorigin="anonymous"></script>
<script defer src="https://use.fontawesome.com/releases/v5.0.13/js/fontawesome.js" integrity="sha384-6OIrr52G08NpOFSZdxxz1xdNSndlD4vdcf/q2myIUVO0VsqaGHJsB0RaBE01VTOY" crossorigin="anonymous"></script>
<script src="js/BuscarSubCategoria.js"></script>
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
    <br /> <br />
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
          <input type="text" class="form-control" placeholder="Buscar" id="buscar" aria-label="Buscar" aria-describedby="btnGroupAddon" />
        </div>
      </div>
    </div>
    <br />
    <div id="subcategorias">
      <!--  Los datos se muestran desde el archivo BuscarSubCategoria.js -->
      <div style="display: flex; justify-content: center;">
        <div class="spinner-border text-primary" style="width: 50px; height: 50px;"></div>
      </div>
    </div>
  </div>
</body>
</html>
<%
	}
%>
