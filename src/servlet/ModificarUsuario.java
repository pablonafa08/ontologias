package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import controllers.Usuarios;
import models.Usuario;

@WebServlet("/ModificarUsuario")
public class ModificarUsuario extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ModificarUsuario() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			Usuarios usuarios = new Usuarios();
			if (usuarios.eliminar(request.getParameter("id"))) {
				request.getSession().setAttribute("respuesta", "success_e");
			} else {
				request.getSession().setAttribute("respuesta", "nosuccess_e");
			}

			response.sendRedirect("/ontologias/usuarios/usuarios.jsp");
		} catch (NumberFormatException ex) {
			request.getSession().setAttribute("respuesta", "error_e");
			response.sendRedirect("/ontologias/usuarios/usuarios.jsp");
		} catch (Exception e) {
			request.getSession().setAttribute("respuesta", "error_e");
			response.sendRedirect("/ontologias/usuarios/usuarios.jsp");
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			Usuario usuario = new Usuario();
			Usuarios usuarios = new Usuarios();
			usuario.setNombres(request.getParameter("nombres"));
			usuario.setApp(request.getParameter("app"));
			usuario.setApm(request.getParameter("apm"));
			usuario.setId(Integer.parseInt(request.getParameter("id_usu")));

			if (usuarios.actualizar(usuario)) {
				request.getSession().setAttribute("respuesta", "success_m");
			} else {
				request.getSession().setAttribute("respuesta", "nosuccess_m");
			}

			response.sendRedirect("/ontologias/usuarios/usuarios.jsp");
		} catch (NumberFormatException ex) {
			request.getSession().setAttribute("respuesta", "error_m");
			response.sendRedirect("/ontologias/usuarios/usuarios.jsp");
		} catch (Exception e) {
			request.getSession().setAttribute("respuesta", "error_m");
			response.sendRedirect("/ontologias/usuarios/usuarios.jsp");
		}
	}
}
