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
<title>Available Cars | EliteDrive</title>

<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
	color: #1e293b;
}

.rentals-container {
	background: #fff;
	padding: 30px;
	border-radius: 12px;
	box-shadow: 5px 5px 20px rgba(0, 0, 0, 0.1);
	text-align: left;
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
}

table td {
	padding: 12px 15px;
	text-align: left;
	vertical-align: middle;
	border: 1px solid #cfd8dc;
	font-size: 0.95em;
	color: #1e293b;
}

table tbody tr:nth-child(even) {
	background-color: #f9f9f9;
}

table tbody tr:hover {
	background-color: #f0f8ff;
}

.status-badge {
	border: 2px solid #28a745;
	color: #28a745 !important;
	background-color: #f4fff6;
	padding: 6px 0;
	width: 140px;
	border-radius: 4px;
	font-size: 0.8em;
	font-weight: 700;
	display: inline-block;
	text-transform: uppercase;
}

.color-indicator {
	display: inline-block;
	width: 14px;
	height: 14px;
	border-radius: 50%;
	margin-right: 8px;
	border: 1px solid #cbd5e1;
	vertical-align: middle;
}

.rent-btn {
	background-color: #1e293b;
	color: white;
	border: none;
	padding: 8px 18px;
	border-radius: 8px;
	cursor: pointer;
	transition: all 0.3s ease;
	font-weight: 500;
}

.rent-btn:hover {
	background-color: #334155;
	transform: translateY(-1px);
}

.modal-header {
	background-color: #1e293b;
	color: white;
	border-top-left-radius: 10px;
	border-top-right-radius: 10px;
}

.modal-title {
	text-transform: uppercase;
	font-weight: 700;
}

.form-label {
	font-weight: 600;
	color: #1e293b;
}

.error-text {
	color: #ef4444;
	font-size: 0.75rem;
	font-weight: 500;
	margin-top: 5px;
	min-height: 18px;
	display: none;
}

.input-error {
	border: 2px solid #b91c1c !important;
	box-shadow: 0 0 0 1px rgba(185, 28, 28, 0.1) !important;
}

.reg-text {
	color: #1e293b;
	font-weight: 700;
	font-family: monospace;
	font-size: 1.1em;
}

.pricing-box {
	background: #f8fafc;
	border: 1px solid #e2e8f0;
	border-radius: 8px;
	padding: 12px;
	margin-top: 15px;
}

.pricing-row {
	display: flex;
	justify-content: space-between;
	margin-bottom: 5px;
	font-size: 0.9rem;
}

