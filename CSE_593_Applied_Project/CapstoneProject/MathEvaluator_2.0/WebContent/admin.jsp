<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	String first_name = (String) session.getAttribute("first_name");
%>
<%
	String last_name = (String) session.getAttribute("last_name");
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
		<h2>Welcome to the Admin page</h2>
	</div>
	<br />
	<div>
		<p align="justify">
			<font size=+1>Hello <b><%=first_name%> <%=last_name%></b>,
				it's nice to see you're here. For now, you can do two things in our
				system:
			</font>
		</p>
		<br />
		<ul>
			<li><font size=+1><b>Add</b> <a href="sign_up_page.jsp">student</a> to database.
			</font></li>
		</ul>

		<ul>
			<li><font size=+1><b>Eliminate</b> <a href="eliminate_student.jsp">student</a> from database.
			</font></li>
		</ul>
	</div>
	<br />
	<div>
		<p align="justify">
			<font size=+1>The first, allows you to add a student, and the
				second to eliminate. Maybe you want to add a student, and go take a
				test in the student section with that information.</font>
		</p>
	</div>
</body>


</body>
</html>