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

@WebServlet("/InsertarSubCategoria")
@MultipartConfig(maxFileSize = 16177215)
public class InsertarSubCategoria extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public InsertarSubCategoria() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (request.getParameter("titulo").equals("")) {
			request.getSession().setAttribute("respuesta", "error_nottitulo");
			response.sendRedirect("/ontologias/categorias/addramas.jsp");
		} else if (request.getParameter("categoria") == null) {
			request.getSession().setAttribute("respuesta", "error_notcategoria");
			response.sendRedirect("/ontologias/categorias/addramas.jsp");
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
				SubCategoria subcategoria = new SubCategoria();
				SubCategorias subcategorias = new SubCategorias();
				subcategoria.setTitulo(request.getParameter("titulo"));
				subcategoria.setCategoria(request.getParameter("categoria"));

				if (inputStream != null) {
					subcategoria.setImagen(imageStr);
				}

				if (subcategorias.insertar(subcategoria)) {
					request.getSession().setAttribute("respuesta", "success");
				} else {
					request.getSession().setAttribute("respuesta", "nosuccess");
				}

				response.sendRedirect("/ontologias/categorias/addramas.jsp");
			} catch (NumberFormatException ex) {
				request.getSession().setAttribute("respuesta", "error");
				response.sendRedirect("/ontologias/categorias/addramas.jsp");
			} catch (Exception e) {
				request.getSession().setAttribute("respuesta", "error");
				response.sendRedirect("/ontologias/categorias/addramas.jsp");
			}
		}
	}

}
