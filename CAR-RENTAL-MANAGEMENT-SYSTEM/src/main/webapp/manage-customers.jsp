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
<title>Administration Manage Customers | EliteDrive</title>

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

.customers-container {
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
	text-align: left;
}

table td {
	padding: 12px 15px;
	vertical-align: middle;
	border: 1px solid #cfd8dc;
	font-size: 0.95em;
	color: #1e293b;
	text-align: left;
}

table th:last-child, table td:last-child {
	text-align: center;
}

table tbody tr:nth-child(even) {
	background-color: #f9f9f9;
}

table tbody tr:hover {
	background-color: #f0f8ff;
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
	<div class="customers-container">
		<div class="top-nav-bar">
			<a href="admin-dashboard.jsp" class="back-link"> <i
				class="fas fa-arrow-left"></i> Back to Dashboard
			</a>
			<div class="user-status">
				<i class="fas fa-user-shield me-1"></i> Logged in as: <strong><%=adminEmail%></strong>
			</div>
		</div>

		<div class="header-banner">
			<h3>Customer Management Dashboard</h3>
		</div>

		<table>
			<thead>
				<tr>
					<th><i class="fas fa-envelope me-1"></i> Customer Email
						Address</th>
					<th><i class="fas fa-user me-1"></i> Customer Name</th>
					<th><i class="fas fa-location-dot me-1"></i> Customer Address</th>
					<th><i class="fas fa-phone me-1"></i> Customer Phone</th>
					<th style="width: 250px;"><i class="fas fa-tools me-1"></i>
						Actions</th>
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

					String query = "SELECT Cust_Name, Cust_Address, Cust_Phone, Cust_Email FROM Customer ORDER BY Cust_Email ASC";
					stmt = conn.prepareStatement(query);
					rs = stmt.executeQuery();

					boolean hasData = false;
					while (rs.next()) {
						hasData = true;
						String custEmail = rs.getString("Cust_Email");
				%>
				<tr>
					<td><strong><%=custEmail%></strong></td>
					<td><%=rs.getString("Cust_Name")%></td>
					<td><%=rs.getString("Cust_Address")%></td>
					<td><%=rs.getString("Cust_Phone")%></td>
					<td>
						<button class="btn-manage btn-edit"
							onclick="window.location.href='UpdateCustomerServlet?email=<%=custEmail%>'">
							<i class="fas fa-pen-to-square"></i> Edit
						</button>
						<button class="btn-manage btn-del ms-1"
							onclick="confirmDelete('<%=custEmail%>')">
							<i class="fas fa-trash-can"></i> Delete
						</button>
					</td>
				</tr>
				<%
				}
				if (!hasData) {
				%>
				<tr>
					<td colspan="5" class="empty-msg"><i
						class="fas fa-folder-open me-2"></i> No customer records found.</td>
				</tr>
				<%
				}
				} catch (Exception e) {
				%>
				<tr>
					<td colspan="5" class="empty-msg text-danger"><i
						class="fas fa-exclamation-triangle me-2"></i> Data connectivity
						error. Check database columns.</td>
				</tr>
				<%
				e.printStackTrace();
				} finally {
				if (rs != null) rs.close();
				if (stmt != null) stmt.close();
				if (conn != null) conn.close();
				}
				%>
			</tbody>
		</table>
	</div>

	<script>
        function confirmDelete(email) {
            Swal.fire({
                title: 'Delete Customer?',
                text: "Removing " + email + " is permanent!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#dc3545',
                cancelButtonColor: '#1e293b',
                confirmButtonText: 'Yes, delete it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    deleteCustomer(email);
                }
            });
        }

        function deleteCustomer(email) {
            fetch('DeleteCustomerServlet?email=' + encodeURIComponent(email))
                .then(response => response.text())
                .then(text => {
                    if (text.trim() === "success") {
                        Swal.fire({
                            title: 'Success!',
                            text: 'Customer has been removed successfully.',
                            icon: 'success',
                            confirmButtonColor: '#1e293b'
                        }).then(() => window.location.reload());
                    } else {
                        Swal.fire('Error!', 'Could not delete customer record.', 'error');
                    }
                });
        }

        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('status') === 'updated') {
            Swal.fire({ title: 'Success!', text: 'Customer details has been saved.', icon: 'success', confirmButtonColor: '#1e293b' });
            window.history.replaceState({}, document.title, window.location.pathname);
        }
    </script>
</body>
</html>