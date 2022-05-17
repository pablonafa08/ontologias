package servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Statement;

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

import controllers.ClasesConsultar;
import controllers.ClasesLectura;
import controllers.Conexion;
import controllers.ModificacionIndividuals;
import models.Utils;

@WebServlet("/ModificarAtributos")
public class ModificarAtributos extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ModificarAtributos() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id_ontologia = request.getSession().getAttribute("id_ontologia").toString();
		try {
			String individuo = request.getParameter("individuo");
			ModificacionIndividuals modificacion = new ModificacionIndividuals();
			if (modificacion.eliminar(individuo, request.getSession().getAttribute("id_ontologia").toString(),
					request.getSession().getAttribute("UsuarioId").toString())) {
				request.getSession().setAttribute("respuesta", "success_e");
			} else {
				request.getSession().setAttribute("respuesta", "nosuccess_e");
			}
			response.sendRedirect("/ontologias/ontologias/todos.jsp?id=" + id_ontologia);
		} catch (NumberFormatException ex) {
			request.getSession().setAttribute("respuesta", "error_e");
			response.sendRedirect("/ontologias/ontologias/todos.jsp?id=" + id_ontologia);
		} catch (Exception e) {
			request.getSession().setAttribute("respuesta", "error_e");
			response.sendRedirect("/ontologias/ontologias/todos.jsp?id=" + id_ontologia);
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Utils utils = new Utils();
		ClasesConsultar consulta = new ClasesConsultar();
		String nombrearc = request.getSession().getAttribute("ruta").toString();
		String ruta = utils.getRuta() + nombrearc;
		String id_ontologia = request.getSession().getAttribute("id_ontologia").toString();
		String usuario = (String) request.getSession().getAttribute("UsuarioId").toString();
		String individuoNo = request.getParameter("nombre_individuo");
		String individuoYclase[] = individuoNo.split("~~");
		String individuo = individuoYclase[0];
		String clase = individuoYclase[1];
		String cadena = "";
		String[] NSySimbolo = consulta.consultarNSySimbolo(ruta);
		String NS = NSySimbolo[0];
		String simbolo = NSySimbolo[1];
		
		ClasesLectura clases = new ClasesLectura();
		int y = 0;
		String atributos[] = clases.leerAtributos(ruta, clase, simbolo, NS);
		for (String atributo : atributos) {
			cadena = cadena + atributo + "¬¬" + request.getParameter(atributo) + "¬¬";
		}

		String objetos[] = clases.leerObjetos(ruta, clase, simbolo, NS);

		for (String objeto : objetos) {
			cadena = cadena + "~~" + objeto + "~~" + request.getParameter(objeto);
		}

		String atributosSplit[] = cadena.split("¬¬");
		String relacionesSplit[] = cadena.split("~~");

		try {
			Conexion cn = new Conexion();
			Connection conn = cn.GetConexion();
			Statement state = conn.createStatement();
			conn = cn.GetConexion();
			state = conn.createStatement();
			String query;

			query = "INSERT into modificar_individuos(id_ontologia,id_usuario,individuo,atributos,estatus) VALUES ('"
					+ id_ontologia + "','" + usuario + "','" + individuo + "','" + cadena + "','P')";

			int i = state.executeUpdate(query);
			if (i > 0) {
				request.getSession().setAttribute("respuesta", "success_m");
			} else {
				request.getSession().setAttribute("respuesta", "nosuccess_m");
			}
			response.sendRedirect("/ontologias/ontologias/todos.jsp?id=" + id_ontologia);
		} catch (Exception e) {
			request.getSession().setAttribute("respuesta", "error_m");
			response.sendRedirect("/ontologias/ontologias/todos.jsp?id=" + id_ontologia);
		}
	}
}
