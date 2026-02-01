<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>EliteDrive | Bespoke Luxury Car Rental & Concierge
	Services</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" type="image/png"
	href="https://cdn4.iconfinder.com/data/icons/filled-outline-car/64/car-front-view-vehicle-automobile-1024.png">
<link
	href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
:root {
	--primary: #2563eb;
	--secondary: #38bdf8;
	--dark: #0f172a;
	--light-bg: #f8fafc;
	--glass: rgba(255, 255, 255, 0.95);
	--transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
}

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Poppins', sans-serif;
}

html {
	scroll-behavior: smooth;
}

body {
	font-family: 'Poppins', sans-serif;
	color: #334155;
	line-height: 1.6;
	background: var(--light-bg);
}

/* PRELOADER */
#preloader {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: #fff;
	z-index: 9999;
	display: flex;
	justify-content: center;
	align-items: center;
}

.loader {
	width: 50px;
	height: 50px;
	border: 5px solid #f3f3f3;
	border-top: 5px solid var(--primary);
	border-radius: 50%;
	animation: spin 1s linear infinite;
}

@
keyframes spin { 0% {
	transform: rotate(0deg);
}

100












%
{
transform












:












rotate










(












360deg












)










;
}
}

/* NAVIGATION */
header {
	position: sticky;
	top: 0;
	z-index: 1000;
	background: var(--glass);
	backdrop-filter: blur(10px);
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 15px 8%;
	box-shadow: 0 2px 20px rgba(0, 0, 0, 0.05);
}

nav a {
	text-decoration: none;
	color: var(--dark);
	font-weight: 500;
	padding: 8px 15px;
	transition: var(--transition);
	border-radius: 5px;
}

nav a:hover:not(.btn-register) {
	color: var(--primary);
	background: rgba(37, 99, 235, 0.1);
}

/* HERO SECTION */
.hero {
	background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)),
		url('https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?q=80&w=2070&auto=format&fit=crop')
		center/cover no-repeat;
	height: 90vh;
	display: flex;
	align-items: center;
	justify-content: center;
	text-align: center;
	color: #fff;
}

.hero h1 {
	font-size: 65px;
	font-weight: 800;
	letter-spacing: -1px;
	line-height: 1.1;
	margin-bottom: 20px;
}

.hero p {
	font-size: 20px;
	margin-bottom: 40px;
	font-weight: 300;
	max-width: 800px;
	margin-left: auto;
	margin-right: auto;
}

/* BUTTONS - HOVER REMOVED, CLICK EFFECT ADDED */
.rent-btn {
	display: inline-block;
	background: var(--primary);
	color: #fff !important;
	padding: 15px 40px;
	border-radius: 50px;
	text-decoration: none;
	font-weight: 600;
	transition: transform 0.1s ease, box-shadow 0.1s ease;
	border: none;
	cursor: pointer;
}

/* Removed hover:transform and hover:shadow */
.rent-btn:hover {
	background: #1d4ed8;
}

/* Show effect only when clicked */
.rent-btn:active {
	transform: translateY(3px);
	box-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.2);
}

/* ABOUT SECTION */
#about {
	padding: 100px 8%;
	background: #fff;
}

#about h4 {
	color: var(--primary);
	font-weight: 700;
	text-transform: uppercase;
	letter-spacing: 2px;
}

#about h2 {
	font-size: 42px;
	color: var(--dark);
	margin: 20px 0;
	line-height: 1.2;
}

.about-grid {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 60px;
	align-items: center;
}

.feature-list {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 15px;
	margin-top: 30px;
}

.feature-list p {
	font-size: 15px;
	font-weight: 500;
}

.feature-list i {
	color: var(--primary);
	margin-right: 10px;
}

#about img {
	width: 100%;
	border-radius: 20px;
	box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
}

/* FLEET SECTION */
#fleet {
	padding: 100px 8%;
	background: #f8fafc;
}

#fleet h2 {
	font-size: 42px;
	font-weight: 700;
	color: #0f172a;
	text-align: center;
	margin-bottom: 20px;
}

.underline {
	width: 80px;
	height: 5px;
	background: var(--primary);
	margin: 0 auto 40px;
	border-radius: 10px;
}

.car-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
	gap: 30px;
}

.car-card {
	position: relative;
	border-radius: 20px;
	overflow: hidden;
	height: 400px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
	background: #000;
}

.car-card img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	opacity: 0.9;
	transition: var(--transition);
}

