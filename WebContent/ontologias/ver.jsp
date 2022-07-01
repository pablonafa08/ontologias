
<%
	String usuario2 = (String) session.getAttribute("Usuario");
	if (usuario2 == null) {
		response.sendRedirect("/ontologias/login.jsp");
	} else {
		request.getSession().setMaxInactiveInterval(60 * 60);
%>
<%@page import="controllers.ClasesLectura"%>
<%@page import="models.Utils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Seleccionar clase</title>
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
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
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
    <div class="row">
      <div class="col-2"></div>
      <div class="col">
        <h3>Seleccionar clase</h3>
      </div>
      <div class="col-1"></div>
    </div>
    <br>
    <div class="row">
      <div class="col-2">
        <%
        	String id_ontologia = request.getSession().getAttribute("id_ontologia").toString();
        %>
        <a href="todos.jsp?id=<%out.print(id_ontologia);%>" class="btn btn-primary" style="color: white;">
          <i class="fas fa-search"></i>
          Consultar datos de la ontología
        </a>
      </div>
      <div class="col">
        <div class="card" style="box-shadow: -4px 5px rgb(237, 234, 245, 0.5);">
          <div class="card-body">
            <form action="../MostrarCampos" method="post" class="form-group">
              <div class="row">
                <%
                	Utils utils = new Utils();
                		String nombre = request.getSession().getAttribute("ruta").toString();
                		String ruta = utils.getRuta() + nombre;
                		ClasesLectura clases = new ClasesLectura();
                		String clasess[] = clases.leerClase(ruta);
                		for (String clase : clasess) {
                %>
                <div class="col-6 my-1">
                  <button class="btn btn-block btn-primary" type="input" name="clase" value="<%out.print(clase);%>">
                    <%
                    	out.print(clase);
                    %>
                  </button>
                </div>
                <%
                	}
                %>
              </div>
            </form>
          </div>
        </div>
      </div>
      <div class="col-1"></div>
    </div>
  </div>
</body>
</html>
<%
	}
%>