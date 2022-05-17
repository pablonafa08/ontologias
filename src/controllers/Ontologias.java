package controllers;

import java.sql.*;
import java.util.ArrayList;

import models.Ontologia;

public class Ontologias {
	Conexion cn = new Conexion();
	private Connection conn;
	private Statement state;

	public Ontologias() {}

	public boolean insertar(Ontologia ontologia) {
		boolean encontrado = false;
		try {
			conn = cn.GetConexion();
			state = conn.createStatement();
			int i = state.executeUpdate(
					"INSERT INTO ontologias(ruta_archivo,id_categoria,id_subcategoria,titulo,descripcion,id_usuario,estatus,simbolo,ns) VALUES ('"
							+ ontologia.getRuta() + "'," + ontologia.getCategoria() + "," + ontologia.getSubcategoria()
							+ ",'" + ontologia.getTitulo() + "','" + ontologia.getDescripcion() + "',"
							+ ontologia.getUsuario() + ",'A','" + ontologia.getSimbolo() + "','" + ontologia.getNs()
							+ "')");
			if (i > 0) {
				encontrado = true;
			}
		} catch (Exception e) {
			e.getStackTrace();
		}
		return encontrado;
	}

	public boolean eliminar(String id) {
		boolean encontrado = false;
		try {
			conn = cn.GetConexion();
			state = conn.createStatement();
			int i = state.executeUpdate("UPDATE ontologias SET estatus = 'B' WHERE id = '" + id + "'");
			if (i > 0) {
				encontrado = true;
			}
		} catch (Exception e) {
			e.getStackTrace();
		}
		return encontrado;
	}

	public ArrayList<Ontologia> listar() throws Exception {
		conn = cn.GetConexion();
		state = conn.createStatement();
		ArrayList<Ontologia> ontologias = new ArrayList<Ontologia>();
		ResultSet rs = state.executeQuery(
				"SELECT * FROM ontologias JOIN usuarios ON usuarios.id = ontologias.id_usuario WHERE ontologias.estatus = 'A'");
		while (rs.next()) {
			Ontologia ontologia = new Ontologia();
			ontologia.setId((Integer) rs.getObject(1));
			ontologia.setRuta((String) rs.getObject(2));
			ontologia.setTitulo((String) rs.getObject(5));
			ontologia.setUsuario(
					(String) rs.getObject("nombres") + " " + rs.getObject("app") + " " + rs.getObject("apm"));
			ontologias.add(ontologia);
		}
		return ontologias;
	}

	public ArrayList<Ontologia> listarXCat(String id) throws Exception {

		conn = cn.GetConexion();
		state = conn.createStatement();
		ArrayList<Ontologia> ontologias = new ArrayList<Ontologia>();
		ResultSet rs = state.executeQuery(
				"SELECT * FROM ontologias JOIN usuarios ON usuarios.id = ontologias.id_usuario WHERE ontologias.estatus = 'A' AND id_subcategoria = "
						+ id);
		while (rs.next()) {
			Ontologia ontologia = new Ontologia();
			ontologia.setId((Integer) rs.getObject(1));
			ontologia.setRuta((String) rs.getObject(2));
			ontologia.setTitulo((String) rs.getObject(5));
			ontologia.setUsuario(
					(String) rs.getObject("nombres") + " " + rs.getObject("app") + " " + rs.getObject("apm"));
			ontologias.add(ontologia);
		}
		return ontologias;
	}

	public ArrayList<Ontologia> listarXUsuario(String id) throws Exception {

		conn = cn.GetConexion();
		state = conn.createStatement();
		ArrayList<Ontologia> ontologias = new ArrayList<Ontologia>();
		ResultSet rs = state.executeQuery("SELECT * FROM ontologias WHERE estatus = 'A' AND id_usuario = " + id);
		while (rs.next()) {
			Ontologia ontologia = new Ontologia();
			ontologia.setId((Integer) rs.getObject(1));
			ontologia.setRuta((String) rs.getObject(2));
			ontologia.setTitulo((String) rs.getObject(5));

			ontologias.add(ontologia);
		}
		return ontologias;
	}
}
