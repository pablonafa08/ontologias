<%@page import="org.apache.jena.ontology.ObjectProperty"%>
<%@page import="org.apache.jena.ontology.DatatypeProperty"%>
<%@page import="org.apache.jena.ontology.Individual"%>
<%@page import="org.apache.commons.lang3.ArrayUtils"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="controllers.ClasesLectura"%>
<%@page import="controllers.ClasesConsultar"%>
<%@page import="controllers.Conexion"%>
<%@page import="controllers.Usuarios"%>
<%@page import="models.Usuario"%>
<%@page import="models.Utils"%>
<%@page import="models.TodosIndividuosYOtros"%>
<%@page import="models.IndividuosTodos"%>

<%
	String id = request.getParameter("id").toString();
	request.getSession().setAttribute("id_ontologia", id);

	// ------ Se obtienen los individuos que tienen propuestas de eliminación o modificación ------ 
	Conexion cn = new Conexion();
	Connection connInEl = cn.GetConexion();
	Statement stateInEl = connInEl.createStatement();
	ResultSet rsInEl = stateInEl.executeQuery(
			"SELECT individuo from eliminar_individuos WHERE estatus = 'P' and id_ontologia = " + id);
	ArrayList<String> individuosEliminados = new ArrayList<String>();
	while (rsInEl.next()) {
		individuosEliminados.add(rsInEl.getObject("individuo").toString());
	}

	Connection connInMo = cn.GetConexion();
	Statement stateInMo = connInMo.createStatement();
	ResultSet rsInMo = stateInMo.executeQuery(
			"SELECT individuo from modificar_individuos WHERE estatus = 'P' and id_ontologia = " + id);
	ArrayList<String> individuosModificados = new ArrayList<String>();
	while (rsInMo.next()) {
		individuosModificados.add(rsInMo.getObject("individuo").toString());
	}

	// ------ Se obtiene la ruta del archivo ------
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

	// ------ Se obtienen todos los datos y metadatos que contiene la ontología ------
	ClasesLectura clases = new ClasesLectura();
	Utils utils = new Utils();
	String ruta = utils.getRuta() + nombre;
	ClasesConsultar query = new ClasesConsultar();
	String[] NSySimbolo = query.consultarNSySimbolo(ruta);
	String NS = NSySimbolo[0];
	String simbolo = NSySimbolo[1];

	TodosIndividuosYOtros todo = query.consultarIndividualTodos2(ruta, simbolo, NS);
	Individual[] individuos = todo.getIndividuos();
	String[] clasesNuevas = todo.getClases();
	IndividuosTodos[] atributosYRelaciones = todo.getAtributosYRelaciones();

	// ------ Inicia creación del Array ------ 
	int countGetDataRelation = 0;
	String salida = "[";
	String relationData = "{";
	for (Individual individuo : individuos) {
		salida += "{";
		// ------ Primer columna (Individuo) ------
		salida += "\"name\": \"" + individuo.getLocalName() + "\",";

		int index = ArrayUtils.indexOf(clasesNuevas, individuo.getOntClass().getLocalName());

		// ------ Segunda columna (Datos) ------
		DatatypeProperty[] atributos = atributosYRelaciones[index].getAtributos();
		int numAtrib = 0;
		salida += "\"attributes\": {";
		for (DatatypeProperty atributo : atributos) {
			numAtrib++;
			String cadena = individuo.getPropertyValue(atributo).toString(); //Por ejemplo
			String arrayCadena[] = cadena.split("http://www.w3.org"); //Esto separa en un array basándose en el separador que le pases
			String datoSubstring = arrayCadena[0];

			salida += "\"" + atributo.getLocalName() + "\": \"";
			if (datoSubstring.length() != individuo.getPropertyValue(atributo).toString().length()) {
				salida += datoSubstring.substring(0, datoSubstring.length() - 2) + "\",";
			} else {
				salida += individuo.getPropertyValue(atributo) + "\",";
			}
		}

		if (numAtrib > 0) {
			salida = salida.substring(0, salida.length() - 1); // Quitar ultima coma
		}
		salida += "},";

		// ------ Tercera columna (Relaciones) ------
		ObjectProperty[] relaciones = atributosYRelaciones[index].getRelaciones();
		int numRelations = 0;
		salida += "\"relations\": {";
		for (ObjectProperty relacion : relaciones) {
			numRelations++;
			salida += "\"" + relacion.getLocalName() + "\": \""
					+ individuo.getPropertyResourceValue(relacion).getLocalName() + "\",";

			if (countGetDataRelation == 0) {
				relationData += "\"" + relacion.getLocalName() + "\": [";
				int numItemsRelationData = 0;
				String individuals[] = clases.leerIndividual(ruta, relacion.getLocalName());
				for (String individual : individuals) {
					numItemsRelationData++;
					relationData += "\"" + individual + "\",";
				}

				if (numItemsRelationData > 0) {
					relationData = relationData.substring(0, relationData.length() - 1); // Quitar ultima coma
				}
				relationData += "],";
			}
		}

		if (countGetDataRelation == 0) {
			relationData = relationData.substring(0, relationData.length() - 1); // Quitar ultima coma
			relationData += "}";
		}

		countGetDataRelation++;

		if (numRelations > 0) {
			salida = salida.substring(0, salida.length() - 1); // Quitar ultima coma
		}
		salida += "},";

		// ------ Cuarta columna (Acciones) ------
		salida += "\"actions\": {";
		String UsuarioCategoria = (String) session.getAttribute("UsuarioCategoria").toString();

		if (UsuarioCategoria.equals("0") || UsuarioCategoria.equals(idCategoriaOntologia)) {

			if (individuosModificados.indexOf(individuo.getLocalName()) == -1) {
				salida += "\"isEditDisabled\": false,";
			} else {
				salida += "\"isEditDisabled\": true,";
			}

			if ((UsuarioCategoria.equals("0") || UsuarioCategoria.equals(idCategoriaOntologia))
					&& individuosEliminados.indexOf(individuo.getLocalName()) == -1) {
				salida += "\"isDeleteDisabled\": false";
			} else {
				salida += "\"isDeleteDisabled\": true";
			}
		} else {
			salida += "\"isEditDisabled\": true, \"isDeleteDisabled\": true";
		}
		salida += "},";

		// ------ Nombre de la clase al que pertenece el individuo------
		salida += "\"clase\": \"" + individuo.getOntClass().getLocalName() + "\"";

		// ------ Termina de agregar el item ------
		salida += "},";
	}

	salida = salida.substring(0, salida.length() - 1); // Quitar ultima coma
	salida += "]";

	out.print("{\"data\":" + salida + ",\"relationItems\":" + relationData + "}");
%>






