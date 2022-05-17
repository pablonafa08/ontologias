
<%
	if (request.getSession().getAttribute("Usuario") == "1") {
		response.sendRedirect("/ontologias/index.jsp");
	}
	String usu = request.getParameter("usuario");
	String password = request.getParameter("contra");
%>
<%@include file="datosLogin.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Iniciar Sesión</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="js/bootstrap.min.js" rel="stylesheet">
<link href="style.css" rel="stylesheet">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script defer src="https://use.fontawesome.com/releases/v5.0.13/js/solid.js" integrity="sha384-tzzSw1/Vo+0N5UhStP3bvwWPq+uvzCMfrN1fEFe+xBmv1C/AtVX5K0uZtmcHitFZ" crossorigin="anonymous"></script>
<script defer src="https://use.fontawesome.com/releases/v5.0.13/js/fontawesome.js" integrity="sha384-6OIrr52G08NpOFSZdxxz1xdNSndlD4vdcf/q2myIUVO0VsqaGHJsB0RaBE01VTOY" crossorigin="anonymous"></script>
</head>
<body>
  <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <img src="img/uasLogo.png" class="logo" alt="Logo" style="height: 50px; width: 50px;">
    <a class="navbar-brand" href="login.jsp">Ontologías</a>
  </nav>
  <div class="container h-100">
    <div class="d-flex justify-content-center h-100">
      <div class="user_card">
        <div class="d-flex justify-content-center">
          <div class="brand_logo_container">
            <img src="img/face.png" class="brand_logo" alt="Logo">
          </div>
        </div>
        <div class="d-flex justify-content-center form_container">
          <form action="login.jsp" method="post">
            <div class="input-group mb-3">
              <div class="input-group-append">
                <span class="input-group-text">
                  <i class="fas fa-user"></i>
                </span>
              </div>
              <input type="text" name="usuario" class="form-control input_user" value="<%if (usu != null) {
				out.print(usu);
			}%>" placeholder="Usuario">
            </div>
            <div class="input-group mb-2">
              <div class="input-group-append">
                <span class="input-group-text">
                  <i class="fas fa-key"></i>
                </span>
              </div>
              <input type="password" name="contra" class="form-control input_pass" value="<%if (password != null) {
				out.print(password);
			}%>" placeholder="Contraseña">
            </div>
            <%
            	if (request.getAttribute("noentro") == "no") {
            		out.print("<div class='alert alert-danger'>Usuario o Contraseña incorrecta</div>");
            	}
            %>
            <div class="d-flex justify-content-center mt-3 login_container">
              <button type="submit" name="button" class="btn login_btn">Entrar</button>
            </div>
          </form>
        </div>
        <div class="mt-4">
          <div class="d-flex justify-content-center links"></div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>