<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Admin View</title>
<style>
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
<h1>WELCOME ADMIN</h1>
<hr/>
<form>
<button class="btn" type="submit" formaction="http://localhost:8081/ShopKart/ProductsServlet" method="post">View Product Details</button>
<button class="btn" type="submit" formaction="http://localhost:8081/ShopKart/OrdersServlet" method="post">View Order details</button>
<button class="btn" type="submit" formaction="http://localhost:8081/ShopKart/LogoffServlet">Logoff</button>
</form>
</body>
</html>