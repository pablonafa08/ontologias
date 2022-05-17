package models;

import org.apache.jena.ontology.DatatypeProperty;
import org.apache.jena.ontology.ObjectProperty;

public class IndividuosTodos {
	private DatatypeProperty[] atributos;
	private ObjectProperty[] relaciones;
	
	public DatatypeProperty[] getAtributos() {
		return atributos;
	}
	
	public void setAtributos(DatatypeProperty[] atributos) {
		this.atributos = atributos;
	}
	
	public ObjectProperty[] getRelaciones() {
		return relaciones;
	}
	
	public void setRelaciones(ObjectProperty[] relaciones) {
		this.relaciones = relaciones;
	}

}
