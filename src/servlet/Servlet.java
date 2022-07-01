package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import controllers.*;
import models.Usuario;

@WebServlet("/Servlet")
public class Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Servlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			Usuarios conexion = new Usuarios();
			Usuario usuario = conexion.login(request.getParameter("usuario"), request.getParameter("contra"));

			if (usuario != null) {
				request.getSession().setAttribute("UsuarioId", usuario.getId());
				request.getSession().setAttribute("UsuarioTipo", Integer.toString(usuario.getTipo()));
				request.getSession().setAttribute("UsuarioCategoria", usuario.getCategoria());
				request.getSession().setAttribute("Usuario", "1");
				request.getSession().setMaxInactiveInterval(60 * 60);

				response.sendRedirect("/ontologias/index.jsp");
			} else {
				request.setAttribute("noentro", "no");
				RequestDispatcher rd;
				rd = request.getRequestDispatcher("/login.jsp");
				rd.forward(request, response);
			}

		} catch (NumberFormatException ex) {
			RequestDispatcher rd;
			rd = request.getRequestDispatcher("/login.jsp");
			rd.forward(request, response);
		} catch (Exception e) {
			RequestDispatcher rd;
			rd = request.getRequestDispatcher("/login.jsp");
			rd.forward(request, response);
		}
	}
}
