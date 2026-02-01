<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" type="image/png"
	href="https://cdn4.iconfinder.com/data/icons/filled-outline-car/64/car-front-view-vehicle-automobile-1024.png">
<title>Admin Registration | Premium Car Rentals</title>
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
* {
	font-family: 'Poppins', sans-serif;
	box-sizing: border-box;
}

body {
	background: linear-gradient(rgba(15, 23, 42, 0.8), rgba(15, 23, 42, 0.8)),
		url('https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?ixlib=rb-1.2.1&auto=format&fit=crop&w=1920&q=80');
	background-size: cover;
	background-position: center;
	background-attachment: fixed;
	height: 100vh;
	display: flex;
	align-items: center;
	justify-content: center;
	margin: 0;
	overflow: hidden;
}

.customer-card {
	background: rgba(255, 255, 255, 0.98);
	padding: 30px 40px;
	border-radius: 12px;
	box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
	width: 95%;
	max-width: 550px;
	max-height: 95vh;
	overflow-y: auto;
}

.customer-header {
	text-align: center;
	margin-bottom: 20px;
}

.customer-header i {
	font-size: 2.5rem;
	color: #1e293b;
	margin-bottom: 10px;
}

.customer-card h2 {
	font-weight: 700;
	color: #1e293b;
	margin-bottom: 2px;
	font-size: 1.5rem;
}

.customer-card p {
	color: #64748b;
	font-size: 0.85rem;
	margin-bottom: 0;
}

.form-label {
	font-weight: 600;
	font-size: 0.75rem;
	color: #1e293b;
	text-transform: uppercase;
	letter-spacing: 0.5px;
	margin-bottom: 4px;
}

.input-group {
	border: 2px solid #e2e8f0;
	border-radius: 8px;
	transition: all 0.3s ease;
	margin-bottom: 2px;
}

.input-group-text {
	background: transparent;
	border: none;
	color: #64748b;
	padding: 8px 12px;
}

.form-control {
	border: none;
	padding: 8px;
	font-size: 0.9rem;
}

.form-control:focus {
	box-shadow: none;
	outline: none;
}

.input-group:focus-within {
	border-color: #0d6efd;
}

.error-border {
	border-color: #ef4444 !important;
}

.error-message {
	color: #ef4444;
	font-size: 0.7rem;
	font-weight: 500;
	min-height: 15px;
	margin-bottom: 8px;
}

.btn-customer {
	background-color: #1e293b;
	color: white;
	border: none;
	padding: 12px;
	border-radius: 8px;
	font-weight: 600;
	width: 100%;
	margin-top: 10px;
	transition: all 0.3s ease;
}

.btn-customer:hover {
	background-color: #334155;
	transform: translateY(-1px);
}

.register-link {
	text-align: center;
	margin-top: 15px;
	font-size: 0.85rem;
}

.register-link a {
	color: #1e293b;
	text-decoration: none;
	font-weight: 600;
}

.register-link a:hover {
	text-decoration: underline;
}

::-webkit-scrollbar {
	width: 6px;
}

::-webkit-scrollbar-thumb {
	background: #cbd5e1;
	border-radius: 10px;
}
</style>
</head>
<body>

	<div class="customer-card">
		<div class="customer-header">
			<i class="fas fa-user-shield"></i>
			<h2>Admin Registration</h2>
			<p>Create your management account</p>
		</div>

		<form id="adminForm" novalidate>
			<label for="Admin_Name" class="form-label">Full Name</label>
			<div class="input-group">
				<span class="input-group-text"><i class="fas fa-user-tie"></i></span>
				<input type="text" id="Admin_Name" name="Admin_Name"
					class="form-control" placeholder="Admin Full Name">
			</div>
			<div id="admin_name_error" class="error-message"></div>

			<label for="Admin_Email" class="form-label">Email Address</label>
			<div class="input-group">
				<span class="input-group-text"><i class="fas fa-envelope"></i></span>
				<input type="email" id="Admin_Email" name="Admin_Email"
					class="form-control" placeholder="admin@rentals.com">
			</div>
			<div id="admin_email_error" class="error-message"></div>

			<label for="Admin_Phone" class="form-label">Phone Number</label>
			<div class="input-group">
				<span class="input-group-text"><i class="fas fa-phone"></i></span> <input
					type="tel" id="Admin_Phone" name="Admin_Phone" class="form-control"
					placeholder="1234567890">
			</div>
			<div id="admin_phone_error" class="error-message"></div>

			<label for="Admin_Password" class="form-label">Password</label>
			<div class="input-group">
				<span class="input-group-text"><i class="fas fa-key"></i></span> <input
					type="password" id="Admin_Password" name="Admin_Password"
					class="form-control" placeholder="************">
			</div>
			<div id="admin_password_error" class="error-message"></div>

			<label for="Admin_Confirm_Password" class="form-label">Confirm
				Password</label>
			<div class="input-group">
				<span class="input-group-text"><i class="fas fa-key"></i></span> <input
					type="password" id="Admin_Confirm_Password"
					name="Admin_Confirm_Password" class="form-control"
					placeholder="************">
			</div>
			<div id="admin_confirm_password_error" class="error-message"></div>

			<button type="submit" class="btn-customer">Register Account</button>
		</form>

		<div class="register-link">
			Already have an admin account? <a href="admin-login.jsp">Login
				Here</a>
		</div>
	</div>

	<script>
