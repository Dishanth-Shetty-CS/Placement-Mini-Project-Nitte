<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
Connection con = null;
Statement st = null;
ResultSet rs = null;

int totalAppointments = 0; 

String registered_users_email_address = request.getParameter("registered_users_email_address");

try {
	 Class.forName("com.mysql.cj.jdbc.Driver");
     con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aarogya_healthcare_db","root","trickortreat");
     
     st = con.createStatement();
     
   	 //Gets the count of the Appointments    
     String getTotalAppointments = "SELECT COUNT(*) FROM appointment_records WHERE registered_users_email_address = \"" + registered_users_email_address + "\" AND appointment_status = \"Approved\" OR registered_users_email_address = \"" + registered_users_email_address + "\" AND appointment_status = \"Awaiting\"";
    
     rs = st.executeQuery(getTotalAppointments);
     rs.next();
     totalAppointments = rs.getInt(1);     
         
                 
     //-------------------------------------
%>

<div class="list-header">
	<h3>My Appointment List</h3>
	<h3>
		Number of Appointments:
		<%= totalAppointments %></h3>
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
		String newAppointments = "SELECT * FROM appointment_records WHERE registered_users_email_address = \"" + registered_users_email_address + "\" AND appointment_status = \"Approved\" OR registered_users_email_address = \"" + registered_users_email_address + "\" AND appointment_status = \"Awaiting\"";
		rs = st.executeQuery(newAppointments);
		
		for (int i = 1; i <= totalAppointments; i++) {		
			rs.next();
			%>
		<tr>
			<td style="text-align: center"><%= rs.getString(1) %></td>
			<td style="text-align: center"><%= rs.getString(2) %></td>
			<td style="text-align: center"><%= rs.getString(3).substring(0, rs.getString(3).length() - 3) %></td>
			<td><%= rs.getString(4) %></td>
			<%
				
					if (rs.getString(5).equals("Awaiting")) {
						%>
			<td style="text-align: center;" class="appt-list-button"><button
					style="background-color: orange"><%= rs.getString(5) %></button></td>
			<%
					} else if (rs.getString(5).equals("Approved")) {
						%>
			<td style="text-align: center;" class="appt-list-button"><button
					style="background-color: green"><%= rs.getString(5) %></button></td>
			<%
					}
			
				%>
			<td><%= rs.getString(6) %></td>
			<td><%= rs.getString(7) %></td>
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