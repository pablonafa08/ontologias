package servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Base64;
import java.util.TimeZone;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import controllers.Categorias;
import models.Categoria;

@WebServlet("/InsertarCategoria")
@MultipartConfig(maxFileSize = 16177215)
public class InsertarCategoria extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public InsertarCategoria() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (request.getParameter("titulo").toString().equals("")) {
			request.getSession().setAttribute("respuesta", "error_nodata");
			response.sendRedirect("/ontologias/categorias/add.jsp");
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
				Categoria categoria = new Categoria();
				Categorias categorias = new Categorias();
				categoria.setTitulo(request.getParameter("titulo"));

				if (inputStream != null) {
					categoria.setImagen(imageStr);
				}

				if (categorias.insertar(categoria)) {
					request.getSession().setAttribute("respuesta", "success");
				} else {
					request.getSession().setAttribute("respuesta", "nosuccess");
				}

				response.sendRedirect("/ontologias/categorias/add.jsp");
			} catch (NumberFormatException ex) {
				request.getSession().setAttribute("respuesta", "error");
				response.sendRedirect("/ontologias/categorias/add.jsp");
			} catch (Exception e) {
				request.getSession().setAttribute("respuesta", "error");
				response.sendRedirect("/ontologias/categorias/add.jsp");
			}
		}
	}

}
