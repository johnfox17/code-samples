<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>MathEvaluator</title>
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
	</div>
	<br />
	<br />
	<br />
	<div>
		<h1>CSE 593- Capstone Project</h1>
		<h4>Student: John Raphael Fox</h4>
		<h4>Adviser: Javier Gonzalez-Sanchez, Ph.D.</h4>
	</div>
	<br/>
	<div>
		<p align="justify">
			<font size="4"> A huge problem in education, is how to <b>evaluate</b>
				the knowledge of students after being taught a specific lesson? In
				this project, we have dedicated our time to create a WebApp that
				will enable us to <b>automate</b> the grading of any subject;
				specifically, mathematics.
			</font>
		</p>
		<p align="justify">
			<font size="4"> We will use a variety of tools for the
				creation of WebApp: </font>
		</p>
		<ul>
			<li>Main Programming Languages: <b>Java</b>, <b>HTML5</b>, <b>CSS</b></li>
			<li>Server: <b>Apache Tombcat</b></li>
			<li>IDE: <b>Eclipse</b></li>
			<li>Version Control: <b>GitHub</b></li>
			<li>Rational Database: <b>SQL</b>, <b>MySQL</b>, <b>AWS RDS</b></li>
		</ul>
		<p align="justify">
			<font size="4"> Like usual, two parties will be able to use
				this WebApp: </font>
		</p>
		<ul>
			<li><b>User:</b> which in this case would be the students.</li>
			<li><b>Administration:</b> which will be the teachers.</li>
		</ul>
	</div>
	<br />
	<div>
		<h2>User</h2>
		<p align="justify">
			<font size="4"> The user will be the student. In other words,
				the student must be able to do the following: </font>
		</p>
		<ul>
			<li><b>Signing in</b> and <b>signing out</b>.</li>
			<li>Taking <b>automated evaluations</b>.
			</li>
			<li>Check <b>progress</b> and <b>grades</b>.
			</li>
		</ul>
	</div>
	<br />
	<div>
		<h2>Administration</h2>
		<p align="justify"></p>
		<ul>
			<li><b>Signing in</b> and <b>signing out</b>.</li>
			<li><b>Register</b> students.</li>
			<li>Check students <b>progress</b> and <b>grades</b>.
			</li>
		</ul>
	</div>
	<form method="get" action="initialize">
		<div>
			<input type="submit" value="Click"><b> Let's start!</b>
		</div>
	</form>
</body>
</html>