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
<title>Administartion Update Customer | EliteDrive</title>

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

.form-control {
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
			<a href="manage-customers.jsp" class="back-link"> <i
				class="fas fa-arrow-left"></i> Back to Customers
			</a>
			<div class="user-status">
				<i class="fas fa-user-shield me-1"></i> Admin: <strong><%=adminEmail%></strong>
			</div>
		</div>

		<div class="header-banner">
			<h3>Edit Customer</h3>
		</div>

		<form action="UpdateCustomerServlet" method="post"
			id="updateCustomerForm" novalidate>
			<div class="section-title">
				<i class="fas fa-id-card me-2"></i>Account Identity
			</div>
			<div class="mb-3">
				<label class="form-label">Email Address</label> <input type="text"
					name="custEmail" id="custEmail" class="form-control bg-light"
					value="${custEmail}" readonly>
			</div>

			<div class="section-title">
				<i class="fas fa-user me-2"></i>Personal Information
			</div>
			<div class="row">
				<div class="col-12 mb-3">
					<label class="form-label">Full Name</label> <input type="text"
						class="form-control" name="custName" id="custName"
						value="${custName}" placeholder="Enter customer's full name">
					<div class="error-text" id="nameError">Full name must be at
						least 3 letters.</div>
				</div>
			</div>

			<div class="section-title">
				<i class="fas fa-map-marked-alt me-2"></i>Contact Details
			</div>
			<div class="row">
				<div class="col-md-12 mb-3">
					<label class="form-label">Residential Address</label>
					<textarea class="form-control" name="custAddress" id="custAddress"
						rows="2" placeholder="Enter permanent address">${custAddress}</textarea>
					<div class="error-text" id="addressError">Please provide a
						valid address.</div>
				</div>
				<div class="col-md-12 mb-3">
					<label class="form-label">Phone Number</label> <input type="text"
						class="form-control" name="custPhone" id="custPhone"
						value="${custPhone}" maxlength="10"
						placeholder="10-digit mobile number">
					<div class="error-text" id="phoneError">Must be exactly 10
						numeric digits.</div>
				</div>
			</div>

			<button type="submit" class="btn btn-update">
				<i class="fas fa-save me-2"></i> Save Changes
			</button>
		</form>
	</div>

	<script>
const form = document.getElementById('update-customer-form');

const validators = {
    custName: (val) => /^[A-Za-z ]+$/.test(val) && val.trim().length >= 3,
    custAddress: (val) => val.trim().length >= 5,
    custPhone: (val) => /^[0-9]{10}$/.test(val)
};

const errorMap = {
    custName: 'nameError',
    custAddress: 'addressError',
    custPhone: 'phoneError'
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

document.querySelectorAll('.form-control').forEach(input => {
    input.addEventListener('input', () => liveValidate(input));
    input.addEventListener('change', () => liveValidate(input));
});

form.addEventListener('submit', function(e) {
    let isFormValid = true;
    document.querySelectorAll('.form-control').forEach(input => {
        if(input.id !== 'custEmail') {
            if (!liveValidate(input)) isFormValid = false;
        }
    });

    if (!isFormValid) {
        e.preventDefault();
    }
});
</script>

</body>
</html>