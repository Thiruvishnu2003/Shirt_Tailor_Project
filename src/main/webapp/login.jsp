<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="CSS/login.css">
</head>
<body>
<div class="con">
	<form action="login.jsp" method="get">
		<h2>Login</h2>
		<input type="text" placeholder="User name" name="user"><br>
		<input type="password" placeholder="Password" name="pass"><br>
		<input type="submit" value="Submit" class="bt" name="button"><br>
	</form>
</div>
<%
	String user = request.getParameter("user");
	String pass = request.getParameter("pass");
	String button = request.getParameter("button");
	if(button != null){
		if(user.equals("Admin") && pass.equals("12345")){
			%>
				<jsp:forward page="home.jsp"></jsp:forward>
			<%
		}
		else{
			out.print("<h2 style='color: black;text-align: center;'>Invalid username or password</h2>");
		}
	}
%>
</body>
</html>