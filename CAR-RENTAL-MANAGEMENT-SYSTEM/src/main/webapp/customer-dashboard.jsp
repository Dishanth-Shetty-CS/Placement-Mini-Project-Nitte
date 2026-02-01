<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*"%>
<%
HttpSession currentSession = request.getSession(false);
if (currentSession == null) {
	response.sendRedirect("customer-login.jsp");
	return;
}

String customerEmail = (String) currentSession.getAttribute("customerEmail");
if (customerEmail == null) {
	response.sendRedirect("customer-login.jsp");
	return;
}

String customerName = "";
int totalRentals = 0;
int activeRentals = 0;
int carsAvailable = 0;

Connection connection = null;
PreparedStatement preparedStatement = null;
ResultSet resultSet = null;

try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_db", "root", "trickortreat");

	String nameQuery = "SELECT Cust_Name FROM Customer WHERE LOWER(Cust_Email) = LOWER(?)";
	preparedStatement = connection.prepareStatement(nameQuery);
	preparedStatement.setString(1, customerEmail);
	resultSet = preparedStatement.executeQuery();
	if (resultSet.next()) {
		customerName = resultSet.getString("Cust_Name");
	}
	resultSet.close();
	preparedStatement.close();

	String totalRentalsQuery = "SELECT COUNT(*) FROM Rental WHERE Cust_Email = ?";
	preparedStatement = connection.prepareStatement(totalRentalsQuery);
	preparedStatement.setString(1, customerEmail);
	resultSet = preparedStatement.executeQuery();
	if (resultSet.next()) {
		totalRentals = resultSet.getInt(1);
	}
	resultSet.close();
	preparedStatement.close();

	String activeRentalsQuery = "SELECT COUNT(*) FROM Rental WHERE Cust_Email = ? AND Rental_Status = 'Ongoing'";
	preparedStatement = connection.prepareStatement(activeRentalsQuery);
	preparedStatement.setString(1, customerEmail);
	resultSet = preparedStatement.executeQuery();
	if (resultSet.next()) {
		activeRentals = resultSet.getInt(1);
	}
	resultSet.close();
	preparedStatement.close();

	String availableCarsQuery = "SELECT COUNT(*) FROM CAR WHERE Car_Status = 'Available'";
	preparedStatement = connection.prepareStatement(availableCarsQuery);
	resultSet = preparedStatement.executeQuery();
	if (resultSet.next()) {
		carsAvailable = resultSet.getInt(1);
	}

} catch (Exception e) {
	e.printStackTrace();
} finally {
	if (resultSet != null)
		try {
	resultSet.close();
		} catch (Exception e) {
		}
	if (preparedStatement != null)
		try {
	preparedStatement.close();
		} catch (Exception e) {
		}
	if (connection != null)
		try {
	connection.close();
		} catch (Exception e) {
		}
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" type="image/png"
	href="https://cdn4.iconfinder.com/data/icons/filled-outline-car/64/car-front-view-vehicle-automobile-1024.png">
<title>Customer Dashboard | EliteDrive</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style>
:root {
	--primary: #2563eb;
	--dark: #0f172a;
}

body {
	background-color: #e3f2fd;
	font-family: 'Poppins', sans-serif;
	min-height: 100vh;
	display: flex;
	flex-direction: column;
}

.navbar {
	background-color: #1e293b !important;
	padding: 12px 0;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	border-bottom: 3px solid #1e88e5;
}

.navbar-brand {
	font-weight: 700;
	color: #fff !important;
	letter-spacing: 1px;
}

.nav-link {
	color: rgba(255, 255, 255, 0.8) !important;
	font-weight: 500;
	margin-left: 10px;
	padding: 8px 15px !important;
	border-radius: 6px;
	transition: all 0.3s ease;
}

.nav-link:hover {
	background-color: rgba(56, 189, 248, 0.2);
	color: #38bdf8 !important;
}

#lbtn {
	background-color: #ef4444;
	color: white !important;
	border-radius: 8px;
	padding: 8px 20px !important;
}

