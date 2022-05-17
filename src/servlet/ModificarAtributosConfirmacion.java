package servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

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
import controllers.ModificacionIndividuals;
import models.Utils;

@WebServlet("/ModificarAtributosConfirmacion")
public class ModificarAtributosConfirmacion extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ModificarAtributosConfirmacion() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String opcion = request.getParameter("opcion");
		if (opcion.equals("eliminar")) {
			try {
				String estatus = request.getParameter("estatus");
				if (estatus.equals("A")) {
					Utils utils = new Utils();
					String nombrearc = request.getParameter("ruta");
					String ruta = utils.getRuta() + nombrearc;
					OntModel model = ModelFactory.createOntologyModel(OntModelSpec.OWL_DL_MEM_RDFS_INF);
					model.read(ruta, "RDF/XML");
					String NS = "";
					int o = 0;
					String laClase = "";
					String simbolo = "";

					try {
						String id_ontologia = request.getParameter("id");
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
					String nombre = request.getParameter("individuo");
					Individual dato = model.getIndividual(NS + simbolo + nombre);
					dato.remove();

					File file = new File(ruta);
					// Hay que capturar las Excepciones
					if (!file.exists()) {
						file.createNewFile();
					}

					FileOutputStream fos = new FileOutputStream(file, false);
					OutputStreamWriter writer = new OutputStreamWriter(fos, "UTF-8");
					model.write(writer, "RDF/XML");
				}

				String id_e = request.getParameter("id_e");
				ModificacionIndividuals modificacion = new ModificacionIndividuals();

				if (modificacion.actualizar_eliminar(id_e, estatus)) {
					if (estatus.equals("A")) {
						request.getSession().setAttribute("respuesta", "success_e");
					} else {
						request.getSession().setAttribute("respuesta", "success_r");
					}
				} else {
					if (estatus.equals("A")) {
						request.getSession().setAttribute("respuesta", "nosuccess_e");
					} else {
						request.getSession().setAttribute("respuesta", "nosuccess_r");
					}
				}

				response.sendRedirect("/ontologias/noti.jsp");
			} catch (NumberFormatException ex) {
				request.getSession().setAttribute("respuesta", "error_e");
				response.sendRedirect("/ontologias/noti.jsp");
			} catch (Exception e) {
				request.getSession().setAttribute("respuesta", "error_e");
				response.sendRedirect("/ontologias/noti.jsp");

			}
		} else {
			try {

				String id_e = request.getParameter("id");
				ModificacionIndividuals modificacion = new ModificacionIndividuals();

				if (modificacion.rechazar_modificacion(id_e)) {
					request.getSession().setAttribute("respuesta", "success_rm");
				} else {
					request.getSession().setAttribute("respuesta", "nosuccess_rm");
				}

				response.sendRedirect("/ontologias/noti.jsp");
			} catch (NumberFormatException ex) {
				request.getSession().setAttribute("respuesta", "error_e");
				response.sendRedirect("/ontologias/noti.jsp");
			} catch (Exception e) {
				request.getSession().setAttribute("respuesta", "error_e");
				response.sendRedirect("/ontologias/noti.jsp");
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Utils utils = new Utils();
		request.getParameter("elid");
		String individuo = "";
		String atributos = "";
		String archivo = "";
		String simbolo = "";
		String NS = "";
		try {
			Conexion cn = new Conexion();
			Connection conn = cn.GetConexion();
			Statement state = conn.createStatement();
			String query;
			query = "SELECT * FROM modificar_individuos JOIN ontologias ON ontologias.id = modificar_individuos.id_ontologia WHERE modificar_individuos.id = '"
					+ request.getParameter("elid") + "'";

			ResultSet rs = state.executeQuery(query);
			while (rs.next()) {
				individuo = rs.getString("modificar_individuos.individuo");
				atributos = rs.getString("modificar_individuos.atributos");
				archivo = rs.getString("ontologias.ruta_archivo");
				simbolo = rs.getString("ontologias.simbolo");
				NS = rs.getString("ontologias.ns");
			}
			int x = 0;
			int y = 0;
			String atributosSplit[] = atributos.split("¬¬");
			String relacionesSplit[] = atributos.split("~~");
			String ruta = utils.getRuta() + archivo;
			OntModel model = ModelFactory.createOntologyModel(OntModelSpec.OWL_DL_MEM_RDFS_INF);
			model.read(ruta, "RDF/XML");
			model.setStrictMode(false);
			Individual elindividuo = model.getIndividual(NS + simbolo + individuo);
			OntClass clase = elindividuo.getOntClass();
			ClasesLectura clases = new ClasesLectura();
			String unosatributos[] = clases.leerAtributos(ruta, clase.getLocalName(), simbolo, NS);
			String relaciones[] = clases.leerObjetos(ruta, clase.getLocalName(), simbolo, NS);
			y = 1;
			for (String relacion : relaciones) {
				Individual dato2 = model.getIndividual(NS + simbolo + relacionesSplit[y + 1]);
				ObjectProperty relacion2 = model.getObjectProperty(NS + simbolo + relacion);
				elindividuo.addProperty(relacion2, dato2);
				y++;
				y = y + 1;
			}

			y = 0;
			for (String unatributo : unosatributos) {
				model.getIndividual(NS + simbolo + individuo).setPropertyValue(
						model.getProperty(NS + simbolo + unatributo), model.createTypedLiteral(atributosSplit[y + 1]));
				y++;
				y = y + 1;
			}

			File file = new File(ruta);
			if (!file.exists()) {
				file.createNewFile();
			}

			FileOutputStream fos = new FileOutputStream(file, false);
			OutputStreamWriter writer = new OutputStreamWriter(fos, "UTF-8");
			model.write(writer, "RDF/XML");

			try {
				Connection conn2 = cn.GetConexion();
				Statement state2 = conn2.createStatement();
				String query2;
				query2 = "UPDATE modificar_individuos SET estatus = 'A' WHERE id = " + request.getParameter("elid")
						+ "";
				int i = state2.executeUpdate(query2);
				if (i > 0) {
					request.getSession().setAttribute("respuesta", "success_m");
				} else {
					request.getSession().setAttribute("respuesta", "nosuccess_m");
				}
				response.sendRedirect("/ontologias/noti.jsp");
			} catch (Exception e) {
				request.getSession().setAttribute("respuesta", "error_m");
				response.sendRedirect("/ontologias/noti.jsp");
			}

		} catch (Exception e) {
			request.getSession().setAttribute("respuesta", "error_m");
			response.sendRedirect("/ontologias/noti.jsp");
		}
	}
}
