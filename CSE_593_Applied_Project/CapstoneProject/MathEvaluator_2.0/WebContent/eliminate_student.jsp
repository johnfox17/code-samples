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
<title>Insert title here</title>
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

.messagelocation {
	position: absolute;
	top: 600px;
	left: 80px;
	font-size: 20px;
	color: red;
}

.inputlocation {
	position: absolute;
	top: 500px;
	left: 80px;
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
		<h2>Eliminate students from dB</h2>
	</div>
	<br />
	<div>
		<p align="justify">
			<font size=+1>Hello <b><%=first_name%> <%=last_name%></b>, so
				you want to eliminate a student? Just so the process will work, you
				can add a student, test in student's section, then eliminate him/her
				and try to take the test. Just to check to see if he was still in
				dB.
			</font>
		</p>
		<p align="justify">
			<font size=+1> Please submit the ID number of the student you
				want to eliminate from the dB. </font>
		</p>
		<br />
	</div>
	<div class="inputlocation">
		<form method="post" action="eliminate_student">
			<table>
				<tr>
					<td>ID Number</td>
					<td><input type="text" name="ID"></td>
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
	</div>
	<div class="messagelocation">
		<%=message %>
	</div>
</body>
</html>