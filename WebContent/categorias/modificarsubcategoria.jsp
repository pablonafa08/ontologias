
<%
	String usuario2 = (String) session.getAttribute("Usuario");
	String usuarioTipo = (String) session.getAttribute("UsuarioTipo");
	if (usuario2 == null || usuarioTipo == null) {
		response.sendRedirect("/ontologias/login.jsp");
	} else if (!usuarioTipo.equals("1")) {
		response.sendRedirect("/ontologias/login.jsp");
	} else {
		request.getSession().setMaxInactiveInterval(60 * 60);
%>
<%@page import="controllers.SubCategorias"%>
<%@page import="models.SubCategoria"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Editar subcategoría</title>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../js/bootstrap.min.js" rel="stylesheet">
<link href="../css/mycss.css" rel="stylesheet">
<link href="../style.css" rel="stylesheet">
<script src="../js/popper.min.js"></script>
<script src="../js/jquery-3.3.1.slim.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script src="../js/fontsolid.js"></script>
<script src="../js/fontawesome.js"></script>
<link href="../css/boton.css" rel="stylesheet">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="../js/buscarCategoria2.js"></script>
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
        <h3>Editar subcategoría</h3>
      </div>
      <div class="col-1"></div>
    </div>
    <br>
    <div class="row">
      <div class="col-1"></div>
      <div class="col align-self-center">
        <div class="card" style="box-shadow: -4px 5px rgb(237, 234, 245, 0.5);">
          <div class="card-body align-self-center">
            <%
            	String id = request.getParameter("id").toString();
            		SubCategorias conexion = new SubCategorias();
            		ArrayList<SubCategoria> subcategorias = conexion.listarxId(id);
            		for (SubCategoria subcategoria : subcategorias) {
            %>
            <form action="../ModificarSubCategoria" method="post" enctype="multipart/form-data">
              <div class="row">
                <div class="col-7">
                  <input type="hidden" class="form-control" name="id" value="<%out.print(subcategoria.getId());%>">
                  <div class="form-group">
                    <label style="font-weight: 600">Agregar título</label>
                    <input type="text" class="form-control" placeholder="Título" name="titulo" value="<%out.print(subcategoria.getTitulo());%>">
                  </div>
                  <div class="form-group">
                    <label style="font-weight: 600">Agregar imágen</label>
                    <br>
                    <input type="file" name="file-1" id="file-1" class="inputfile inputfile-1" data-multiple-caption="{count} archivos seleccionados" multiple />
                    <label for="file-1">
                      <svg xmlns="http://www.w3.org/2000/svg" class="iborrainputfile" width="20" height="17" viewBox="0 0 20 17">
												<path
                          d="M10 0l-5.2 4.9h3.3v5.1h3.8v-5.1h3.3l-5.2-4.9zm9.3 11.5l-3.2-2.1h-2l3.4 2.6h-3.5c-.1 0-.2.1-.2.1l-.8 2.3h-6l-.8-2.2c-.1-.1-.1-.2-.2-.2h-3.6l3.4-2.6h-2l-3.2 2.1c-.4.3-.7 1-.6 1.5l.6 3.1c.1.5.7.9 1.2.9h16.3c.6 0 1.1-.4 1.3-.9l.6-3.1c.1-.5-.2-1.2-.7-1.5z"></path></svg>
                      <span class="iborrainputfile">Seleccionar imágen</span>
                    </label>
                  </div>
                </div>
                <div class="col-4">
                  <%
                  	if (subcategoria.getImagen() != null) {
                  %>
                  <div class="card"
                    style="width: 11rem; height: 10rem; background-image: url('data:image/png;base64,<%out.print(subcategoria.getImagen());%>'); background-color: rgb(167, 161, 161,0.5);  background-size: cover; box-shadow: -4px 5px rgb(237,234,245,0.5); ">
                  </div>
                  <%
                  	} else {
                  %>
                  <div class="card" style="width: 11rem; height: 10rem; background-image: url('../img/fondoCat.png'); background-color: rgb(167, 161, 161, 0.5); background-size: cover; box-shadow: -4px 5px rgb(237, 234, 245, 0.5);"></div>
                  <%
                  	}
                  %>
                  <div class="form-group">
                    <label style="font-weight: 600">Eliminar Foto</label>
                    <input type="checkbox" class="" name="eliminar_foto" id="eliminar_foto">
                  </div>
                </div>
              </div>
              <button type="submit" class="btn btn-primary">
                <i class="fas fa-save"></i>
                Guardar
              </button>
            </form>
            <%
            	}
            %>
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
  				out.print("<script>toastr.success('Se modificó la subcategoría'); </script> ");
  			} else if (respuesta.equals("nosuccess")) {
  				out.print("<script>toastr.error('No se pudo modificar la subcategoría'); </script> ");
  			} else if (respuesta.equals("error")) {
  				out.print("<script>toastr.error('Error al modificar la subcategoría'); </script> ");
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