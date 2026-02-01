<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
Connection con = null;
Statement st = null;
ResultSet rs = null;

int totalNewAppointments = 0;
 
String opname = request.getParameter("opname");
String apptId = request.getParameter("apptId");
String action = request.getParameter("action");
String registered_doctors_email_address = request.getParameter("registered_doctors_email_address");

session = request.getSession();
String dept = (String) session.getAttribute("department");

try {
	 Class.forName("com.mysql.cj.jdbc.Driver");
     con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aarogya_healthcare_db","root","trickortreat");
     
     st = con.createStatement();
     
     //Performs Update operation
     if (opname.equals("update")) {
	     if (action.equals("accept")) {
	    	 String updateStatus = "UPDATE appointment_records SET appointment_status = \"Approved\", registered_doctors_email_address = \""+ registered_doctors_email_address + "\" WHERE appointment_id = \"" + apptId + "\"";
	    	 st.executeUpdate(updateStatus);
	     } else if (action.equals("decline")) {
	    	 String updateStatus = "UPDATE appointment_records SET appointment_status = \"Cancelled\", registered_doctors_email_address = \""+ registered_doctors_email_address + "\" WHERE appointment_id = \"" + apptId + "\"";
	    	 st.executeUpdate(updateStatus);
	     }    	 
     }
     
   	 //Gets the count of the Appointments    
     String getTotalNewAppointments = "SELECT COUNT(*) FROM appointment_records WHERE appointment_status = \"Awaiting\" AND appointment_type = \"" + dept + "\"";
    
     rs = st.executeQuery(getTotalNewAppointments);
     rs.next();
     totalNewAppointments = rs.getInt(1);     
         
                 
     //-------------------------------------
%>

<div class="list-header">
	<h3>New Appointment List</h3>
	<h3>
		Number of Appointments:
		<%= totalNewAppointments %></h3>
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
			<th>Actions</th>
		</tr>

		<%
		String newAppointments = "SELECT * FROM appointment_records WHERE appointment_status = \"Awaiting\" AND appointment_type = \"" + dept + "\"";
		rs = st.executeQuery(newAppointments);
		
		for (int i = 1; i <= totalNewAppointments; i++) {		
			rs.next();
			%>
		<tr>
			<td style="text-align: center"><%= rs.getString(1) %></td>
			<td style="text-align: center"><%= rs.getString(2) %></td>
			<td style="text-align: center"><%= rs.getString(3).substring(0, rs.getString(3).length() - 3) %></td>
			<td><%= rs.getString(4) %></td>
			<td style="text-align: center;" class="appt-list-button"><button
					style="background-color: orange"><%= rs.getString(5) %></button></td>
			<td><%= rs.getString(6) %></td>
			<td style="text-align: center" id="<%= rs.getInt(1) %>">
				<button class="accept-button"
					onclick="loadNewApptFilter(this.parentElement.id, 'accept')"
					style="margin-right: 10px;">Accept</button>
				<button class="delete-button"
					onclick="loadNewApptFilter(this.parentElement.id, 'decline')">Decline</button>
			</td>
		</tr>
		<%
		}
		%>
	</table>
</div>

<%
     con.close();
} catch(Exception e) {            
     e.printStackTrace();
} 
%>