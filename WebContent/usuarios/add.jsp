
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
<%@page import="controllers.Categorias"%>
<%@page import="models.Categoria"%>
<%@page import="controllers.Usuarios"%>
<%@page import="models.Tipo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="models.Usuario"%>
<%@page import="java.sql.*"%>
<%@page import="controllers.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Nuevo usuario</title>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../js/bootstrap.min.js" rel="stylesheet">
<link href="../style.css" rel="stylesheet">
<script src="../js/popper.min.js"></script>
<script src="../js/jquery-3.3.1.slim.min.js"></script>
<script src="../js/bootstrap4.min.js"></script>
<script src="../js/fontsolid.js"></script>
<script src="../js/fontawesome.js"></script>
</head>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<link href="../css/boton.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<link href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet">
<script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
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
        <h3>Nuevo usuario</h3>
      </div>
      <div class="col-1"></div>
    </div>
    <br>
    <div class="row">
      <div class="col-1"></div>
      <div class="col ">
        <div class="card" style="box-shadow: -4px 5px rgb(237, 234, 245, 0.5);">
          <div class="card-body ">
            <form action="../Insertar" method="post" class="row" enctype="multipart/form-data">
              <div class="col-6">
                <div class="form-group">
                  <label style="font-weight: 600">Nombre(s)</label>
                  <input type="text" class="form-control" placeholder="Nombre(s)" name="nombres" required>
                </div>
                <div class="form-group">
                  <label style="font-weight: 600">Apellido paterno</label>
                  <input type="text" class="form-control" placeholder="Apellido paterno" name="app" required>
                </div>
                <div class="form-group">
                  <label style="font-weight: 600">Apellido materno</label>
                  <input type="text" class="form-control" placeholder="Apellido materno" name="apm" required>
                </div>
                <div class="form-group">
                  <label style="font-weight: 600">Correo electrónico</label>
                  <input type="email" class="form-control" placeholder="Correo electrónico" name="correo" required>
                </div>
                <div class="form-group">
                  <label style="font-weight: 600">Tipo de usuario</label>
                  <select class="form-control" name="tipo">
                    <%
                    	Usuarios users = new Usuarios();
                    		ArrayList<Tipo> usuarios = users.tipo_usuario();
                    		for (Tipo usuario : usuarios) {
                    %>
                    <option value="<%out.print(usuario.getId());%>">
                      <%
                      	out.print(usuario.getDescripcion());
                      %>
                    </option>
                    <%
                    	}
                    %>
                  </select>
                </div>
                <div class="form-group">
                  <label style="font-weight: 600">Categoría</label>
                  <select class="form-control" name="categoria">
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
              </div>
              <div class="col-6">
                <div class="form-group">
                  <label style="font-weight: 600">Nombre de usuario</label>
                  <input type="text" class="form-control" placeholder="Nombre de usuario" name="usuario" required>
                </div>
                <div class="form-group">
                  <label style="font-weight: 600">Contraseña</label>
                  <input type="password" class="form-control" placeholder="Contraseña" name="contra" required>
                </div>
                <div class="form-group">
                  <label style="font-weight: 600">Repetir contraseña</label>
                  <input type="password" class="form-control" placeholder="Repetir contraseña" name="contra2" required>
                </div>
                <div class="form-group">
                  <label style="font-weight: 600">Foto</label>
                  <br>
                  <input type="file" name="file-1" id="file-1" class="inputfile inputfile-1" data-multiple-caption="{count} archivos seleccionados" multiple />
                  <label for="file-1">
                    <svg xmlns="http://www.w3.org/2000/svg" class="iborrainputfile" width="20" height="17" viewBox="0 0 20 17">
											<path
                        d="M10 0l-5.2 4.9h3.3v5.1h3.8v-5.1h3.3l-5.2-4.9zm9.3 11.5l-3.2-2.1h-2l3.4 2.6h-3.5c-.1 0-.2.1-.2.1l-.8 2.3h-6l-.8-2.2c-.1-.1-.1-.2-.2-.2h-3.6l3.4-2.6h-2l-3.2 2.1c-.4.3-.7 1-.6 1.5l.6 3.1c.1.5.7.9 1.2.9h16.3c.6 0 1.1-.4 1.3-.9l.6-3.1c.1-.5-.2-1.2-.7-1.5z"></path></svg>
                    <span class="iborrainputfile">Seleccionar imágen</span>
                  </label>
                  <br> <br>
                  <button type="submit" class="btn btn-primary ">
                    <i class="fas fa-user-plus"></i>
                    Agregar
                  </button>
                </div>
              </div>
            </form>
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
  				out.print("<script>toastr.success('Se insertó el usuario'); </script> ");
  			} else if (respuesta.equals("difpass")) {
  				out.print("<script>toastr.error('Las contraseñas no son iguales'); </script> ");
  			} else if (respuesta.equals("repeatusu")) {
  				out.print("<script>toastr.error('Usuario repetido'); </script> ");
  			} else if (respuesta.equals("nosuccess")) {
  				out.print("<script>toastr.error('No se pudo insertar'); </script> ");
  			} else if (respuesta.equals("error")) {
  				out.print("<script>toastr.error('Error al insertar'); </script> ");
  			} else if (respuesta.equals("error_notdata")) {
  				out.print("<script>toastr.error('Llene todos los campos'); </script> ");
  			} else if (respuesta.equals("repeatemail")) {
  				out.print("<script>toastr.error('Correo repetido'); </script> ");
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