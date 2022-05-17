package servlet;

import java.io.IOException;
import java.io.InputStream;
import java.util.Base64;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import controllers.Usuarios;
import models.Usuario;

@WebServlet("/ModificarPerfil")
@MultipartConfig(maxFileSize = 16177215)
public class ModificarPerfil extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ModificarPerfil() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (request.getParameter("nombres").toString().equals("") || request.getParameter("app").toString().equals("")
				|| request.getParameter("apm").toString().equals("")) {
			request.getSession().setAttribute("respuesta", "error_notdata");
			response.sendRedirect("/ontologias/perfil.jsp");
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
				usuario.setId(Integer.parseInt(request.getSession().getAttribute("UsuarioId").toString()));
				usuario.setNombres(request.getParameter("nombres"));
				usuario.setApp(request.getParameter("app"));
				usuario.setApm(request.getParameter("apm"));
				String che = request.getParameter("eliminar_foto");
				if (che != null) {
					usuario.setFoto("encendido");
				}
				if (!imageStr.equals("")) {
					usuario.setFoto(imageStr);
				}

				if (usuarios.actualizar_perfil(usuario)) {
					request.getSession().setAttribute("respuesta", "success");
				} else {
					request.getSession().setAttribute("respuesta", "nosuccess");
				}

				response.sendRedirect("/ontologias/perfil.jsp");
			} catch (NumberFormatException ex) {
				request.getSession().setAttribute("respuesta", "error");
				response.sendRedirect("/ontologias/perfil.jsp");
			} catch (Exception e) {
				request.getSession().setAttribute("respuesta", "error");
				response.sendRedirect("/ontologias/perfil.jsp");
			}
		}
	}

}
