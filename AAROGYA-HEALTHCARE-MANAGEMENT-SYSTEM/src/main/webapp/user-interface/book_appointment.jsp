<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<h3 style="margin-top: 0;">Appointment Booking Form</h3>


<form method="post" class="add-form"
	onsubmit="return submitApptFormData(event)">

	<div class="input-container">
		<div class="col-div-register">
			<div class="register-input">
				<i class="fa-solid fa-calendar-days"></i> <input type="date"
					name="appt_date" required>
			</div>

			<div class="register-input">
				<i class="fa-solid fa-clock" style="padding: 9px;"></i> <input
					type="time" name="appt_time" required>
			</div>

			<div class="register-input register-input-user">
				<i class="fa-solid fa-calendar-check" style="border: none"></i> <select
					name="department-filter" onchange="loadApptsByFilter()"
					id="department-filter" required>
					<option value="">Appointment Type</option>
					<option value="Neurology">Neurology</option>
					<option value="Cardiology">Cardiology</option>
					<option value="Orthopedics">Orthopedics</option>
					<option value="Dermatology">Dermatology</option>
					<option value="Gastroenterology">Gastroenterology</option>
				</select>
			</div>
		</div>

	</div>

	<div class="input-container">
		<div class="row-div-button">
			<button type="submit">Register</button>
		</div>
	</div>

</form>

<%

Connection con = null;
PreparedStatement pt = null;


String appt_date = request.getParameter("appt_date");
String appt_time = request.getParameter("appt_time");
String appt_type = request.getParameter("department-filter");
String registered_users_email_address = request.getParameter("registered_users_email_address");


if (registered_users_email_address != null) {
	try {
		 Class.forName("com.mysql.cj.jdbc.Driver");
	     con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aarogya_healthcare_db","root","trickortreat");	     	    
	     
	     pt = con.prepareStatement("INSERT INTO appointment_records (appointment_date, appointment_time, appointment_type, appointment_status, registered_users_email_address) VALUES (?, ?, ?, \"Awaiting\", ?)");                    
	     pt.setString(1, appt_date);
	     pt.setString(2, appt_time);
	     pt.setString(3, appt_type);
	     pt.setString(4, registered_users_email_address);
	             	        
	     pt.executeUpdate();
	     con.close();
	} catch(Exception e) {            
	     e.printStackTrace();
	} 	
}

%>