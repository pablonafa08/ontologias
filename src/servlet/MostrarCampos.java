package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/MostrarCampos")
public class MostrarCampos extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public MostrarCampos() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			request.getSession().setAttribute("clase_e", request.getParameter("clase"));
			request.getSession().setMaxInactiveInterval(60 * 30);
			response.sendRedirect("/ontologias/ontologias/insertar.jsp");
		} catch (Exception e) {
		}
	}
}
