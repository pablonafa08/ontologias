package models;

public class Utils {
	private String ruta;

	// "\\home\\openkm\\tomcat-8.5.24\\webapps\\ontologias\\archivos\\"
	// "C:\\Users\\Jesus\\Documents\\Semestre 8\\Yobani\\1.- interfaces dinamicas\\archivos owl\\carreras.owl"
	// "\\usr\\local\\tomcat9\\webapps\\ontologias\\archivos\\"
	public Utils() {
		setRuta("C:\\Users\\pablo\\eclipse-workspace\\ontologias\\WebContent\\archivos\\");
	}

	public String getRuta() {
		return ruta;
	}

	public void setRuta(String ruta) {
		this.ruta = ruta;
	}

}
