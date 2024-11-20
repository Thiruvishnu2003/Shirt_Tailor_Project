<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="CSS/home.css">
</head>
<body>
	<form action="home.jsp" method="get">
		<input type="submit" name="submit" value="Add Order"><br>
		<input type="submit" name="submit" value="Active Orders"><br>
		<input type="submit" name="submit" value="Finished Orders"><br>
		<input type="submit" name="submit" value="Logout"><br>
	</form>
	<%
		String submit = request.getParameter("submit");
		if(submit != null){
			if(submit.equalsIgnoreCase("Add Order")){
				response.sendRedirect("AddOrder.jsp");
			}
			else if(submit.equalsIgnoreCase("Active Orders")){
				response.sendRedirect("ActiveOrders.jsp");
			}
			else if(submit.equalsIgnoreCase("Finished Orders")){
				response.sendRedirect("FinishedOrders.jsp");
			}
			else if(submit.equalsIgnoreCase("logout")){
				response.sendRedirect("login.jsp");
			}
		}
	%>
</body>
</html>