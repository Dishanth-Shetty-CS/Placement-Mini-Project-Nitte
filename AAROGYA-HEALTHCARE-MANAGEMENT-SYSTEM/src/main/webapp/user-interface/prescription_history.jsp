<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
Connection con = null;
Statement st = null;
ResultSet rs = null;

int totalPrescriptions = 0; 

String registered_users_email_address = request.getParameter("registered_users_email_address");

try {
	 Class.forName("com.mysql.cj.jdbc.Driver");
     con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aarogya_healthcare_db","root","trickortreat");
     
     st = con.createStatement();
     
   	 //Gets the count of the Appointments    
     String getTotalPrescription = "SELECT COUNT(*) FROM prescription WHERE registered_users_email_address = \"" + registered_users_email_address + "\" AND refill < 1";
    
     rs = st.executeQuery(getTotalPrescription);
     rs.next();
     totalPrescriptions = rs.getInt(1);     
         
                 
     //-------------------------------------
%>

<div class="list-header">
	<h3>Prescription History List</h3>
	<h3>
		Number of Prescriptions:
		<%= totalPrescriptions %></h3>
</div>

<div class="query-records-container"
	style="border-top-left-radius: 10px;">
	<table>
		<tr>
			<th>ID</th>
			<th>Date</th>
			<th>Time 24h</th>
			<th>Diagnosis</th>
			<th>Med Info</th>
			<th>Refill</th>
			<th>Instructions</th>
			<th>Appt. ID</th>
			<th>Doctor Email</th>
		</tr>

		<%
		String newAppointments = "SELECT * FROM prescription WHERE registered_users_email_address = \"" + registered_users_email_address + "\" AND refill < 1 ORDER BY prescription_id DESC";
		rs = st.executeQuery(newAppointments);
		
		for (int i = 1; i <= totalPrescriptions; i++) {		
			rs.next();
			%>
		<tr>
			<td style="text-align: center"><%= rs.getString(1) %></td>
			<td style="text-align: center"><%= rs.getString(2) %></td>
			<td style="text-align: center"><%= rs.getString(3).substring(0, rs.getString(3).length() - 3) %></td>
			<td><%= rs.getString(4) %></td>
			<td><%= rs.getString(5) %></td>
			<td style="text-align: center"><%= rs.getString(6) %></td>
			<td><%= rs.getString(7) %></td>
			<td style="text-align: center"><%= rs.getString(8) %></td>
			<td><%= rs.getString(9) %></td>
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