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
<title>Administration Manage Rentals | EliteDrive</title>

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

.empty-msg {
	padding: 40px !important;
	font-size: 1.2rem;
	color: #64748b;
	font-weight: 500;
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
			<h3>Rental Management Dashboard</h3>
		</div>

		<table>
			<thead>
				<tr>
					<th><i class="fas fa-hashtag me-1"></i>Rental ID</th>
					<th><i class="fas fa-user me-1"></i>Customer Name</th>
					<th><i class="fas fa-calendar-check me-1"></i>Start Date</th>
					<th><i class="fas fa-calendar-times me-1"></i>End Date</th>
					<th><i class="fas fa-info-circle me-1"></i>Status</th>
					<th><i class="fas fa-envelope me-1"></i>Cust Email</th>
					<th><i class="fas fa-car me-1"></i>Car Reg No</th>
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

					String query = "SELECT Rental_ID, Rental_Name, Rent_Start_Date, Rent_End_Date, Rental_Status, Cust_Email, Car_Regno FROM Rental ORDER BY Rental_ID DESC";
					preparedStatement = connection.prepareStatement(query);
					resultSet = preparedStatement.executeQuery();

					while (resultSet.next()) {
						hasData = true;
						int rentalId = resultSet.getInt("Rental_ID");
						String status = resultSet.getString("Rental_Status");
						String statusClass = (status != null) ? status.replace(" ", "") : "Pending";
				%>
				<tr>
					<td><strong>#<%=rentalId%></strong></td>
					<td><%=resultSet.getString("Rental_Name")%></td>
					<td><%=resultSet.getDate("Rent_Start_Date")%></td>
					<td><%=resultSet.getDate("Rent_End_Date")%></td>
					<td><span class="status-badge <%=statusClass%>"> <%=status%>
					</span></td>
					<td><%=resultSet.getString("Cust_Email")%></td>
					<td><span class="reg-text text-uppercase"><%=resultSet.getString("Car_Regno")%></span></td>
					<td>
						<button class="btn-manage btn-edit"
							onclick="window.location.href='UpdateRentalServlet?id=<%=rentalId%>'">
							<i class="fas fa-pen-to-square"></i> Edit
						</button>
						<button class="btn-manage btn-del ms-1"
							onclick="confirmDelete('<%=rentalId%>')">
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
						class="fas fa-folder-open me-2"></i> No rental records found.</td>
				</tr>
				<%
				}

				} catch (Exception e) {
				out.println("<tr><td colspan='8' class='empty-msg text-danger'>Error loading rental data.</td></tr>");
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
        function confirmDelete(rentalId) {
            Swal.fire({
                title: 'Delete Rental Record?',
                text: "Removing Rental #" + rentalId + " is permanent!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#dc3545',
                cancelButtonColor: '#1e293b',
                confirmButtonText: 'Yes, delete it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    deleteRental(rentalId);
                }
            });
        }

        function deleteRental(rentalId) {
            fetch('DeleteRentalServlet?id=' + encodeURIComponent(rentalId))
                .then(response => response.text())
                .then(text => {
                    if (text.trim() === "success") {
                        Swal.fire('Deleted!', 'Rental record removed.', 'success').then(() => window.location.reload());
                    } else {
                        Swal.fire('Error!', 'Could not delete rental record.', 'error');
                    }
                });
        }

        const urlParams = new URLSearchParams(window.location.search);
        const status = urlParams.get('status');

        if (status === 'updated') {
            Swal.fire({
                title: 'Success!',
                text: 'The rental record has been updated successfully.',
                icon: 'success',
                confirmButtonColor: '#1e293b',
                timer: 3000
            }).then(() => {
                window.history.replaceState({}, document.title, window.location.pathname);
            });
        } else if (status === 'error') {
            Swal.fire({
                title: 'Error!',
                text: 'Something went wrong while updating the record.',
                icon: 'error',
                confirmButtonColor: '#1e293b'
            });
        }
    
    </script>
</body>
</html>