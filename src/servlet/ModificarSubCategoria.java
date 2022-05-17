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

import controllers.SubCategorias;
import models.SubCategoria;

@WebServlet("/ModificarSubCategoria")
@MultipartConfig(maxFileSize = 16177215)
public class ModificarSubCategoria extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ModificarSubCategoria() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			SubCategorias subcategorias = new SubCategorias();
			if (subcategorias.eliminar(request.getParameter("id"))) {
				request.getSession().setAttribute("respuesta", "success");
			} else {
				request.getSession().setAttribute("respuesta", "nosuccess");
			}

			response.sendRedirect("/ontologias/categorias/ramas.jsp");
		} catch (NumberFormatException ex) {
			request.getSession().setAttribute("respuesta", "error");
			response.sendRedirect("/ontologias/categorias/ramas.jsp");
		} catch (Exception e) {
			request.getSession().setAttribute("respuesta", "error");
			response.sendRedirect("/ontologias/categorias/ramas.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
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
			SubCategoria subcategoria = new SubCategoria();
			SubCategorias subcategorias = new SubCategorias();
			subcategoria.setId(Integer.parseInt(request.getParameter("id")));
			subcategoria.setTitulo(request.getParameter("titulo"));
			String che = request.getParameter("eliminar_foto");
			if (che != null) {
				subcategoria.setImagen("encendido");
			}
			if (!imageStr.equals("")) {
				subcategoria.setImagen(imageStr);
			}

			if (subcategorias.actualizar(subcategoria)) {
				request.getSession().setAttribute("respuesta", "success_m");
			} else {
				request.getSession().setAttribute("respuesta", "nosuccess_m");
			}

			response.sendRedirect("/ontologias/categorias/ramas.jsp");
		} catch (NumberFormatException ex) {
			request.getSession().setAttribute("respuesta", "error_m");
			response.sendRedirect("/ontologias/categorias/ramas.jsp");
		} catch (Exception e) {
			request.getSession().setAttribute("respuesta", "error_m");
			response.sendRedirect("/ontologias/categorias/ramas.jsp");
		}
	}
}
