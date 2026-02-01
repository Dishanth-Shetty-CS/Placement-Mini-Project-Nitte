<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
Connection con = null;
Statement st = null;
ResultSet rs = null;

int totalAppointments = 0;

String opname = request.getParameter("opname");

try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aarogya_healthcare_db", "root", "trickortreat");

	st = con.createStatement();

	if (opname.equals("filter")) {
		String deptValue = request.getParameter("dept");
		String apptStatusValue = request.getParameter("status");

		String search_user_filter = request.getParameter("search_user_filter");
		String search_doctor_filter = request.getParameter("search_doctor_filter");

		if (search_user_filter != null) {
	search_user_filter = search_user_filter.trim();
		}

		if (search_doctor_filter != null) {
	search_doctor_filter = search_doctor_filter.trim();
		}

		if (search_user_filter == null) {
	search_user_filter = "";
		}

		if (search_doctor_filter == null) {
	search_doctor_filter = "";
		}

		if (deptValue.equals("All Departments") && apptStatusValue.equals("All Status")) {

	if (search_user_filter.length() > 0 && search_doctor_filter.length() > 0) {
		//Gets the count of the total Appointments
		rs = st.executeQuery(
				"SELECT COUNT(*) FROM appointment_records WHERE registered_users_email_address LIKE \""
						+ search_user_filter + "%\" AND registered_doctors_email_address LIKE \""
						+ search_doctor_filter + "%\"");
		rs.next();
		totalAppointments = rs.getInt(1);

		//Gets the Appointment List
		String getAppointmentList = "SELECT * FROM appointment_records WHERE registered_users_email_address LIKE \""
				+ search_user_filter + "%\" AND registered_doctors_email_address LIKE \"" + search_doctor_filter
				+ "%\"";
		rs = st.executeQuery(getAppointmentList);

	} else if (search_user_filter.length() > 0) {
		//Gets the count of the total Appointments
		rs = st.executeQuery(
				"SELECT COUNT(*) FROM appointment_records WHERE registered_users_email_address LIKE \""
						+ search_user_filter + "%\"");
		rs.next();
		totalAppointments = rs.getInt(1);

		//Gets the Appointment List
		String getAppointmentList = "SELECT * FROM appointment_records WHERE registered_users_email_address LIKE \""
				+ search_user_filter + "%\"";
		rs = st.executeQuery(getAppointmentList);

	} else if (search_doctor_filter.length() > 0) {
		//Gets the count of the total Appointments
		rs = st.executeQuery(
				"SELECT COUNT(*) FROM appointment_records WHERE registered_doctors_email_address LIKE \""
						+ search_doctor_filter + "%\"");
		rs.next();
		totalAppointments = rs.getInt(1);

		//Gets the Appointment List
		String getAppointmentList = "SELECT * FROM appointment_records WHERE registered_doctors_email_address LIKE \""
				+ search_doctor_filter + "%\"";
		rs = st.executeQuery(getAppointmentList);

	} else {
		//Gets the count of the total Appointments
		rs = st.executeQuery("SELECT COUNT(*) FROM appointment_records");
		rs.next();
		totalAppointments = rs.getInt(1);

		//Gets the Appointment List
		String getAppointmentList = "SELECT * FROM appointment_records";
		rs = st.executeQuery(getAppointmentList);
	}

		} else if (deptValue.equals("All Departments")) {

	if (search_user_filter.length() > 0 && search_doctor_filter.length() > 0) {
		//Gets the count of the total Appointments
		rs = st.executeQuery(
				"SELECT COUNT(*) FROM appointment_records WHERE registered_users_email_address LIKE \""
						+ search_user_filter + "%\" AND registered_doctors_email_address LIKE \""
						+ search_doctor_filter + "%\" AND appointment_status = \"" + apptStatusValue + "\"");
		rs.next();
		totalAppointments = rs.getInt(1);

		//Gets the Appointment List
		String getAppointmentList = "SELECT * FROM appointment_records WHERE registered_users_email_address LIKE \""
				+ search_user_filter + "%\" AND registered_doctors_email_address LIKE \"" + search_doctor_filter
				+ "%\" AND appointment_status = \"" + apptStatusValue + "\"";
		rs = st.executeQuery(getAppointmentList);

	} else if (search_user_filter.length() > 0) {
		//Gets the count of the total Appointments
		rs = st.executeQuery(
				"SELECT COUNT(*) FROM appointment_records WHERE registered_users_email_address LIKE \""
						+ search_user_filter + "%\" AND appointment_status = \"" + apptStatusValue + "\"");
		rs.next();
		totalAppointments = rs.getInt(1);

		//Gets the Appointment List
		String getAppointmentList = "SELECT * FROM appointment_records WHERE registered_users_email_address LIKE \""
				+ search_user_filter + "%\" AND appointment_status = \"" + apptStatusValue + "\"";
		rs = st.executeQuery(getAppointmentList);

	} else if (search_doctor_filter.length() > 0) {
		//Gets the count of the total Appointments
		rs = st.executeQuery(
				"SELECT COUNT(*) FROM appointment_records WHERE registered_doctors_email_address LIKE \""
						+ search_doctor_filter + "%\" AND appointment_status = \"" + apptStatusValue + "\"");
		rs.next();
		totalAppointments = rs.getInt(1);

		//Gets the Appointment List
		String getAppointmentList = "SELECT * FROM appointment_records WHERE registered_doctors_email_address LIKE \""
				+ search_doctor_filter + "%\" AND appointment_status = \"" + apptStatusValue + "\"";
		rs = st.executeQuery(getAppointmentList);

	} else {
		//Gets the count of the total Appointments
		rs = st.executeQuery("SELECT COUNT(*) FROM appointment_records WHERE appointment_status = \""
				+ apptStatusValue + "\"");
		rs.next();
		totalAppointments = rs.getInt(1);

		//Gets the Appointment List
		String getAppointmentList = "SELECT * FROM appointment_records WHERE appointment_status = \""
				+ apptStatusValue + "\"";
		rs = st.executeQuery(getAppointmentList);
	}

		} else if (apptStatusValue.equals("All Status")) {

	if (search_user_filter.length() > 0 && search_doctor_filter.length() > 0) {
		//Gets the count of the total Appointments
		rs = st.executeQuery(
				"SELECT COUNT(*) FROM appointment_records WHERE registered_users_email_address LIKE \""
						+ search_user_filter + "%\" AND registered_doctors_email_address LIKE \""
						+ search_doctor_filter + "%\" AND appointment_type = \"" + deptValue + "\"");
		rs.next();
		totalAppointments = rs.getInt(1);

		//Gets the Appointment List
		String getAppointmentList = "SELECT * FROM appointment_records WHERE registered_users_email_address LIKE \""
				+ search_user_filter + "%\" AND registered_doctors_email_address LIKE \"" + search_doctor_filter
				+ "%\" AND appointment_type = \"" + deptValue + "\"";
		rs = st.executeQuery(getAppointmentList);

	} else if (search_user_filter.length() > 0) {
		//Gets the count of the total Appointments
		rs = st.executeQuery(
				"SELECT COUNT(*) FROM appointment_records WHERE registered_users_email_address LIKE \""
						+ search_user_filter + "%\" AND appointment_type = \"" + deptValue + "\"");
		rs.next();
		totalAppointments = rs.getInt(1);

		//Gets the Appointment List
		String getAppointmentList = "SELECT * FROM appointment_records WHERE registered_users_email_address LIKE \""
				+ search_user_filter + "%\" AND appointment_type = \"" + deptValue + "\"";
		rs = st.executeQuery(getAppointmentList);

	} else if (search_doctor_filter.length() > 0) {
		//Gets the count of the total Appointments
		rs = st.executeQuery(
				"SELECT COUNT(*) FROM appointment_records WHERE registered_doctors_email_address LIKE \""
						+ search_doctor_filter + "%\" AND appointment_type = \"" + deptValue + "\"");
		rs.next();
		totalAppointments = rs.getInt(1);

		//Gets the Appointment List
		String getAppointmentList = "SELECT * FROM appointment_records WHERE registered_doctors_email_address LIKE \""
				+ search_doctor_filter + "%\" AND appointment_type = \"" + deptValue + "\"";
		rs = st.executeQuery(getAppointmentList);

	} else {
		//Gets the count of the total Appointments
		rs = st.executeQuery(
				"SELECT COUNT(*) FROM appointment_records WHERE appointment_type = \"" + deptValue + "\"");
		rs.next();
		totalAppointments = rs.getInt(1);

		//Gets the Appointment List
		String getAppointmentList = "SELECT * FROM appointment_records WHERE appointment_type = \"" + deptValue
				+ "\"";
		rs = st.executeQuery(getAppointmentList);
	}

		} else {

	if (search_user_filter.length() > 0 && search_doctor_filter.length() > 0) {
		//Gets the count of the total Appointments
		rs = st.executeQuery(
				"SELECT COUNT(*) FROM appointment_records WHERE registered_users_email_address LIKE \""
						+ search_user_filter + "%\" AND registered_doctors_email_address LIKE \""
						+ search_doctor_filter + "%\" AND appointment_type = \"" + deptValue
						+ "\" AND appointment_status = \"" + apptStatusValue + "\"");
		rs.next();
		totalAppointments = rs.getInt(1);

		//Gets the Appointment List
		String getAppointmentList = "SELECT * FROM appointment_records WHERE registered_users_email_address LIKE \""
				+ search_user_filter + "%\" AND registered_doctors_email_address LIKE \"" + search_doctor_filter
				+ "%\" AND appointment_type = \"" + deptValue + "\" AND appointment_status = \""
				+ apptStatusValue + "\"";
		rs = st.executeQuery(getAppointmentList);

	} else if (search_user_filter.length() > 0) {
		//Gets the count of the total Appointments
		rs = st.executeQuery(
				"SELECT COUNT(*) FROM appointment_records WHERE registered_users_email_address LIKE \""
						+ search_user_filter + "%\" AND appointment_type = \"" + deptValue
						+ "\" AND appointment_status = \"" + apptStatusValue + "\"");
		rs.next();
		totalAppointments = rs.getInt(1);

		//Gets the Appointment List
		String getAppointmentList = "SELECT * FROM appointment_records WHERE registered_users_email_address LIKE \""
				+ search_user_filter + "%\" AND appointment_type = \"" + deptValue
				+ "\" AND appointment_status = \"" + apptStatusValue + "\"";
		rs = st.executeQuery(getAppointmentList);

	} else if (search_doctor_filter.length() > 0) {
		//Gets the count of the total Appointments
		rs = st.executeQuery(
				"SELECT COUNT(*) FROM appointment_records WHERE registered_doctors_email_address LIKE \""
						+ search_doctor_filter + "%\" AND appointment_type = \"" + deptValue
						+ "\" AND appointment_status = \"" + apptStatusValue + "\"");
		rs.next();
		totalAppointments = rs.getInt(1);

		//Gets the Appointment List
		String getAppointmentList = "SELECT * FROM appointment_records WHERE registered_doctors_email_address LIKE \""
				+ search_doctor_filter + "%\" AND appointment_type = \"" + deptValue
				+ "\" AND appointment_status = \"" + apptStatusValue + "\"";
		rs = st.executeQuery(getAppointmentList);

	} else {
		//Gets the count of the total Appointments
		rs = st.executeQuery("SELECT COUNT(*) FROM appointment_records WHERE appointment_type = \"" + deptValue
				+ "\" AND appointment_status = \"" + apptStatusValue + "\"");
		rs.next();
		totalAppointments = rs.getInt(1);

		//Gets the Appointment List
		String getAppointmentList = "SELECT * FROM appointment_records WHERE appointment_type = \"" + deptValue
				+ "\" AND appointment_status = \"" + apptStatusValue + "\"";
		rs = st.executeQuery(getAppointmentList);
	}
		}

	} else {
		//Gets the count of the total Appointments
		rs = st.executeQuery("SELECT COUNT(*) FROM appointment_records");
		rs.next();
		totalAppointments = rs.getInt(1);

		//Gets the Appointment List
		String getAppointmentList = "SELECT * FROM appointment_records";
		rs = st.executeQuery(getAppointmentList);
	}

	//---------------------------------------
