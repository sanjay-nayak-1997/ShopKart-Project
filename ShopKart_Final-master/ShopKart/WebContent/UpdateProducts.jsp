<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Update Product</title>
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
<h1>UPDATE PRODUCT</h1>
<hr/>
	<%
		if (session != null) {
			String name = (String) session.getAttribute("userName");
			if (name == null) {
				System.out.print("UserName Not Found!!!");
				response.getWriter().print(
						"Something went Wrong Session<br>Please Login Again<a href=\"Login.html\">Login</a>");
				return;
			}
		}
	%><form>
					<button class="btn" formaction="http://localhost:8081/ShopKart/ProductsServlet">GO
						BACK</button></td></form>
	<form action="http://localhost:8081/ShopKart/UpdateProduct"
		method="post">
		<table align="center">
			<tr>
				<td style="text-align:left;">Product id</td>
				<td><input class="txt" type="text" name="pid" required /></td>
			</tr>
			<tr>
				<td style="text-align:left;">Product Name</td>
				<td><input class="txt" type="text" name="pname" required /></td>
			</tr>
			<tr>
				<td style="text-align:left;">Category</td>
				<td><input class="txt" type="text" name="cat" required /></td>
			</tr>
			<tr>
				<td style="text-align:left;">Price</td>
				<td><input class="txt" type="number" name="price" required /></td>
			</tr>
			<tr>
				<td style="text-align:left;">Quantity</td>
				<td><input class="txt" type="number" name="qty" required /></td>
			</tr>
			<tr>
				<td style="text-align:left;">Discount Percentage</td>
				<td><input class="txt" type="number" name="dis" required /></td>
			</tr>
			<tr>
				<td style="text-align:left;">Tax Rate</td>
				<td><input class="txt" type="number" name="tax" required /></td>
			</tr>
			<tr>
				<td colspan="2"><button class="btn" type="submit">UPDATE</button>
					<button class="btn" type="reset">CLEAR</button>
					</form>
					
			</tr>
		</table>

		<%
			String msg = (String) request.getAttribute("addmsg");
		%>
		<%
			if (msg != null) {
				out.println(msg);
			}
		%>
	
</body>
</html>