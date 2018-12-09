<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	String first_name = (String) session.getAttribute("first_name");
%>
<%
	String last_name = (String) session.getAttribute("last_name");
%>
<%
	String message = (String) session.getAttribute("message");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin/Teacher</title>

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

.submitbutton {
	position: absolute;
	top: 500px;
	height: 100px;
	width: 200px;
	right: 800px;
	font-size: 46px;
}

.instr1stbutton {
	position: absolute;
	top: 300px;
	left: 200px;
	font-size: 20px;
}

.instructions {
	position: absolute;
	top: 100px;
	left: 200px;
}

.headerinf {
	position: absolute;
	right: 600px;
	top: 35px;
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
			<a href="logout.jsp">logout?</a>
		</div>
	</div>
	<br />
	<br />
	<br />
	<div>
		<h1>Administration/Teacher Page</h1>
		<h2>Student sign-up</h2>
	</div>
	<br />
	<div>
		<p align="justify">
			<font size=+1>Hello <b><%=first_name%> <%=last_name%></b>,
				it's nice to see you're here. In this part of the WebApp you can
				sign students up for our automated testing.<br /> <br />Please
				input the information required to sign a student up.
			</font>
		</p>
		<br />
	</div>
	<form method="post" action="create_student">
		<table>
			<tr>
				<td>ID Number</td>
				<td><input type="text" name="ID"></td>
			</tr>
			<tr>
				<td>First Name</td>
				<td><input type="text" name="first_name"></td>
			</tr>
			<tr>
				<td>Last Name</td>
				<td><input type="text" name="last_name"></td>
			</tr>
			<tr>
				<td>Age</td>
				<td><input type="text" name="age"></td>
			</tr>
			<tr>
				<td>Password</td>
				<td><input type="password" name="password"></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" value="enter"></td>
			</tr>
			<tr>
				<td><a href="admin.jsp">Go back</a></td>
			</tr>
		</table>
	</form>
	<div>
		<font color="red"><%=message %></font>
	</div>
</body>
</html>