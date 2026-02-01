<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" type="image/png"
	href="https://cdn4.iconfinder.com/data/icons/filled-outline-car/64/car-front-view-vehicle-automobile-1024.png">
<title>Customer Portal | Premium Car Rentals</title>

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
	padding: 45px;
	border-radius: 12px;
	box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
	width: 100%;
	max-width: 450px;
	max-height: 95vh;
	overflow-y: auto;
}

.customer-header {
	text-align: center;
	margin-bottom: 35px;
}

.customer-header i {
	font-size: 3rem;
	color: #1e293b;
	margin-bottom: 15px;
}

.customer-card h2 {
	font-weight: 700;
	color: #1e293b;
	letter-spacing: -1px;
	margin-bottom: 5px;
}

.customer-card p {
	color: #64748b;
	font-size: 0.9rem;
}

.form-label {
	font-weight: 600;
	font-size: 0.8rem;
	color: #1e293b;
	text-transform: uppercase;
	letter-spacing: 0.5px;
}

.input-group {
	border: 2px solid #e2e8f0;
	border-radius: 8px;
	transition: all 0.3s ease;
}

.input-group-text {
	background: transparent;
	border: none;
	color: #64748b;
}

.form-control {
	border: none;
	padding: 12px;
	font-size: 0.95rem;
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
	box-shadow: 0 0 0 3px rgba(239, 68, 68, 0.1) !important;
}

.error-message {
	color: #ef4444;
	font-size: 0.75rem;
	font-weight: 500;
	margin-top: 5px;
	min-height: 18px;
}

.btn-customer {
	background-color: #1e293b;
	color: white;
	border: none;
	padding: 14px;
	border-radius: 8px;
	font-weight: 600;
	width: 100%;
	margin-top: 15px;
	transition: all 0.3s ease;
}

.btn-customer:hover {
	background-color: #334155;
	transform: translateY(-1px);
}

.footer-note {
	text-align: center;
	margin-top: 25px;
	font-size: 0.85rem;
	color: #94a3b8;
}

.register-link {
	text-align: center;
	margin-top: 10px;
}

.register-link a {
	color: #1e293b;
	text-decoration: none;
	font-weight: 600;
}

.register-link a:hover {
	text-decoration: underline;
}

.customer-card::-webkit-scrollbar {
	width: 0px;
	background: transparent;
}

.customer-card {
	-ms-overflow-style: none;
	scrollbar-width: none;
}
</style>
</head>

<body>
	<div class="customer-card">
		<div class="customer-header">
			<i class="fas fa-car"></i>
			<h2>Customer Portal</h2>
			<p>Secure Customer Access</p>
		</div>

		<form id="customerLoginForm" novalidate>
			<div class="mb-3">
				<label for="Cust_Email" class="form-label">Email Address</label>
				<div class="input-group" id="emailGroup">
					<span class="input-group-text"><i class="fas fa-envelope"></i></span>
					<input type="email" id="Cust_Email" name="Cust_Email"
						class="form-control" placeholder="customer@gmail.com">
				</div>
				<div id="cust_email_error" class="error-message"></div>
			</div>

			<div class="mb-3">
				<label for="Cust_Password" class="form-label">Password</label>
				<div class="input-group" id="passGroup">
					<span class="input-group-text"><i class="fas fa-key"></i></span> <input
						type="password" id="Cust_Password" name="Cust_Password"
						class="form-control" placeholder="************">
				</div>
				<div id="cust_password_error" class="error-message"></div>
			</div>

			<button type="submit" class="btn-customer">Authorize Access</button>
		</form>

		<div class="footer-note">Registered Customers Only.</div>
		<div class="register-link">
			Don't have an account? <a href="customer-register.jsp">Register
				Here</a>
		</div>
	</div>

	<script>
const loginForm = document.getElementById("customerLoginForm");
const emailInput = document.getElementById("Cust_Email");
const passInput = document.getElementById("Cust_Password");
const emailError = document.getElementById("cust_email_error");
const passError = document.getElementById("cust_password_error");
const emailGroup = document.getElementById("emailGroup");
const passGroup = document.getElementById("passGroup");

function validateEmail() {
    const value = emailInput.value.trim();
    const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (value === "") {
        emailError.textContent = "Please enter your registered email address.";
        emailGroup.classList.add("error-border");
        return false;
    } else if (!regex.test(value)) {
        emailError.textContent = "Please provide a valid email format (e.g., name@gmail.com).";
        emailGroup.classList.add("error-border");
        return false;
    } else {
        emailError.textContent = "";
        emailGroup.classList.remove("error-border");
        return true;
    }
}

function validatePassword() {
    const value = passInput.value;
    const regex = /^(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{12,}$/;
    if (value === "") {
        passError.textContent = "Your account password is required to log in.";
        passGroup.classList.add("error-border");
        return false;
    } else if (value.length < 12) {
        passError.textContent = "Security policy: Password must be at least 12 characters long.";
        passGroup.classList.add("error-border");
        return false;
    } else if (!regex.test(value)) {
        passError.textContent = "Password must include at least one number and one special character.";
        passGroup.classList.add("error-border");
        return false;
    } else {
        passError.textContent = "";
        passGroup.classList.remove("error-border");
        return true;
    }
}

emailInput.addEventListener("input", validateEmail);
passInput.addEventListener("input", validatePassword);

loginForm.addEventListener("submit", function(e) {
    e.preventDefault();

    const isEmailValid = validateEmail();
    const isPassValid = validatePassword();

    if (isEmailValid && isPassValid) {
        const submitBtn = this.querySelector("button");
        submitBtn.disabled = true;
        submitBtn.innerText = "Verifying Credentials...";

        const params = new URLSearchParams(new FormData(this));

        fetch("LoginServlet", {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: params
        })
        .then(res => res.text())
        .then(result => {
            if (result.includes("Login successful")) {
                Swal.fire({
                    title: "Authenticated!",
                    text: "Access granted. Redirecting to your dashboard...",
                    icon: "success",
                    showConfirmButton: false,
                    timer: 1500,
                    confirmButtonColor: "#1e293b"
                }).then(() => window.location.href = "customer-dashboard.jsp");
            } else {
                submitBtn.disabled = false;
                submitBtn.innerText = "Authorize Access";
                Swal.fire({
                    title: "Access Denied!",
                    text: "The email or password you entered is incorrect.",
                    icon: "error",
                    confirmButtonColor: "#1e293b"
                });
            }
        })
        .catch(() => {
            submitBtn.disabled = false;
            submitBtn.innerText = "Authorize Access";
            Swal.fire({
                title: "System Error",
                text: "We couldn't connect to the server. Please try again later.",
                icon: "warning",
                confirmButtonColor: "#1e293b"
            });
        });
    }
});
</script>
</body>
</html>