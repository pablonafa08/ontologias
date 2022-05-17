package models;

public class SubCategoria {

  private int id;
  private String titulo;
  private String categoria;
  private String imagen;

  public SubCategoria() {
    setId(0);
    setTitulo("");
    setCategoria("");
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

  public String getCategoria() {
    return categoria;
  }

  public void setCategoria(String categoria) {
    this.categoria = categoria;
  }

  public String getImagen() {
    return imagen;
  }

  public void setImagen(String imagen) {
    this.imagen = imagen;
  }
}
