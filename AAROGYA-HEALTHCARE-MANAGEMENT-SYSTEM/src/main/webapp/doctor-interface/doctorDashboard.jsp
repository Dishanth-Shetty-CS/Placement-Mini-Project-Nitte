<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
Connection con = null;
Statement st = null;
ResultSet rs = null;

int totalScheduledAppointments = 0;
int totalNewAppointments = 0;
int totalAppointments = 0;
 
String opname = request.getParameter("opname");
String apptId = request.getParameter("apptId");
String button_type = request.getParameter("button_type");

session = request.getSession();
String dept = (String) session.getAttribute("department"); 

try {
	 Class.forName("com.mysql.cj.jdbc.Driver");
     con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aarogya_healthcare_db","root","trickortreat");
     
     st = con.createStatement();
     
     if (opname.equals("update")) {
    	 if (button_type != null) {
    		 if (button_type.equals("yes")) {
    			 String updateStatus = "UPDATE appointment_records SET appointment_status = \"Visited\" WHERE appointment_id = \"" + apptId + "\"";
    	    	 st.executeUpdate(updateStatus);  
    		 } else if (button_type.equals("no")) {
    			 String updateStatus = "UPDATE appointment_records SET appointment_status = \"Not Visited\" WHERE appointment_id = \"" + apptId + "\"";
    	    	 st.executeUpdate(updateStatus);  
    		 }
    	 } else {
	    	 String updateStatus = "UPDATE appointment_records SET appointment_status = \"Cancelled\" WHERE appointment_id = \"" + apptId + "\"";
	    	 st.executeUpdate(updateStatus);    		 
    	 }
     }          
     
   	 //Gets the count of the Appointments
     String getTotalScheduledAppointments = "SELECT COUNT(*) FROM appointment_records WHERE appointment_status = \"Approved\" AND appointment_type = \"" + dept + "\"";
     String getTotalNewAppointments = "SELECT COUNT(*) FROM appointment_records WHERE appointment_status = \"Awaiting\" AND appointment_type = \"" + dept + "\"";
     String getTotalAppointments = "SELECT COUNT(*) FROM appointment_records WHERE appointment_type = \"" + dept + "\"";    
     
     rs = st.executeQuery(getTotalScheduledAppointments);          
     rs.next();
     totalScheduledAppointments = rs.getInt(1);     
     
     rs = st.executeQuery(getTotalNewAppointments);
     rs.next();
     totalNewAppointments = rs.getInt(1);     
     
     totalAppointments = totalScheduledAppointments + totalNewAppointments;
                 
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
			New Appointments:
			<%= totalNewAppointments %></p>
	</div>

	<div class="view-details" style="border-left: 10px solid greenyellow;">
		<p id="patients">
			Total Appointments:
			<%= totalAppointments %></p>
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
				<th>Patient Email</th>
				<th>Visited</th>
				<th>Action</th>
			</tr>

			<%
			String scheduledAppointments = "SELECT * FROM appointment_records WHERE appointment_status = \"Approved\" AND appointment_type = \"" + dept + "\"";
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
				<td><%= rs.getString(6) %></td>
				<td id="<%= rs.getString(1) %>">
					<button class="yes-button"
						onclick="visitedUpdate(this.parentElement.id, 'yes')">Yes</button>
					<button class="no-button"
						onclick="visitedUpdate(this.parentElement.id, 'no')">No</button>
				</td>
				<td style="text-align: center"><button class="delete-button"
						id="<%= rs.getInt(1) %>"
						onclick="loadApptFilterDashboard(this.id)">Cancel</button></td>
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