#lbtn:hover {
	background-color: #dc2626;
	transform: scale(1.02);
}

.dashboard-main {
	flex: 1 0 auto;
	display: flex;
	justify-content: center;
	padding: 40px 20px;
}

.rentals-container {
	background: #fff;
	padding: 40px;
	border-radius: 12px;
	box-shadow: 5px 5px 20px rgba(0, 0, 0, 0.1);
	width: 100%;
	max-width: 1400px;
}

.header-banner {
	background: linear-gradient(135deg, #f8fbff 0%, #e3f2fd 100%);
	padding: 35px;
	border-radius: 10px;
	border-left: 5px solid #1e88e5;
	margin-bottom: 40px;
	text-align: center;
}

h3.welcome-txt {
	color: #1e293b;
	margin: 0;
	font-size: 2.2em;
	font-weight: 700;
	text-transform: uppercase;
	letter-spacing: 2px;
}

.stat-card {
	background: #ffffff;
	border: 2px solid #cfd8dc;
	border-radius: 12px;
	padding: 30px;
	text-align: center;
	transition: all 0.3s ease;
	height: 100%;
}

.stat-card:hover {
	transform: translateY(-5px);
	border-color: #1e88e5;
}

.stat-card i {
	font-size: 3rem;
	color: #1e88e5;
	margin-bottom: 20px;
}

.stat-card .value {
	font-size: 2.5rem;
	font-weight: 700;
	color: #1e293b;
}

footer {
	background: var(--dark);
	color: #94a3b8;
	padding: 80px 8% 40px;
	margin-top: auto;
}

.footer-grid {
	display: grid;
	grid-template-columns: 2fr 1fr 1fr 1.5fr;
	gap: 40px;
	margin-bottom: 50px;
}

.footer-col h4 {
	color: #fff;
	margin-bottom: 25px;
	font-size: 18px;
	border-left: 3px solid var(--primary);
	padding-left: 15px;
}

.footer-col ul {
	list-style: none;
	padding-left: 0;
}

.footer-col ul li {
	margin-bottom: 12px;
}

.footer-col ul li a {
	color: #94a3b8;
	text-decoration: none;
	transition: 0.3s;
	font-size: 14px;
}

.footer-col ul li a:hover {
	color: #fff;
	padding-left: 8px;
}

@media ( max-width : 992px) {
	.footer-grid {
		grid-template-columns: 1fr 1fr;
	}
}

@media ( max-width : 576px) {
	.footer-grid {
		grid-template-columns: 1fr;
	}
}
</style>
</head>
<body>

	<nav class="navbar navbar-expand-lg">
		<div class="container-fluid px-5">
			<a class="navbar-brand" href="#"><i class="fas fa-car"></i>
				EliteDrive | Customer Dashboard</a>
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav ms-auto align-items-center">
					<li class="nav-item"><a class="nav-link"
						href="available-cars.jsp"><i class="fas fa-search me-1"></i>
							Browse Cars</a></li>
					<li class="nav-item"><a class="nav-link" href="my-rentals.jsp"><i
							class="fas fa-calendar-check me-1"></i> My Bookings</a></li>
					<li class="nav-item"><a class="nav-link"
						href="profile-update.jsp"><i class="fas fa-user-cog me-1"></i>
							Profile Settings</a></li>
					<li class="nav-item ms-lg-3"><a class="nav-link" id="lbtn"
						href="#">Logout</a></li>
					<li class="nav-item ms-lg-3 border-start ps-3"><span
						class="nav-link" style="color: #38bdf8 !important;"> Hi, <%=customerName%>
					</span></li>
				</ul>
			</div>
		</div>
	</nav>

	<div class="dashboard-main">
		<div class="rentals-container">
			<div class="header-banner">
				<h3 class="welcome-txt">
					Welcome Back,
					<%=customerName%>!
				</h3>
				<p class="text-muted mt-2">Access your personalized dashboard to
					manage your car rentals and bookings.</p>
			</div>

			<div class="row g-4">
				<div class="col-md-4">
					<div class="stat-card">
						<i class="fas fa-list-check"></i>
						<h4>Total Bookings</h4>
						<div class="value"><%=totalRentals%></div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="stat-card">
						<i class="fas fa-key"></i>
						<h4>Active Rentals</h4>
						<div class="value"><%=activeRentals%></div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="stat-card">
						<i class="fas fa-car-on"></i>
						<h4>Available Fleet</h4>
						<div class="value"><%=carsAvailable%></div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<footer>
		<div class="footer-grid">
			<div class="footer-col">
				<a href="#"
					style="text-decoration: none; font-size: 26px; font-weight: 800; color: #fff;">Elite<span
					style="color: var(--primary)">Drive</span></a>
				<p style="margin-top: 20px; font-size: 14px; line-height: 1.8;">The
					global authority in luxury automotive experiences. Operating in 45
					countries, we provide bespoke mobility solutions to the world's
					most discerning clientele.</p>
				<div style="display: flex; gap: 15px; margin-top: 25px;">
					<a href="#" style="color: #fff; font-size: 20px;"><i
						class="fa-brands fa-facebook"></i></a> <a href="#"
						style="color: #fff; font-size: 20px;"><i
						class="fa-brands fa-instagram"></i></a> <a href="#"
						style="color: #fff; font-size: 20px;"><i
						class="fa-brands fa-x-twitter"></i></a> <a href="#"
						style="color: #fff; font-size: 20px;"><i
						class="fa-brands fa-linkedin"></i></a>
				</div>
			</div>
			<div class="footer-col">
				<h4>Company</h4>
				<ul>
					<li><a href="index.jsp#about">About Us</a></li>
					<li><a href="#">Our Heritage</a></li>
					<li><a href="#">Global Locations</a></li>
					<li><a href="#">Sustainability</a></li>
					<li><a href="#">Newsroom</a></li>
				</ul>
			</div>
			<div class="footer-col">
				<h4>Services</h4>
				<ul>
					<li><a href="#">Long Term Rental</a></li>
					<li><a href="#">Corporate Accounts</a></li>
					<li><a href="#">Chauffeur Service</a></li>
					<li><a href="#">Armored Transport</a></li>
					<li><a href="#">Luxury Gift Vouchers</a></li>
				</ul>
			</div>
			<div class="footer-col">
				<h4>Support</h4>
				<ul>
					<li><a href="#">Help Center</a></li>
					<li><a href="#">Privacy Policy</a></li>
					<li><a href="#">Terms of Service</a></li>
					<li><a href="#">Rental Agreement</a></li>
					<li><a href="index.jsp#contact">Contact Us</a></li>
				</ul>
			</div>
		</div>
		<div
			style="border-top: 1px solid rgba(255, 255, 255, 0.1); padding-top: 30px; text-align: center; font-size: 13px;">
			<p>&copy; 2026 EliteDrive Global S.A. All Rights Reserved.
				Crafted for excellence.</p>
		</div>
	</footer>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script>
	document.getElementById("lbtn").addEventListener("click", function(e) {
	    e.preventDefault(); 
	    
	    Swal.fire({
	        title: "Are you sure?",
	        text: "You are about to end your session. Any unsaved changes to your profile update will be lost.",
	        icon: "question",
	        showCancelButton: true,
	        confirmButtonColor: "#1e293b",
	        cancelButtonColor: "#64748b", 
	        confirmButtonText: "Yes, Logout",
	        cancelButtonText: "Stay Logged In",
	        reverseButtons: true 
	    }).then((result) => {
	        if (result.isConfirmed) {
	            Swal.fire({
	                title: "Logging out...",
	                timer: 1000,
	                showConfirmButton: false,
	                didOpen: () => {
	                    Swal.showLoading();
	                }
	            }).then(() => {
	                window.location.replace("customer-login.jsp");
	            });
	        }
	    });
	});
    </script>
</body>
</html>