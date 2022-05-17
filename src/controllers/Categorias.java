package controllers;

import java.sql.*;
import java.util.ArrayList;
import java.util.Base64;

import models.Categoria;

public class Categorias {
	Conexion cn = new Conexion();
	private Connection conn;
	private Statement state;

	public Categorias() {

	}

	public boolean insertar(Categoria categoria) {
		boolean encontrado = false;
		try {
			conn = cn.GetConexion();
			state = conn.createStatement();
			String query;
			if (categoria.getImagen().equals("")) {
				query = "INSERT INTO categorias(titulo,imagen,estatus) VALUES ('" + categoria.getTitulo()
						+ "',null,'A')";
			} else {
				query = "INSERT INTO categorias(titulo,imagen,estatus) VALUES ('" + categoria.getTitulo() + "','"
						+ categoria.getImagen() + "','A')";
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
			int i = state.executeUpdate("UPDATE categorias SET estatus = 'B' WHERE id = '" + id + "'");
			if (i > 0) {
				encontrado = true;
			}
		} catch (Exception e) {
			e.getStackTrace();
		}
		return encontrado;
	}

	public boolean actualizar(Categoria categoria) {
		boolean encontrado = false;
		try {
			conn = cn.GetConexion();
			state = conn.createStatement();
			String query;
			if (categoria.getImagen().equals("")) {
				query = "UPDATE categorias SET titulo = '" + categoria.getTitulo() + "' WHERE id = "
						+ categoria.getId();
			} else if (categoria.getImagen().equals("encendido")) {
				query = "UPDATE categorias SET titulo = '" + categoria.getTitulo() + "', imagen = null WHERE id = "
						+ categoria.getId();
			} else {
				query = "UPDATE categorias SET titulo = '" + categoria.getTitulo() + "', imagen = '"
						+ categoria.getImagen() + "' WHERE id = " + categoria.getId();
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

	public ArrayList<Categoria> listar() throws Exception {

		conn = cn.GetConexion();
		state = conn.createStatement();
		ArrayList<Categoria> categorias = new ArrayList<Categoria>();
		ResultSet rs = state.executeQuery("SELECT * FROM categorias WHERE estatus = 'A'");
		while (rs.next()) {
			Categoria categoria = new Categoria();
			categoria.setId((Integer) rs.getObject(1));
			categoria.setTitulo((String) rs.getObject(2));
			categoria.setImagen(rs.getString(3));
			categorias.add(categoria);
		}
		return categorias;

	}

	public ArrayList<Categoria> listarxId(String id) throws Exception {

		conn = cn.GetConexion();
		state = conn.createStatement();
		ArrayList<Categoria> categorias = new ArrayList<Categoria>();
		ResultSet rs = state.executeQuery("SELECT * FROM categorias WHERE estatus = 'A' AND id = " + id);
		while (rs.next()) {
			Categoria categoria = new Categoria();
			categoria.setId((Integer) rs.getObject(1));
			categoria.setTitulo((String) rs.getObject(2));
			categoria.setImagen(rs.getString(3));
			categorias.add(categoria);
		}
		return categorias;

	}

	public ArrayList<Categoria> listarXFiltro(String q) throws Exception {

		conn = cn.GetConexion();
		state = conn.createStatement();
		ArrayList<Categoria> categorias = new ArrayList<Categoria>();
		ResultSet rs = state.executeQuery("SELECT * FROM categorias WHERE titulo LIKE '%" + q + "%' AND estatus = 'A'");
		while (rs.next()) {
			Categoria categoria = new Categoria();
			categoria.setId((Integer) rs.getObject(1));
			categoria.setTitulo((String) rs.getObject(2));
			categoria.setImagen(rs.getString(3));
			categorias.add(categoria);
		}
		return categorias;

	}

}
