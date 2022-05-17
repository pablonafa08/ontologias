package servlet;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Base64;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import models.Usuario;
import controllers.Usuarios;

@WebServlet("/Insertar")
@MultipartConfig(maxFileSize = 16177215)
public class Insertar extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Insertar() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (request.getParameter("nombres").toString().equals("") || request.getParameter("app").toString().equals("")
				|| request.getParameter("app").toString().equals("")
				|| request.getParameter("correo").toString().equals("")
				|| request.getParameter("usuario").toString().equals("")
				|| request.getParameter("contra").toString().equals("")
				|| request.getParameter("contra2").toString().equals("") || request.getParameter("tipo") == null
				|| request.getParameter("categoria") == null) {
			request.getSession().setAttribute("respuesta", "error_notdata");
			response.sendRedirect("/ontologias/usuarios/add.jsp");
		} else {
			String password = request.getParameter("contra").toString();
			String password2 = request.getParameter("contra2").toString();
			if (!password.equals(password2)) {
				request.getSession().setAttribute("respuesta", "difpass");
				response.sendRedirect("/ontologias/usuarios/add.jsp");
			} else {
				String nombre_usuario = request.getParameter("usuario").toString();

				try {
					Usuarios conexion = new Usuarios();
					ArrayList<Usuario> usuarios2 = conexion.buscarXUsuario(nombre_usuario);

					if (usuarios2.size() >= 1) {
						request.getSession().setAttribute("respuesta", "repeatusu");
						response.sendRedirect("/ontologias/usuarios/add.jsp");
					} else {
						ArrayList<Usuario> usuarios3 = conexion.buscarXEmail(request.getParameter("correo").toString());

						if (usuarios3.size() >= 1) {
							request.getSession().setAttribute("respuesta", "repeatemail");
							response.sendRedirect("/ontologias/usuarios/add.jsp");
						} else {
							InputStream inputStream = null;
							Part filePart = request.getPart("file-1");
							if (filePart != null) {

								inputStream = filePart.getInputStream();
							}

							byte[] imageBytes = new byte[(int) filePart.getSize()];
							inputStream.read(imageBytes, 0, imageBytes.length);
							inputStream.close();
							String imageStr = Base64.getEncoder().encodeToString(imageBytes);

							try {
								Usuario usuario = new Usuario();
								Usuarios usuarios = new Usuarios();
								usuario.setNombres(request.getParameter("nombres"));
								usuario.setApp(request.getParameter("app"));
								usuario.setApm(request.getParameter("apm"));
								usuario.setCorreo(request.getParameter("correo"));
								usuario.setUsuario(request.getParameter("usuario"));
								usuario.setContra(request.getParameter("contra"));
								usuario.setTipo(Integer.parseInt(request.getParameter("tipo")));
								usuario.setCategoria(Integer.parseInt(request.getParameter("categoria")));
								if (inputStream != null) {

									usuario.setFoto(imageStr);
								}

								if (usuarios.insertar(usuario)) {

									request.getSession().setAttribute("respuesta", "success");
								} else {
									request.getSession().setAttribute("respuesta", "nosuccess");
								}
								response.sendRedirect("/ontologias/usuarios/add.jsp");

							} catch (NumberFormatException ex) {
								request.getSession().setAttribute("respuesta", "error");
								response.sendRedirect("/ontologias/usuarios/add.jsp");
							} catch (Exception e) {
								request.getSession().setAttribute("respuesta", "error");
								response.sendRedirect("/ontologias/usuarios/add.jsp");
							}
						}
					}
				} catch (Exception e1) {
					request.getSession().setAttribute("respuesta", "error");
					response.sendRedirect("/ontologias/usuarios/add.jsp");
				}

			}
		}
	}

}
