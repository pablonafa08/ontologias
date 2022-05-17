<%@page import="controllers.Usuarios"%>
<%@page import="models.Usuario"%>
<%@page import="controllers.Conexion"%>
<%@page import="java.sql.*"%>
<%
	if (request.getParameter("button") != null) {
		try {
			session.invalidate();
			Usuarios conexion = new Usuarios();
			Usuario usuario = conexion.login(request.getParameter("usuario"), request.getParameter("contra"));
			if (usuario != null) {
				request.getSession().setAttribute("UsuarioId", usuario.getId());
				request.getSession().setAttribute("UsuarioTipo", Integer.toString(usuario.getTipo()));
				request.getSession().setAttribute("UsuarioCategoria", usuario.getCategoria());
				request.getSession().setAttribute("Usuario", "1");
				request.getSession().setMaxInactiveInterval(60 * 30);
				response.sendRedirect("/ontologias/index.jsp");
			} else {
				request.setAttribute("noentro", "no");
			}

		} catch (NumberFormatException ex) {
			request.setAttribute("noentro", "no");
		} catch (Exception e) {
			request.setAttribute("noentro", "no");
		}

	}
%>