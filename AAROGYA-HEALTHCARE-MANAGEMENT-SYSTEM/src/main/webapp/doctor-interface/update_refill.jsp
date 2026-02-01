<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
Connection con = null;
Statement st = null;
ResultSet rs = null;

int totalPrescriptions = 0; 

String prescription_id_filter = request.getParameter("prescription_id_filter");
String prescription_id = request.getParameter("prescription_id");

try {
	 Class.forName("com.mysql.cj.jdbc.Driver");
     con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aarogya_healthcare_db","root","trickortreat");
     
     st = con.createStatement();
     
     if (prescription_id != null) {
    	 String updatePrescriptionRefill = "UPDATE prescription SET refill = refill - 1 WHERE prescription_id = \"" + prescription_id + "\"";
    	 st.executeUpdate(updatePrescriptionRefill);
     }
     
     if (prescription_id_filter != null) {
    	 prescription_id_filter = prescription_id_filter.trim();    	 
     }
     
   	 //Gets the count of the Appointments    
     String getTotalPrescription = "SELECT COUNT(*) FROM prescription WHERE prescription_id LIKE \"" + prescription_id_filter + "%\" AND refill > 0";
    
     rs = st.executeQuery(getTotalPrescription);
     rs.next();
     totalPrescriptions = rs.getInt(1);     
         
                 
     //-------------------------------------
%>

<div class="list-header">
	<h3>Prescription List</h3>
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
			<th>Patient Email</th>
			<th>Doctor Email</th>
			<th>Action</th>
		</tr>

		<%
		String newAppointments = "SELECT * FROM prescription WHERE prescription_id LIKE \"" + prescription_id_filter + "%\" AND refill > 0";
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
			<td><%= rs.getString(10) %></td>
			<td><%= rs.getString(9) %></td>
			<td style="text-align: center" id="<%= rs.getInt(1) %>">
				<button class="delete-button" style="width: 130px;"
					onclick="loadPrescriptionFilter(this.parentElement.id)">Decrement</button>
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