.empty-msg {
	padding: 40px !important;
	font-size: 1.2rem;
	color: #64748b;
	font-weight: 500;
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
			<h3>Available Fleet Dashboard</h3>
		</div>

		<table>
			<thead>
				<tr>
					<th><i class="fas fa-hashtag me-1"></i>Car Reg No</th>
					<th><i class="fas fa-car-alt me-1"></i>Car Model</th>
					<th><i class="fas fa-calendar-alt me-1"></i>Car Year</th>
					<th><i class="fas fa-paint-brush me-1"></i>Car Color</th>
					<th><i class="fas fa-wallet me-2"></i>Car Price (&#8377;/Hr)</th>
					<th class="text-center"><i class="fas fa-info-circle me-1"></i>Car
						Status</th>
					<th><i class="fas fa-clock me-1"></i>Created At</th>
					<th><i class="fas fa-handshake me-1"></i>Action</th>
				</tr>
			</thead>
			<tbody>
				<%
				try {
					Class.forName("com.mysql.cj.jdbc.Driver");
					Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_db", "root", "trickortreat");
					String sql = "SELECT * FROM CAR WHERE Car_Status = 'Available'";
					PreparedStatement stmt = conn.prepareStatement(sql);
					ResultSet rs = stmt.executeQuery();
					boolean hasRows = false;
					while (rs.next()) {
						hasRows = true;
						double hourlyPrice = rs.getDouble("Car_Price");
				%>
				<tr>
					<td><span class="reg-text"><%=rs.getString("Car_Regno")%></span></td>
					<td><%=rs.getString("Car_Model")%></td>
					<td><%=rs.getInt("Car_Year")%></td>
					<td><span class="color-indicator"
						style="background-color: <%=rs.getString("Car_Color")%>;"></span>
						<%=rs.getString("Car_Color")%></td>
					<td><strong>₹<%=hourlyPrice%></strong></td>
					<td class="text-center"><span class="status-badge">Available</span></td>
					<td><%=rs.getTimestamp("Created_At")%></td>
					<td>
						<button class="rent-btn"
							onclick="openModal('<%=rs.getString("Car_Regno")%>', this, <%=hourlyPrice%>)">
							<i class="fas fa-key me-1"></i> Rent Now
						</button>
					</td>
				</tr>
				<%
				}
				if (!hasRows) {
				%>
				<tr>
					<td colspan="8" class="empty-msg text-center py-5"><i
						class="fas fa-car-side me-2"></i> No cars are currently available
						for rent.</td>
				</tr>
				<%
				}
				conn.close();
				} catch (Exception e) {
				%>
				<tr>
					<td colspan="8" class="empty-msg text-danger text-center"><i
						class="fas fa-exclamation-circle me-2"></i> Unable to load the
						fleet. Please try again later.</td>
				</tr>
				<%
				e.printStackTrace();
				}
				%>
			</tbody>
		</table>
	</div>

	<div class="modal fade" id="rentModal" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">
						<i class="fas fa-handshake me-2"></i>Rent This Car
					</h5>
					<button type="button" class="btn-close btn-close-white"
						data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body p-4">
					<form id="rentalForm">
						<input type="hidden" name="carRegno" id="modalCarRegno"> <input
							type="hidden" name="totalCarPrice" id="totalCarPrice"> <input
							type="hidden" id="hourlyRate">

						<div class="mb-3">
							<label class="form-label">Rental Name / Type</label> <select
								name="rentalName" id="rentalName" class="form-select">
								<option value="" disabled selected>Select Rental Type</option>
								<option value="Personal Trip">Personal Trip</option>
								<option value="Business Lease">Business Lease</option>
								<option value="Corporate Rental">Corporate Rental</option>
								<option value="VIP Service">VIP Service</option>
								<option value="Weekend Getaway">Weekend Getaway</option>
								<option value="Wedding Event">Wedding / Special Event</option>
								<option value="Airport Transfer">Airport Transfer
									Service</option>
								<option value="Executive Travel">Executive Travel</option>
								<option value="Family Vacation">Family Vacation</option>
								<option value="Photo Shoot">Photo / Video Shoot</option>
								<option value="Self-Drive Tour">Self-Drive Tour</option>
								<option value="Monthly Subscription">Monthly
									Subscription</option>
							</select>
							<div class="error-text" id="error-rentalName">Please select
								a rental type.</div>
						</div>
						<div class="mb-3">
							<label class="form-label">Start Date</label> <input type="date"
								id="rentStartDate" name="rentStartDate" class="form-control">
							<div class="error-text" id="error-rentStartDate">Please
								select a valid start date.</div>
						</div>
						<div class="mb-3">
							<label class="form-label">End Date</label> <input type="date"
								id="rentEndDate" name="rentEndDate" class="form-control">
							<div class="error-text" id="error-rentEndDate">End date
								must be after start date.</div>
						</div>

						<div class="pricing-box">
							<div class="pricing-row">
								<span>Total Days:</span><strong id="displayDays">0 Days</strong>
							</div>
							<div class="pricing-row">
								<span>Total Price:</span><strong id="displayPrice"
									class="text-primary">₹0.00</strong>
							</div>
						</div>

						<button type="submit" class="btn w-100 mt-3"
							style="background-color: #1e293b; color: white; font-weight: 700; padding: 12px; text-transform: uppercase;">
							Confirm Booking</button>
					</form>
				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script>
    const myModal = new bootstrap.Modal(document.getElementById('rentModal'));
    const startDateInput = document.getElementById('rentStartDate');
    const endDateInput = document.getElementById('rentEndDate');
    const rentalType = document.getElementById('rentalName');
    const rentalForm = document.getElementById('rentalForm');
    let currentActiveBtn = null;

    const today = new Date().toISOString().split('T')[0];
    const displayDate = new Date().toLocaleDateString('en-US', { month: '2-digit', day: '2-digit', year: 'numeric' });

    function calculatePrice() {
        const start = new Date(startDateInput.value);
        const end = new Date(endDateInput.value);
        const hourlyRate = parseFloat(document.getElementById('hourlyRate').value);
        
        if (startDateInput.value && endDateInput.value && end > start) {
            const days = Math.ceil(Math.abs(end - start) / (1000 * 60 * 60 * 24));
            const total = days * 24 * hourlyRate;
            document.getElementById('displayDays').innerText = days + " Days";
            document.getElementById('displayPrice').innerText = "₹" + total.toLocaleString();
            document.getElementById('totalCarPrice').value = total;
        } else {
            document.getElementById('displayDays').innerText = "0 Days";
            document.getElementById('displayPrice').innerText = "₹0.00";
            document.getElementById('totalCarPrice').value = "";
        }
    }

    function showError(input, errorId, message) {
        input.classList.add('input-error');
        const errEl = document.getElementById(errorId);
        errEl.innerText = message;
        errEl.style.display = 'block';
    }

    function clearError(input, errorId) {
        input.classList.remove('input-error');
        document.getElementById(errorId).style.display = 'none';
    }

    function validateType() { 
        if (!rentalType.value) { 
            showError(rentalType, 'error-rentalName', "Please select a rental type."); 
            return false; 
        }
        clearError(rentalType, 'error-rentalName'); 
        return true;
    }

    function validateStart() {
        const val = startDateInput.value;
        if (!val) { 
            showError(startDateInput, 'error-rentStartDate', "Please select a start date."); 
            return false; 
        }
        if (val < today) { 
            showError(startDateInput, 'error-rentStartDate', "Value must be " + displayDate + " or later."); 
            return false; 
        }
        clearError(startDateInput, 'error-rentStartDate'); 
        return true;
    }

    function validateEnd() {
        const startVal = startDateInput.value; 
        const endVal = endDateInput.value;
        if (!endVal) { 
            showError(endDateInput, 'error-rentEndDate', "Please select an end date."); 
            return false; 
        }
        if (endVal < today) { 
            showError(endDateInput, 'error-rentEndDate', "Value must be " + displayDate + " or later."); 
            return false; 
        }
        if (startVal && endVal <= startVal) { 
            showError(endDateInput, 'error-rentEndDate', "End date must be after the start date."); 
            return false; 
        }
        clearError(endDateInput, 'error-rentEndDate'); 
        return true;
    }

    startDateInput.addEventListener('input', () => { validateStart(); if (endDateInput.value) validateEnd(); calculatePrice(); });
    endDateInput.addEventListener('input', () => { validateEnd(); calculatePrice(); });
    rentalType.addEventListener('change', validateType);

    function openModal(regNo, btn, price) {
        currentActiveBtn = btn;
        rentalForm.reset();
        [rentalType, startDateInput, endDateInput].forEach(el => el.classList.remove('input-error'));
        document.querySelectorAll('.error-text').forEach(el => el.style.display = 'none');
        
        document.getElementById('hourlyRate').value = price;
        document.getElementById('modalCarRegno').value = regNo;
        document.getElementById('displayDays').innerText = "0 Days";
        document.getElementById('displayPrice').innerText = "₹0.00";
        myModal.show();
    }

    rentalForm.addEventListener('submit', function(e) {
        e.preventDefault();
        
        const isTypeValid = validateType();
        const isStartValid = validateStart();
        const isEndValid = validateEnd();

        if (isTypeValid && isStartValid && isEndValid) {
            fetch('ProcessRent', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: new URLSearchParams(new FormData(this))
            })
            .then(res => res.json())
            .then(data => {
                if(data.status === 'success') {
                    myModal.hide();
                    if(currentActiveBtn) {
                        const row = currentActiveBtn.closest('tr');
                        row.style.opacity = "0";
                        setTimeout(() => row.remove(), 500);
                    }
                    Swal.fire({
                        title: "Reservation Confirmed!",
                        html: `
                            <div style="text-align: center;">
                                <p>Your vehicle has been successfully reserved.</p>
                                <div style="background: #f1f5f9; padding: 15px; border-radius: 8px; margin: 15px 0; border: 1px solid #cbd5e1;">
                                    <span style="display: block; font-size: 0.85rem; color: #64748b; text-transform: uppercase; font-weight: 600;">Booking Reference</span>
                                    <strong style="font-size: 1.5rem; color: #1e88e5; font-family: monospace;">` + data.rentalId + `</strong>
                                </div>
                                <p style="font-size: 0.9rem; color: #475569;">You are being redirected to the secure payment gateway to finalize your booking.</p>
                            </div>
                        `,
                        icon: "success",
                        confirmButtonText: "Proceed to Payment",
                        confirmButtonColor: "#1e293b",
                        allowOutsideClick: false
                    }).then((result) => {
                        if (result.isConfirmed) {
                            window.location.href = "payments.jsp?rentalId=" + data.rentalId;
                        }
                    });
                } else { 
                    Swal.fire("Error", data.message, "error"); 
                }
            })
            .catch(() => Swal.fire("Error", "Server connection failed.", "error"));
        }
    });
</script>
</body>
</html>