.car-overlay {
	position: absolute;
	inset: 0;
	padding: 40px 30px;
	background: linear-gradient(to top, rgba(15, 23, 42, 0.95), transparent);
	color: #fff;
	display: flex;
	flex-direction: column;
	justify-content: flex-end;
	opacity: 0;
	transition: var(--transition);
}

.car-card:hover .car-overlay {
	opacity: 1;
}

.car-overlay h3 {
	font-size: 26px;
	margin-bottom: 15px;
	transform: translateY(20px);
	transition: 0.5s;
}

.car-overlay p {
	font-size: 15px;
	line-height: 1.6;
	transform: translateY(20px);
	transition: 0.6s;
}

.car-card:hover h3, .car-card:hover p {
	transform: translateY(0);
}

/* SERVICES SECTION */
#services {
	padding: 100px 8%;
	text-align: center;
}

.services-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
	gap: 30px;
}

.service-card {
	background: #fff;
	padding: 50px 30px;
	border-radius: 20px;
	border: 2px solid transparent;
	transition: var(--transition);
}

.service-card:hover {
	border-color: var(--primary);
	box-shadow: 0 15px 30px rgba(37, 99, 235, 0.1);
	transform: translateY(-5px);
}

.service-card i {
	font-size: 45px;
	color: var(--primary);
	margin-bottom: 25px;
}

/* CONTACT SECTION */
.contact-section {
	padding: 100px 8%;
	background: #fff;
}

.contact-container {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 80px;
}

.contact-info p {
	margin-bottom: 12px;
	font-size: 15px;
}

.contact-info strong {
	color: var(--dark);
	font-weight: 600;
}

.contact-form {
	background: #f8fafc;
	padding: 40px;
	border-radius: 20px;
	width: 100%;
}

.form-group {
	margin-bottom: 20px;
	position: relative;
}

.form-group label {
	display: block;
	margin-bottom: 8px;
	font-weight: 600;
	font-size: 14px;
	color: #0f172a;
}

.form-group input, .form-group textarea {
	width: 100%;
	padding: 14px;
	border: 1px solid #e2e8f0;
	border-radius: 10px;
	outline: none;
	transition: all 0.3s ease;
}

.form-group input.invalid, .form-group textarea.invalid {
	border: 1px solid #ef4444 !important;
	background-color: #fff1f2 !important;
}

.error-msg {
	color: #ef4444;
	font-size: 12px;
	margin-top: 5px;
	display: none;
	font-weight: 500;
}

/* FOOTER */
footer {
	background: var(--dark);
	color: #94a3b8;
	padding: 80px 8% 40px;
}

.footer-grid {
	display: grid;
	grid-template-columns: 2fr 1fr 1fr 1.5fr;
	gap: 40px;
	margin-bottom: 50px;
}

.footer-col h4 {
	color: #fff;
	margin-bottom: 25px;
	font-size: 18px;
	border-left: 3px solid var(--primary);
	padding-left: 15px;
}

.footer-col ul {
	list-style: none;
}

.footer-col ul li {
	margin-bottom: 12px;
}

.footer-col ul li a {
	color: #94a3b8;
	text-decoration: none;
	transition: 0.3s;
	font-size: 14px;
}

.footer-col ul li a:hover {
	color: #fff;
	padding-left: 8px;
}

@media ( max-width : 992px) {
	.about-grid, .contact-container, .footer-grid {
		grid-template-columns: 1fr;
	}
	.hero h1 {
		font-size: 45px;
	}
}
</style>
</head>

