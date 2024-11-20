<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="pack1.DBcode" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="CSS/ActiveOrders.css">
</head>
<body>
	<h3>Active Orders</h3>
	<%!
		DBcode db = new DBcode();
		ResultSet rs;
		
	%>
	<%	
		String searchIn = request.getParameter("searchIn");
		if(searchIn==null || searchIn.isEmpty()){
			rs = db.activeOrders();
		}
		else{
			long search = Long.parseLong(searchIn);
			rs = db.searchOrder(search);
		}
	%>
	<form action="ActiveOrders.jsp">
		<input  class="bt" type="submit" name="submit" value="Home" id="Home">
		<input class="bt"  type="submit" name="submit" value="Add Order" id="Add Order">
	</form>
	<!-- Search Button-->
	<form action="ActiveOrders.jsp">
		<input class="search"  name="searchIn" id="searchIn" type="number" placeholder="Search by phone">
		<input class="bt" type="submit" value="Search">
	</form>
	
	
	<table border="3" rules="all">
		<tr><td>ID</td><td>Name</td><td>Phone</td><td>OrderDate</td><td>DeliveryDate</td><td>NeckSize</td><td>Length</td><td>ChestSize</td><td>StomachSize</td><td>HipSize</td><td>SleeveSize</td><td>Pocket</td></tr>
	<%
	while(rs.next())
	{ 
	%>
	<tr>
		<form action="ActiveOrders.jsp">
		<input class="bt" type="hidden" name="id" value="<%= rs.getInt("id") %>">
		<td><%=rs.getInt("id") %></td>
		<td><input name="name"		class="inp" type="text" value= <%=rs.getString("name") %>></td>
		<td><input name="phone"		class="inp"  type="number" value= <%=rs.getLong("phone") %>></td>
		<td><input name="or_date"	class="inp"  type="date" value= <%=rs.getString("or_date") %>></td>
		<td><input name="del_date"	class="inp"  type="date" value= <%=rs.getString("del_date") %>></td>
		<td><input name="neck_size" 	step="0.01" class="inp"  type="number" value= <%=rs.getFloat("neck_size") %>></td>
		<td><input name="length" 		step="0.01" class="inp"  type="number" value= <%=rs.getFloat("length") %>></td>
		<td><input name="chest_size" 	step="0.01"	class="inp"  type="number" value= <%=rs.getFloat("chest_size") %>></td>
		<td><input name="stomach_size" 	step="0.01" class="inp"  type="number" value= <%=rs.getFloat("stomach_size") %>></td>
		<td><input name="hip_size" 		step="0.01" class="inp"  type="number" value= <%=rs.getFloat("hip_size") %>></td>
		<td><input name="sleeve_size" 	step="0.01" class="inp"  type="number" value= <%=rs.getFloat("sleeve_size") %>></td>
		<td><input name="pocket" class="inp"  type="text" value= <%=rs.getString("pocket") %>></td>
		<td><input  class="bt" type="submit" value="Edit" name="submit"></td>
		</form>
		<td>
            <form action="ActiveOrders.jsp" onsubmit="return confirmAction();">
            	<input class="bt" type="hidden" name="id" value="<%= rs.getInt("id") %>">
            	<input class="bt"  type="submit" value="Cancel" name="submit"></td>
            	<td><input class="bt"  type="submit" value="Finish" name="submit"></td>
            </form>
        </td>
	</tr>
	<%
	} 
	%>
	<%
		String submit = request.getParameter("submit");
		if(submit != null){
			if(submit.equalsIgnoreCase("Home")){
				out.print("Back");
				response.sendRedirect("home.jsp");
			}
			else if(submit.equalsIgnoreCase("add order")){
				response.sendRedirect("AddOrder.jsp");
			}
			else if(submit.equalsIgnoreCase("Finish")){
				int res = 0;
				int id = Integer.parseInt(request.getParameter("id"));
				res = db.finishOrder(id);
				if(res!=0){
					response.sendRedirect("ActiveOrders.jsp");
				}
				else{
					out.print("Not updated");
				}
			}
			else if(submit.equalsIgnoreCase("Cancel")){
				out.print("cancel");
				System.out.print("Cancel");
				int res = 0;
				int id = Integer.parseInt(request.getParameter("id"));
				res = db.cancelOrder(id);
				if(res!=0){
					response.sendRedirect("ActiveOrders.jsp");
				}
				else{
					out.print("Error..");
				}
			}
			else if(submit.equalsIgnoreCase("Edit")){
				//Edit Details
				int id = Integer.parseInt(request.getParameter("id"));
				String name = request.getParameter("name");
				long phone = Long.parseLong((String)request.getParameter("phone"));
				String or_date = request.getParameter("or_date");
				String del_date = request.getParameter("del_date");
				float neck_size = Float.parseFloat(request.getParameter("neck_size"));
				float length = Float.parseFloat(request.getParameter("length"));
				float chest_size = Float.parseFloat(request.getParameter("chest_size"));
				float stomach_size = Float.parseFloat(request.getParameter("stomach_size"));
				float hip_size = Float.parseFloat(request.getParameter("hip_size"));
				float sleeve_size = Float.parseFloat(request.getParameter("sleeve_size"));
				String pocket = request.getParameter("pocket");
				int res = 0;
				res = db.editOrder(id,name,phone,or_date,del_date,neck_size,length,chest_size,stomach_size,hip_size,sleeve_size,pocket);
				if(res!=0){
					System.out.println("Edited");
				}
				else{
					System.out.println("Not edited");
				}
				response.sendRedirect("ActiveOrders.jsp");
			}
		}
	%>
	</table>
	<form>
	</form>
	<script>
		function confirmAction(){
			const submitButton = event.submitter; // The button that triggered the form submission
		    const action = submitButton.value;
			if(action=="Cancel"){
				return confirm("Cancel order?");
			}
			else if(action=="Finish"){
				return confirm("Are you sure the order is Finished?");
			}
			return false;
		}
	</script>
</body>
</html>