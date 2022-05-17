<%@page import="java.util.Date"%>
<%@page import="org.apache.jena.ontology.ObjectProperty"%>
<%@page import="org.apache.jena.ontology.DatatypeProperty"%>
<%@page import="org.apache.jena.ontology.Individual"%>
<%@page import="controllers.ClasesConsultar"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%
	String usuario2 = (String) session.getAttribute("Usuario");
	if (usuario2 == null) {
		response.sendRedirect("/ontologias/login.jsp");
	} else {
%>
<%@page import="controllers.ClasesLectura"%>
<%@page import="java.sql.*"%>
<%@page import="controllers.Conexion"%>
<%@page import="controllers.Usuarios"%>
<%@page import="models.Usuario"%>
<%@page import="models.Utils"%>
<%@page import="models.TodosIndividuosYOtros"%>
<%@page import="models.IndividuosTodos"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.commons.lang3.ArrayUtils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Consultar</title>
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
<script src="../js/buscarIndividuo.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<link href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet">
</head>
<body onload="doSearch();">
  <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <img src="../img/uasLogo.png" class="logo" alt="Logo" style="height: 50px; width: 50px;">
    <a class="navbar-brand" href="../index.jsp">Ontologías</a>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav mr-auto">
      </ul>
      <form class="form-inline my-2 my-lg-0">
        <%
        	if (request.getSession().getAttribute("UsuarioTipo").toString().equals("1")) {
        %>
        <a class="navbar-brand" href="../categorias/categorias.jsp">Categorías</a>
        <a class="navbar-brand" href="../categorias/ramas.jsp">Subcategorías</a>
        <a class="navbar-brand" href="../ontologias/todas.jsp">Ontologías</a>
        <a class="navbar-brand" href="../usuarios/usuarios.jsp">
          <i class="fas fa-users"></i>
        </a>
        <%
        	}
        %>
        <a class="navbar-brand" href="../ontologias/propias.jsp">Mis Ontologías</a>
        <a class="navbar-brand" href="../noti.jsp">
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
              <img src="../img/face2.png" style="width: 2rem; height: 2rem; object-fit: cover;">
              <%
              	}
              		}
              %>
            </a>
            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
              <a class="dropdown-item" href="../perfil.jsp">Ver Perfil</a>
              <a class="dropdown-item" href="../cambiar.jsp">Cambiar Contraseña</a>
              <a class="dropdown-item" href="../salir.jsp">Cerrar sesión</a>
            </div>
          </li>
        </ul>
      </form>
    </div>
  </nav>
  <div class="container">
    <br>
    <div class="row justify-content-between">
      <div class="col-3">
        <%
        	String id_subcategoria = (String) session.getAttribute("id_subcategoria");
        		if (id_subcategoria != null) {
        %>
        <a href="ontologias.jsp?id=<%out.print(id_subcategoria);%>" class="btn btn-primary" style="color: white;">
          <i class="fas fa-mouse-pointer"></i>
          Seleccionar Ontologia
        </a>
        <br> <br>
        <%
        	}
        %>
      </div>
      <div class="col-3">
        <a href="ver.jsp" class="btn btn-primary" style="color: white;">
          Añadir individuo
          <i class="fas fa-plus"></i>
        </a>
      </div>
    </div>
    <br>
    <div class="row justify-content-between align-items-center">
      <div class="col-4 "></div>
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
    <h3 id="datos3" style="display: none">No se han registrado individuos</h3>
    <h3 id="datos2" style="display: none">No se encontraron coincidencias</h3>
    <table class="table table-hover" id="datos">
      <thead class="thead-default">
        <%
        	Date fechaPPP = new Date();
        		DateFormat hourdateFormatPPP = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy");
        		System.out.println(hourdateFormatPPP.format(fechaPPP));
        		String UsuarioCategoria = (String) session.getAttribute("UsuarioCategoria").toString();

        		String id = request.getParameter("id").toString();
        		Conexion cnInEl = new Conexion();
        		Connection connInEl = cnInEl.GetConexion();
        		Statement stateInEl = connInEl.createStatement();
        		ResultSet rsInEl = stateInEl.executeQuery(
        				"SELECT individuo from eliminar_individuos WHERE estatus = 'P' and id_ontologia = " + id);
        		ArrayList<String> individuosEliminados = new ArrayList<String>();
        		while (rsInEl.next()) {
        			individuosEliminados.add(rsInEl.getObject("individuo").toString());
        		}

        		Conexion cnInMo = new Conexion();
        		Connection connInMo = cnInMo.GetConexion();
        		Statement stateInMo = connInMo.createStatement();
        		ResultSet rsInMo = stateInMo.executeQuery(
        				"SELECT individuo from modificar_individuos WHERE estatus = 'P' and id_ontologia = " + id);
        		ArrayList<String> individuosModificados = new ArrayList<String>();
        		while (rsInMo.next()) {
        			individuosModificados.add(rsInMo.getObject("individuo").toString());
        		}

        		request.getSession().setAttribute("id_ontologia", id);
        		request.getSession().setMaxInactiveInterval(60 * 30);
        		Conexion cn = new Conexion();
        		Connection conn = cn.GetConexion();
        		Statement state = conn.createStatement();
        		ResultSet rs = state.executeQuery("SELECT ruta_archivo, id_categoria FROM ontologias WHERE id= " + id);
        		String nombre = "";
        		String idCategoriaOntologia = "";
        		while (rs.next()) {
        			nombre = rs.getObject("ruta_archivo").toString();
        			idCategoriaOntologia = rs.getObject("id_categoria").toString();
        		}
        		request.getSession().setAttribute("ruta", nombre);
        		request.getSession().setMaxInactiveInterval(60 * 30);
        		Utils utils = new Utils();
        		String ruta = utils.getRuta() + nombre;

        		ClasesConsultar query = new ClasesConsultar();
        		String[] NSySimbolo = query.consultarNSySimbolo(ruta);
        		String NS = NSySimbolo[0];
        		String simbolo = NSySimbolo[1];
        		/* Individual[] individuos = query.consultarIndividualTodos(ruta); */

        		System.out.println("Traer todo");
        		TodosIndividuosYOtros todo = query.consultarIndividualTodos2(ruta, simbolo, NS);
        		Individual[] individuos = todo.getIndividuos();
        		String[] clasesNuevas = todo.getClases();
        		IndividuosTodos[] atributosYRelaciones = todo.getAtributosYRelaciones();
        		/* System.out.println("Empiezo el for");
        		for (Individual individuo : individuosNuevos) {
        			System.out.println(individuo.getLocalName());
        			int index = ArrayUtils.indexOf(clasesNuevas, individuo.getOntClass().getLocalName());
        			DatatypeProperty[] atributos = atributosYRelaciones[index].getAtributos();
        			System.out.println(Arrays.toString(atributos));
        		}
        		System.out.println("Termino el for"); */
        %>
        <tr style="text-align: center;">
          <th>Individuo</th>
          <th>Datos</th>
          <th>Relaciones</th>
          <th>Acciones</th>
        </tr>
      </thead>
      <tbody>
        <%
        	for (Individual individuo : individuos) {
        %>
        <tr>
          <td>
            <%
            	out.print(individuo.getLocalName());
            %>
          </td>
          <%
          	int index = ArrayUtils.indexOf(clasesNuevas, individuo.getOntClass().getLocalName());
          			DatatypeProperty[] atributos = atributosYRelaciones[index].getAtributos();
          			/* DatatypeProperty atributos[] = query.consultarAtributos(ruta,
          							individuo.getOntClass().getLocalName(), simbolo, NS); */
          			/* System.out.println(Arrays.toString(atributos)); */
          			/* ObjectProperty relaciones[] = query.consultarRelacion(ruta, individuo.getOntClass().getLocalName(),
          					simbolo, NS); */
          			ObjectProperty[] relaciones = atributosYRelaciones[index].getRelaciones();
          %>
          <td>
            <%
            	for (DatatypeProperty atributo2 : atributos) {
            				String cadena = individuo.getPropertyValue(atributo2).toString(); //Por ejemplo
            				String arrayCadena[] = cadena.split("http://www.w3.org"); //Esto separa en un array basï¿½ndose en el separador que le pases
            				String datoSubstring = arrayCadena[0];
            				if (datoSubstring.length() != individuo.getPropertyValue(atributo2).toString().length()) {
            %>
            <strong> <%
 	out.print(atributo2.getLocalName() + ": ");
 %>
            </strong>
            <%
            	out.print(datoSubstring.substring(0, datoSubstring.length() - 2) + " ");
            				} else {
            %>
            <strong> <%
 	out.print(atributo2.getLocalName() + ": ");
 %>
            </strong>
            <%
            	out.print(individuo.getPropertyValue(atributo2) + " ");
            				}
            			}
            %>
          </td>
          <%%>
          <td>
            <%
            	for (ObjectProperty relacion : relaciones) {
            %>
            <strong> <%
 	out.print(relacion.getLocalName() + ": ");
 %>
            </strong>
            <%
            	out.print(individuo.getPropertyResourceValue(relacion).getLocalName());
            			}
            %>
          </td>
          <td>
            <%
            	if (UsuarioCategoria.equals("0") || UsuarioCategoria.equals(idCategoriaOntologia)) {
            				if (individuosModificados.indexOf(individuo.getLocalName()) == -1) {
            %>
            <a href="#modificar-<%out.print(individuo.getLocalName());%>" class="btn btn-sm btn-secondary" data-toggle="modal">
              <i class="fas fa-pencil-alt"></i>
            </a>
            <%
            	} else {
            %>
            <a href="#modificar-<%out.print(individuo.getLocalName());%>" class="btn btn-sm btn-secondary disabled" data-toggle="modal">
              <i class="fas fa-pencil-alt"></i>
            </a>
            <%
            	}
            %>
            <%
            	if (individuosEliminados.indexOf(individuo.getLocalName()) == -1) {
            					Boolean eliminar = query.eliminar(individuo, ruta);
            					if (!eliminar) {
            %>
            <a href="#eliminar-<%out.print(individuo.getLocalName());%>" class="btn btn-sm btn-danger" data-toggle="modal">
              <i class="fas fa-trash-alt"></i>
            </a>
            <%
            	}
            				} else {
            %>
            <a href="#eliminar-<%out.print(individuo.getLocalName());%>" class="btn btn-sm btn-danger disabled" data-toggle="modal">
              <i class="fas fa-trash-alt"></i>
            </a>
            <%
            	}
            			} else {
            %>
            <a href="#modificar-<%out.print(individuo.getLocalName());%>" class="btn btn-sm btn-secondary disabled" data-toggle="modal">
              <i class="fas fa-pencil-alt"></i>
            </a>
            <a href="#eliminar-<%out.print(individuo.getLocalName());%>" class="btn btn-sm btn-danger disabled" data-toggle="modal">
              <i class="fas fa-trash-alt"></i>
            </a>
            <%
            	}
            %>
            <!--Eliminar-->
            <div class="modal fade" id="eliminar-<%out.print(individuo.getLocalName());%>">
              <div class="modal-dialog" role="document">
                <div class="modal-content">
                  <div class="modal-header">
                    <h4 class="modal-title">¿Estás seguro que quieres eliminar?</h4>
                  </div>
                  <div class="modal-body">
                    <h5>
                      Se eliminará el individuo:
                      <%
                    	out.print(individuo.getLocalName());
                    %>
                    </h5>
                  </div>
                  <div class="modal-footer">
                    <a href="../ModificarAtributos?individuo=<%out.print(individuo.getLocalName());%>" class="btn btn-primary">Eliminar</a>
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                  </div>
                </div>
              </div>
            </div>
            <!--Modificar-->
            <div class="modal fade" id="modificar-<%out.print(individuo.getLocalName());%>">
              <div class="modal-dialog" role="document">
                <div class="modal-content">
                  <div class="modal-header">
                    <h4 class="modal-title">
                      Modificar Individuo
                      <%
                    	out.print(individuo.getLocalName());
                    %>
                    </h4>
                  </div>
                  <form class="form-group" method="post" action="../ModificarAtributos">
                    <div class="modal-body">
                      <input type="hidden" value="<%out.print(individuo.getLocalName() + "~~" + individuo.getOntClass().getLocalName());%>" name="nombre_individuo">
                      <%
                      	for (DatatypeProperty atributo : atributos) {

                      				String cadena = individuo.getPropertyValue(atributo).toString(); //Por ejemplo
                      				String arrayCadena[] = cadena.split("http://www.w3.org"); //Esto separa en un array basï¿½ndose en el separador que le pases
                      				String datoSubstring = arrayCadena[0];
                      				String eldato = "";
                      				if (datoSubstring.length() != individuo.getPropertyValue(atributo).toString().length()) {

                      					eldato = datoSubstring.substring(0, datoSubstring.length() - 2);

                      				} else {
                      					eldato = individuo.getPropertyValue(atributo).toString();

                      				}
                      %>
                      <label>
                        <%
                        	out.print(atributo.getLocalName());
                        %>
                      </label>
                      <input class="form-control" type="text" value="<%out.print(eldato);%>" name="<%out.print(atributo.getLocalName());%>">
                      <%
                      	}
                      %>
                      <%
                      	for (ObjectProperty objetoz : relaciones) {
                      %>
                      <label>
                        <%
                        	out.print(objetoz.getLocalName());
                        %>
                      </label>
                      <%
                      	String objeto = objetoz.getLocalName();
                      %>
                      <select class="form-control" name="<%out.print(objeto);%>">
                        <%
                        	ClasesLectura clases = new ClasesLectura();
                        				int i = 0;
                        				String individuals[][] = clases.leerIndividual(ruta, objetoz.getLocalName());
                        				for (String individual2[] : individuals) {
                        %>
                        <option value="<%out.print(individual2[0]);%>">
                          <%
                          	out.print(individual2[0] + " - " + individual2[1]);
                          %>
                        </option>
                        <%
                        	i++;
                        				}
                        %>
                      </select>
                      <%
                      	}
                      %>
                    </div>
                    <div class="modal-footer">
                      <button type="submit" name="guardar" id="guardar" class="btn btn-primary">Guardar Cambios</button>
                      <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                    </div>
                  </form>
                </div>
              </div>
            </div>
          </td>
        </tr>
        <%
        	Date fechaPPP2 = new Date();
        			DateFormat hourdateFormatPPP2 = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy");
        			System.out.println(hourdateFormatPPP2.format(fechaPPP2));
        		}
        %>
      </tbody>
    </table>
  </div>
  <%
  	String respuesta = (String) session.getAttribute("respuesta");

  		if (respuesta != null) {
  			if (respuesta.equals("success_i")) {
  				out.print("<script>toastr.success('Se insertï¿½ el individuo'); </script> ");
  			} else if (respuesta.equals("success_e")) {
  				out.print(
  						"<script>toastr.success('Se ha puesto en pendiente para su eliminaciï¿½n'); </script> ");
  			} else if (respuesta.equals("nosuccess_e")) {
  				out.print(
  						"<script>toastr.error('No se pudo pudo poner en pendiente para su eliminaciï¿½n'); </script> ");
  			} else if (respuesta.equals("error_e")) {
  				out.print("<script>toastr.error('Error al cambiar estatus'); </script> ");
  			} else if (respuesta.equals("success_m")) {
  				out.print(
  						"<script>toastr.success('Se ha puesto en pendiente para su modificaciï¿½n'); </script> ");
  			} else if (respuesta.equals("nosuccess_m")) {
  				out.print(
  						"<script>toastr.error('No se pudo pudo poner en pendiente para su modificaciï¿½n'); </script> ");
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