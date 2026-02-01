<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*"%>
<%
String customerEmail = (String) session.getAttribute("customerEmail");
if (customerEmail == null) {
	response.sendRedirect("customer-login.jsp");
	return;
}

String name = "", address = "", phone = "", email = "", password = "";
try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_db", "root", "trickortreat");
	PreparedStatement ps = con.prepareStatement("SELECT * FROM CUSTOMER WHERE Cust_Email = ?");
	ps.setString(1, customerEmail);
	ResultSet rs = ps.executeQuery();
	if (rs.next()) {
		name = rs.getString("Cust_Name");
		address = rs.getString("Cust_Address");
		phone = rs.getString("Cust_Phone");
		email = rs.getString("Cust_Email");
		password = rs.getString("Cust_Password");
	}
	con.close();
} catch (Exception e) {
	e.printStackTrace();
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
<title>Customer Account Update | EliteDrive</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
html, body {
	height: 100vh;
	margin: 0;
	overflow: hidden;
}

body {
	background: linear-gradient(135deg, #f0f4f8 0%, #e3f2fd 100%);
	font-family: 'Poppins', sans-serif;
	display: flex;
	align-items: center;
	justify-content: center;
}

.main-wrapper {
	width: 100%;
	max-width: 580px;
	padding: 0 20px;
}

.top-nav-bar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 15px;
	padding: 0 5px;
}

.back-link {
	text-decoration: none;
	color: #1e293b;
	font-weight: 600;
	font-size: 0.9rem;
	transition: 0.3s;
	display: flex;
	align-items: center;
	gap: 8px;
}

.back-link:hover {
	color: #1e88e5;
}

.user-status {
	font-size: 0.85rem;
	color: #1e293b;
}

.profile-card {
	background: #ffffff;
	padding: 30px 40px;
	border-radius: 16px;
	box-shadow: 0 25px 50px -12px rgba(30, 41, 59, 0.25);
	border-top: 6px solid #1e293b;
}

.header-banner {
	text-align: center;
	margin-bottom: 20px;
}

.header-banner h2 {
	color: #1e293b;
	font-weight: 800;
	text-transform: uppercase;
	font-size: 1.6rem;
	letter-spacing: 1.5px;
	margin: 0;
}

.form-label {
	font-weight: 700;
	color: #475569;
	font-size: 0.75rem;
	text-transform: uppercase;
	margin-bottom: 5px;
}

.form-control {
	border: 2px solid #e2e8f0;
	border-radius: 10px;
	padding: 10px 15px;
	font-size: 0.9rem;
	transition: 0.3s;
}

.form-control:focus {
	border-color: #1e88e5;
	box-shadow: 0 0 0 4px rgba(30, 136, 229, 0.1);
	outline: none;
}

.error-message {
	color: #ef4444;
	font-size: 0.68rem;
	margin-top: 4px;
	font-weight: 500;
	min-height: 18px;
	line-height: 1.2;
}

.is-invalid {
	border-color: #ef4444 !important;
}

.btn-update {
	background-color: #1e293b;
	color: white;
	border: none;
	padding: 14px;
	border-radius: 10px;
	font-weight: 700;
	width: 100%;
	margin-top: 15px;
	text-transform: uppercase;
	letter-spacing: 1px;
	transition: 0.3s;
}

.btn-update:hover {
	background-color: #334155;
	transform: translateY(-2px);
	box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
}

.pass-hint {
	font-size: 0.65rem;
	color: #64748b;
	margin-top: -12px;
	margin-bottom: 10px;
	display: block;
}
</style>
</head>
<body>

	<div class="main-wrapper">
		<div class="top-nav-bar">
			<a href="customer-dashboard.jsp" class="back-link"> <i
				class="fas fa-arrow-left"></i> Back to Dashboard
			</a>
			<div class="user-status">
				<i class="fas fa-user-circle me-1"></i> Logged in as: <strong><%=customerEmail%></strong>
			</div>
		</div>

		<div class="profile-card">
			<div class="header-banner">
				<h2>Update Account</h2>
			</div>

			<form id="profileForm">
				<div class="row g-2">
					<div class="col-md-12 mb-1">
						<label class="form-label">Full Name</label> <input type="text"
							id="Cust_Name" name="Cust_Name" class="form-control"
							value="<%=name%>">
						<div id="name_error" class="error-message"></div>
					</div>

					<div class="col-md-6 mb-1">
						<label class="form-label">Phone Number</label> <input type="tel"
							id="Cust_Phone" name="Cust_Phone" class="form-control"
							value="<%=phone%>">
						<div id="phone_error" class="error-message"></div>
					</div>

					<div class="col-md-6 mb-1">
						<label class="form-label">Email Address</label> <input
							type="email" id="Cust_Email" name="Cust_Email"
							class="form-control" value="<%=email%>" readonly
							style="background-color: #f8fafc; cursor: not-allowed;">
						<div id="email_error" class="error-message"></div>
					</div>

					<div class="col-md-12 mb-1">
						<label class="form-label">Residential Address</label> <input
							type="text" id="Cust_Address" name="Cust_Address"
							class="form-control" value="<%=address%>">
						<div id="address_error" class="error-message"></div>
					</div>

					<div class="col-md-6 mb-1">
						<label class="form-label">New Password</label> <input
							type="password" id="Cust_Password" name="Cust_Password"
							class="form-control" value="<%=password%>">
						<div id="pass_error" class="error-message"></div>
					</div>

					<div class="col-md-6 mb-1">
						<label class="form-label">Confirm Password</label> <input
							type="password" id="Confirm_Password" class="form-control"
							value="<%=password%>">
						<div id="conf_error" class="error-message"></div>
					</div>
				</div>

				<button type="submit" class="btn-update">Save Settings</button>
			</form>
		</div>
	</div>

	<script>
    const form = document.getElementById("profileForm");
    const inputs = {
        name: document.getElementById("Cust_Name"),
        phone: document.getElementById("Cust_Phone"),
        email: document.getElementById("Cust_Email"),
        addr: document.getElementById("Cust_Address"),
        pass: document.getElementById("Cust_Password"),
        conf: document.getElementById("Confirm_Password")
    };
    const errors = {
        name: document.getElementById("name_error"),
        phone: document.getElementById("phone_error"),
        email: document.getElementById("email_error"),
        addr: document.getElementById("address_error"),
        pass: document.getElementById("pass_error"),
        conf: document.getElementById("conf_error")
    };

    const validate = {
        name: () => {
            const val = inputs.name.value.trim();
            if (!/^[a-zA-Z\s]{3,}$/.test(val)) {
                errors.name.innerText = "Full Name required (Letters only, min 3)";
                inputs.name.classList.add("is-invalid");
                return false;
            }
            errors.name.innerText = "";
            inputs.name.classList.remove("is-invalid");
            return true;
        },
        phone: () => {
            if (!/^\d{10}$/.test(inputs.phone.value)) {
                errors.phone.innerText = "Must be exactly 10 digits";
                inputs.phone.classList.add("is-invalid");
                return false;
            }
            errors.phone.innerText = "";
            inputs.phone.classList.remove("is-invalid");
            return true;
        },
        email: () => {
            errors.email.innerText = "";
            inputs.email.classList.remove("is-invalid");
            return true;
        },
        addr: () => {
            if (inputs.addr.value.trim().length < 5) {
                errors.addr.innerText = "Please enter a full valid address";
                inputs.addr.classList.add("is-invalid");
                return false;
            }
            errors.addr.innerText = "";
            inputs.addr.classList.remove("is-invalid");
            return true;
        },
        pass: () => {
            const val = inputs.pass.value;
            const hasNumber = /\d/.test(val);
            const hasSpecial = /[!@#$%^&*(),.?":{}|<>]/.test(val);
            
            if (val.length === 0) {
                errors.pass.innerText = "Password is required";
                inputs.pass.classList.add("is-invalid");
                return false;
            } else if (val.length < 12) {
                errors.pass.innerText = "Password must be at least 12 characters";
                inputs.pass.classList.add("is-invalid");
                return false;
            } else if (!hasNumber || !hasSpecial) {
                errors.pass.innerText = "Include at least one number and one special character";
                inputs.pass.classList.add("is-invalid");
                return false;
            }
            errors.pass.innerText = "";
            inputs.pass.classList.remove("is-invalid");
            return true;
        },
        conf: () => {
            if (inputs.conf.value !== inputs.pass.value) {
                errors.conf.innerText = "Passwords do not match";
                inputs.conf.classList.add("is-invalid");
                return false;
            }
            errors.conf.innerText = "";
            inputs.conf.classList.remove("is-invalid");
            return true;
        }
    };

    Object.keys(inputs).forEach(key => {
        inputs[key].addEventListener("input", () => {
            validate[key]();
            if (key === 'pass') validate.conf(); 
        });
    });

    form.addEventListener("submit", function(e) {
        e.preventDefault();
        const isValid = validate.name() && validate.phone() && validate.addr() && validate.pass() && validate.conf();

        if (isValid) {
            const formData = new URLSearchParams(new FormData(this));
            fetch("ProfileServlet", {
                method: "POST",
                body: formData
            })
            .then(res => res.text())
            .then(data => {
                if (data.includes("Updated")) {
                    Swal.fire({
                        title: "Changes Saved!",
                        text: "Your profile has been updated successfully.",
                        icon: "success",
                        confirmButtonColor: "#1e293b"
                    }).then(() => { window.location.href = "customer-dashboard.jsp"; });
                } else {
                    Swal.fire("Update Failed!", "System error occurred.", "error");
                }
            })
            .catch(() => Swal.fire("Error", "Server connection failed.", "error"));
        }
    });
</script>
</body>
</html>