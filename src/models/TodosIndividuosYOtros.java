package models;

import org.apache.jena.ontology.Individual;

public class TodosIndividuosYOtros {

  private Individual[] individuos;
  private String[] clases;
  private IndividuosTodos[] atributosYRelaciones;

  public Individual[] getIndividuos() {
    return individuos;
  }

  public void setIndividuos(Individual[] individuos) {
    this.individuos = individuos;
  }

  public String[] getClases() {
    return clases;
  }

  public void setClases(String[] clases) {
    this.clases = clases;
  }

  public IndividuosTodos[] getAtributosYRelaciones() {
    return atributosYRelaciones;
  }

  public void setAtributosYRelaciones(IndividuosTodos[] atributosYRelaciones) {
    this.atributosYRelaciones = atributosYRelaciones;
  }
}
