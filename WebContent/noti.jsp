
<%
	String usuario2 = (String) session.getAttribute("Usuario");
	if (usuario2 == null) {
		response.sendRedirect("/ontologias/login.jsp");
	} else {
		request.getSession().setMaxInactiveInterval(60 * 60);
%>
<%@page import="java.sql.*"%>
<%@page import="controllers.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Notificaciones</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="js/bootstrap.min.js" rel="stylesheet">
<link href="./css/mycss.css" rel="stylesheet">
<link href="style.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script defer src="https://use.fontawesome.com/releases/v5.0.13/js/solid.js" integrity="sha384-tzzSw1/Vo+0N5UhStP3bvwWPq+uvzCMfrN1fEFe+xBmv1C/AtVX5K0uZtmcHitFZ" crossorigin="anonymous"></script>
<script defer src="https://use.fontawesome.com/releases/v5.0.13/js/fontawesome.js" integrity="sha384-6OIrr52G08NpOFSZdxxz1xdNSndlD4vdcf/q2myIUVO0VsqaGHJsB0RaBE01VTOY" crossorigin="anonymous"></script>
<script src="js/filterNotifications.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<link href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet">
<script src="js/navbar.js"></script>
<script>
	loadNavBar({
		src : ''
	});
</script>
</head>
<body>
  <nav id="navBarContent" class="navbar navbar-expand-lg navbar-dark bg-primary" style="justify-content: flex-start; min-height: 66px"></nav>

  <div class="container">
    <br> <br>
    <nav>
      <div class="nav nav-tabs" id="nav-tab" role="tablist">
        <a class="nav-link active" id="nav-edit-tab" data-toggle="tab" href="#nav-edit" role="tab" aria-controls="nav-edit" aria-selected="true">Peticiones de modificaci??n</a>
        <a class="nav-link" id="nav-delete-tab" data-toggle="tab" href="#nav-delete" role="tab" aria-controls="nav-delete" aria-selected="false">Peticiones de eliminaci??n</a>
      </div>
    </nav>

    <div class="tab-content" id="nav-tabContent" style="margin-top: 16px">
      <div class="tab-pane fade" id="nav-delete" role="tabpanel" aria-labelledby="nav-delete-tab">
        <div class="row justify-content-end align-items-center">
          <div class="col-4">
            <div class="input-group">
              <div class="input-group-prepend">
                <div class="input-group-text" id="btnGroupAddon">
                  <i class="fas fa-search"></i>
                </div>
              </div>
              <input type="text" class="form-control" placeholder="Buscar" id="searchTermDelete" onkeyup="doSearchDeleteRequest();" aria-label="Buscar" aria-describedby="btnGroupAddon">
            </div>
          </div>
        </div>
        <br>
        <h4 id="datosDelete3" style="display: none; text-align: center; margin-top: 30px">No se han hecho peticiones de eliminaci??n</h4>
        <h4 id="datosDelete2" style="display: none; text-align: center; margin-top: 30px">No se encontraron coincidencias</h4>
        <table class="table table-hover" id="datosDelete">
          <thead class="thead-default">
            <tr style="text-align: center;">
              <th>Id</th>
              <th>Ontolog??a</th>
              <th>Individuo a eliminar</th>
              <th>Acciones</th>
            <tr>
          </thead>
          <tbody>
            <%
            	Conexion cn = new Conexion();
            		Connection conn = cn.GetConexion();
            		Statement state = conn.createStatement();
            		String UsuarioCategoria = (String) session.getAttribute("UsuarioCategoria").toString();
            		String query;
            		if (UsuarioCategoria.equals("0")) {
            			query = "SELECT * FROM eliminar_individuos JOIN ontologias ON ontologias.id = eliminar_individuos.id_ontologia WHERE eliminar_individuos.estatus = 'P'";
            		} else {
            			query = "SELECT * FROM eliminar_individuos JOIN ontologias ON ontologias.id = eliminar_individuos.id_ontologia WHERE eliminar_individuos.estatus = 'P' AND id_categoria = "
            					+ UsuarioCategoria;
            		}

            		ResultSet rs = state.executeQuery(query);
            		while (rs.next()) {
            %>
            <tr>
              <td style="text-align: center;">
                <%
                	out.print(rs.getString("eliminar_individuos.id"));
                %>
              </td>
              <td style="text-align: center;">
                <%
                	out.print(rs.getString("titulo"));
                %>
              </td>
              <td style="text-align: center;">
                <%
                	out.print(rs.getString("individuo"));
                %>
              </td>
              <td>
                <div class="row justify-content-center">
                  <a href="#eliminar-<%out.print(rs.getString("eliminar_individuos.id"));%>" class="btn btn-sm btn-danger" style="margin-right: 8px" data-toggle="modal">
                    <i class="fas fa-trash-alt"></i>
                  </a>
                  <a href="#rechazar-<%out.print(rs.getString("eliminar_individuos.id"));%>" class="btn btn-sm btn-danger" data-toggle="modal">
                    <i class="fas fa-times"></i>
                  </a>
                </div>
                <!-- Aceptar eliminaci??n de individuo -->
                <div class="modal fade" id="eliminar-<%out.print(rs.getString("eliminar_individuos.id"));%>">
                  <div class="modal-dialog" role="document">
                    <div class="modal-content">
                      <div class="modal-header justify-content-center" style="text-align: center">
                        <h5 class="modal-title">??Est??s seguro que quieres eliminar?</h5>
                      </div>
                      <div class="modal-body">
                        <p style="text-align: center">
                          Se eliminar?? el individuo: <b> <%
 	out.print(rs.getString("individuo"));
 %>
                          </b>
                        </p>
                      </div>
                      <div class="modal-footer">
                        <a
                          href="ModificarAtributosConfirmacion?id=<%out.print(rs.getString("id_ontologia"));%>&individuo=<%out.print(rs.getString("individuo"));%>&ruta=<%out.print(rs.getString("ruta_archivo"));%>&id_e=<%out.print(rs.getString("eliminar_individuos.id"));%>&estatus=A&opcion=eliminar"
                          class="btn btn-primary">Eliminar</a>
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                      </div>
                    </div>
                  </div>
                </div>
                <!-- Rechazar eliminaci??n de individuo -->
                <div class="modal fade" id="rechazar-<%out.print(rs.getString("eliminar_individuos.id"));%>">
                  <div class="modal-dialog" role="document">
                    <div class="modal-content">
                      <div class="modal-header justify-content-center" style="text-align: center">
                        <h5 class="modal-title">??Est??s seguro que quieres rechazar?</h5>
                      </div>
                      <div class="modal-body">
                        <p style="text-align: center">
                          Se rechazar?? la eliminaci??n del individuo: <b> <%
 	out.print(rs.getString("individuo"));
 %>
                          </b>
                        </p>
                      </div>
                      <div class="modal-footer">
                        <a
                          href="ModificarAtributosConfirmacion?id=<%out.print(rs.getString("id_ontologia"));%>&individuo=<%out.print(rs.getString("individuo"));%>&ruta=<%out.print(rs.getString("ruta_archivo"));%>&id_e=<%out.print(rs.getString("eliminar_individuos.id"));%>&estatus=B&opcion=eliminar"
                          class="btn btn-primary">Rechazar</a>
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                      </div>
                    </div>
                  </div>
                </div>
              </td>
            </tr>
            <%
            	}
            %>
          </tbody>
        </table>
      </div>

      <div class="tab-pane fade show active" id="nav-edit" role="tabpanel" aria-labelledby="nav-edit-tab">
        <div class="row justify-content-end align-items-center">
          <div class="col-4">
            <div class="input-group">
              <div class="input-group-prepend">
                <div class="input-group-text" id="btnGroupAddon">
                  <i class="fas fa-search"></i>
                </div>
              </div>
              <input type="text" class="form-control" placeholder="Buscar" id="searchTermEdit" onkeyup="doSearchEditRequest();" aria-label="Buscar" aria-describedby="btnGroupAddon">
            </div>
          </div>
        </div>
        <br>
        <h4 id="datosEdit3" style="display: none; text-align: center; margin-top: 30px">No se han hecho peticiones de modificaci??n</h4>
        <h4 id="datosEdit2" style="display: none; text-align: center; margin-top: 30px">No se encontraron coincidencias</h4>
        <table class="table table-hover" id="datosEdit">
          <thead class="thead-default">
            <tr style="text-align: center;">
              <th>Id</th>
              <th>Ontolog??a</th>
              <th>Individuo</th>
              <th>Nuevos datos</th>
              <th>Acciones</th>
            <tr>
          </thead>
          <tbody>
            <%
            	Connection conn3 = cn.GetConexion();
            		Statement states = conn.createStatement();
            		String UsuarioCategoria2 = (String) session.getAttribute("UsuarioCategoria").toString();
            		String query2;
            		if (UsuarioCategoria.equals("0")) {
            			query = "SELECT * FROM modificar_individuos JOIN ontologias ON ontologias.id = modificar_individuos.id_ontologia WHERE modificar_individuos.estatus = 'P'";
            		} else {
            			query = "SELECT * FROM modificar_individuos JOIN ontologias ON ontologias.id = modificar_individuos.id_ontologia WHERE modificar_individuos.estatus = 'P' AND id_categoria = "
            					+ UsuarioCategoria;
            		}

            		ResultSet rs1 = state.executeQuery(query);
            		while (rs1.next()) {
            %>
            <tr>
              <td style="text-align: center;">
                <%
                	out.print(rs1.getString("modificar_individuos.id"));
                %>
              </td>
              <td style="text-align: center;">
                <%
                	out.print(rs1.getString("titulo"));
                %>
              </td>
              <td style="text-align: center;">
                <%
                	out.print(rs1.getString("individuo"));
                %>
              </td>
              <%
              	
              %>
              <td>
                <%
                	int y = 0;
                			String atributosSplit[] = rs1.getString("atributos").split("????");

                			int existe = atributosSplit.length;
                			if (atributosSplit[existe - 1].substring(0, 1).equals("~")) {
                				for (y = 0; y < atributosSplit.length - 1; y++) {
                					if (y % 2 == 0) {
                						out.print(" <b>" + atributosSplit[y] + ":</b> ");
                					} else {
                						out.print(atributosSplit[y]);
                					}
                				}
                			} else {
                				for (y = 0; y < atributosSplit.length; y++) {
                					if (y % 2 == 0) {
                						out.print(" <b>" + atributosSplit[y] + ":</b> ");
                					} else {
                						out.print(atributosSplit[y]);
                					}
                				}
                			}

                			String relacionesSplit[] = rs1.getString("atributos").split("~~");
                			for (y = 1; y < relacionesSplit.length; y++) {
                				if (y % 2 == 0) {
                					out.print(relacionesSplit[y]);
                				} else {
                					out.print(" <b>" + relacionesSplit[y] + ":</b> ");
                				}
                			}
                %>
              </td>
              <td>
                <div class="row justify-content-center">
                  <a href="#modificar-<%out.print(rs1.getString("modificar_individuos.id"));%>" class="btn btn-sm btn-primary" style="margin-right: 8px" data-toggle="modal">
                    <i class="fas fa-pencil-alt"></i>
                  </a>
                  <a href="#rechazarc-<%out.print(rs1.getString("modificar_individuos.id"));%>" class="btn btn-sm btn-danger" data-toggle="modal">
                    <i class="fas fa-times"></i>
                  </a>
                </div>
                <!-- Aceptar modificaci??n de individuo -->
                <div class="modal fade" id="modificar-<%out.print(rs1.getString("modificar_individuos.id"));%>">
                  <div class="modal-dialog" role="document">
                    <div class="modal-content">
                      <div class="modal-header justify-content-center" style="text-align: center">
                        <h5 class="modal-title">
                          ??Est??s seguro que quieres modificar el individuo "<%
                        	out.print(rs1.getString("individuo"));
                        %>"?
                        </h5>
                      </div>
                      <form method="post" action="ModificarAtributosConfirmacion">
                        <div class="modal-body">
                          <h5 style="margin-bottom: 24px">Nuevos datos:</h5>
                          <%
                          	String atributosSplit2[] = rs1.getString("atributos").split("????");
                          			if (atributosSplit2[existe - 1].substring(0, 1).equals("~")) {
                          				for (y = 0; y < atributosSplit2.length - 1; y++) {
                          					if (y % 2 == 0) {
                          %>
                          <label style="font-weight: 600">
                            <%
                            	out.print(atributosSplit2[y]);
                            %>
                          </label>
                          <%
                          	} else {
                          %>
                          <label class="form-control" style="margin-bottom: 1rem">
                            <%
                            	out.print(atributosSplit2[y]);
                            %>
                          </label>
                          <%
                          	}
                          				}
                          			} else {
                          				for (y = 0; y < atributosSplit2.length; y++) {
                          					if (y % 2 == 0) {
                          %>
                          <label style="font-weight: 600">
                            <%
                            	out.print(atributosSplit2[y]);
                            %>
                          </label>
                          <%
                          	} else {
                          %>
                          <label class="form-control" style="margin-bottom: 1rem">
                            <%
                            	out.print(atributosSplit2[y]);
                            %>
                          </label>
                          <%
                          	}
                          				}
                          			}
                          %>
                          <%
                          	String relacionesSplit2[] = rs1.getString("atributos").split("~~");
                          			for (y = 1; y < relacionesSplit2.length; y++) {
                          				if (y % 2 == 0) {
                          %>
                          <label class="form-control" style="margin-bottom: 1rem">
                            <%
                            	out.print(relacionesSplit2[y]);
                            %>
                          </label>
                          <%
                          	} else {
                          %>
                          <label style="font-weight: 600">
                            <%
                            	out.print(relacionesSplit2[y]);
                            %>
                          </label>
                          <%
                          	}
                          			}
                          %>
                          <input type="hidden" name="elid" value="<%out.print(rs1.getString("modificar_individuos.id"));%>">
                        </div>
                        <div class="modal-footer">
                          <button type="submit" class="btn btn-primary">Modificar</button>
                          <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                        </div>
                      </form>
                    </div>
                  </div>
                </div>
                <!-- Rechazar modificaci??n de individuo -->
                <div class="modal fade" id="rechazarc-<%out.print(rs1.getString("modificar_individuos.id"));%>">
                  <div class="modal-dialog" role="document">
                    <div class="modal-content">
                      <div class="modal-header justify-content-center" style="text-align: center">
                        <h5 class="modal-title">??Est??s seguro que quieres rechazar?</h5>
                      </div>
                      <div class="modal-body">
                        <p style="text-align: center">
                          Se rechazar?? la modificaci??n del individuo: <b> <%
 	out.print(rs1.getString("individuo"));
 %>
                          </b>
                        </p>
                      </div>
                      <div class="modal-footer">
                        <a href="ModificarAtributosConfirmacion?id=<%out.print(rs1.getString("modificar_individuos.id"));%>&opcion=modificar" class="btn btn-primary">Rechazar</a>
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                      </div>
                    </div>
                  </div>
                </div>
              </td>
            </tr>
            <%
            	}
            %>
          </tbody>
        </table>
      </div>
    </div>
  </div>
  <%
  	String respuesta = (String) session.getAttribute("respuesta");
  		if (respuesta != null) {

  			if (respuesta.equals("success_e")) {
  				out.print("<script>toastr.success('Se elimin?? el individuo'); </script> ");
  			} else if (respuesta.equals("nosuccess_e")) {
  				out.print("<script>toastr.error('No se pudo eliminar el individuo'); </script> ");
  			} else if (respuesta.equals("error_e")) {
  				out.print("<script>toastr.error('Error'); </script> ");
  			} else if (respuesta.equals("success_r")) {
  				out.print("<script>toastr.success('Se rechaz?? la petici??n de eliminaci??n'); </script> ");
  			} else if (respuesta.equals("nosuccess_r")) {
  				out.print("<script>toastr.error('No se pudo rechazar la petici??n de eliminaci??n'); </script> ");
  			} else if (respuesta.equals("success_m")) {
  				out.print("<script>toastr.success('Se modific?? el individuo'); </script> ");
  			} else if (respuesta.equals("nosuccess_m")) {
  				out.print("<script>toastr.error('No se pudo modificar el individuo'); </script> ");
  			} else if (respuesta.equals("success_rm")) {
  				out.print("<script>toastr.success('Se rechaz?? la petici??n de modificacion'); </script> ");
  			} else if (respuesta.equals("nosuccess_rm")) {
  				out.print(
  						"<script>toastr.error('No se pudo rechazar la petici??n de modificacion'); </script> ");
  			} else if (respuesta.equals("error_m")) {
  				out.print("<script>toastr.error('Error'); </script> ");
  			}
  			request.getSession().setAttribute("respuesta", null);
  		}
  %>
</body>
</html>
<%
	}
%>