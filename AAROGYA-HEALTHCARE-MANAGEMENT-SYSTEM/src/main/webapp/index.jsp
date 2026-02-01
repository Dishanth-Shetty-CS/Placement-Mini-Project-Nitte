<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Aarogya Healthcare</title>
<link rel="stylesheet" href="index.css">
<link rel="icon" href="images/favicon.png" type="image/x-icon">
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
	integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
	<aside id="contact-header">
		<i class="fa-regular fa-envelope"></i> <a
			href="mailto:aarogyahealthcare@gmail.com">aarogyahealthcare@gmail.com</a>
		<i class="fa-solid fa-mobile-screen"></i> <span>+91 8867544785</span>
	</aside>

	<header id="index-header">
		<a href="index.jsp" id="logo"> Aarogya Healthcare </a>

		<nav>
			<a href="#home">Home</a> <a href="#service">Services</a> <a
				href="#about">About</a> <a href="#contact">Contact</a>
			<button onclick="window.location.href='logins/patient_register.jsp'">Patient
				Register</button>
			<button onclick="window.location.href='logins/patient_login.html'">Patient
				Login</button>
			<button onclick="window.location.href='logins/doctor_login.html'">Doctor
				Login</button>
		</nav>
	</header>

	<section id="bg-img">
		<div class="container" id="home">
			<h1>Welcome to Aarogya Healthcare</h1>
			<h2>We are here to justify your medical needs and secure well
				being</h2>
			<button onclick="window.location.href='logins/patient_login.html'">Get
				Started</button>
		</div>
	</section>

	<aside>
		<div id="page-up" onclick="window.location.href='#home'">
			<i class="fa-solid fa-arrow-up"></i>
		</div>
	</aside>

	<main id="main">
		<div class="main-container">
			<div id="main-div">
				<h2>Why Choose Aarogya Healthcare?</h2>
				<p>Aarogya Healthcare is a comprehensive healthcare solution
					designed to empower you with affordable access to quality medical
					care. We prioritize your well-being and strive to ensure you
					receive the right medical attention at a manageable cost.</p>
			</div>

			<div>
				<i class="fa-solid fa-plus"></i>
				<h3>Best Services</h3>
				<p>If you are at Aarogya Healthcare, you must be the one values
					quality. And you are at the right place for it.</p>
			</div>

			<div>
				<i class="fa-regular fa-heart"></i>
				<h3>Trustworthy</h3>
				<p>Trust is the pillars on which we stand. Aarogya Healthcare
					ensures you get all the justice for what you pay.</p>
			</div>

			<div>
				<i class="fa-solid fa-indian-rupee-sign"></i>
				<h3>Budget Friendly</h3>
				<p>No more compromises with your health for your limited budget.
					We have plans for everyone.</p>
			</div>
		</div>

		<section id="services-section">
			<div id="service">
				<h2>Services</h2>
				<div class="line"></div>
			</div>

			<div id="services">

				<div class="services-row">
					<div>
						<i class="fa-solid fa-truck-medical"></i>
						<h3>Ambulance Services</h3>

						<p>24 Hours Ambulance Service, Emergency Ambulance Service
							Providers in India.</p>
					</div>

					<div>
						<i class="fa-solid fa-brain"></i>
						<h3>Dedicated Stroke Centre</h3>

						<p>We specially have dedicated stroke centre which is very
							handy in critical situations.</p>
					</div>

					<div>
						<i class="fa-solid fa-eye"></i>
						<h3>LASIK Vision Correction Treatment</h3>

						<p>We have LASIK Vision treatment which is the latest in the
							world.</p>
					</div>
				</div>


				<div class="services-row">
					<div>
						<i class="fa-solid fa-x-ray"></i>
						<h3>Radiology</h3>

						<p>Our advanced radiology department delivers swift and highly
							accurate diagnostic insights.</p>
					</div>

					<div>
						<i class="fa-solid fa-hospital"></i>
						<h3>17 State-of-the-art Operation Theatres</h3>

						<p>These Operation Theatres are full of latest technologies
							and equipments.</p>
					</div>

					<div>
						<i class="fa-solid fa-syringe"></i>
						<h3>Blood Bank</h3>

						<p>In house provisions for blood donation and blood reception
							from blood bank.</p>
					</div>
				</div>

			</div>
		</section>

		<hr>

		<section id="about-section">
			<div id="about">
				<h2>About</h2>
				<div class="line"></div>
			</div>

			<div id="about-info">
				<b>About Aarogya Healthcare: Your Trusted Partner in Patient
					Management</b>
				<p>Aarogya Healthcare is a leading provider of comprehensive
					Patient Management Systems (PMS) designed to streamline operations,
					enhance patient care, and empower healthcare institutions.</p>

				<p>We understand the complexities of managing a hospital and the
					critical need for efficient solutions that cater to every
					department.</p>

				<p>Our Aarogya PMS goes beyond simple record-keeping, offering a
					robust suite of integrated features to seamlessly manage all
					aspects of your hospital's operations.</p>

				<br> <b>Join the Aarogya Healthcare Family:</b> <br>
				<p>Experience the transformative power of a comprehensive PMS.
					Contact Aarogya Healthcare today and discover how our solutions can
					empower the hospital to deliver exceptional care and achieve
					operational excellence.</p>
			</div>
		</section>

		<hr>

		<section id="contact-section">
			<div id="contact">
				<h2>Contact</h2>
				<div class="line"></div>
			</div>

			<div class="contact-form">
				<form onsubmit="submitQueries(event)">
					<div id="contact-1">
						<input name="name" type="text" placeholder="Your Name" required>
						<input name="email_address" type="email" placeholder="Enter Email"
							required>
					</div>

					<div id="contact-2">
						<input name="subject" type="text" placeholder="Subject" required>
						<br>
						<textarea name="message" cols="30" rows="10" placeholder="Message"
							required></textarea>
					</div>

					<button id="send-msg" type="submit">Send Message</button>
				</form>
			</div>
		</section>
	</main>

	<section id="footer-top">
		<div class="footer-body">
			<div>
				<div>
					<h3>Aarogya Healthcare</h3>
					<p>
						Brigade Road <br> Bangalore, India - 560001
					</p>
				</div>

				<div>
					<p style="margin-bottom: 0;">
						<b>Phone:</b> +91 8867544785
					</p>
					<p style="margin-top: 0;">
						<b>Email:</b> aarogyahealthcare@gmail.com
					</p>
				</div>
			</div>

			<div>
				<h3>Userful Links</h3>

				<ul class="footer-links">
					<li><a href="#home">Home</a></li>
					<li><a href="#service">Services</a></li>
					<li><a href="#about">About</a></li>
					<li><a href="#contact">Contact</a></li>
				</ul>
			</div>

			<div>
				<h3>Our Services</h3>

				<ul class="footer-links">
					<li><a href="#service">Ambulance Services</a></li>
					<li><a href="#service">Dedicated Stroke Centre</a></li>
					<li><a href="#service">LASIK Vision Correction Treatment</a></li>
					<li><a href="#service">Radiology</a></li>
					<li><a href="#service">17 State-of-the-art Operation
							Theatres</a></li>
					<li><a href="#service">Blood Bank</a></li>
				</ul>
			</div>

			<div class="footer-last">
				<img src="images/favicon.png" alt="">
			</div>
		</div>
	</section>

	<footer id="footer">
		<div>
			&copy; Copyright <b>Aarogya Healthcare</b>. All Rights Reserved
		</div>
	</footer>

	<script src="index.js"></script>
</body>
</html>

<%

Connection con = null;
PreparedStatement pt = null;

String email_address = request.getParameter("email_address");
String name = request.getParameter("name");
String subject = request.getParameter("subject");
String message = request.getParameter("message");

if (email_address != null) {
	try {
		 Class.forName("com.mysql.cj.jdbc.Driver");
	     con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aarogya_healthcare_db","root","trickortreat");
	     	  
	     pt = con.prepareStatement("INSERT INTO query_records(email_address, name, subject, message, message_status, date) VALUES (?, ?, ?, ?, 'unread', CURDATE())");                    	     
	     pt.setString(1, email_address.trim());
	     pt.setString(2, name.trim());
	     pt.setString(3, subject.trim());
	     pt.setString(4, message.trim());             
	        
	     pt.executeUpdate();
	     con.close();
	} catch(Exception e) {            
	     e.printStackTrace();
	} 	
}

%>