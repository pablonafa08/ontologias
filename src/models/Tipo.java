package models;

public class Tipo {

  private int id;
  private String descripcion;

  public Tipo() {
    setId(0);
    setDescripcion("");
  }

  public int getId() {
    return id;
  }

  public void setId(int id) {
    this.id = id;
  }

  public String getDescripcion() {
    return descripcion;
  }

  public void setDescripcion(String descripcion) {
    this.descripcion = descripcion;
  }
}