<body
	onload="document.getElementById('preloader').style.display='none';">

	<div id="preloader">
		<div class="loader"></div>
	</div>

	<header>
		<a href="#"
			style="text-decoration: none; font-size: 28px; font-weight: 800; color: var(--dark);">Elite<span
			style="color: var(--primary)">Drive</span></a>
		<nav>
			<a href="#home">Home</a> <a href="#about">About</a> <a href="#fleet">Fleet</a>
			<a href="#services">Services</a> <a href="#contact">Contact</a> <a
				href="customer-login.jsp"
				style="border: 2px solid var(--primary); color: var(--primary); margin-left: 10px;">Sign
				In</a> <a href="customer-register.jsp" class="btn-register"
				style="background: var(--primary); color: white;">Join Now</a>
		</nav>
	</header>

	<section class="hero" id="home">
		<div class="hero-content">
			<h1>BESPOKE AUTOMOTIVE EXCELLENCE.</h1>
			<p>Experience the pinnacle of engineering and prestige. We offer
				an unparalleled selection of world-class vehicles for those who
				demand nothing less than perfection.</p>
			<a href="#fleet" class="rent-btn">Explore the Collection</a>
		</div>
	</section>

	<section id="about">
		<div class="about-grid">
			<div>
				<h4>Experience the Legacy</h4>
				<h2>Redefining Premium Mobility Since 2012</h2>
				<p>EliteDrive stands as the global leader in luxury automotive
					rentals. Our mission is to bridge the gap between aspirational
					dreams and driving reality. We curate the world's most exclusive
					fleet, providing seamless access to engineering masterpieces.</p>
				<p>Whether you require a track-ready supercar for a weekend in
					the Alps or an armored executive SUV for high-stakes diplomacy, our
					logistics network ensures your vehicle is delivered with
					white-glove precision.</p>

				<div class="feature-list">
					<p>
						<i class="fa-solid fa-circle-check"></i> 24/7 VIP Concierge
						Support
					</p>
					<p>
						<i class="fa-solid fa-circle-check"></i> Global Comprehensive
						Insurance
					</p>
					<p>
						<i class="fa-solid fa-circle-check"></i> Multilingual Professional
						Chauffeurs
					</p>
					<p>
						<i class="fa-solid fa-circle-check"></i> Bespoke Track & Race Prep
					</p>
					<p>
						<i class="fa-solid fa-circle-check"></i> Cross-Border Delivery
						Service
					</p>
					<p>
						<i class="fa-solid fa-circle-check"></i> Armored VR7/VR9 Vehicle
						Fleet
					</p>
				</div>
			</div>
			<div>
				<img
					src="https://images.unsplash.com/photo-1621135802920-133df287f89c?q=80&w=2070&auto=format&fit=crop"
					alt="Elite Supercar">
			</div>
		</div>
	</section>

	<section id="fleet">
		<h2>Masterpiece Collection</h2>
		<div class="underline"></div>
		<div class="car-grid">
			<div class="car-card">
				<img
					src="https://images.unsplash.com/photo-1614162692292-7ac56d7f7f1e?auto=format&fit=crop&w=800&q=80">
				<div class="car-overlay">
					<h3>Porsche 911 Turbo S</h3>
					<p>The 911 Turbo S is the quintessential daily supercar.
						Featuring a twin-turbocharged flat-six engine producing 640 HP, it
						achieves 0-60 in just 2.6 seconds with unrivaled German precision.</p>
				</div>
			</div>
			<div class="car-card">
				<img
					src="https://images.unsplash.com/photo-1583121274602-3e2820c69888?auto=format&fit=crop&w=800&q=80">
				<div class="car-overlay">
					<h3>Ferrari F8 Tributo</h3>
					<p>A tribute to the most powerful V8 in Ferrari history. The F8
						Tributo offers lightning-fast responsiveness and soul-stirring
						acoustics, delivering 710 HP of pure Italian adrenaline to the
						rear wheels.</p>
				</div>
			</div>
			<div class="car-card">
				<img
					src="https://images.unsplash.com/photo-1544636331-e26879cd4d9b?auto=format&fit=crop&w=800&q=80">
				<div class="car-overlay">
					<h3>Lamborghini Huracán</h3>
					<p>The Huracán EVO redefines aerodynamic efficiency. With its
						naturally aspirated V10 engine, it provides a visceral driving
						experience that stimulates every sense, finished in breathtaking
						Arancio Xanto.</p>
				</div>
			</div>
		</div>
	</section>

	<section id="services">
		<h2>Exclusive Services</h2>
		<div class="underline"></div>
		<div class="services-grid">
			<div class="service-card">
				<i class="fa-solid fa-user-tie"></i>
				<h3>Elite Chauffeur</h3>
				<p>Security-cleared multilingual drivers.</p>
			</div>
			<div class="service-card">
				<i class="fa-solid fa-plane-arrival"></i>
				<h3>Airport Concierge</h3>
				<p>VIP tarmac pickup and logistics.</p>
			</div>
			<div class="service-card">
				<i class="fa-solid fa-shield-halved"></i>
				<h3>Security Details</h3>
				<p>Armored vehicle protection (VR7/VR9).</p>
			</div>
			<div class="service-card">
				<i class="fa-solid fa-calendar-check"></i>
				<h3>Events & Media</h3>
				<p>Logistics for weddings and film shoots.</p>
			</div>
			<div class="service-card">
				<i class="fa-solid fa-road"></i>
				<h3>Track Days</h3>
				<p>High-performance racing preparation.</p>
			</div>
			<div class="service-card">
				<i class="fa-solid fa-truck-ramp-box"></i>
				<h3>Global Delivery</h3>
				<p>Enclosed delivery to your doorstep.</p>
			</div>
			<div class="service-card">
				<i class="fa-solid fa-key"></i>
				<h3>Membership</h3>
				<p>Exclusive access to limited models.</p>
			</div>
			<div class="service-card">
				<i class="fa-solid fa-helicopter"></i>
				<h3>Sky Access</h3>
				<p>Private jet and helicopter charters.</p>
			</div>
		</div>
	</section>

	<section id="contact" class="contact-section">
		<div class="contact-container">
			<div class="contact-info">
				<h4>Consult with Experts</h4>
				<h2 style="margin-bottom: 15px;">Secure Your Reservation</h2>
				<p style="margin-bottom: 25px;">Our dedicated VIP concierge team
					is standing by to customize your driving experience. From color
					preferences to route planning, we handle every detail.</p>
				<div style="margin-top: 10px;">
					<p>
						<i class="fa-solid fa-phone"
							style="color: var(--primary); width: 25px;"></i> <strong>Direct
							Line:</strong> +91 98765 43210
					</p>
					<p>
						<i class="fa-solid fa-envelope"
							style="color: var(--primary); width: 25px;"></i> <strong>Reservations:</strong>
						bookings@elitedrive.com
					</p>
					<p>
						<i class="fa-solid fa-location-dot"
							style="color: var(--primary); width: 25px;"></i> <strong>Flagship:</strong>
						Luxury Hub, BKC, Mumbai, MH 400051
					</p>
					<p>
						<i class="fa-solid fa-clock"
							style="color: var(--primary); width: 25px;"></i> <strong>Operating
							Hours:</strong> 24/7 Global Concierge
					</p>
					<p>
						<i class="fa-solid fa-earth-americas"
							style="color: var(--primary); width: 25px;"></i> <strong>Offices:</strong>
						London | Dubai | Monaco | Mumbai
					</p>
					<p>
						<i class="fa-solid fa-gem"
							style="color: var(--primary); width: 25px;"></i> <strong>VIP
							Desk:</strong> Priority for Diamond Members
					</p>
				</div>
			</div>
			<div class="contact-form">
				<form id="rentalForm" onsubmit="return validateForm(event)">
					<div class="form-group">
						<label>Full Name</label> <input type="text" id="userName"
							placeholder="e.g. Alexander Knight">
						<div id="nameError" class="error-msg">Please enter your full
							name.</div>
					</div>

					<div class="form-group">
						<label>Email Address</label> <input type="email" id="userEmail"
							placeholder="alex@corporate.com">
						<div id="emailError" class="error-msg">Please enter a valid
							email address.</div>
					</div>

					<div class="form-group">
						<label>Preferred Vehicle</label> <input type="text" id="userCar"
							placeholder="e.g. Porsche 911 Turbo S">
						<div id="carError" class="error-msg">Please specify a
							vehicle of interest.</div>
					</div>

					<div class="form-group">
						<label>Message</label>
						<textarea id="userMsg" rows="4"
							placeholder="Special requirements..."></textarea>
						<div id="msgError" class="error-msg">Please mention your
							special requirements.</div>
					</div>

					<button type="submit" class="rent-btn"
						style="width: 100%; display: block;">Initialize
						Consultation</button>
				</form>
			</div>
		</div>
	</section>

	<footer>
		<div class="footer-grid">
			<div class="footer-col">
				<a href="#"
					style="text-decoration: none; font-size: 26px; font-weight: 800; color: #fff;">Elite<span
					style="color: var(--primary)">Drive</span></a>
				<p style="margin-top: 20px; font-size: 14px; line-height: 1.8;">The
					global authority in luxury automotive experiences. Operating in 45
					countries, we provide bespoke mobility solutions to the world's
					most discerning clientele.</p>
				<div style="display: flex; gap: 15px; margin-top: 25px;">
					<a href="#" style="color: #fff; font-size: 20px;"><i
						class="fa-brands fa-facebook"></i></a> <a href="#"
						style="color: #fff; font-size: 20px;"><i
						class="fa-brands fa-instagram"></i></a> <a href="#"
						style="color: #fff; font-size: 20px;"><i
						class="fa-brands fa-x-twitter"></i></a> <a href="#"
						style="color: #fff; font-size: 20px;"><i
						class="fa-brands fa-linkedin"></i></a>
				</div>
			</div>
			<div class="footer-col">
				<h4>Company</h4>
				<ul>
					<li><a href="#about">About Us</a></li>
					<li><a href="#">Our Heritage</a></li>
					<li><a href="#">Global Locations</a></li>
					<li><a href="#">Sustainability</a></li>
					<li><a href="#">Newsroom</a></li>
				</ul>
			</div>
			<div class="footer-col">
				<h4>Services</h4>
				<ul>
					<li><a href="#">Long Term Rental</a></li>
					<li><a href="#">Corporate Accounts</a></li>
					<li><a href="#">Chauffeur Service</a></li>
					<li><a href="#">Armored Transport</a></li>
					<li><a href="#">Luxury Gift Vouchers</a></li>
				</ul>
			</div>
			<div class="footer-col">
				<h4>Support</h4>
				<ul>
					<li><a href="#">Help Center</a></li>
					<li><a href="#">Privacy Policy</a></li>
					<li><a href="#">Terms of Service</a></li>
					<li><a href="#">Rental Agreement</a></li>
					<li><a href="#">Contact Us</a></li>
				</ul>
			</div>
		</div>
		<div
			style="border-top: 1px solid rgba(255, 255, 255, 0.1); padding-top: 30px; text-align: center; font-size: 13px;">
			<p>&copy; 2026 EliteDrive Global S.A. All Rights Reserved.
				Crafted for excellence.</p>
		</div>
	</footer>

	<script>
	document.addEventListener('DOMContentLoaded', () => {
	    const form = document.getElementById('rentalForm');

	    const fields = [
	        { id: 'userName', errorId: 'nameError' },
	        { id: 'userEmail', errorId: 'emailError', isEmail: true },
	        { id: 'userCar', errorId: 'carError' },
	        { id: 'userMsg', errorId: 'msgError' }
	    ];

	    fields.forEach(field => {
	        const input = document.getElementById(field.id);
	        if (input) {
	            input.addEventListener('input', () => {
	                validateSingleField(field);
	            });
	        }
	    });

	    function validateSingleField(field) {
	        const input = document.getElementById(field.id);
	        const errorDiv = document.getElementById(field.errorId);
	        const value = input.value.trim();
	        let isFieldValid = value !== "";

	        if (isFieldValid && field.isEmail) {
	            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
	            isFieldValid = emailRegex.test(value);
	        }

	        if (!isFieldValid) {
	            input.classList.add('invalid');
	            errorDiv.style.display = 'block';
	        } else {
	            input.classList.remove('invalid');
	            errorDiv.style.display = 'none';
	        }
	        return isFieldValid;
	    }

	    form.addEventListener('submit', function(event) {
	        event.preventDefault(); 
	        
	        let isFormValid = true;
	        fields.forEach(field => {
	            if (!validateSingleField(field)) isFormValid = false;
	        });

	        if (isFormValid) {
	            if (typeof Swal !== 'undefined') {
	                Swal.fire({
	                    title: 'Processing...',
	                    text: 'Contacting our concierge team',
	                    allowOutsideClick: false,
	                    didOpen: () => { Swal.showLoading(); }
	                });
	            }

	            // 2. Format data for the Servlet (matches request.getParameter in Java)
	            const formData = new URLSearchParams();
	            formData.append('userName', document.getElementById('userName').value);
	            formData.append('userEmail', document.getElementById('userEmail').value);
	            formData.append('userCar', document.getElementById('userCar').value);
	            formData.append('userMsg', document.getElementById('userMsg').value);

	            fetch('ContactServlet', { 
	                method: 'POST',
	                headers: {
	                    'Content-Type': 'application/x-www-form-urlencoded'
	                },
	                body: formData.toString()
	            })
	            .then(response => {
	                if (!response.ok) throw new Error('Network response was not ok');
	                return response.text();
	            })
	            .then(responseText => {
	                if (responseText.trim().includes("SUCCESS")) {
	                    Swal.fire({
	                        icon: 'success',
	                        title: 'Success!',
	                        text: 'Your request has been saved.',
	                        confirmButtonColor: "#1e293b"
	                    });
	                    form.reset();
	                } else {
	                    throw new Error(responseText);
	                }
	            })
	            .catch(error => {
	                console.error('Submission error:', error);
	                Swal.fire({
	                    icon: 'error',
	                    title: 'Submission Failed',
	                    text: 'Could not connect to the server. Please check your connection.',
	                    confirmButtonColor: "#1e293b"
	                });
	            });
	        }
	    });
	});
	</script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

	<script src="script.js"></script>
</body>
</html>