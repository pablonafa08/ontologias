package controllers;

import java.sql.*;
import java.util.ArrayList;

import models.SubCategoria;

public class SubCategorias {
	Conexion cn = new Conexion();
	private Connection conn;
	private Statement state;

	public SubCategorias() {

	}

	public boolean insertar(SubCategoria subcategoria) {
		boolean encontrado = false;
		try {
			conn = cn.GetConexion();
			state = conn.createStatement();
			String query;
			if (subcategoria.getImagen().equals("")) {
				query = "INSERT INTO subcategorias(titulo,id_categoria,imagen,estatus) VALUES ('"
						+ subcategoria.getTitulo() + "'," + subcategoria.getCategoria() + ",null,'A')";
			} else {
				query = "INSERT INTO subcategorias(titulo,id_categoria,imagen,estatus) VALUES ('"
						+ subcategoria.getTitulo() + "'," + subcategoria.getCategoria() + ",'"
						+ subcategoria.getImagen() + "','A')";
			}
			int i = state.executeUpdate(query);
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
			int i = state.executeUpdate("UPDATE subcategorias SET estatus = 'B' WHERE id = '" + id + "'");
			if (i > 0) {
				encontrado = true;
			}
		} catch (Exception e) {
			e.getStackTrace();
		}
		return encontrado;
	}

	public boolean actualizar(SubCategoria subcategoria) {
		boolean encontrado = false;
		try {
			conn = cn.GetConexion();
			state = conn.createStatement();
			String query;
			if (subcategoria.getImagen().equals("")) {
				query = "UPDATE subcategorias SET titulo = '" + subcategoria.getTitulo() + "' WHERE id = "
						+ subcategoria.getId();
			} else if (subcategoria.getImagen().equals("encendido")) {
				query = "UPDATE subcategorias SET titulo = '" + subcategoria.getTitulo()
						+ "', imagen = null WHERE id = " + subcategoria.getId();
			} else {
				query = "UPDATE subcategorias SET titulo = '" + subcategoria.getTitulo() + "', imagen = '"
						+ subcategoria.getImagen() + "' WHERE id = " + subcategoria.getId();
			}
			int i = state.executeUpdate(query);
			if (i > 0) {
				encontrado = true;
			}
		} catch (Exception e) {
			e.getStackTrace();
		}
		return encontrado;
	}

	public ArrayList<SubCategoria> listarXCategoria(String id) throws Exception {

		conn = cn.GetConexion();
		state = conn.createStatement();
		ArrayList<SubCategoria> subcategorias = new ArrayList<SubCategoria>();
		ResultSet rs = state.executeQuery("SELECT * FROM subcategorias WHERE estatus = 'A' AND id_categoria = " + id);
		while (rs.next()) {
			SubCategoria subcategoria = new SubCategoria();
			subcategoria.setId((Integer) rs.getObject(1));
			subcategoria.setTitulo((String) rs.getObject(2));
			subcategoria.setImagen(rs.getString(4));
			subcategorias.add(subcategoria);
		}
		return subcategorias;

	}

	public ArrayList<SubCategoria> listar() throws Exception {

		conn = cn.GetConexion();
		state = conn.createStatement();
		ArrayList<SubCategoria> subcategorias = new ArrayList<SubCategoria>();
		ResultSet rs = state.executeQuery("SELECT * FROM subcategorias WHERE estatus = 'A'");
		while (rs.next()) {
			SubCategoria subcategoria = new SubCategoria();
			subcategoria.setId((Integer) rs.getObject(1));
			subcategoria.setTitulo((String) rs.getObject(2));
			subcategoria.setImagen(rs.getString(4));
			subcategorias.add(subcategoria);
		}
		return subcategorias;

	}

	public ArrayList<SubCategoria> listarxId(String id) throws Exception {

		conn = cn.GetConexion();
		state = conn.createStatement();
		ArrayList<SubCategoria> subcategorias = new ArrayList<SubCategoria>();
		ResultSet rs = state.executeQuery("SELECT * FROM subcategorias WHERE estatus = 'A' AND id = " + id);
		while (rs.next()) {
			SubCategoria subcategoria = new SubCategoria();
			subcategoria.setId((Integer) rs.getObject(1));
			subcategoria.setTitulo((String) rs.getObject(2));
			subcategoria.setImagen(rs.getString(4));
			subcategorias.add(subcategoria);
		}
		return subcategorias;

	}

	public ArrayList<SubCategoria> listarXCategoriaXFiltro(String q, String id) throws Exception {

		conn = cn.GetConexion();
		state = conn.createStatement();
		ArrayList<SubCategoria> subcategorias = new ArrayList<SubCategoria>();
		ResultSet rs = state.executeQuery("SELECT * FROM subcategorias WHERE titulo LIKE '%" + q
				+ "%' AND estatus = 'A' AND id_categoria = " + id);
		while (rs.next()) {
			SubCategoria subcategoria = new SubCategoria();
			subcategoria.setId((Integer) rs.getObject(1));
			subcategoria.setTitulo((String) rs.getObject(2));
			subcategoria.setImagen(rs.getString(4));
			subcategorias.add(subcategoria);
		}
		return subcategorias;

	}
}
