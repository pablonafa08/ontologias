/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;

import org.apache.jena.ontology.Individual;
import org.apache.jena.ontology.OntClass;
import org.apache.jena.ontology.OntModel;
import org.apache.jena.ontology.OntModelSpec;
import org.apache.jena.rdf.model.ModelFactory;
import org.apache.jena.util.iterator.ExtendedIterator;
import controllers.ClasesConsultar;
import models.Utils;

import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import org.apache.jena.datatypes.RDFDatatype;
import org.apache.jena.ontology.DatatypeProperty;
import org.apache.jena.ontology.ObjectProperty;
import org.apache.jena.ontology.Ontology;
import org.apache.jena.rdf.model.Statement;

public class Pruebas {
	public String[] leer(String nombre, String id) throws IOException {
		OntModel model = ModelFactory.createOntologyModel(OntModelSpec.OWL_DL_MEM_RDFS_INF);
		Utils utils = new Utils();
		String ruta = utils.getRuta() + nombre;
		model.read(ruta, "RDF/XML");
		// Se crea el modelo dee la ontologia que sera la copia
		OntModel model2 = ModelFactory.createOntologyModel(OntModelSpec.OWL_DL_MEM_RDFS_INF);
		int o = 0;
		ClasesConsultar consulta = new ClasesConsultar();
		String[] NSySimbolo = consulta.consultarNSySimbolo(ruta);
		String NS = NSySimbolo[0];
		String simbolo = NSySimbolo[1];

		ClasesLectura clasesLectura = new ClasesLectura();
		String[] clases = clasesLectura.leerClase(ruta);
		DatatypeProperty[] atributos;
		ObjectProperty[] relaciones;
		Individual[] individuos;

		int i = 0;
		for (o = 0; o < clases.length; o++) {
			OntClass laclase = model2.createClass(NS + simbolo + clases[o]);
			OntClass clasePadretl = model.getOntClass(NS + simbolo + laclase.getLocalName());
			if (!clasePadretl.getSuperClass().getLocalName().equals("Resource")) {
				laclase.addSuperClass(clasePadretl.getSuperClass());
			}

			atributos = consulta.consultarAtributos(ruta, clases[o], simbolo, NS);
			relaciones = consulta.consultarRelacion(ruta, clases[o], simbolo, NS);
			individuos = consulta.consultarIndividual(ruta, clases[o]);

			for (i = 0; i < atributos.length; i++) {
				DatatypeProperty elatributo = model2.createDatatypeProperty(NS + simbolo + atributos[i].getLocalName());
				elatributo.setDomain(atributos[i].getDomain());
				elatributo.setRange(atributos[i].getRange());
			}

			for (i = 0; i < relaciones.length; i++) {
				ObjectProperty elobjeto = model2.createObjectProperty(NS + simbolo + relaciones[i].getLocalName());
				elobjeto.setDomain(relaciones[i].getDomain());
				elobjeto.setRange(relaciones[i].getRange());
			}

			String objetos[] = clasesLectura.leerObjetos(ruta, clases[o], simbolo, NS);
			String atributos2[] = clasesLectura.leerAtributos(ruta, clases[o], simbolo, NS);

			for (i = 0; i < individuos.length; i++) {
				Individual elindividuo = model2.createIndividual(NS + simbolo + individuos[i].getLocalName(), laclase);
				Individual dato1 = model.getIndividual(NS + simbolo + elindividuo.getLocalName());
				for (String objeto : objetos) {
					ObjectProperty relacion2 = model.getObjectProperty(NS + simbolo + objeto);
					Individual dato2 = model
							.getIndividual(NS + simbolo + dato1.getPropertyResourceValue(relacion2).getLocalName());

					elindividuo.addProperty(relacion2, dato2);
				}

				Individual dato3 = model.getIndividual(NS + simbolo + elindividuo.getLocalName());
				for (String atributo : atributos2) {
					DatatypeProperty estas = model.getDatatypeProperty(NS + simbolo + atributo);

					model2.getIndividual(NS + simbolo + elindividuo.getLocalName())
							.setPropertyValue(model.getProperty(NS + simbolo + atributo), model.createTypedLiteral(
									dato3.getPropertyValue(estas), estas.getRange().getLabel(estas.getLocalName())));

				}
			}
		}

		Date fecha = new Date();
		DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		DateFormat hourdateFormat = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy");
		String[] parts = hourdateFormat.format(fecha).split(":");
		String[] partss = parts[2].split(" ");
		String nombre2 = id + "_" + parts[0] + "-" + parts[1] + "-" + partss[0] + "-" + dateFormat.format(fecha)
				+ ".owl";
		File file = new File(utils.getRuta() + nombre2);

		if (!file.exists()) {
			file.createNewFile();
		}

		FileOutputStream fos = new FileOutputStream(file, false);
		OutputStreamWriter writer = new OutputStreamWriter(fos, "UTF-8");
		model2.write(writer, "RDF/XML");

		String[] todo = { NS, simbolo, nombre2 };

		return todo;
	}
}
