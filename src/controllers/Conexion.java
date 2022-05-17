package controllers;

import java.sql.Connection;
import java.sql.DriverManager;
import java.util.TimeZone;

public class Conexion {
	private Connection conn;
	
	public Connection GetConexion() {
		try {//version de mariaDB 5.5 "proliantserv"
			Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
			//Class.forName("org.mariadb.jdbc.Driver").newInstance();
			conn = DriverManager.getConnection("jdbc:mysql://localhost/ontologias?serverTimezone=" + TimeZone.getDefault().getID(),"root",null);
			//conn = DriverManager.getConnection("jdbc:mariadb://localhost/ontologias?serverTimezone=" + TimeZone.getDefault().getID(),"root","proliantserv");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return conn;
	}

}
