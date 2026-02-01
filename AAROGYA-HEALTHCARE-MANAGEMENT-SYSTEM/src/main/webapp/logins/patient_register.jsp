<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="org.mindrot.jbcrypt.BCrypt"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Patient Register</title>
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
			<button onclick="window.location.href='patient_login.html'">Patient
				Login</button>
		</nav>
	</header>

	<main id="login-main" class="signup-main">
		<div class="login-input signup-input">
			<h2>Patient Register</h2>
			<p id="error">Passwords doesn't match!</p>
			<p id="email_error">Email address already exists</p>

			<form method="post" class="form-body"
				onsubmit="return submitPatientFormData(event)">
				<div class="sign-in-input">
					<i class="fa-solid fa-user"></i> <input type="text"
						name="first_name" placeholder="First Name" required>
				</div>

				<div class="sign-in-input">
					<i class="fa-solid fa-user"></i> <input type="text"
						name="last_name" placeholder="Last Name" required>
				</div>

				<div class="sign-in-input">
					<i class="fa-solid fa-envelope" id="fa-envelope"></i> <input
						type="email" name="email_address" placeholder="Email Address"
						required>
				</div>

				<div class="sign-in-input">
					<i class="fa-solid fa-mobile"></i> <input type="number"
						name="phone_num" placeholder="Phone Number" required>
				</div>

				<div class="sign-in-input">
					<i class="fa-solid fa-lock"></i> <input type="password"
						name="password" placeholder="Password" required>
				</div>

				<div class="sign-in-input">
					<i class="fa-solid fa-lock"></i> <input type="password"
						name="confirm_password" placeholder="Confirm Password" required>
				</div>

				<button type="submit">Register</button>
			</form>
			<br>
			<p id="sign-up-option">
				Already have and account? <a href="patient_login.html">Login</a>
			</p>
		</div>
	</main>

	<script src="../index.js"></script>
</body>
</html>

<%

Connection con = null;
PreparedStatement pt = null;
Statement st = null;
ResultSet rs = null;

String email_address = request.getParameter("email_address");
String first_name = request.getParameter("first_name");
String last_name = request.getParameter("last_name");
String password = request.getParameter("password");
String phone_num = request.getParameter("phone_num");

int checkEmail = 1;

if (email_address != null) {
	try {
		 Class.forName("com.mysql.cj.jdbc.Driver");
	     con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aarogya_healthcare_db","root","trickortreat");
	     
	     st = con.createStatement();
	     String storedEmailAddress = "SELECT COUNT(email_address) FROM registered_users WHERE email_address = \"" + email_address + "\"";
	     rs = st.executeQuery(storedEmailAddress);
	     rs.next();
	     checkEmail = rs.getInt(1);
	     
		 if (checkEmail == 0) {		     
		     password = password.trim();
	         int strength = 10; 
	         String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt(strength));
		     
		     pt = con.prepareStatement("INSERT INTO registered_users(email_address, first_name, last_name, phone_num, password) VALUES (?, ?, ?, ?, ?)");                    
		     pt.setString(1, email_address.trim());
		     pt.setString(2, first_name.trim());
		     pt.setString(3, last_name.trim());
		     pt.setLong(4, Long.parseLong(phone_num));
		     pt.setString(5, hashedPassword);	     
		        
		     pt.executeUpdate();
		     con.close();
		 } else {
			 response.setContentType("text/plain"); 
			 response.getWriter().write("Incorrect"); 
		 }
	} catch(Exception e) {            
	     e.printStackTrace();
	} 	
}

%>