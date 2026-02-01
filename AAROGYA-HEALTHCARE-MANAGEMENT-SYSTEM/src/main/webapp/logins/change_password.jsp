<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="org.mindrot.jbcrypt.BCrypt"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Change Password</title>
<link rel="stylesheet" href="../index.css">
<link rel="icon" href="../images/favicon.png" type="image/x-icon">
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
	integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
	<header id="header">
		<a href="../index.jsp" id="logo"> Aarogya Healthcare </a>

		<nav>
			<button onclick="window.location.href='../index.jsp'">Home</button>
		</nav>
	</header>

	<main id="login-main">
		<div class="login-body">
			<img src="../images/favicon.png" alt="" id="login-img">

			<div class="login-input">
				<h2>Change Password</h2>
				<p id="error">Passwords doesn't match!</p>

				<form class="form-body" onsubmit="return changePassword(event)">
					<div class="sign-in-input">
						<i class="fa-solid fa-lock"></i> <input type="Password"
							name="password" placeholder="Password" required>
					</div>

					<div class="sign-in-input">
						<i class="fa-solid fa-lock"></i> <input type="password"
							name="confirm_password" placeholder="Confirm Password" required>
					</div>

					<button type="submit">Change Password</button>
				</form>
				<br>
			</div>
		</div>
	</main>

	<script src="../index.js"></script>
</body>
</html>

<%

Connection con = null;
Statement st = null;

String email_address = request.getParameter("email_address");
String user_table = request.getParameter("user_table");
String password = request.getParameter("password");


if (email_address != null) {
	try {
		 Class.forName("com.mysql.cj.jdbc.Driver");
	     con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aarogya_healthcare_db","root","trickortreat");
	     st = con.createStatement();
	     
	     password = password.trim();
         int strength = 10; 
         String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt(strength));         	     
	     
         String updateSQL = "UPDATE " + user_table + " SET password = \"" + hashedPassword + "\" WHERE email_address = \"" + email_address + "\"";                
	     st.executeUpdate(updateSQL);	 
	     
	     con.close();
	} catch(Exception e) {            
	     e.printStackTrace();
	} 	
}

%>