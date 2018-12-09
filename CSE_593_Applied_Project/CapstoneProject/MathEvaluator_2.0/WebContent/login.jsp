<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	String message = (String) session.getAttribute("message");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sign-in Page</title>
<style>
.container {
	position: relative;
}

.topright {
	position: absolute;
	top: 8px;
	right: 16px;
	font-size: 18px;
}

.img {
	width: 100%;
	height: auto;
	opacity: 0.3;
}

HTML, body {
	margin: 30px;
	padding: 10px;
	border: 10px;
}
</style>

</head>
<body style="background-color: lightblue">
	<div class="container">
		<img src="src/ASUOnlineLogo.png" alt="ASUlogo">
		<div class="topright">
			<b>Intro page: </b><a href="index.jsp">here</a>
		</div>
	</div>
	<br />
	<br />
	<br />
	<div>
		<h2>Welcome to MathEvaluator! Please sign in or create an
			account!</h2>
	</div>
	<form method="post" action="login">
		<table>
			<tr>
				<td>ID Number:<input type="text" name="ID">
				</td>
			</tr>
			<tr>
				<td>Password:<input type="password" name="password"></td>
			</tr>
			<tr>
				<td><input type="radio" name="category" value="admin">Admin/teacher</td>
			</tr>
			<tr>
				<td><input type="radio" name="category" value="students">Student</td>
			</tr>
			<tr>
				<td><input type="submit" value="login"></td>
			</tr>
		</table>
		<div>
			<font color=red><%=message%></font>
		</div>
	</form>
</body>
</html>