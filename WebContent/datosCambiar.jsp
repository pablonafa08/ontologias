<%@page import="controllers.Usuarios"%>
<%@page import="models.Usuario"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="controllers.Conexion"%>
<%
	if (request.getParameter("button") != null) {
		String pass = request.getParameter("contra");
		String newpass = request.getParameter("contra_nueva");
		String newpass2 = request.getParameter("contra_nueva2");
		String actualpass = "";
		if (pass.equals("") || newpass.equals("") || newpass2.equals("")) {
			request.setAttribute("respuesta", "error_notdata");
		} else {
			if (!newpass.equals(newpass2)) {
				request.setAttribute("respuesta", "difpass");
			} else {

				try {
					Usuarios conexion = new Usuarios();
					ArrayList<Usuario> usuarios = conexion
							.buscarXId(request.getSession().getAttribute("UsuarioId").toString());
					for (Usuario usuario : usuarios) {
						actualpass = usuario.getContra();
					}

				} catch (NumberFormatException ex) {
					request.setAttribute("respuesta", "error");
				} catch (Exception e) {
					request.setAttribute("respuesta", "error");
				}
				if (!pass.equals(actualpass)) {
					request.setAttribute("respuesta", "wrongpass");
				} else {

					try {
						Usuario usuario = new Usuario();
						Usuarios usuarios = new Usuarios();
						usuario.setId(
								Integer.parseInt(request.getSession().getAttribute("UsuarioId").toString()));
						usuario.setContra(newpass);

						if (usuarios.actualizar_password(usuario)) {
							request.setAttribute("respuesta", "success");

						} else {
							request.setAttribute("respuesta", "nosuccess");
						}

					} catch (NumberFormatException ex) {
						request.setAttribute("respuesta", "error");
					} catch (Exception e) {
						request.setAttribute("respuesta", "error");
					}

				}

			}
		}

	}
%>