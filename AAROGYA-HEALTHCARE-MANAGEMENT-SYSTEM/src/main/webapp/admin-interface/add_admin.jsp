<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="org.mindrot.jbcrypt.BCrypt"%>

<h3 style="margin-top: 0;">Admin Registration Form</h3>


<form method="post" class="add-form"
	onsubmit="return submitAdminFormData(event)">

	<div class="input-container">
		<div class="col-div-register">
			<div class="register-input">
				<i class="fa-solid fa-user"></i> <input type="text"
					name="first_name" placeholder="First Name" required>
			</div>

			<div class="register-input">
				<i class="fa-solid fa-user"></i> <input type="text" name="last_name"
					placeholder="Last Name" required>
			</div>

			<div class="register-input">
				<i class="fa-solid fa-envelope" id="fa-envelope"></i> <input
					type="email" name="email_address" placeholder="Email Address"
					required>
			</div>
		</div>

		<div class="col-div-register">
			<div class="register-input">
				<i class="fa-solid fa-mobile"></i> <input type="number"
					name="phone_num" placeholder="Phone Number" required>
			</div>

			<div class="register-input">
				<i class="fa-solid fa-lock"></i> <input type="password"
					name="password" placeholder="Password" required>
			</div>

			<div class="register-input">
				<i class="fa-solid fa-lock"></i> <input type="password"
					name="confirm_password" placeholder="Confirm Password" required>
			</div>
		</div>

	</div>

	<div class="input-container">
		<div class="row-div-button">
			<button type="submit">Register</button>
		</div>

		<div class="register-input">
			<div id="error" style="margin-top: 30px;">Passwords doesn't
				match!</div>
		</div>
	</div>

</form>

<%
Connection con = null;
PreparedStatement pt = null;

String email_address = request.getParameter("email_address");
String first_name = request.getParameter("first_name");
String last_name = request.getParameter("last_name");
String password = request.getParameter("password");
String phone_num = request.getParameter("phone_num");

if (email_address != null) {
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aarogya_healthcare_db", "root", "trickortreat");

		password = password.trim();
		int strength = 10;
		String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt(strength));

		pt = con.prepareStatement(
		"INSERT INTO registered_admins(email_address, first_name, last_name, phone_num, password, admin_type) VALUES (?, ?, ?, ?, ?, 'Admin')");
		pt.setString(1, email_address.trim());
		pt.setString(2, first_name.trim());
		pt.setString(3, last_name.trim());
		pt.setLong(4, Long.parseLong(phone_num));
		pt.setString(5, hashedPassword);

		pt.executeUpdate();
		con.close();
	} catch (Exception e) {
		e.printStackTrace();
	}
}
%>