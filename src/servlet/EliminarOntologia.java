/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import controllers.Conexion;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "EliminarOntologia", urlPatterns = { "/EliminarOntologia" })
public class EliminarOntologia extends HttpServlet {

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Conexion cn = new Conexion();
		try {
			Connection conn2 = cn.GetConexion();
			Statement state2 = conn2.createStatement();
			String query2;
			query2 = "UPDATE ontologias SET estatus = 'B' WHERE id = " + request.getParameter("id") + "";
			int i = state2.executeUpdate(query2);
			if (i > 0) {
				request.getSession().setAttribute("respuesta", "success");
			} else {
				request.getSession().setAttribute("respuesta", "nosuccess");
			}
			response.sendRedirect("/ontologias/ontologias/todas.jsp");
		} catch (Exception e) {
			request.getSession().setAttribute("respuesta", "error");
			response.sendRedirect("/ontologias/ontologias/todas.jsp");
		}

	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

}
