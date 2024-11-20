<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="pack1.DBcode" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="CSS/FinishedOrders.css">
</head>
<body>
	<h3>Finished Orders</h3>
	<%!
		DBcode db = new DBcode();
		ResultSet rs;
	%>
	<%
		rs = db.finishedOrders();
	%>
	<table border="3" rules="all">
		<tr><td>ID</td><td>Name</td><td>Phone</td><td>OrderDate</td><td>DeliveryDate</td><td>NeckSize</td><td>Length</td><td>ChestSize</td><td>StomachSize</td><td>HipSize</td><td>SleeveSize</td><td>Pocket</td></tr>
	<%
	while(rs.next())
	{ 
	%>
	<tr>
		<td><%=rs.getInt("id") %></td>
		<td><%=rs.getString("name") %></td>
		<td><%=rs.getLong("phone") %></td>
		<td><%=rs.getString("or_date") %></td>
		<td><%=rs.getString("del_date") %></td>
		<td><%=rs.getFloat("neck_size") %></td>
		<td><%=rs.getFloat("length") %></td>
		<td><%=rs.getFloat("chest_size") %></td>
		<td><%=rs.getFloat("stomach_size") %></td>
		<td><%=rs.getFloat("hip_size") %></td>
		<td><%=rs.getFloat("sleeve_size") %></td>
		<td><%=rs.getString("pocket") %></td>
		<td>
            <form action="FinishedOrders.jsp" onsubmit="return collecting();">
            	<input type="hidden" name="id" value="<%= rs.getInt("id") %>">
            	<input type="submit" value="Collect" name="submit">
            </form>
        </td>
	</tr>
	<%
	} 
	%>
	<form action="FinishedOrders.jsp">
		<input type="submit" name="submit" value="Home">
	</form>
	<%
		String submit = request.getParameter("submit");
		if(submit != null){
			if(submit.equalsIgnoreCase("Home")){
				response.sendRedirect("home.jsp");
			}
			else{
				int res = 0;
				int id = Integer.parseInt(request.getParameter("id"));
				res = db.collectOrder(id);
				if(res!=0){
					response.sendRedirect("FinishedOrders.jsp");
				}
				else{
					out.print("Not updated");
				}
			}
		}
	%>
	</table>
	<script>
		function collecting(){
			if(confirm("Customer paid the amount and Collecting his shirt")){
				return true;
			}
			else{
				return false;
			}
		}
	</script>
</body>
</html>