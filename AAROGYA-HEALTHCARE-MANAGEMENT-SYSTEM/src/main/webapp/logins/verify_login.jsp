<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="org.mindrot.jbcrypt.BCrypt"%>

<%

Connection con = null;
Statement st = null;
ResultSet rs = null;

String user_table = request.getParameter("user_table");
String email_address = request.getParameter("email_address");
String password = request.getParameter("password");
String redirect_to = request.getParameter("redirect_to");


if (email_address != null) {
	try {
		 Class.forName("com.mysql.cj.jdbc.Driver");
	     con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aarogya_healthcare_db","root","trickortreat");
	     	  
	     st = con.createStatement();
	     
	     String getHashedPassword = "SELECT password FROM " + user_table + " WHERE email_address = \"" + email_address + "\"";
	     rs = st.executeQuery(getHashedPassword);
	     rs.next();
	     String hashedPassword = rs.getString(1);
	     
		 if (BCrypt.checkpw(password.trim(), hashedPassword)) {					
				
			 if (user_table.equals("registered_doctors")) {
				 String getDepartment = "SELECT department FROM registered_doctors WHERE email_address = \"" + email_address + "\"";
				 rs = st.executeQuery(getDepartment);
			     rs.next();
			     String department = rs.getString(1);

			     session = request.getSession();
				 session.setAttribute("department", department);
			 } else if (user_table.equals("registered_users")) {		
			     session = request.getSession();
				 session.setAttribute("registerd_user_email_address", email_address);
			 }
			 
			 response.setContentType("text/plain"); 
			 response.getWriter().write(redirect_to); 			 
		 } else {			 
			 response.setContentType("text/plain"); 
			 response.getWriter().write("Incorrect"); 	
		 }
		 
	     con.close();
	} catch(Exception e) {            
	     e.printStackTrace();
	} 	
}

%>