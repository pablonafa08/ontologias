
<%
	String usuario2 = (String) session.getAttribute("Usuario");
	if (usuario2 == null) {
		response.sendRedirect("/ontologias/login.jsp");
	} else {
		String clase_s = request.getSession().getAttribute("clase_e").toString();
		request.getSession().setMaxInactiveInterval(60 * 60);
%>
<%@page import="controllers.ClasesLectura"%>
<%@page import="controllers.ClasesConsultar"%>
<%@page import="org.apache.jena.ontology.DatatypeProperty"%>
<%@page import="models.Utils"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Nuevo individuo "<%
	out.print(clase_s);
%>"
</title>
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
        <h3>
          Nuevo individuo "<%
        	out.print(clase_s);
        %>"
        </h3>
      </div>
      <div class="col-1"></div>
    </div>
    <br>
    <div class="row">
      <div class="col-2">
        <a href="ver.jsp" class="btn btn-primary" style="color: white;">
          <i class="fas fa-mouse-pointer"></i>
          Seleccionar clase
        </a>
        <br> <br>
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
          <div class="card-body ">
            <div class="row justify-content-center">
              <div class="col-8">
                <form class="form-group" method="post" action="../InsertarAtributos">
                  <div class="form-group">
                    <label style="font-weight: 600">Nombre de individuo</label>
                    <input class="form-control" type="text" name="nombre_individuo">
                  </div>
                  <%
                  	ClasesLectura clases = new ClasesLectura();
                  		Utils utils = new Utils();
                  		ClasesConsultar consulta = new ClasesConsultar();

                  		String nombre = request.getSession().getAttribute("ruta").toString();
                  		String ruta = utils.getRuta() + nombre;
                  		String clase = request.getSession().getAttribute("clase_e").toString();
                  		String[] NSySimbolo = consulta.consultarNSySimbolo(ruta);
                  		String NS = NSySimbolo[0];
                  		String simbolo = NSySimbolo[1];
                  		String objetos[] = clases.leerObjetos(ruta, clase, simbolo, NS);
                  		DatatypeProperty atributoss[] = consulta.consultarAtributos(ruta, clase, simbolo, NS);

                  		for (DatatypeProperty atributo : atributoss) {
                  %>
                  <div class="form-group">
                    <label style="font-weight: 600">
                      <%
                      	out.print(atributo.getLocalName());
                      %>
                    </label>
                    <%
                    	if (atributo.getRange().getLocalName().equals("decimal")) {
                    %>
                    <input class="form-control" type="number" step="any" name="<%out.print(atributo.getLocalName());%>">
                    <%
                    	} else if (atributo.getRange().getLocalName().equals("integer")
                    					|| atributo.getRange().getLocalName().equals("int")) {
                    %>
                    <input class="form-control" type="number" name="<%out.print(atributo.getLocalName());%>">
                    <%
                    	} else {
                    %>
                    <input class="form-control" type="text" name="<%out.print(atributo.getLocalName());%>">
                    <%
                    	}
                    %>
                  </div>
                  <%
                  	}

                  		for (String objeto : objetos) {
                  %>
                  <div class="form-group">
                    <label style="font-weight: 600">
                      <%
                      	out.print(objeto);
                      %>
                    </label>
                    <select class="form-control" name="<%out.print(objeto);%>">
                      <%
                      	String individuals[] = clases.leerIndividual(ruta, objeto);
                      			for (String individual : individuals) {
                      %>
                      <option value="<%out.print(individual);%>">
                        <%
                        	out.print(individual);
                        %>
                      </option>
                      <%
                      	}
                      %>
                    </select>
                  </div>
                  <%
                  	}
                  %>
                  <button type="submit" class="btn btn-primary">
                    <i class="fas fa-plus"></i>
                    Agregar
                  </button>
                </form>
              </div>
            </div>
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