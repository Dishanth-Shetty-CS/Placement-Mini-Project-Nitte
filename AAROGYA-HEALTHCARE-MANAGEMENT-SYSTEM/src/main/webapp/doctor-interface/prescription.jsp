<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="org.mindrot.jbcrypt.BCrypt"%>


<h3 style="margin-top: 0;">Prescription Form</h3>


<form method="post" class="add-form"
	onsubmit="return submitPrescriptionForm(event)">

	<div class="input-container">
		<div class="col-div-register">
			<div class="register-input">
				<i class="fa-solid fa-calendar-check"
					style="padding: 9px; padding-left: 13px; padding-right: 13px;"></i>
				<input type="number" id="appt_id" name="appt_id"
					placeholder="Appointment ID" required>
			</div>

			<div class="register-input">
				<i class="fa-solid fa-stethoscope"></i> <input type="text"
					id="diagnosis" name="diagnosis" placeholder="Diagnosis" required>
			</div>

			<div class="register-input">
				<i class="fa-regular fa-calendar-days"></i> <input type="number"
					id="refill_amount" name="refill_amount" placeholder="Refill Amount"
					required>
			</div>

		</div>

		<div class="col-div-register">
			<div class="register-input">
				<i class="fa-solid fa-capsules"></i>
				<textarea id="medication_info" name="medication_info"
					placeholder="Medication Info" required></textarea>
			</div>

			<div class="register-input">
				<i class="fa-solid fa-file-lines"
					style="padding: 10px; padding-left: 14px; padding-right: 14px;"></i>
				<textarea id="instructions" name="instructions"
					placeholder="Instructions" required></textarea>
			</div>
		</div>

	</div>

	<div class="input-container">
		<div class="row-div-button">
			<button type="submit">Save</button>
		</div>
	</div>

</form>

<%
Connection con = null;
PreparedStatement pt = null;
Statement st = null;
ResultSet rs = null;

String appt_id = request.getParameter("appt_id");
String diagnosis = request.getParameter("diagnosis");
String refill_amount = request.getParameter("refill_amount");
String medication_info = request.getParameter("medication_info");
String instructions = request.getParameter("instructions");

if (appt_id != null) {
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aarogya_healthcare_db", "root", "trickortreat");
		st = con.createStatement();

		String getPatientEmail = "SELECT registered_doctors_email_address, registered_users_email_address FROM appointment_records WHERE appointment_id = \""
		+ appt_id + "\"";
		rs = st.executeQuery(getPatientEmail);
		rs.next();
		String registered_doctors_email_address = rs.getString(1);
		String registered_users_email_address = rs.getString(2);

		pt = con.prepareStatement(
		"INSERT INTO prescription (date, time, diagnosis, medication_info, refill, instructions, appointment_records_appointment_id, registered_doctors_email_address, registered_users_email_address) VALUES (CURDATE(), CURTIME(), ?, ?, ?, ?, ?, ?, ?)");

		pt.setString(1, diagnosis.trim());
		pt.setString(2, medication_info.trim());
		pt.setInt(3, Integer.parseInt(refill_amount));
		pt.setString(4, instructions.trim());
		pt.setInt(5, Integer.parseInt(appt_id));
		pt.setString(6, registered_doctors_email_address);
		pt.setString(7, registered_users_email_address);

		pt.executeUpdate();

		con.close();
	} catch (Exception e) {
		e.printStackTrace();
	}
}
%>