package controllers;

import java.sql.*;
import java.util.ArrayList;

import models.Usuario;
import models.Tipo;

public class Usuarios {
	Conexion cn = new Conexion();
	private Connection conn;
	private Statement state;

	public Usuarios() {

	}

	public Usuario login(String usuario, String contra) {
		Usuario usu = null;
		try {
			conn = cn.GetConexion();
			state = conn.createStatement();
			ResultSet rs = state.executeQuery("SELECT * FROM usuarios WHERE usuario = '" + usuario + "' and contra = '"
					+ contra + "' and estatus = 'A'");
			while (rs.next()) {
				usu = new Usuario();
				usu.setId((Integer) rs.getObject(1));
				usu.setNombres((String) rs.getObject(2));
				usu.setApp((String) rs.getObject(3));
				usu.setApm((String) rs.getObject(4));
				usu.setTipo((Integer) rs.getObject(9));
				usu.setCategoria((Integer) rs.getObject(10));

			}

		} catch (Exception e) {
			e.getStackTrace();
		}
		return usu;

	}

	public boolean insertar(Usuario usuario) {
		boolean encontrado = false;
		try {
			conn = cn.GetConexion();
			state = conn.createStatement();
			String query;
			if (usuario.getFoto().equals("")) {
				query = "INSERT INTO usuarios(nombres,app,apm,correo,usuario,contra,estatus,tipo_usuario,categoria,foto) VALUES ('"
						+ usuario.getNombres() + "','" + usuario.getApp() + "','" + usuario.getApm() + "','"
						+ usuario.getCorreo() + "','" + usuario.getUsuario() + "','" + usuario.getContra() + "','A',"
						+ usuario.getTipo() + "," + usuario.getCategoria() + ",null)";
			} else {

				query = "INSERT INTO usuarios(nombres,app,apm,correo,usuario,contra,estatus,tipo_usuario,categoria,foto) VALUES ('"
						+ usuario.getNombres() + "','" + usuario.getApp() + "','" + usuario.getApm() + "','"
						+ usuario.getCorreo() + "','" + usuario.getUsuario() + "','" + usuario.getContra() + "','A',"
						+ usuario.getTipo() + "," + usuario.getCategoria() + ",'" + usuario.getFoto() + "')";
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
			int i = state.executeUpdate("UPDATE usuarios SET estatus = 'B' WHERE id = '" + id + "'");
			if (i > 0) {
				encontrado = true;
			}
		} catch (Exception e) {
			e.getStackTrace();
		}
		return encontrado;
	}

	public boolean actualizar(Usuario usuario) {
		boolean encontrado = false;
		try {
			conn = cn.GetConexion();
			state = conn.createStatement();
			int i = state.executeUpdate("UPDATE usuarios SET nombres = '" + usuario.getNombres() + "', app = '"
					+ usuario.getApp() + "', apm = '" + usuario.getApm() + "' WHERE id = " + usuario.getId());
			if (i > 0) {
				encontrado = true;
			}
		} catch (Exception e) {
			e.getStackTrace();
		}
		return encontrado;
	}

	public boolean actualizar_perfil(Usuario usuario) {
		boolean encontrado = false;
		try {
			conn = cn.GetConexion();
			state = conn.createStatement();
			String query;
			if (usuario.getFoto().equals("")) {
				query = "UPDATE usuarios SET nombres = '" + usuario.getNombres() + "', app = '" + usuario.getApp()
						+ "', apm = '" + usuario.getApm() + "' WHERE id = " + usuario.getId();
			} else if (usuario.getFoto().equals("encendido")) {
				query = "UPDATE usuarios SET nombres = '" + usuario.getNombres() + "', app = '" + usuario.getApp()
						+ "', apm = '" + usuario.getApm() + "', foto = null WHERE id = " + usuario.getId();
			} else {
				query = "UPDATE usuarios SET nombres = '" + usuario.getNombres() + "', app = '" + usuario.getApp()
						+ "', apm = '" + usuario.getApm() + "', foto = '" + usuario.getFoto() + "' WHERE id = "
						+ usuario.getId();
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

	public boolean actualizar_password(Usuario usuario) {
		boolean encontrado = false;
		try {
			conn = cn.GetConexion();
			state = conn.createStatement();
			int i = state.executeUpdate(
					"UPDATE usuarios SET contra = '" + usuario.getContra() + "' WHERE id = " + usuario.getId());
			if (i > 0) {
				encontrado = true;
			}
		} catch (Exception e) {
			e.getStackTrace();
		}
		return encontrado;
	}

	public ArrayList<Usuario> listar() throws Exception {
		conn = cn.GetConexion();
		state = conn.createStatement();
		ArrayList<Usuario> usuarios = new ArrayList<Usuario>();
		ResultSet rs = state.executeQuery("SELECT * FROM usuarios WHERE estatus = 'A'");
		while (rs.next()) {
			Usuario usuario = new Usuario();
			usuario.setId((Integer) rs.getObject(1));
			usuario.setNombres((String) rs.getObject(2));
			usuario.setApp((String) rs.getObject(3));
			usuario.setApm((String) rs.getObject(4));
			usuario.setCorreo((String) rs.getObject(5));
			usuario.setUsuario((String) rs.getObject(6));
			usuarios.add(usuario);
		}
		return usuarios;
	}

	public ArrayList<Usuario> buscarXId(String id) throws Exception {
		conn = cn.GetConexion();
		state = conn.createStatement();
		ArrayList<Usuario> usuarios = new ArrayList<Usuario>();
		ResultSet rs = state.executeQuery("SELECT * FROM usuarios WHERE estatus = 'A' AND id = " + id);
		while (rs.next()) {
			Usuario usuario = new Usuario();
			usuario.setId((Integer) rs.getObject(1));
			usuario.setNombres((String) rs.getObject(2));
			usuario.setApp((String) rs.getObject(3));
			usuario.setApm((String) rs.getObject(4));
			usuario.setCorreo((String) rs.getObject(5));
			usuario.setUsuario((String) rs.getObject(6));
			usuario.setTipo((Integer) rs.getObject(9));
			usuario.setFoto(rs.getString(11));
			usuario.setContra((String) rs.getObject("contra"));
			usuarios.add(usuario);
		}
		return usuarios;

	}

	public ArrayList<Usuario> buscarXUsuario(String n_usuario) throws Exception {
		conn = cn.GetConexion();
		state = conn.createStatement();
		ArrayList<Usuario> usuarios = new ArrayList<Usuario>();
		ResultSet rs = state
				.executeQuery("SELECT * FROM usuarios WHERE estatus = 'A' AND usuario = '" + n_usuario + "'");
		while (rs.next()) {
			Usuario usuario = new Usuario();
			usuario.setId((Integer) rs.getObject(1));
			usuario.setNombres((String) rs.getObject(2));
			usuario.setApp((String) rs.getObject(3));
			usuario.setApm((String) rs.getObject(4));
			usuario.setCorreo((String) rs.getObject(5));
			usuario.setUsuario((String) rs.getObject(6));
			usuario.setTipo((Integer) rs.getObject(9));
			usuario.setFoto(rs.getString(11));
			usuario.setContra((String) rs.getObject("contra"));
			usuarios.add(usuario);
		}
		return usuarios;

	}

	public ArrayList<Usuario> buscarXEmail(String e_usuario) throws Exception {
		conn = cn.GetConexion();
		state = conn.createStatement();
		ArrayList<Usuario> usuarios = new ArrayList<Usuario>();
		ResultSet rs = state
				.executeQuery("SELECT * FROM usuarios WHERE estatus = 'A' AND correo = '" + e_usuario + "'");
		while (rs.next()) {
			Usuario usuario = new Usuario();
			usuario.setId((Integer) rs.getObject(1));
			usuario.setNombres((String) rs.getObject(2));
			usuario.setApp((String) rs.getObject(3));
			usuario.setApm((String) rs.getObject(4));
			usuario.setCorreo((String) rs.getObject(5));
			usuario.setUsuario((String) rs.getObject(6));
			usuario.setTipo((Integer) rs.getObject(9));
			usuario.setFoto(rs.getString(11));
			usuario.setContra((String) rs.getObject("contra"));
			usuarios.add(usuario);
		}
		return usuarios;

	}

	public ArrayList<Tipo> tipo_usuario() throws Exception {
		conn = cn.GetConexion();
		state = conn.createStatement();
		ArrayList<Tipo> tipo_usuarios = new ArrayList<Tipo>();
		ResultSet rs = state.executeQuery("SELECT * FROM tipo_usuarios");
		while (rs.next()) {
			Tipo tipo_usuario = new Tipo();
			tipo_usuario.setId((Integer) rs.getObject(1));
			tipo_usuario.setDescripcion((String) rs.getObject(2));
			tipo_usuarios.add(tipo_usuario);
		}
		return tipo_usuarios;
	}
}
