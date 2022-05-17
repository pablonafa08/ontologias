package servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import controllers.Ontologias;
import controllers.Pruebas;
import models.Ontologia;
import models.Utils;

@WebServlet("/InsertarOntologia")
@MultipartConfig(maxFileSize = 16177215)
public class InsertarOntologia extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public InsertarOntologia() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (request.getParameter("categoria") == null) {
			request.getSession().setAttribute("respuesta", "error_notcategoria");
			response.sendRedirect("/ontologias/ontologias/add.jsp");
		} else if (request.getParameter("subcategoria") == null) {
			request.getSession().setAttribute("respuesta", "error_notsubcat");
			response.sendRedirect("/ontologias/ontologias/add.jsp");
		} else if (request.getParameter("titulo").toString().equals("")) {
			request.getSession().setAttribute("respuesta", "error_nottitulo");
			response.sendRedirect("/ontologias/ontologias/add.jsp");
		} else {
			InputStream inputStream = null;
			Part filePart = request.getPart("file-1");
			String filename = getFilename(filePart);
			if (!filename.equals("")) {
				String[] partsFile = filename.split("\\.");
				if (partsFile[partsFile.length - 1].equals("owl")) {
					if (filePart != null) {
						inputStream = filePart.getInputStream();
					}
					
					Utils utils = new Utils();
					String archivourl = utils.getRuta();
					Date fecha = new Date();

					try {
						DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
						DateFormat hourdateFormat = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy");
						String[] parts = hourdateFormat.format(fecha).split(":");
						String[] partss = parts[2].split(" ");
						String nombre = request.getSession().getAttribute("UsuarioId").toString() + "_" + parts[0] + "-"
								+ parts[1] + "-" + partss[0] + "-" + dateFormat.format(fecha) + ".owl";
						String ruta = archivourl + "\\" + nombre;
						File outputfle = new File(ruta);
						outputfle.deleteOnExit();
						FileOutputStream os = new FileOutputStream(outputfle);

						int ch = inputStream.read();
						while (ch != -1) {
							os.write(ch);
							ch = inputStream.read();
						}
						inputStream.close();
						os.close();

						Pruebas pruebas = new Pruebas();
						String[] todo = pruebas.leer(nombre, request.getSession().getAttribute("UsuarioId").toString());
						nombre = todo[2];
						Ontologia ontologia = new Ontologia();
						Ontologias ontologias = new Ontologias();
						ontologia.setTitulo(request.getParameter("titulo").toString());
						ontologia.setDescripcion(request.getParameter("titulo").toString());
						ontologia.setCategoria(request.getParameter("categoria").toString());
						ontologia.setSubcategoria(request.getParameter("subcategoria").toString());
						ontologia.setRuta(nombre);
						ontologia.setUsuario(request.getSession().getAttribute("UsuarioId").toString());
						ontologia.setNs(todo[0]);
						ontologia.setSimbolo(todo[1]);

//						if (ontologias.insertar(ontologia)) {
							request.getSession().setAttribute("respuesta", "success");
//						} else {
//							request.getSession().setAttribute("respuesta", "nosuccess");
//						}

						outputfle.delete();
						response.sendRedirect("/ontologias/ontologias/add.jsp");
					} catch (NumberFormatException ex) {
						request.getSession().setAttribute("respuesta", "error");
						response.sendRedirect("/ontologias/ontologias/add.jsp");
					} catch (Exception e) {
						request.getSession().setAttribute("respuesta", "error");
						response.sendRedirect("/ontologias/ontologias/add.jsp");
					}
				} else {
					request.getSession().setAttribute("respuesta", "error_notfileextension");
					response.sendRedirect("/ontologias/ontologias/add.jsp");
				}
			} else {
				request.getSession().setAttribute("respuesta", "error_notfile");
				response.sendRedirect("/ontologias/ontologias/add.jsp");
			}
		}
	}

	private static String getFilename(Part part) {
		for (String cd : part.getHeader("content-disposition").split(";")) {
			if (cd.trim().startsWith("filename")) {
				String filename = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
				return filename.substring(filename.lastIndexOf('/') + 1).substring(filename.lastIndexOf('\\') + 1);
			}
		}
		return null;
	}
}
