<%@page import="com.shopkart.BusinessObject"%>
<%@page import="com.shopkart.Transaction"%>
<%@page
	import="org.springframework.context.support.ClassPathXmlApplicationContext"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page import="com.shopkart.Product"%>
<%@page import="com.shopkart.ShopKartDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript">

    <%if (session != null) {
				String name = (String) session.getAttribute("userName");
				if (name == null) {
					System.out.print("UserName Not Found!!!");
					response.getWriter().print(
							"Something went Wrong Session<br>Please Login Again<a href=\"Login.html\">Login</a>");
					return;
				}
			}%>
<%if (!(request.getAttribute("msg") == null)) {%>
	alert('<%out.print(request.getAttribute("msg"));%>');
<%}%>
	
</script>
<title>Order Summary</title>
<style>
.txt {
	width: 300px;
	height: 30px;
	border:2px solid black;
	border-radius:3px;
	font-family:"Comic Sans MS";
	font-size:18px;
}
body{
	font-family:"Comic Sans MS";
	text-align:center;
}
.btn{
	font-family:"Comic Sans MS";
	background-color:grey;
	border:2px solid black;
	width:200px;
	color:white;
	padding:10px;
	border-radius:3px;
}
div{
	position:absolute;
	top:0;
	left:0;
	width:100%;
	height:100%;
	background-image:url("Images/PageWallpaper.jpg");
	background-size:cover;
	background-repeat:no-repeat;
	background-attachment:fixed;
	opacity:0.6;
	z-index:-1;
}
</style>
</head>
<body>
<div></div>
<img src="Images/logofinal.png" height="100px" width="100px">
	<h1>
		WELCOME
		<%=session.getAttribute("userName")%></h1>
	<hr />
	<table align="center" cellpadding="10px" cellspacing="0" border="1">
		<tr>
			<th>Product Name</th>
			<th>Quantity</th>
			<th>Discount</th>
			<th>Net Amount</th>
		</tr>
		<%
			ApplicationContext context = new ClassPathXmlApplicationContext("Beans.xml");
			ShopKartDAO sp = (ShopKartDAO) context.getBean("eDao");
			String userName =(String) session.getAttribute("userName");
			ArrayList<Transaction> transList = sp.getTrans("select * from Transaction where userName='"+userName+"'");
			for (Transaction trans : transList) {
				String productName = BusinessObject.getProductName(trans.getProductId());
		%>
		<tr>
			<%
				out.print("<td>" + productName + "</td>");
					out.print("<td>" + trans.getQuantity() + "</td>");
					out.print("<td>" + trans.getDistcountAmt() + "</td>");
					out.print("<td>" + trans.getNetAmt() + "</td>");
			%>
		</tr>
		<%
			}
		%>
	</table>
	<br/>
	<br/>
	<table align="center">
	<tr>
	<td colspan="2">
	<form action="http://localhost:8081/ShopKart/AddToKart" method="post">
		<%
			ArrayList<Product> productList = sp.getProducts("select * from Product");
		%>
		<select class="txt" name="productId">
			<%
				for (Product p : productList) {
			%>
			<option value="<%out.print(p.getProductId());%>">
				<%
					out.print(p.getProductName());
				%>
			</option>
			<%
				}
			%>
		</select> 
		Quantity:<input class="txt" type="number" name="quantity" required> 
		<input class="btn" type="submit" value="Add to Cart">
		<br/>
	</form>
	</td>
	</tr>
	<tr>
	<td>
	<br/>
	<form action="http://localhost:8081/ShopKart/CancelServlet">
		<input class="btn" type="submit" value="Cancel">
	</form>
	<form action="http://localhost:8081/ShopKart/PaymentServlet">
		<input class="btn" type="submit" value="Shop">
	</form>
	<form action="http://localhost:8081/ShopKart/LogoffServlet">
		<input class="btn" type="submit" value="LogOff">
	</form>
	</td>
	</tr>
	</table>
</body>
</html>