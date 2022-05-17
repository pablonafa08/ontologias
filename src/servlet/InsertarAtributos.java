package servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.jena.ontology.Individual;
import org.apache.jena.ontology.ObjectProperty;
import org.apache.jena.ontology.OntClass;
import org.apache.jena.ontology.OntModel;
import org.apache.jena.ontology.OntModelSpec;
import org.apache.jena.ontology.Ontology;
import org.apache.jena.rdf.model.ModelFactory;
import org.apache.jena.util.iterator.ExtendedIterator;

import controllers.ClasesLectura;
import controllers.Conexion;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import models.Ontologia;
import models.Utils;

import java.sql.*;

@WebServlet("/InsertarAtributos")
public class InsertarAtributos extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public InsertarAtributos() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String nombrearc = request.getSession().getAttribute("ruta").toString();
		Utils utils = new Utils();
		String ruta = utils.getRuta() + nombrearc;
		OntModel model = ModelFactory.createOntologyModel(OntModelSpec.OWL_DL_MEM_RDFS_INF);
		model.read(ruta, "RDF/XML");
		int i = 0;
		int y = 0;
		String NS = "";
		int o = 0;
		String laClase = "";
		String simbolo = "";
		try {
			String id_ontologia = request.getSession().getAttribute("id_ontologia").toString();
			Conexion cn = new Conexion();
			Connection conn = cn.GetConexion();
			Statement state = conn.createStatement();
			ResultSet rs = state.executeQuery("SELECT * FROM ontologias WHERE id = " + id_ontologia);
			while (rs.next()) {
				NS = rs.getString("ns");
				simbolo = rs.getString("simbolo");

			}
		} catch (Exception e) {
		}
		model.setStrictMode(false);
		String clase = request.getSession().getAttribute("clase_e").toString();
		String nombre = request.getParameter("nombre_individuo");
		OntClass claseIndividual = model.getOntClass(NS + simbolo + clase);
		Individual dato = model.createIndividual(NS + simbolo + nombre, claseIndividual);
		ClasesLectura clases = new ClasesLectura();
		String objetos[] = clases.leerObjetos(ruta, clase, simbolo, NS);
		for (String objeto : objetos) {
			Individual dato2 = model.getIndividual(NS + simbolo + request.getParameter(objeto));
			ObjectProperty relacion2 = model.getObjectProperty(NS + simbolo + objeto);
			dato.addProperty(relacion2, dato2);
		}

		String atributos[] = clases.leerAtributos(ruta, clase, simbolo, NS);
		for (String atributo : atributos) {
			model.getIndividual(NS + simbolo + nombre).setPropertyValue(model.getProperty(NS + simbolo + atributo),
					model.createTypedLiteral(request.getParameter(atributo)));
		}

		File file = new File(ruta);
		if (!file.exists()) {
			file.createNewFile();
		}

		FileOutputStream fos = new FileOutputStream(file, false);
		OutputStreamWriter writer = new OutputStreamWriter(fos, "UTF-8");
		model.write(writer, "RDF/XML");
		String id_ontologia = request.getSession().getAttribute("id_ontologia").toString();
		request.setAttribute("clase", request.getSession().getAttribute("clase_e").toString());
		request.setAttribute("clase2", request.getSession().getAttribute("clase_e").toString());
		request.getSession().setAttribute("respuesta", "success_i");
		response.sendRedirect("/ontologias/ontologias/todos.jsp?id=" + id_ontologia);
	}

}
