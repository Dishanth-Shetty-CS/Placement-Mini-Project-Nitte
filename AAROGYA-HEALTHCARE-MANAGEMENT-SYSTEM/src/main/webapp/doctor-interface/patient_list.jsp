<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
Connection con = null;
Statement st = null;
ResultSet rs = null;

int totalPatients = 0;

String opname = request.getParameter("opname");
String email_address = request.getParameter("email_address");
 
try {
	 Class.forName("com.mysql.cj.jdbc.Driver");
     con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aarogya_healthcare_db","root","trickortreat");
     
     st = con.createStatement();             
     
     
     if (opname.equals("search-filter")) {
    	 //Gets the count of the total registered doctors
         rs = st.executeQuery("SELECT COUNT(*) FROM registered_users WHERE email_address LIKE \"" + email_address + "%\"");     
         rs.next();
         totalPatients = rs.getInt(1);
         
         //Gets the Doctor List
         String getPatientList = "SELECT * FROM registered_users WHERE email_address LIKE \"" + email_address + "%\"";
         rs = st.executeQuery(getPatientList);
     } else {
    	 //Gets the count of the total registered users
         rs = st.executeQuery("SELECT COUNT(*) FROM registered_users");     
         rs.next();
         totalPatients = rs.getInt(1);
         
         //Gets the Patient List
         String getPatientList = "SELECT * FROM registered_users";
         rs = st.executeQuery(getPatientList);
     }          
     
     //---------------------------------------

%>

<div class="list-header">
	<h3>Patient List</h3>
	<h3>
		Number of Patients:
		<%= totalPatients %></h3>
</div>

<div class="query-records-container"
	style="border-top-left-radius: 10px;">
	<table>
		<tr>
			<th>First Name</th>
			<th>Last Name</th>
			<th>Phone Number</th>
			<th>Email Address</th>
		</tr>

		<%
			for (int i = 1; i <= totalPatients; i++) {
				rs.next();
		%>
		<tr>
			<td><%= rs.getString(2) %></td>
			<td><%= rs.getString(3) %></td>
			<td style="text-align: center"><%= rs.getString(4) %></td>
			<td><%= rs.getString(1) %></td>
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