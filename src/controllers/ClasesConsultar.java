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

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import org.apache.commons.lang3.ArrayUtils;
import models.IndividuosTodos;
import models.TodosIndividuosYOtros;
// System.out.println(Arrays.toString());  System.out.println();

//Date fechaPPP = new Date();
//DateFormat hourdateFormatPPP = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy");
//System.out.println(hourdateFormatPPP.format(fechaPPP));

//Date fechaPPP2 = new Date();
//DateFormat hourdateFormatPPP2 = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy");
//System.out.println(hourdateFormatPPP2.format(fechaPPP2));
public class ClasesConsultar {
	public String[] consultarNSySimbolo(String ruta) {
		OntModel model = ModelFactory.createOntologyModel(OntModelSpec.OWL_DL_MEM_RDFS_INF);
		model.read(ruta, "RDF/XML");
		String[] items = new String[2];

		ExtendedIterator iteclases = model.listClasses();
		while (iteclases.hasNext()) {
			OntClass clase1 = (OntClass) iteclases.next();
			if (clase1.toString().length() > 0) {
				items[0] = clase1.toString().substring(0,
						(clase1.toString().length()) - (clase1.getLocalName().length()) - 1);
				items[1] = clase1.toString().substring(items[0].length(), items[0].length() + 1);
				break;
			}
		}

		return items;
	}

	public Individual[] consultarIndividual(String ruta, String clase) {
		OntModel model = ModelFactory.createOntologyModel(OntModelSpec.OWL_DL_MEM_RDFS_INF);
		model.read(ruta, "RDF/XML");
		Individual[] vector = {};

		ExtendedIterator iteIndi = model.listIndividuals();
		while (iteIndi.hasNext()) {
			Individual individuo = (Individual) iteIndi.next();
			if (individuo.getOntClass().getLocalName().equals(clase)) {
				vector = append(vector, individuo);
			}
		}

		return vector;
	}

	public Individual[] consultarIndividualTodos(String ruta) {
		OntModel model = ModelFactory.createOntologyModel(OntModelSpec.OWL_DL_MEM_RDFS_INF);
		model.read(ruta, "RDF/XML");
		Individual[] vector = {};

		ExtendedIterator iteIndi = model.listIndividuals();
		while (iteIndi.hasNext()) {
			Individual individuo = (Individual) iteIndi.next();
			vector = append(vector, individuo);
		}

		return vector;
	}

	public TodosIndividuosYOtros consultarIndividualTodos2(String ruta, String simbolo, String NS) {
		OntModel model = ModelFactory.createOntologyModel(OntModelSpec.OWL_DL_MEM_RDFS_INF);
		model.read(ruta, "RDF/XML");
		Individual[] vector = {};
		String[] clases = {};
		IndividuosTodos[] arrayTodos = {};
		IndividuosTodos objectTodos = null;
		TodosIndividuosYOtros todo = new TodosIndividuosYOtros();

		ExtendedIterator iteIndi = model.listIndividuals();
		while (iteIndi.hasNext()) {
			Individual individuo = (Individual) iteIndi.next();
			int index = ArrayUtils.indexOf(clases, individuo.getOntClass().getLocalName());
			if (index < 0) {
				clases = append(clases, individuo.getOntClass().getLocalName());

				objectTodos = new IndividuosTodos();

				DatatypeProperty[] atributos = this.consultarAtributos(ruta, individuo.getOntClass().getLocalName(),
						simbolo, NS);
				objectTodos.setAtributos(atributos);

				ObjectProperty[] relaciones = this.consultarRelacion(ruta, individuo.getOntClass().getLocalName(),
						simbolo, NS);
				objectTodos.setRelaciones(relaciones);

				arrayTodos = append(arrayTodos, objectTodos);
			}

			vector = append(vector, individuo);
		}

		todo.setIndividuos(vector);
		todo.setClases(clases);
		todo.setAtributosYRelaciones(arrayTodos);

		return todo;
	}

	public DatatypeProperty[] consultarAtributos(String ruta, String clase, String simbolo, String NS) {
		DatatypeProperty[] vector = {};
		OntModel model = ModelFactory.createOntologyModel(OntModelSpec.OWL_DL_MEM_RDFS_INF);
		model.read(ruta, "RDF/XML");
		OntClass clasePadre = model.getOntClass(NS + simbolo + clase);
		if ((clasePadre.getSuperClass().getLocalName().equals("Resource"))
				|| (clasePadre.getSuperClass().getLocalName() == null)) {
			clase = clasePadre.getLocalName();
		} else {
			clase = clasePadre.getSuperClass().getLocalName();
		}

		ExtendedIterator iteAtributos = model.listDatatypeProperties();
		while (iteAtributos.hasNext()) {
			DatatypeProperty atributos = (DatatypeProperty) iteAtributos.next();
			if (atributos.getDomain().getLocalName().equals(clase)) {
				vector = append(vector, atributos);
			}
		}

		return vector;
	}

	public ObjectProperty[] consultarRelacion(String ruta, String clase, String simbolo, String NS) {
		ObjectProperty vector[] = {};
		OntModel model = ModelFactory.createOntologyModel(OntModelSpec.OWL_DL_MEM_RDFS_INF);
		model.read(ruta, "RDF/XML");

		OntClass clasePadre = model.getOntClass(NS + simbolo + clase);

		if ((clasePadre.getSuperClass().getLocalName().equals("Resource"))
				|| (clasePadre.getSuperClass().getLocalName() == null)) {
			clase = clasePadre.getLocalName();
		} else {
			clase = clasePadre.getSuperClass().getLocalName();
		}

		ExtendedIterator iteObjeto = model.listObjectProperties();
		while (iteObjeto.hasNext()) {
			ObjectProperty objeto = (ObjectProperty) iteObjeto.next();
			if (objeto.getDomain().getLocalName().equals(clase)) {
				vector = append(vector, objeto);
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
