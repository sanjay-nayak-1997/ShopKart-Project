<%@page import="com.shopkart.Product"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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
	height:500%;
	background-image:url("Images/PageWallpaper.jpg");
	background-size:cover;
	background-repeat:no-repeat;
	background-attachment:fixed;
	opacity:0.6;
	z-index:-1;
}
</style>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Product Details</title>
</head>
<body>
<div></div>
<img src="Images/logofinal.png" height="100px" width="100px">
<h1>PRODUCT DETAILS</h1>
<hr/>
<table border="1" align="center" cellspacing="0" cellpadding="10px">
<tr>
<th>Product ID</th>
<th>Product Name</th>
<th>Category</th>
<th>Price</th>
<th>Quantity</th>
<th>Discount %</th>
<th>Tax Name</th>
</tr>
<%
	ArrayList<Product> al=(ArrayList<Product>)request.getAttribute("al");
	for(int i=0;i<al.size();i++)
	{
%><tr>
		<td><%=al.get(i).getProductId()%></td>
		<td><%=al.get(i).getProductName()%></td>
		<td><%=al.get(i).getCategory()%></td>
		<td><%=al.get(i).getPrice()%></td>
		<td><%=al.get(i).getQuantity()%></td>
		<td><%=al.get(i).getDiscountPerc()%></td>
		<td><%=al.get(i).getTaxRate()%></td>
		</tr>
<%}%>
</table>
<br/>
<br/>
<form>
<button class="btn" type="submit" name="addprod" formaction="http://localhost:8081/ShopKart/AddProducts.jsp">Add Products</button>
<button class="btn" type="submit" name="updprod" formaction="http://localhost:8081/ShopKart/UpdateProducts.jsp">Update Products</button>
<button class="btn" type="submit" name="remprod" formaction="http://localhost:8081/ShopKart/DeleteProducts.jsp">Remove Products</button>
<button class="btn" type="submit" formaction="http://localhost:8081/ShopKart/AdminHome.jsp">GO BACK</button>
</form>
</body>
</html>