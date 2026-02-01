<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*"%>
<%
String adminEmail = (String) session.getAttribute("adminEmail");
if (adminEmail == null) {
	response.sendRedirect("admin-login.jsp");
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
<title>Manage Fleet | EliteDrive</title>

<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

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

.color-indicator {
	display: inline-block;
	width: 15px;
	height: 15px;
	border-radius: 50%;
	margin-right: 8px;
	border: 1px solid #ddd;
	vertical-align: middle;
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

.Available {
	border: 2px solid #28a745;
	color: #28a745 !important;
	background-color: #f4fff6;
}

.NotAvailable {
	border: 2px solid #dc3545;
	color: #dc3545 !important;
	background-color: #fff5f5;
}

.reg-text {
	font-weight: 700;
	font-family: monospace;
	font-size: 1.1em;
}

.btn-manage {
	border: none;
	padding: 8px 0;
	border-radius: 6px;
	transition: 0.3s;
	font-size: 0.85em;
	font-weight: 600;
	width: 100px;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	gap: 6px;
}

.btn-edit {
	background-color: #e3f2fd;
	color: #1e88e5;
}

.btn-edit:hover {
	background-color: #1e88e5;
	color: #fff;
}

.btn-del {
	background-color: #fdeaea;
	color: #dc3545;
}

.btn-del:hover {
	background-color: #dc3545;
	color: #fff;
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
			<a href="admin-dashboard.jsp" class="back-link"> <i
				class="fas fa-arrow-left"></i> Back to Dashboard
			</a>
			<div class="user-status">
				<i class="fas fa-user-shield me-1"></i> Logged in as: <strong><%=adminEmail%></strong>
			</div>
		</div>

		<div class="header-banner">
			<h3>Fleet Management Dashboard</h3>
			<button class="btn btn-primary rounded-pill px-4 mt-2"
				onclick="window.location.href='add-new-car.jsp'">
				<i class="fas fa-plus me-2"></i>Add New Car
			</button>
		</div>

		<table>
			<thead>
				<tr>
					<th><i class="fas fa-car me-1"></i>Car Reg No</th>
					<th><i class="fas fa-signature me-1"></i>Car Model</th>
					<th><i class="fas fa-calendar-alt me-1"></i>Car Year</th>
					<th><i class="fas fa-palette me-1"></i>Car Color</th>
					<th><i class="fas fa-map-marker-alt me-1"></i>Car Location</th>
					<th><i class="fas fa-tag me-1"></i>Daily Price</th>
					<th><i class="fas fa-info-circle me-1"></i>Car Status</th>
					<th style="width: 250px;"><i class="fas fa-tools me-1"></i>Actions</th>
				</tr>
			</thead>
			<tbody>
				<%
				Connection connection = null;
				PreparedStatement preparedStatement = null;
				ResultSet resultSet = null;
				boolean hasData = false;

				try {
					Class.forName("com.mysql.cj.jdbc.Driver");
					connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_db", "root", "trickortreat");

					String query = "SELECT Car_Regno, Car_Model, Car_Year, Car_Color, Car_Status, Car_Price, Car_Location FROM Car ORDER BY Car_Regno ASC";
					preparedStatement = connection.prepareStatement(query);
					resultSet = preparedStatement.executeQuery();

					while (resultSet.next()) {
						hasData = true;
						String carRegno = resultSet.getString("Car_Regno");
						String status = resultSet.getString("Car_Status");
						String statusClass = (status != null) ? status.replace(" ", "") : "Available";
				%>
				<tr>
					<td><span class="reg-text text-uppercase"><%=carRegno%></span></td>
					<td><strong><%=resultSet.getString("Car_Model")%></strong></td>
					<td><%=resultSet.getInt("Car_Year")%></td>
					<td>
						<%
						String carColor = resultSet.getString("Car_Color");
						String cssColor = (carColor != null) ? carColor.toLowerCase().trim() : "transparent";
						%>
						<div class="d-flex align-items-center justify-content-start ps-3">
							<span class="color-indicator"
								style="background-color: <%=cssColor%>;"></span> <span
								style="text-transform: capitalize;"><%=carColor%></span>
						</div>
					</td>
					<td><%=resultSet.getString("Car_Location")%></td>
					<td><strong>₹<%=resultSet.getInt("Car_Price")%></strong></td>
					<td><span class="status-badge <%=statusClass%>"> <%=status%>
					</span></td>
					<td>
						<button class="btn-manage btn-edit"
							onclick="window.location.href='UpdateCarServlet?id=<%=carRegno%>'">
							<i class="fas fa-pen-to-square"></i> Edit
						</button>
						<button class="btn-manage btn-del ms-1"
							onclick="confirmDelete('<%=carRegno%>')">
							<i class="fas fa-trash-can"></i> Delete
						</button>
					</td>
				</tr>
				<%
				}

				if (!hasData) {
				%>
				<tr>
					<td colspan="8" class="empty-msg"><i
						class="fas fa-folder-open me-2"></i> No vehicle records found.</td>
				</tr>
				<%
				}

				} catch (Exception e) {
				out.println("<tr><td colspan='8' class='empty-msg text-danger'>Error loading fleet data.</td></tr>");
				} finally {
				if (resultSet != null)
				resultSet.close();
				if (preparedStatement != null)
				preparedStatement.close();
				if (connection != null)
				connection.close();
				}
				%>
			</tbody>
		</table>
	</div>

	<script>
        function confirmDelete(carRegno) {
            Swal.fire({
                title: 'Delete Vehicle?',
                text: "Are you sure you want to remove " + carRegno + "?",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#dc3545',
                cancelButtonColor: '#1e293b',
                confirmButtonText: 'Yes, delete it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    deleteCar(carRegno);
                }
            });
        }

        function deleteCar(carRegno) {
            fetch('DeleteCarServlet?id=' + encodeURIComponent(carRegno))
                .then(response => response.text())
                .then(text => {
                    if (text.trim() === "success") {
                        Swal.fire('Deleted !', 'Vehicle removed successfully.', 'success').then(() => window.location.reload());
                    } else {
                        Swal.fire('Error!', 'Could not delete.', 'error');
                    }
                });
        }
        
        window.onload = function() {
            const params = new URLSearchParams(window.location.search);
            if (params.get('status') === 'updated') {
                Swal.fire({
                    title: 'Success!',
                    text: 'Vehicle details have been modified successfully.',
                    icon: 'success',
                    confirmButtonColor: '#1e293b'
                });
            } else if (params.get('status') === 'error') {
                Swal.fire({
                    title: 'Error!',
                    text: 'Something went wrong. Please try again.',
                    icon: 'error',
                    confirmButtonColor: '#1e293b'
                });
            }
            window.history.replaceState({}, document.title, window.location.pathname);
        };
    </script>
</body>
</html>