package models;

public class Ontologia {
	private int id;
	private String ruta;
	private String categoria;
	private String subcategoria;
	private String titulo;
	private String descripcion;
	private String usuario;
	private String simbolo;
	private String ns;
	
	public Ontologia() {
		setId(0);
		setRuta("");
		setCategoria("");
		setTitulo("");
		setDescripcion("");
		setUsuario("");
		setSimbolo("");
		setNs("");
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getRuta() {
		return ruta;
	}

	public void setRuta(String ruta) {
		this.ruta = ruta;
	}

	public String getCategoria() {
		return categoria;
	}

	public void setCategoria(String categoria) {
		this.categoria = categoria;
	}

	public String getTitulo() {
		return titulo;
	}

	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public String getUsuario() {
		return usuario;
	}

	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}

	public String getSubcategoria() {
		return subcategoria;
	}

	public void setSubcategoria(String subcategoria) {
		this.subcategoria = subcategoria;
	}

	public String getSimbolo() {
		return simbolo;
	}

	public void setSimbolo(String simbolo) {
		this.simbolo = simbolo;
	}

	public String getNs() {
		return ns;
	}

	public void setNs(String ns) {
		this.ns = ns;
	}
	
}
