<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	String first_name = (String) session.getAttribute("first_name");
%>
<%
	String last_name = (String) session.getAttribute("last_name");
%>
<%
	String chapter = (String) session.getAttribute("chapter");
%>
<%
	String difficulty = (String) session.getAttribute("difficulty");
%>
<%
	int probNum = (int) session.getAttribute("probNum");
%>
<%
	int numCorrect = (int) session.getAttribute("numCorrect");
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

.locatiofsubmit {
	position: absolute;
	top: 500px;
	right: 1050px;
}

.topright {
	position: absolute;
	top: 8px;
	right: 16px;
	font-size: 18px;
}

.instructions {
	position: absolute;
	top: 400px;
	left: 700px;
}

.submitbutton {
	position: absolute;
	top: 120px;
	height: 100px;
	width: 200px;
	left: 0px;
	font-size: 46px;
}

.returndemo {
	position: absolute;
	top: 600px;
	right: 850px;
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

input[type=submit] {
	width: 120%;
	background-color: #4CAF50;
	color: white;
	padding: 14px 20px;
	margin: 8px 0;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 20px;
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
			<b>Logout? </b><a href="logout.jsp">here</a>
		</div>
		<div class="headerinf">
			<table style="width: 200%">
				<tr>
					<td><font size=+2><b>Hello: </b><%=first_name%> <%=last_name%></font></td>

					<td><font size=+2><b>Chapter: </b><%=chapter%></font></td>
					<td><font size=+2><b>Difficulty: </b><%=difficulty%></font></td>
				</tr>
				<tr>
			</table>
		</div>
	</div>
	<div class="instructions">
		<font size=14 color=red><b>You got <%=numCorrect%>/<%=probNum%></b></font>
	</div>
	<form method="get" action="returnHome">
		<div class="locatiofsubmit">
			<input type="submit" value="Submit">
		</div>
		<div class="returndemo">
			<font size=14 color=purple>Click submit to end demo</font>
		</div>
	</form>

</body>
</html>