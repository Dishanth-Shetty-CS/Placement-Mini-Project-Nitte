<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*"%>
<%
String customerEmail = (String) session.getAttribute("customerEmail");
if (customerEmail == null) {
	response.sendRedirect("customer-login.jsp");
	return;
}

String rentalId = request.getParameter("rentalId");
double totalPrice = 0.0;
String carReg = "N/A";

try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_db", "root", "trickortreat");
	String sql = "SELECT Total_Car_Price, Car_Regno FROM RENTAL WHERE Rental_ID = ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, rentalId);
	ResultSet rs = stmt.executeQuery();
	if (rs.next()) {
		totalPrice = rs.getDouble("Total_Car_Price");
		carReg = rs.getString("Car_Regno");
	}
	conn.close();
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
<title>Secure Checkout | EliteDrive</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
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

.payment-card {
	background: #ffffff;
	border-radius: 16px;
	box-shadow: 0 25px 50px -12px rgba(30, 41, 59, 0.25);
	overflow: hidden;
	border-top: 6px solid #1e293b;
}

.payment-header {
	background-color: #1e293b;
	color: white;
	padding: 20px;
	text-align: center;
}

.payment-header h2 {
	margin: 0;
	font-weight: 800;
	letter-spacing: 1.5px;
	text-transform: uppercase;
	font-size: 1.4rem;
}

.order-summary {
	background: #f8fafc;
	padding: 20px;
	border-bottom: 2px dashed #cbd5e1;
}

.summary-item {
	display: flex;
	justify-content: space-between;
	margin-bottom: 8px;
	font-size: 0.9rem;
	color: #475569;
}

.total-amount {
	display: flex;
	justify-content: space-between;
	margin-top: 12px;
	padding-top: 12px;
	border-top: 1px solid #cbd5e1;
	font-size: 1.25rem;
	font-weight: 700;
	color: #1e88e5;
}

.payment-body {
	padding: 30px;
}

.form-label {
	font-weight: 700;
	color: #475569;
	font-size: 0.75rem;
	text-transform: uppercase;
	margin-bottom: 8px;
	letter-spacing: 0.5px;
}

.form-select {
	border: 2px solid #e2e8f0;
	border-radius: 10px;
	padding: 12px;
	font-size: 0.95rem;
	transition: all 0.3s;
}

.form-select:focus {
	border-color: #1e88e5;
	box-shadow: 0 0 0 4px rgba(30, 136, 229, 0.1);
	outline: none;
}

.btn-pay {
	background-color: #1e293b;
	color: white;
	border: none;
	padding: 15px;
	border-radius: 10px;
	font-weight: 700;
	width: 100%;
	text-transform: uppercase;
	letter-spacing: 1px;
	transition: 0.3s;
	margin-top: 10px;
}

.btn-pay:hover {
	background-color: #334155;
	transform: translateY(-2px);
	box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
}

.error-text {
	color: #ef4444;
	font-size: 0.7rem;
	margin-top: 5px;
	font-weight: 500;
	display: none;
}

.input-error {
	border-color: #ef4444 !important;
}
</style>
</head>
<body>

	<div class="main-wrapper">
		<div class="top-nav-bar">
			<a href="available-cars.jsp" class="back-link"> <i
				class="fas fa-arrow-left"></i> Back to Fleet
			</a>
			<div class="user-status">
				<i class="fas fa-user-circle me-1"></i> Logged in as: <strong><%=customerEmail%></strong>
			</div>
		</div>

		<div class="payment-card">
			<div class="payment-header">
				<h2>
					<i class="fas fa-shield-alt me-2"></i> Secure Checkout
				</h2>
			</div>

			<div class="order-summary">
				<div class="summary-item">
					<span><i class="fas fa-hashtag me-2"></i>Booking Reference:</span>
					<strong><%=rentalId%></strong>
				</div>
				<div class="summary-item">
					<span><i class="fas fa-car me-2"></i>Vehicle Reg:</span> <strong><%=carReg%></strong>
				</div>
				<div class="total-amount">
					<span>Total to Pay:</span> <span>₹<%=String.format("%.2f", totalPrice)%></span>
				</div>
			</div>

			<div class="payment-body">
				<form id="paymentForm">
					<input type="hidden" name="rentalID" value="<%=rentalId%>">
					<input type="hidden" name="amount" value="<%=totalPrice%>">

					<div class="mb-4">
						<label class="form-label">Select Payment Method</label> <select
							name="payMethod" id="payMethod" class="form-select">
							<option value="" disabled selected>Choose a method...</option>
							<option value="Credit Card">Credit/Debit Card</option>
							<option value="UPI">UPI (GPay/PhonePe)</option>
							<option value="Net Banking">Net Banking</option>
							<option value="Cash">Cash on Arrival</option>
						</select>
						<div id="payMethod-error" class="error-text">Please select a
							payment method to proceed.</div>
					</div>

					<button type="submit" class="btn-pay">
						<i class="fas fa-lock me-2"></i> Complete Payment
					</button>
				</form>

				<p class="text-center mt-4 mb-0 text-muted"
					style="font-size: 0.75rem;">
					<i class="fas fa-info-circle me-1"></i> Your transaction is
					encrypted and 100% secure.
				</p>
			</div>
		</div>
	</div>

	<script>
    const paymentForm = document.getElementById("paymentForm");
    const payMethodInput = document.getElementById("payMethod");
    const payMethodError = document.getElementById("payMethod-error");

    function validatePayMethod() {
        if (!payMethodInput.value) {
            payMethodError.style.display = "block";
            payMethodInput.classList.add("input-error");
            return false;
        } else {
            payMethodError.style.display = "none";
            payMethodInput.classList.remove("input-error");
            return true;
        }
    }

    payMethodInput.addEventListener("change", validatePayMethod);

    paymentForm.addEventListener("submit", function(event) {
        event.preventDefault();

        if (validatePayMethod()) {
            const formData = new URLSearchParams(new FormData(this));

            fetch("ProcessPayment", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.status === "success") {
                    Swal.fire({
                        title: "Payment Successful!",
                        text: "Your booking is now confirmed. Enjoy your ride!",
                        icon: "success",
                        confirmButtonColor: "#1e293b"
                    }).then(() => {
                        window.location.href = "customer-dashboard.jsp";
                    });
                } else {
                    Swal.fire({
                        title: "Payment Failed!",
                        text: data.message || "Transaction declined by the server.",
                        icon: "error",
                        confirmButtonColor: "#ef4444"
                    });
                }
            })
            .catch(error => {
                Swal.fire("System Error", "Connection lost. Please check your internet.", "error");
            });
        }
    });
</script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>