const form = document.getElementById("adminForm");
const fields = {
	name: document.getElementById("Admin_Name"),
	email: document.getElementById("Admin_Email"),
	phone: document.getElementById("Admin_Phone"),
	password: document.getElementById("Admin_Password"),
	confirm: document.getElementById("Admin_Confirm_Password")
};
const errors = {
	name: document.getElementById("admin_name_error"),
	email: document.getElementById("admin_email_error"),
	phone: document.getElementById("admin_phone_error"),
	password: document.getElementById("admin_password_error"),
	confirm: document.getElementById("admin_confirm_password_error")
};

function validateAllFields() {
	let valid = true;

	const nameVal = fields.name.value.trim();
	if(nameVal === "") { 
		errors.name.textContent = "Please provide your official full name for registration."; 
		fields.name.parentElement.classList.add("error-border"); 
		valid = false; 
	} else if(!/^[a-zA-Z\s]+$/.test(nameVal)) { 
		errors.name.textContent = "Full name should only contain alphabetical letters and spaces."; 
		fields.name.parentElement.classList.add("error-border"); 
		valid = false; 
	} else { 
		errors.name.textContent = ""; 
		fields.name.parentElement.classList.remove("error-border"); 
	}

	const emailVal = fields.email.value.trim();
	const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
	if(emailVal === "") { 
		errors.email.textContent = "A corporate email address is required for administrative access."; 
		fields.email.parentElement.classList.add("error-border"); 
		valid = false; 
	} else if(!emailRegex.test(emailVal)) { 
		errors.email.textContent = "Please enter a valid email format (e.g., admin@company.com)."; 
		fields.email.parentElement.classList.add("error-border"); 
		valid = false; 
	} else { 
		errors.email.textContent = ""; 
		fields.email.parentElement.classList.remove("error-border"); 
	}

	const phoneVal = fields.phone.value.trim();
	if(phoneVal === "") { 
		errors.phone.textContent = "Contact number is mandatory for system security alerts."; 
		fields.phone.parentElement.classList.add("error-border"); 
		valid = false; 
	} else if(!/^\d{10}$/.test(phoneVal)) { 
		errors.phone.textContent = "Please provide a valid 10-digit mobile number."; 
		fields.phone.parentElement.classList.add("error-border"); 
		valid = false; 
	} else { 
		errors.phone.textContent = ""; 
		fields.phone.parentElement.classList.remove("error-border"); 
	}

	const passVal = fields.password.value;
	const passRegex = /^(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{12,}$/;
	if(passVal === "") { 
		errors.password.textContent = "Please set a highly secure password to protect the portal."; 
		fields.password.parentElement.classList.add("error-border"); 
		valid = false; 
	} else if(passVal.length < 12) { 
		errors.password.textContent = "Security Requirement: Password must be at least 12 characters long."; 
		fields.password.parentElement.classList.add("error-border"); 
		valid = false; 
	} else if(!passRegex.test(passVal)) { 
		errors.password.textContent = "Include at least one digit and one special character for a strong password."; 
		fields.password.parentElement.classList.add("error-border"); 
		valid = false; 
	} else { 
		errors.password.textContent = ""; 
		fields.password.parentElement.classList.remove("error-border"); 
	}

	if(fields.confirm.value === "") { 
		errors.confirm.textContent = "Please repeat your password to confirm it."; 
		fields.confirm.parentElement.classList.add("error-border"); 
		valid = false; 
	} else if(fields.confirm.value !== passVal) { 
		errors.confirm.textContent = "The confirmation password does not match. Please re-check."; 
		fields.confirm.parentElement.classList.add("error-border"); 
		valid = false; 
	} else { 
		errors.confirm.textContent = ""; 
		fields.confirm.parentElement.classList.remove("error-border"); 
	}

	return valid;
}

for(let key in fields) { fields[key].addEventListener("input", validateAllFields); }

form.addEventListener("submit", function(e){
	e.preventDefault();
	if(validateAllFields()){
		const params = new URLSearchParams(new FormData(this));
		fetch("AdminServlet",{ method:"POST", headers:{"Content-Type":"application/x-www-form-urlencoded"}, body: params })
		.then(res=>res.json())
		.then(data=>{
			if(data.status==="success"){
				Swal.fire({ title:"Access Granted!", text:"Admin account created successfully.", icon:"success",confirmButtonColor: "#1e293b" })
				.then(()=>window.location.href="admin-login.jsp");
			} else {
				Swal.fire({title:"Registration Failed", text:data.message, icon:"error"});
			}
		})
		.catch(err=>Swal.fire({title:"Error", text:"Could not connect to the server. Please try again.", icon:"warning"}));
	}
});
</script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>