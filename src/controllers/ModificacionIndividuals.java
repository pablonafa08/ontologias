/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.sql.*;
import java.util.ArrayList;
import java.util.Base64;

public class ModificacionIndividuals {

	Conexion cn = new Conexion();
	private Connection conn;
	private Statement state;

	public ModificacionIndividuals() {}

	public boolean eliminar(String individuo, String id_ontologia, String id_usuario) {
		boolean encontrado = false;
		try {
			conn = cn.GetConexion();
			state = conn.createStatement();
			String query = "INSERT INTO eliminar_individuos(id_ontologia,id_usuario,individuo,estatus) VALUES ('"
					+ id_ontologia + "','" + id_usuario + "','" + individuo + "','P')";

			int i = state.executeUpdate(query);
			if (i > 0) {
				encontrado = true;
			}
		} catch (Exception e) {
			e.getStackTrace();
		}
		return encontrado;
	}

	public boolean actualizar_eliminar(String id, String estatus) {
		boolean encontrado = false;
		try {
			conn = cn.GetConexion();
			state = conn.createStatement();
			String query = "UPDATE eliminar_individuos SET estatus = '" + estatus + "' WHERE id = " + id;

			int i = state.executeUpdate(query);
			if (i > 0) {
				encontrado = true;
			}
		} catch (Exception e) {
			e.getStackTrace();
		}
		return encontrado;
	}

	public boolean rechazar_modificacion(String id) {
		boolean encontrado = false;
		try {
			conn = cn.GetConexion();
			state = conn.createStatement();
			String query = "UPDATE modificar_individuos SET estatus = 'B' WHERE id = " + id;

			int i = state.executeUpdate(query);
			if (i > 0) {
				encontrado = true;
			}
		} catch (Exception e) {
			e.getStackTrace();
		}
		return encontrado;
	}

}
