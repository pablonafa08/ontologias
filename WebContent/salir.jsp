<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1" />
<title>Insert title here</title>
</head>
<body>
  <%
  	session.invalidate();
  	response.sendRedirect("/ontologias/login.jsp");
  %>
</body>
</html>
