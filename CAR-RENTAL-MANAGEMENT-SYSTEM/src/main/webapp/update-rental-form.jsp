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
<link rel="icon" type="image/png"
	href="https://cdn4.iconfinder.com/data/icons/filled-outline-car/64/car-front-view-vehicle-automobile-1024.png">
<title>Administration Update Rental | EliteDrive</title>

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

.form-container {
	background: #fff;
	padding: 30px;
	border-radius: 12px;
	box-shadow: 5px 5px 20px rgba(0, 0, 0, 0.1);
	width: 100%;
	max-width: 600px;
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
	font-size: 1.8em;
	font-weight: 700;
	text-transform: uppercase;
	letter-spacing: 2px;
}

.section-title {
	font-size: 0.85rem;
	text-transform: uppercase;
	letter-spacing: 1px;
	color: #1e88e5;
	margin: 20px 0 15px 0;
	font-weight: 700;
	border-bottom: 1px solid #e3f2fd;
	padding-bottom: 5px;
}

.form-label {
	font-weight: 500;
	color: #1e293b;
	font-size: 0.9rem;
}

.form-control, .form-select {
	border: 1px solid #cfd8dc;
	border-radius: 8px;
	padding: 10px 15px;
	transition: 0.2s;
}

.is-invalid {
	border-color: #dc3545 !important;
	background-color: #fff8f8 !important;
}

.error-text {
	color: #dc3545;
	font-size: 0.75rem;
	font-weight: 500;
	margin-top: 5px;
	display: none;
}

.btn-update {
	background-color: #1e293b !important;
	color: white !important;
	border: none;
	padding: 15px;
	border-radius: 8px;
	font-weight: 600;
	width: 100%;
	margin-top: 20px;
	text-transform: uppercase;
	letter-spacing: 1px;
	transition: none !important;
}

.btn-update:hover {
	background-color: #334155 !important;
}
</style>
</head>
<body>

	<div class="form-container">
		<div class="top-nav-bar">
			<a href="manage-rentals.jsp" class="back-link"> <i
				class="fas fa-arrow-left"></i> Back to Rentals
			</a>
			<div class="user-status">
				<i class="fas fa-user-shield me-1"></i> Admin: <strong><%=adminEmail%></strong>
			</div>
		</div>

		<div class="header-banner">
			<h3>Update Rental</h3>
		</div>

		<form action="UpdateRentalActionServlet" method="post"
			id="updateRentalForm" novalidate>
			<input type="hidden" name="rentalId"
				value="<%=request.getAttribute("rentalId")%>">

			<div class="section-title">
				<i class="fas fa-user-tag me-2"></i>Assignment Details
			</div>
			<div class="row">
				<div class="col-md-6 mb-3">
					<label class="form-label">Customer Name</label> <input type="text"
						class="form-control" name="rentalName" id="rentalName"
						value="<%=request.getAttribute("rentalName")%>">
					<div class="error-text" id="nameError">Letters and spaces
						only.</div>
				</div>
				<div class="col-md-6 mb-3">
					<label class="form-label">Customer Email</label> <input
						type="email" class="form-control" name="custEmail" id="custEmail"
						value="<%=request.getAttribute("custEmail")%>">
					<div class="error-text" id="emailError">Enter a valid email
						address.</div>
				</div>
			</div>

			<div class="section-title">
				<i class="fas fa-calendar-alt me-2"></i>Schedule & Vehicle
			</div>
			<div class="row">
				<div class="col-md-6 mb-3">
					<label class="form-label">Start Date</label> <input type="date"
						class="form-control" name="rentStartDate" id="rentStartDate"
						value="<%=request.getAttribute("rentStartDate")%>">
				</div>
				<div class="col-md-6 mb-3">
					<label class="form-label">End Date</label> <input type="date"
						class="form-control" name="rentEndDate" id="rentEndDate"
						value="<%=request.getAttribute("rentEndDate")%>">
					<div class="error-text" id="dateError">End date cannot be
						before start date.</div>
				</div>
				<div class="col-12 mb-3">
					<label class="form-label">Car Registration No</label> <input
						type="text" class="form-control" name="carRegno" id="carRegno"
						value="<%=request.getAttribute("carRegno")%>">
					<div class="error-text" id="regError">Invalid Registration
						number format.</div>
				</div>
			</div>

			<div class="section-title">
				<i class="fas fa-info-circle me-2"></i>Status Management
			</div>
			<div class="row">
				<div class="col-12 mb-3">
					<label class="form-label">Rental Status</label> <select
						class="form-select status-select" name="rentalStatus"
						id="rentalStatus">
						<%
						String currentStatus = (String) request.getAttribute("rentalStatus");
						if (currentStatus == null)
							currentStatus = "Active"; // Set Active as default
						%>
						<option value="Active"
							<%="Active".equals(currentStatus) ? "selected" : ""%>>Active</option>
						<option value="Ongoing"
							<%="Ongoing".equals(currentStatus) ? "selected" : ""%>>Ongoing</option>
						<option value="Pending"
							<%="Pending".equals(currentStatus) ? "selected" : ""%>>Pending</option>
						<option value="Completed"
							<%="Completed".equals(currentStatus) ? "selected" : ""%>>Completed</option>
						<option value="Cancelled"
							<%="Cancelled".equals(currentStatus) ? "selected" : ""%>>Cancelled</option>
					</select>
				</div>
			</div>

			<button type="submit" class="btn btn-update">
				<i class="fas fa-save me-2"></i> Update Record
			</button>
		</form>
	</div>

	<script>
const form = document.getElementById('updateRentalForm');

const validators = {
    rentalName: (val) => /^[A-Za-z ]+$/.test(val) && val.trim() !== "",
    custEmail: (val) => /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(val),
    carRegno: (val) => val.trim().length >= 5,
    rentEndDate: () => {
        const start = new Date(document.getElementById('rentStartDate').value);
        const end = new Date(document.getElementById('rentEndDate').value);
        return end >= start;
    },
    rentalStatus: (val) => val !== ""
};

const errorMap = {
    rentalName: 'nameError',
    custEmail: 'emailError',
    carRegno: 'regError',
    rentEndDate: 'dateError'
};

function liveValidate(input) {
    const validator = validators[input.id];
    if (!validator) return true;

    const isValid = validator(input.value);
    const errorDiv = document.getElementById(errorMap[input.id]);

    if (isValid) {
        input.classList.remove('is-invalid');
        if (errorDiv) errorDiv.style.display = 'none';
        return true;
    } else {
        input.classList.add('is-invalid');
        if (errorDiv) errorDiv.style.display = 'block';
        return false;
    }
}

document.querySelectorAll('.form-control, .form-select').forEach(input => {
    input.addEventListener('input', () => liveValidate(input));
    input.addEventListener('change', () => liveValidate(input));
});

form.addEventListener('submit', function(e) {
    let isFormValid = true;
    document.querySelectorAll('.form-control, .form-select').forEach(input => {
        if (!liveValidate(input)) isFormValid = false;
    });

    if (!isFormValid) {
        e.preventDefault();
    }
});
</script>

</body>
</html>