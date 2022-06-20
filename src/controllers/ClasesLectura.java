/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import org.apache.jena.ontology.DatatypeProperty;
import org.apache.jena.ontology.Individual;
import org.apache.jena.ontology.ObjectProperty;
import org.apache.jena.ontology.OntClass;
import org.apache.jena.ontology.OntModel;
import org.apache.jena.ontology.OntModelSpec;
import org.apache.jena.ontology.Ontology;
import org.apache.jena.rdf.model.ModelFactory;
import org.apache.jena.util.iterator.ExtendedIterator;
import java.util.*;

public class ClasesLectura {

	public String[] leerClase(String ruta) {
		String[] vector = {};
		OntModel model = ModelFactory.createOntologyModel(OntModelSpec.OWL_DL_MEM_RDFS_INF);
		model.read(ruta, "RDF/XML");

		ExtendedIterator iteratorClasses = model.listClasses();
		while (iteratorClasses.hasNext()) {
			OntClass ontClass = (OntClass) iteratorClasses.next();
			vector = append(vector, ontClass.getLocalName());
		}
		return vector;
	}

	public String[] leerObjetos(String ruta, String clase, String simbolo, String NS) {
		String[] vector = {};
		OntModel model = ModelFactory.createOntologyModel(OntModelSpec.OWL_DL_MEM_RDFS_INF);
		model.read(ruta, "RDF/XML");

		OntClass clasePadre = model.getOntClass(NS + simbolo + clase);

		if ((clasePadre.getSuperClass().getLocalName().equals("Resource"))
				|| (clasePadre.getSuperClass().getLocalName() == null)) {
			clase = clasePadre.getLocalName();
		} else {
			clase = clasePadre.getSuperClass().getLocalName();
		}

		ExtendedIterator iteratorObjeto = model.listObjectProperties();
		while (iteratorObjeto.hasNext()) {
			ObjectProperty objeto = (ObjectProperty) iteratorObjeto.next();
			if (objeto.getDomain().getLocalName().equals(clase)) {
				vector = append(vector, objeto.getLocalName());
			}
		}

		return vector;
	}

	public String[] leerAtributos(String ruta, String clase, String simbolo, String NS) {
		String[] vector = {};
		OntModel model = ModelFactory.createOntologyModel(OntModelSpec.OWL_DL_MEM_RDFS_INF);
		model.read(ruta, "RDF/XML");

		OntClass clasePadre = model.getOntClass(NS + simbolo + clase);

		if ((clasePadre.getSuperClass().getLocalName().equals("Resource"))
				|| (clasePadre.getSuperClass().getLocalName() == null)) {
			clase = clasePadre.getLocalName();
		} else {
			clase = clasePadre.getSuperClass().getLocalName();
		}

		ExtendedIterator iteratorAtributo = model.listDatatypeProperties();
		while (iteratorAtributo.hasNext()) {
			DatatypeProperty atributo = (DatatypeProperty) iteratorAtributo.next();
			if (atributo.getDomain().getLocalName().equals(clase)) {
				vector = append(vector, atributo.getLocalName());
			}
		}

		return vector;
	}

	public String[] leerIndividual(String ruta, String relacion) {

		String vector[] = {};
		OntModel model = ModelFactory.createOntologyModel(OntModelSpec.OWL_DL_MEM_RDFS_INF);
		model.read(ruta, "RDF/XML");
		String rango = "";

		ExtendedIterator iteratorObjecto = model.listObjectProperties();
		while (iteratorObjecto.hasNext()) {
			ObjectProperty objecto = (ObjectProperty) iteratorObjecto.next();

			if (objecto.getLocalName().equals(relacion)) {
				rango = objecto.getRange().getLocalName();
				break;
			}
		}

		ExtendedIterator iteratorIndividual = model.listIndividuals();
		while (iteratorIndividual.hasNext()) {
			Individual individual = (Individual) iteratorIndividual.next();

			if (individual.getOntClass().getLocalName().equals(rango)) {
				vector = append(vector, individual.getLocalName());
			}
		}

		return vector;
	}

	static <T> T[] append(T[] arr, T element) {
		final int N = arr.length;
		arr = Arrays.copyOf(arr, N + 1);
		arr[N] = element;
		return arr;
	}
}
