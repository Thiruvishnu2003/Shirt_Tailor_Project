<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="pack1.DBcode" import="com.itextpdf.text.*" import="com.itextpdf.text.pdf.*"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="CSS/AddOrder.css">
</head>
<body>
<div class="con" id="con">
<form action="AddOrder.jsp" method="get">
	<h3>Adding order</h3>
	<table>
		<tr><td>Customer Name:</td><td><input type="text" 				name="cname"	id="cname"></td></tr>
		<tr><td>Customer Mobile number:</td><td><input type="number" 	name="phone"	id="phone"></td></tr>
		<tr><td>Order Date:</td><td><input type="date" 					name="or_date"	id="or_date"></td></tr>
		<tr><td>Delivery Date:</td><td><input type="date" 				name="del_date"	id="del_date"></td></tr>
		<tr><td>Neck Size:</td><td><input type="number" 				name="neck_size" step="0.01"></td></tr>
		<tr><td>Length:</td><td><input type="number" 					name="length" step="0.01"></td></tr>
		<tr><td>Chest Size:</td><td><input type="number" 				name="chest_size" step="0.01"></td></tr>
		<tr><td>Stomach Size:</td><td><input type="number" 				name="stomach_size" step="0.01"></td></tr>
		<tr><td>Hip Size:</td><td><input type="number"  				name="hip_size" step="0.01"></td></tr>
		<tr><td>Sleeve Size:</td><td><input type="number" 				name="sleeve_size" step="0.01"></td></tr>
		<tr><td>Pocket:</td><td>
			<select 													name="pocket">
				<option>No</option>
				<option>Single</option>
				<option>Double</option>
			</select>
		</td></tr>
		<tr><td></td><td><input type="Button" onclick="printBill()" value="Print Bill" class="bt2"><input type="submit" value="Done" name="submit" class="bt1"><input type="submit" value="Cancel" name="submit" class="bt2"></td></tr>
	</table>
	
</form>
</div>
<div id="bill" style="display:none;">
	<h1>Shirt Bill</h1>
	<p>Name: <span id="n"></span></p>
	<p>Phone: <span id="p"></span></p>
	<p>Order date: <span id="od"></span></p>
	<p>Devivery Date: <span id="dd"></span></p>
</div>
<%
try{
	String submit = request.getParameter("submit");
	if(submit != null){
		if(submit.equalsIgnoreCase("Cancel")){
			response.sendRedirect("home.jsp");
		}
		else if(submit.equalsIgnoreCase("Done")){
			//Getting data
			String cname = request.getParameter("cname");
			long phone = Long.parseLong(request.getParameter("phone"));
			String or_date = request.getParameter("or_date");
			String del_date = request.getParameter("del_date");
			float neck_size = Float.parseFloat(request.getParameter("neck_size"));
			float length = Float.parseFloat(request.getParameter("length"));
			float chest_size = Float.parseFloat(request.getParameter("chest_size"));
			float stomach_size = Float.parseFloat(request.getParameter("stomach_size"));
			float hip_size = Float.parseFloat(request.getParameter("hip_size"));
			float sleeve_size = Float.parseFloat(request.getParameter("sleeve_size"));
			String pocket = request.getParameter("pocket");
			String order_status = "Active";
			//DBcode object
			DBcode db = new DBcode();
			int res = 0;
			res = db.addOrder(cname, phone, or_date, del_date, neck_size, length, chest_size, stomach_size, hip_size, sleeve_size, pocket, order_status);
			if(res!=0){
				out.print("<h3>");
				out.print("Order added successfully..");
				out.print("</h3>");%>
				<script>
	            	alert("Order added Successfully!!");
	            	window.location.href = "ActiveOrders.jsp"
	        	</script>
	        	<%
			}
			else{
				out.print("<h3>");
				out.print("Failed to add order..");
				out.print("</h3>");
			}
		}
	}
}
catch(Exception e){
	out.print("<h3>");
	out.print("Error occured!! Check the inputs.");
	out.print("</h3>");
}
%>
</body>
<script>
	const today = new Date();
	const dd = String(today.getDate())
	const mm = String(today.getMonth() + 1) // Months are zero-based
	const yyyy = today.getFullYear();
	
	const formattedDate = yyyy+"-"+mm+"-"+dd;
	document.getElementById("or_date").value = formattedDate;
	
	function printBill(){
		cname = document.getElementById("cname").value;
		phone = document.getElementById("phone").value;
		or_date = document.getElementById("or_date").value;
		del_date = document.getElementById("del_date").value;
		if(confirm("print bill?")){
			const n = document.getElementById("n");
			const p = document.getElementById("p");
			const od = document.getElementById("od");
			const dd = document.getElementById("dd");
			n.innerText = cname;
			p.innerText = phone;
			od.innerText = or_date;
			dd.innerText = del_date;
			con = document.getElementById("con");
			con.style.display = "none";
			bill = document.getElementById("bill");
			bill.style.display = "";
			window.print();
			con.style.display = "";
			bill.style.display = "none";
		}
	}
</script>
</html>