<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*"%>
<%
HttpSession currentSession = request.getSession(false);
if (currentSession == null) {
	response.sendRedirect("admin-login.jsp");
	return;
}

String adminEmail = (String) currentSession.getAttribute("adminEmail");
if (adminEmail == null) {
	response.sendRedirect("admin-login.jsp");
	return;
}

String adminName = (String) currentSession.getAttribute("adminName");
int totalCars = 0, totalCustomers = 0, totalRentals = 0, activeRentals = 0, pendingReturns = 0;
double totalRevenue = 0.0;

Connection connection = null;
PreparedStatement preparedStatement = null;
ResultSet resultSet = null;

try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_db", "root", "trickortreat");
	String queries[] = {"SELECT COUNT(*) FROM Car", "SELECT COUNT(*) FROM Customer", "SELECT COUNT(*) FROM Rental",
	"SELECT COUNT(*) FROM Rental WHERE Rental_Status IN ('Active', 'Ongoing')",
	"SELECT COUNT(*) FROM Rental WHERE Rent_End_Date < CURDATE() AND Rental_Status NOT IN ('Completed', 'Cancelled')",
	"SELECT IFNULL(SUM(Amount_Paid), 0) FROM Payment WHERE Pay_Status = 'Completed'"};

	for (int i = 0; i < queries.length; i++) {
		preparedStatement = connection.prepareStatement(queries[i]);
		resultSet = preparedStatement.executeQuery();
		if (resultSet.next()) {
	if (i == 0)
		totalCars = resultSet.getInt(1);
	else if (i == 1)
		totalCustomers = resultSet.getInt(1);
	else if (i == 2)
		totalRentals = resultSet.getInt(1);
	else if (i == 3)
		activeRentals = resultSet.getInt(1);
	else if (i == 4)
		pendingReturns = resultSet.getInt(1);
	else if (i == 5)
		totalRevenue = resultSet.getDouble(1);
		}
		resultSet.close();
		preparedStatement.close();
	}
} catch (Exception e) {
	e.printStackTrace();
} finally {
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
<title>Administration Dashboard | EliteDrive</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap"
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
	padding: 12px 0; /* Matched to customer dashboard height */
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	border-bottom: 3px solid #1e88e5;
}

.navbar-brand {
	font-weight: 700;
	color: #fff !important;
	letter-spacing: 1px;
	white-space: nowrap;
	font-size: 1.25rem;
}

.nav-link {
	color: rgba(255, 255, 255, 0.8) !important;
	font-weight: 500;
	margin-left: 10px;
	padding: 8px 15px !important;
	border-radius: 6px;
	transition: all 0.3s ease;
	white-space: nowrap;
	font-size: 0.9rem;
}

.nav-link:hover {
	background-color: rgba(56, 189, 248, 0.2);
	color: #38bdf8 !important;
}

#lbtn {
	background-color: #ef4444;
	color: white !important;
	border-radius: 8px;
	margin-left: 10px;
	padding: 8px 20px !important;
}

#lbtn:hover {
	background-color: #dc2626;
	transform: scale(1.02);
}

.container-fluid {
	padding-left: 3rem !important;
	padding-right: 3rem !important;
}

.admin-name-tag {
	color: #38bdf8 !important;
	font-weight: 600;
	font-size: 0.85rem;
	white-space: nowrap;
}

.dashboard-main {
	flex: 1 0 auto;
	display: flex;
	justify-content: center;
	padding: 40px 20px;
}

.admin-container {
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
	font-size: 2.2em;
	font-weight: 700;
	text-transform: uppercase;
	letter-spacing: 2px;
	margin: 0;
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
	box-shadow: 0 10px 20px rgba(30, 136, 229, 0.1);
}

.stat-card i {
	font-size: 2.8rem;
	color: #1e88e5;
	margin-bottom: 15px;
}

.stat-card h4 {
	font-size: 0.9rem;
	color: #64748b;
	text-transform: uppercase;
	font-weight: 600;
}

.stat-card .value {
	font-size: 2.2rem;
	font-weight: 700;
	color: #1e293b;
}

.stat-card .value.revenue {
	color: #10b981;
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

	<nav class="navbar navbar-expand-xl navbar-dark">
		<div class="container-fluid px-4">
			<a class="navbar-brand" href="#"><i
				class="fas fa-shield-halved me-2"></i>EliteDrive | Admin Dashboard</a>

			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNav">
				<span class="navbar-toggler-icon"></span>
			</button>

			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav ms-auto align-items-center">
					<li class="nav-item"><a class="nav-link"
						href="manage-cars.jsp"> <i class="fa-solid fa-car-rear me-1"></i>
							Manage Cars
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="manage-rentals.jsp"> <i class="fa-solid fa-key me-1"></i>
							Manage Rentals
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="manage-customers.jsp"> <i
							class="fa-solid fa-address-card me-1"></i> Manage Customers
					</a></li>
					<li class="nav-item d-none d-xl-block border-start ms-3 ps-3">
						<span class="admin-name-tag"> <i
							class="fas fa-user-shield me-1"></i> <%=adminName%>
					</span>
					</li>

					<li class="nav-item"><a class="nav-link" id="lbtn" href="#">
							<i class="fas fa-power-off me-1"></i> Logout
					</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<div class="dashboard-main">
		<div class="admin-container">
			<div class="header-banner">
				<h3 class="welcome-txt">Operational Overview</h3>
				<p class="text-muted mt-2">Centralized control panel for
					real-time fleet management and financial tracking.</p>
			</div>

			<div class="row g-4">
				<div class="col-md-4">
					<div class="stat-card">
						<i class="fas fa-car-side"></i>
						<h4>Total Fleet</h4>
						<div class="value"><%=totalCars%></div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="stat-card">
						<i class="fas fa-user-group"></i>
						<h4>Registered Users</h4>
						<div class="value"><%=totalCustomers%></div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="stat-card">
						<i class="fas fa-file-invoice-dollar"></i>
						<h4>Cumulative Rentals</h4>
						<div class="value"><%=totalRentals%></div>
					</div>
				</div>

				<div class="col-md-4">
					<div class="stat-card">
						<i class="fas fa-circle-play"></i>
						<h4>Active Sessions</h4>
						<div class="value"><%=activeRentals%></div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="stat-card">
						<i class="fas fa-clock-rotate-left"></i>
						<h4>Overdue Returns</h4>
						<div class="value <%=(pendingReturns > 0) ? "text-danger" : ""%>">
							<%=pendingReturns%>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="stat-card">
						<i class="fas fa-vault"></i>
						<h4>Net Revenue</h4>
						<div class="value revenue">
							₹<%=String.format("%,.2f", totalRevenue)%></div>
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
	        text: "You are about to end your administrative session. Any unsaved management changes will be lost.",
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
	                window.location.replace("admin-login.jsp");
	            });
	        }
	    });
	});
    </script>
</body>
</html>