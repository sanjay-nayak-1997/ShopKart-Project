<%@page import="com.shopkart.BusinessObject"%>
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
	height:100%;
	background-image:url("Images/PageWallpaper.jpg");
	background-size:cover;
	background-repeat:no-repeat;
	background-attachment:fixed;
	opacity:0.6;
	z-index:-1;
}
</style>
<head>
<script type="text/javascript">
<%if (session != null) {
				String name = (String) session.getAttribute("userName");
				if (name == null) {
					System.out.print("UserName Not Found!!!");
					response.getWriter().print("Something went Wrong Session<br>Please Login Again<a href=\"Login.html\">Login</a>");
					return;
				}				
			}%>
</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Thank You</title>
</head>
<body>
<div></div>
<img src="Images/logofinal.png" height="100px" width="100px">
	<h1>Thank You for Shopping with Us</h1>
	<h1>Your order will be delivered to this Address</h1>
	<h2><%=BusinessObject.getAddress((String)session.getAttribute("userName")) %></h2>
	<hr/>
	<br>
	<form action="http://localhost:8081/ShopKart/LogoffServlet">
		<input class="btn" type="submit" value="Logoff">
	</form><br>
	<form action="CustomerHome.jsp">
		<input class="btn" type="submit" value="New Order">
	</form>
</body>
</html>