
<%
	String usuario2 = (String) session.getAttribute("Usuario");
	if (usuario2 == null) {
		response.sendRedirect("/ontologias/login.jsp");
	} else {
		request.getSession().setMaxInactiveInterval(60 * 60);
%>
<%@page import="controllers.Categorias"%>
<%@page import="models.Categoria"%>
<%@page import="controllers.SubCategorias"%>
<%@page import="models.SubCategoria"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="controllers.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Nueva ontología</title>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../js/bootstrap.min.js" rel="stylesheet">
<link href="../style.css" rel="stylesheet">
<script src="../js/popper.min.js"></script>
<script src="../js/jquery-3.3.1.slim.min.js"></script>
<script src="../js/bootstrap4.min.js"></script>
<script src="../js/fontsolid.js"></script>
<script src="../js/fontawesome.js"></script>
<link href="../css/boton.css" rel="stylesheet">
<!-- <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script> -->
<!-- <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script> -->
<!-- <script src="//code.jquery.com/jquery-1.11.1.min.js"></script> -->
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script> -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script defer src="https://use.fontawesome.com/releases/v5.0.13/js/solid.js" integrity="sha384-tzzSw1/Vo+0N5UhStP3bvwWPq+uvzCMfrN1fEFe+xBmv1C/AtVX5K0uZtmcHitFZ" crossorigin="anonymous"></script>
<script defer src="https://use.fontawesome.com/releases/v5.0.13/js/fontawesome.js" integrity="sha384-6OIrr52G08NpOFSZdxxz1xdNSndlD4vdcf/q2myIUVO0VsqaGHJsB0RaBE01VTOY" crossorigin="anonymous"></script>
<script src="../js/obtenerSubcategorias.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<link href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet">
<script src="../js/navbar.js"></script>
<script>
	loadNavBar({
		src : '../'
	});
</script>
</head>
<body>
  <nav id="navBarContent" class="navbar navbar-expand-lg navbar-dark bg-primary" style="justify-content: flex-start; min-height: 66px"></nav>

  <div class="container">
    <br>
    <div class="row">
      <div class="col-1 "></div>
      <div class="col">
        <h3>Nueva ontología</h3>
      </div>
      <div class="col-1"></div>
    </div>
    <br>
    <div class="row">
      <div class="col-1"></div>
      <div class="col">
        <div class="card" style="box-shadow: -4px 5px rgb(237, 234, 245, 0.5);">
          <div class="card-body center">
            <div class="container">
              <form action="../InsertarOntologia" method="post" enctype="multipart/form-data">
                <div class="row">
                  <div class="col-4">
                    <label style="font-weight: 600">Seleccionar categoría</label>
                  </div>
                  <div class="col-4">
                    <label style="font-weight: 600">Seleccionar rama</label>
                  </div>
                  <div class="col-4">
                    <label style="font-weight: 600">Agregar título o descripción</label>
                  </div>
                </div>
                <div class="row">
                  <div class="col-4">
                    <select class="form-control" name="categoria" id="categoria">
                      <%
                      	Conexion cn = new Conexion();
                      		Connection conn = cn.GetConexion();
                      		Statement state = conn.createStatement();
                      		Statement state2 = conn.createStatement();
                      		String cate = "";
                      		String cate2 = "";
                      		ResultSet rs = state.executeQuery("SELECT categoria FROM usuarios WHERE id = "
                      				+ request.getSession().getAttribute("UsuarioId").toString());
                      		while (rs.next()) {
                      			cate = rs.getString("categoria");
                      		}
                      		if (cate != null) {
                      			ResultSet rs2 = state2.executeQuery("SELECT titulo FROM categorias WHERE id = " + cate);
                      			while (rs2.next()) {
                      				cate2 = rs2.getString("titulo");
                      %>
                      <option value="<%out.print(cate);%>">
                        <%
                        	out.print(rs2.getString("titulo"));
                        %>
                      </option>
                      <%
                      	}
                      		} else {

                      			Categorias categoriass = new Categorias();
                      			ArrayList<Categoria> categorias = categoriass.listar();
                      			for (Categoria categoria : categorias) {
                      %>
                      <option value="<%out.print(categoria.getId());%>">
                        <%
                        	out.print(categoria.getTitulo());
                        %>
                      </option>
                      <%
                      	}
                      		}
                      %>
                    </select>
                  </div>
                  <div class="col-4">
                    <select class="form-control" name="subcategoria" id="subcategoria">
                      <%
                      	SubCategorias subcategoriass = new SubCategorias();
                      		if (cate != null) {
                      			ArrayList<SubCategoria> subcategorias = subcategoriass.listarXCategoria(cate);
                      			for (SubCategoria subcategoria : subcategorias) {
                      %>
                      <option value="<%out.print(subcategoria.getId());%>">
                        <%
                        	out.print(subcategoria.getTitulo());
                        %>
                      </option>
                      <%
                      	}
                      		}
                      %>
                    </select>
                  </div>
                  <div class="col-4">
                    <input type="text" class="form-control" placeholder="Título" name="titulo">
                  </div>
                </div>
                <div class="row">
                  <div class="col-4"></div>
                  <div class="col-4"></div>
                  <div class="col-4"></div>
                </div>
                <br>
                <div class="row">
                  <div class="col-4"></div>
                  <div class="col-4"></div>
                  <div class="col-4 justify-content-between">
                    <input type="file" name="file-1" id="file-1" class="inputfile inputfile-1" data-multiple-caption="{count} archivos seleccionados" multiple />
                    <label for="file-1">
                      <svg xmlns="http://www.w3.org/2000/svg" class="iborrainputfile" width="20" height="17" viewBox="0 0 20 17">
												<path
                          d="M10 0l-5.2 4.9h3.3v5.1h3.8v-5.1h3.3l-5.2-4.9zm9.3 11.5l-3.2-2.1h-2l3.4 2.6h-3.5c-.1 0-.2.1-.2.1l-.8 2.3h-6l-.8-2.2c-.1-.1-.1-.2-.2-.2h-3.6l3.4-2.6h-2l-3.2 2.1c-.4.3-.7 1-.6 1.5l.6 3.1c.1.5.7.9 1.2.9h16.3c.6 0 1.1-.4 1.3-.9l.6-3.1c.1-.5-.2-1.2-.7-1.5z"></path></svg>
                      <span class="iborrainputfile">Seleccionar Ontología</span>
                    </label>
                    <br> <br>
                    <button type="submit" class="btn btn-primary">
                      <i class="fas fa-plus"></i>
                      Agregar
                    </button>
                  </div>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
      <div class="col-1"></div>
    </div>
  </div>
  <%
  	String respuesta = (String) session.getAttribute("respuesta");
  		if (respuesta != null) {

  			if (respuesta.equals("success")) {
  				out.print("<script>toastr.success('Se insertó la ontología'); </script> ");
  			} else if (respuesta.equals("nosuccess")) {
  				out.print("<script>toastr.error('No se pudo insertar'); </script> ");
  			} else if (respuesta.equals("error")) {
  				out.print("<script>toastr.error('Error al insertar'); </script> ");
  			} else if (respuesta.equals("error_notcategoria")) {
  				out.print("<script>toastr.error('Selecciona una categoría'); </script> ");
  			} else if (respuesta.equals("error_notsubcat")) {
  				out.print("<script>toastr.error('Selecciona una subcategoría'); </script> ");
  			} else if (respuesta.equals("error_nottitulo")) {
  				out.print("<script>toastr.error('Ingresa el título de la ontología'); </script> ");
  			} else if (respuesta.equals("error_notfile")) {
  				out.print("<script>toastr.error('Selecciona una ontología'); </script> ");
  			} else if (respuesta.equals("error_notfileextension")) {
  				out.print("<script>toastr.error('Extensión del archivo no válida'); </script> ");
  			}
  			request.getSession().setAttribute("respuesta", null);
  		}
  %>
  <script>
			var inputs = document.querySelectorAll('.inputfile');
			Array.prototype.forEach
					.call(
							inputs,
							function(input) {
								var label = input.nextElementSibling, labelVal = label.innerHTML;

								input
										.addEventListener(
												'change',
												function(e) {
													var fileName = '';
													if (this.files
															&& this.files.length > 1)
														fileName = (this
																.getAttribute('data-multiple-caption') || '')
																.replace(
																		'{count}',
																		this.files.length);
													else
														fileName = e.target.value
																.split("\\")
																.pop();

													if (fileName)
														label
																.querySelector('span').innerHTML = fileName;
													else
														label.innerHTML = labelVal;
												});
							});
		</script>
</body>
</html>
<%
	}
%>