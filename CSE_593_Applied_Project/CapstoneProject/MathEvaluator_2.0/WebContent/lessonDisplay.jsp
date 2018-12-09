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
	String problem = (String) session.getAttribute("problem");
%>
<%
	String solution1 = (String) session.getAttribute("solution1");
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
.locatiofsubmit{
	position: absolute;
	top: 500px;
	right: 200px;
}

.topright {
	position: absolute;
	top: 8px;
	right: 16px;
	font-size: 18px;
}

.problemdisplay {
	position: absolute;
	top: 450px;
	left: 500px;
	font-size: 150px;
}

.solutiondisplay {
	position: absolute;
	top: 200px;
	left: 850px;
	font-size: 46px;
}

.headerinf {
	position: absolute;
	right: 600px;
	top: 35px;
}

.lessoninstrloc {
	position: absolute;
	top: 300px;
	left: 150px;
}


.img {
	width: 100%;
	height: auto;
	opacity: 0.3;
}

input[type=text] {
	width: 100%;
	padding: 20px 20px;
	margin: 8px 0;
	box-sizing: border-box;
	font-size: 20px;
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
	<div>
		<font class="problemdisplay"><%=problem%></font>
	</div>
	<div class="lessoninstrloc">
		<font color="red" size="12"><%=message%></font>
	</div>
	<div class="locatiofsubmit">
		<div>
			<form method="post" action="checkSolution">
				<table>
					<tr>
						<td><input type="text" name="answer"></td>
						<td><input type="submit" value="Submit"></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
