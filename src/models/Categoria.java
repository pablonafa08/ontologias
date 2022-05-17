package models;

public class Categoria {

  private int id;
  private String titulo;
  private String imagen;

  public Categoria() {
    setId(0);
    setTitulo("");
    setImagen("");
  }

  public int getId() {
    return id;
  }

  public void setId(int id) {
    this.id = id;
  }

  public String getTitulo() {
    return titulo;
  }

  public void setTitulo(String titulo) {
    this.titulo = titulo;
  }

  public String getImagen() {
    return imagen;
  }

  public void setImagen(String imagen) {
    this.imagen = imagen;
  }
}
