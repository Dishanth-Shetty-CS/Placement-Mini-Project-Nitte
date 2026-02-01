<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
Connection con = null;
Statement st = null;
ResultSet rs = null;

int totalScheduledAppointments = 0;
int totalAwaitingAppt = 0;
int totalAppointmentsHistory = 0;
 
String opname = request.getParameter("opname");
String apptId = request.getParameter("apptId");

session = request.getSession();
String email_address = (String) session.getAttribute("registerd_user_email_address"); 

try {
	 Class.forName("com.mysql.cj.jdbc.Driver");
     con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aarogya_healthcare_db","root","trickortreat");
     
     st = con.createStatement();             
     
     if (opname != null) {   
    	 if (opname.equals("cancel")) { 
   			 String cancelAppt = "UPDATE appointment_records SET appointment_status = \"Cancelled\" WHERE appointment_id = \"" + apptId + "\"";
   			 st.executeUpdate(cancelAppt);  
    	 }
     }   
     
   	 //Gets the count of the Appointments
     String getTotalScheduledAppointments = "SELECT COUNT(*) FROM appointment_records WHERE appointment_status = \"Approved\" AND registered_users_email_address = \"" + email_address + "\"";
     String getTotalAwaitingAppt = "SELECT COUNT(*) FROM appointment_records WHERE registered_users_email_address = \"" + email_address + "\" AND appointment_status = \"Awaiting\"";
     String getTotalAppointmentsHistory = "SELECT COUNT(*) FROM appointment_records WHERE registered_users_email_address = \"" + email_address + "\" AND appointment_status = \"Visited\" OR registered_users_email_address = \"" + email_address + "\" AND appointment_status = \"Cancelled\" OR registered_users_email_address = \"" + email_address + "\" AND appointment_status = \"Not Visited\"";    
     
     rs = st.executeQuery(getTotalScheduledAppointments);          
     rs.next();
     totalScheduledAppointments = rs.getInt(1);     
     
     rs = st.executeQuery(getTotalAwaitingAppt);
     rs.next();
     totalAwaitingAppt = rs.getInt(1);     
          
     rs = st.executeQuery(getTotalAppointmentsHistory);          
     rs.next();
     totalAppointmentsHistory = rs.getInt(1);     
               
     //-------------------------------------
%>


<div class="dashboard-top-container">
	<div class="view-details" style="border-left: 10px solid orange;">
		<p id="appointments">
			Scheduled Meeting:
			<%= totalScheduledAppointments %></p>
	</div>

	<div class="view-details"
		style="border-left: 10px solid rgb(1, 234, 255);">
		<p id="doctors">
			Total Awaiting Appt. :
			<%= totalAwaitingAppt %></p>
	</div>

	<div class="view-details" style="border-left: 10px solid greenyellow;">
		<p id="patients">
			Total Appt. History:
			<%= totalAppointmentsHistory %></p>
	</div>
</div>

<div class="dashboard-bottom-container">
	<div class="list-header">
		<h3>Scheduled Appointment List</h3>
		<h3>
			Number of Appointments:
			<%= totalScheduledAppointments %></h3>
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
				<th>Doctor Email</th>
				<th>Action</th>
			</tr>

			<%
			String scheduledAppointments = "SELECT * FROM appointment_records WHERE appointment_status = \"Approved\" AND registered_users_email_address = \"" + email_address + "\"";
			rs = st.executeQuery(scheduledAppointments);
			
			for (int i = 1; i <= totalScheduledAppointments; i++) {		
				rs.next();
				%>
			<tr>
				<td style="text-align: center"><%= rs.getString(1) %></td>
				<td style="text-align: center"><%= rs.getString(2) %></td>
				<td style="text-align: center"><%= rs.getString(3).substring(0, rs.getString(3).length() - 3) %></td>
				<td><%= rs.getString(4) %></td>
				<td style="text-align: center;" class="appt-list-button"><button
						style="background-color: green"><%= rs.getString(5) %></button></td>
				<td><%= rs.getString(7) %></td>
				<td style="text-align: center"><button class="delete-button"
						id="<%= rs.getInt(1) %>" onclick="cancelAppt(this.id)">Cancel</button></td>
			</tr>
			<%
			}
			%>
		</table>
	</div>
</div>


<%
     con.close();
} catch(Exception e) {            
     e.printStackTrace();
} 
%>
