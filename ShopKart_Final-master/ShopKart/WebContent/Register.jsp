<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base>
<script type="text/javascript">
<%if (!(request.getAttribute("msg") == null)) {%>
alert('<%out.print(request.getAttribute("msg"));%>
	');
<%}%></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Register New Users</title>
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
<h1>USER REGISTRATION</h1>
<hr/>
	<form action="http://localhost:8081/ShopKart/RegisterCheck" method="post">
		<table cellpadding="10px" align="center">
		<tr>
		<td style="text-align:left;">
		User Name:</td><td><input class="txt" type="text" name="userName" required></td>
		</tr>
		<tr>
		<td style="text-align:left;">
		Email:</td><td><input class="txt" type="email" name="email" required></td>
		</tr> 
		<tr>
		<td style="text-align:left;">
		Password:</td><td><input class="txt" type="text" name="password" required></td>
		</tr>
		<tr>
		<td style="text-align:left;">
		Address:</td><td><textarea class="txt" name="address"></textarea></td>
		</tr>
		<tr>
		<td colspan="2">
		<input class="btn" type="submit" value="Register">
		</td>
		</tr>
		</table>
	</form>
</body>
</html>