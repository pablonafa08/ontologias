package models;

import java.io.InputStream;

public class Usuario {

  private int id;
  private String nombres;
  private String app;
  private String apm;
  private String correo;
  private String usuario;
  private String contra;
  private int tipo;
  private int categoria;
  private String foto;

  public Usuario() {
    setId(0);
    setNombres("");
    setApp("");
    setApm("");
    setCorreo("");
    setUsuario("");
    setContra("");
    setTipo(0);
    setCategoria(0);
    setFoto("");
  }

  public int getId() {
    return id;
  }

  public void setId(int id) {
    this.id = id;
  }

  public String getNombres() {
    return nombres;
  }

  public void setNombres(String nombres) {
    this.nombres = nombres;
  }

  public String getApp() {
    return app;
  }

  public void setApp(String app) {
    this.app = app;
  }

  public String getApm() {
    return apm;
  }

  public void setApm(String apm) {
    this.apm = apm;
  }

  public String getCorreo() {
    return correo;
  }

  public void setCorreo(String correo) {
    this.correo = correo;
  }

  public String getUsuario() {
    return usuario;
  }

  public void setUsuario(String usuario) {
    this.usuario = usuario;
  }

  public String getContra() {
    return contra;
  }

  public void setContra(String contra) {
    this.contra = contra;
  }

  public int getTipo() {
    return tipo;
  }

  public void setTipo(int tipo) {
    this.tipo = tipo;
  }

  public String getFoto() {
    return foto;
  }

  public void setFoto(String foto) {
    this.foto = foto;
  }

  public int getCategoria() {
    return categoria;
  }

  public void setCategoria(int categoria) {
    this.categoria = categoria;
  }
}