%>

<div class="list-header">
	<h3>Appointment List</h3>
	<div class="list-header-nav">
		<h3>
			Number of Appointments:
			<%=totalAppointments%></h3>

		<select name="department-filter" onchange="loadApptsByFilter()"
			id="department-filter">
			<option value="All Departments">All Departments</option>
			<option value="Neurology">Neurology</option>
			<option value="Cardiology">Cardiology</option>
			<option value="Orthopedics">Orthopedics</option>
			<option value="Dermatology">Dermatology</option>
			<option value="Gastroenterology">Gastroenterology</option>
		</select> <select name="appointment-filter" onchange="loadApptsByFilter()"
			id="appointment-filter">
			<option value="All Status">All Status</option>
			<option value="Approved">Approved</option>
			<option value="Awaiting">Awaiting</option>
			<option value="Cancelled">Cancelled</option>
			<option value="Visited">Visited</option>
			<option value="Not Visited">Not Visited</option>
		</select>
	</div>
</div>

<div class="query-records-container"
	style="border-top-left-radius: 10px;">
	<table>
		<tr>
			<th>ID</th>
			<th>Date</th>
			<th>Time 24h</th>
			<th>Type</th>
			<th>Status</th>
			<th>Patient Email</th>
			<th>Doctor Email</th>
		</tr>

		<%
		for (int i = 1; i <= totalAppointments; i++) {
			rs.next();
		%>
		<tr>
			<td style="text-align: center"><%=rs.getString(1)%></td>
			<td style="text-align: center"><%=rs.getString(2)%></td>
			<td style="text-align: center"><%=rs.getString(3).substring(0, rs.getString(3).length() - 3)%></td>
			<td><%=rs.getString(4)%></td>
			<%
			if (rs.getString(5).equals("Awaiting")) {
			%>
			<td style="text-align: center;" class="appt-list-button"><button
					style="background-color: orange"><%=rs.getString(5)%></button></td>
			<%
			} else if (rs.getString(5).equals("Approved")) {
			%>
			<td style="text-align: center;" class="appt-list-button"><button
					style="background-color: green"><%=rs.getString(5)%></button></td>
			<%
			} else if (rs.getString(5).equals("Cancelled")) {
			%>
			<td style="text-align: center;" class="appt-list-button"><button
					style="background-color: red"><%=rs.getString(5)%></button></td>
			<%
			} else if (rs.getString(5).equals("Visited")) {
			%>
			<td style="text-align: center;" class="appt-list-button"><button
					style="background-color: rgb(6, 111, 216)"><%=rs.getString(5)%></button></td>
			<%
			} else if (rs.getString(5).equals("Not Visited")) {
			%>
			<td style="text-align: center;" class="appt-list-button"><button
					style="background-color: grey"><%=rs.getString(5)%></button></td>
			<%
			}
			%>
			<td><%=rs.getString(6)%></td>
			<td><%=rs.getString(7)%></td>
		</tr>
		<%
		}
		%>
	</table>
</div>

<%
con.close();
} catch (Exception e) {
e.printStackTrace();
}
%>