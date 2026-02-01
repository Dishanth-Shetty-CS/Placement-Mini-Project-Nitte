<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
Connection con = null;
Statement st = null;
ResultSet rs = null;

int totalDoctors = 0;

String opname = request.getParameter("opname");
String email_address = request.getParameter("email_address");
 
try {
	 Class.forName("com.mysql.cj.jdbc.Driver");
     con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aarogya_healthcare_db","root","trickortreat");
     
     st = con.createStatement();
          
     if (opname.equals("deleteDoctor")) {
    	 String deleteId = request.getParameter("id");
    	 
    	 String updateAppointmentTbDoctorFk = "UPDATE appointment_records SET registered_doctors_email_address = null where registered_doctors_email_address = \"" + deleteId + "\"";
    	 st.executeUpdate(updateAppointmentTbDoctorFk);
    	 
    	 String updatePrescriptionTbDoctorFk = "UPDATE prescription SET registered_doctors_email_address = null where registered_doctors_email_address = \"" + deleteId + "\"";
    	 st.executeUpdate(updatePrescriptionTbDoctorFk);
    	 
    	 String deleteDoctorSQL = "DELETE FROM registered_doctors where email_address = \"" + deleteId + "\"";
    	 st.executeUpdate(deleteDoctorSQL);
     }
     
     
     if (opname.equals("search-filter")) {
    	 //Gets the count of the total registered doctors
         rs = st.executeQuery("SELECT COUNT(*) FROM registered_doctors WHERE email_address LIKE \"" + email_address + "%\"");     
         rs.next();
         totalDoctors = rs.getInt(1);
         
         //Gets the Doctor List
         String getDoctorList = "SELECT * FROM registered_doctors WHERE email_address LIKE \"" + email_address + "%\"";
         rs = st.executeQuery(getDoctorList);
     } else {
    	 //Gets the count of the total registered doctors
         rs = st.executeQuery("SELECT COUNT(*) FROM registered_doctors");     
         rs.next();
         totalDoctors = rs.getInt(1);  
         
         //Gets the Doctor List
         String getDoctorList = "SELECT * FROM registered_doctors";
         rs = st.executeQuery(getDoctorList);
     }       
     
     
     
     //---------------------------------------

%>

<div class="list-header">
	<h3>Doctor List</h3>
	<h3>
		Number of Doctors:
		<%= totalDoctors %></h3>
</div>

<div class="query-records-container"
	style="border-top-left-radius: 10px;">
	<table>
		<tr>
			<th>First Name</th>
			<th>Last Name</th>
			<th>Department</th>
			<th>Email Address</th>
			<th>Delete Account</th>
		</tr>

		<%
			for (int i = 1; i <= totalDoctors; i++) {
				rs.next();
		%>
		<tr>
			<td><%= rs.getString(2) %></td>
			<td><%= rs.getString(3) %></td>
			<td><%= rs.getString(6) %></td>
			<td><%= rs.getString(1) %></td>
			<td style="text-align: center"><button class="delete-button"
					id="<%= rs.getString(1) %>" onclick="deleteDoctor(this.id)">Delete</button></td>
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