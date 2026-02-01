<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*"%>
<%
String customerEmail = (String) session.getAttribute("customerEmail");
if (customerEmail == null) {
	response.sendRedirect("customer-login.jsp");
	return;
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" type="image/png"
	href="https://cdn4.iconfinder.com/data/icons/filled-outline-car/64/car-front-view-vehicle-automobile-1024.png">
<title>Customer My Rentals | EliteDrive</title>

<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<style>
body {
	background-color: #e3f2fd;
	font-family: 'Poppins', sans-serif;
	min-height: 100vh;
	display: flex;
	justify-content: center;
	align-items: flex-start;
	padding: 30px;
}

.rentals-container {
	background: #fff;
	padding: 30px;
	border-radius: 12px;
	box-shadow: 5px 5px 20px rgba(0, 0, 0, 0.1);
	width: 100%;
	max-width: 1600px;
	overflow-x: auto;
}

.top-nav-bar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
	padding: 0 5px;
}

.back-link {
	text-decoration: none;
	color: #1e293b;
	font-weight: 600;
	transition: 0.3s;
	display: flex;
	align-items: center;
	gap: 8px;
}

.back-link:hover {
	color: #1e88e5;
}

.user-status {
	font-size: 0.9rem;
	color: #1e293b;
}

.header-banner {
	background: linear-gradient(135deg, #f8fbff 0%, #e3f2fd 100%);
	padding: 20px;
	border-radius: 10px;
	border-left: 5px solid #1e88e5;
	margin-bottom: 35px;
	text-align: center;
	box-shadow: inset 0 0 10px rgba(30, 136, 229, 0.05);
}

h3 {
	color: #1e293b;
	margin: 0;
	font-size: 2.2em;
	font-weight: 700;
	text-transform: uppercase;
	letter-spacing: 2px;
}

table {
	width: 100%;
	border-collapse: collapse;
	border: 1px solid #1e293b;
}

table thead {
	background-color: #1e293b;
	color: white;
}

table thead th {
	padding: 15px;
	font-weight: 500;
	border: 1px solid #334155;
	text-align: center;
}

table td {
	padding: 12px 15px;
	vertical-align: middle;
	border: 1px solid #cfd8dc;
	font-size: 0.95em;
	color: #1e293b;
	text-align: center;
}

table tbody tr:nth-child(even) {
	background-color: #f9f9f9;
}

table tbody tr:hover {
	background-color: #f0f8ff;
}

.status-badge {
	padding: 6px 0;
	width: 140px;
	border-radius: 4px;
	font-size: 0.8em;
	font-weight: 700;
	display: inline-block;
	text-transform: uppercase;
}

.Active {
	border: 2px solid #10b981;
	color: #047857 !important;
	background-color: #f0fdf4;
}

.Ongoing {
	border: 2px solid #f59e0b;
	color: #b45309 !important;
	background-color: #fffbeb;
}

.Pending {
	border: 2px solid #6366f1;
	color: #4338ca !important;
	background-color: #eef2ff;
}

.Completed {
	border: 2px solid #64748b;
	color: #334155 !important;
	background-color: #f8fafc;
}

.Cancelled {
	border: 2px solid #ef4444;
	color: #b91c1c !important;
	background-color: #fef2f2;
}

.reg-text {
	font-weight: 700;
	font-family: monospace;
	font-size: 1.1em;
}

.empty-msg {
	padding: 40px !important;
	font-size: 1.2rem;
	color: #64748b;
	font-weight: 500;
}

@media ( max-width : 768px) {
	table th, table td {
		font-size: 0.85em;
		padding: 10px;
	}
}
</style>
</head>
<body>
	<div class="rentals-container">
		<div class="top-nav-bar">
			<a href="customer-dashboard.jsp" class="back-link"> <i
				class="fas fa-arrow-left"></i> Back to Dashboard
			</a>
			<div class="user-status">
				<i class="fas fa-user-circle me-1"></i> Logged in as: <strong><%=customerEmail%></strong>
			</div>
		</div>

		<div class="header-banner">
			<h3>My Rental History Dashboard</h3>
		</div>

		<table>
			<thead>
				<tr>
					<th><i class="fas fa-hashtag me-1"></i> Rental ID</th>
					<th><i class="fas fa-signature me-1"></i> Rental Type</th>
					<th><i class="fas fa-calendar-alt me-1"></i> Rental Start Date</th>
					<th><i class="fas fa-calendar-check me-1"></i> Rental End Date</th>
					<th><i class="fas fa-wallet me-1"></i> Total Amount</th>
					<th class="text-center"><i class="fas fa-info-circle me-1"></i>
						Rental Status</th>
					<th><i class="fas fa-car me-1"></i> Car Reg No</th>
					<th><i class="fas fa-clock me-1"></i> Booked At</th>
				</tr>
			</thead>
			<tbody>
				<%
				Connection conn = null;
				PreparedStatement stmt = null;
				ResultSet rs = null;
				try {
					Class.forName("com.mysql.cj.jdbc.Driver");
					conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_db", "root", "trickortreat");

					String sql = "SELECT Rental_ID, Rental_Name, Rent_Start_Date, Rent_End_Date, Rental_Status, Car_Regno, Total_Car_Price, Created_At FROM RENTAL WHERE Cust_Email = ? ORDER BY Created_At DESC";
					stmt = conn.prepareStatement(sql);
					stmt.setString(1, customerEmail);
					rs = stmt.executeQuery();

					boolean hasRows = false;
					while (rs.next()) {
						hasRows = true;
						String status = rs.getString("Rental_Status");
						long wholePrice = Math.round(rs.getDouble("Total_Car_Price"));
				%>
				<tr>
					<td><strong>#<%=rs.getInt("Rental_ID")%></strong></td>
					<td><%=rs.getString("Rental_Name") != null ? rs.getString("Rental_Name") : "General"%></td>
					<td><%=rs.getDate("Rent_Start_Date")%></td>
					<td><%=rs.getDate("Rent_End_Date")%></td>
					<td><strong>₹<%=wholePrice%></strong></td>
					<td class="text-center"><span class="status-badge <%=status%>"><%=status%></span>
					</td>
					<td><span class="reg-text text-uppercase"><%=rs.getString("Car_Regno")%></span></td>
					<td><%=rs.getTimestamp("Created_At")%></td>
				</tr>
				<%
				}
				if (!hasRows) {
				%>
				<tr>
					<td colspan="8" class="empty-msg text-center py-5"><i
						class="fas fa-history me-2"></i> You haven't made any rentals yet.
					</td>
				</tr>
				<%
				}
				} catch (Exception e) {
				%>
				<tr>
					<td colspan="8" class="empty-msg text-danger text-center"><i
						class="fas fa-exclamation-triangle me-2"></i> Connectivity error.
						Could not retrieve rental history.</td>
				</tr>
				<%
				} finally {
				if (rs != null)
					rs.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
				}
				%>
			</tbody>
		</table>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>