<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
Connection con = null;
Statement st = null;
ResultSet rs = null;

int totalPatients = 0;
int totalDoctors = 0;
int totalAppointments = 0;
int totalUnreadQueries = 0;
int totalReadQueries = 0;

String opname = request.getParameter("opname");
String queryId = request.getParameter("qid");

try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aarogya_healthcare_db", "root", "trickortreat");

	st = con.createStatement();

	String getTotalPatients = "SELECT COUNT(*) FROM registered_users";
	String getTotalDoctors = "SELECT COUNT(*) FROM registered_doctors";
	String getTotalAppointments = "SELECT COUNT(*) FROM appointment_records";
	String getTotalUnreadQueries = "SELECT COUNT(*) FROM query_records WHERE message_status = \"unread\"";
	String getTotalReadQueries = "SELECT COUNT(*) FROM query_records WHERE message_status = \"read\"";

	rs = st.executeQuery(getTotalPatients);
	rs.next();
	totalPatients = rs.getInt(1);

	rs = st.executeQuery(getTotalDoctors);
	rs.next();
	totalDoctors = rs.getInt(1);

	rs = st.executeQuery(getTotalAppointments);
	rs.next();
	totalAppointments = rs.getInt(1);

	rs = st.executeQuery(getTotalUnreadQueries);
	rs.next();
	totalUnreadQueries = rs.getInt(1);

	rs = st.executeQuery(getTotalReadQueries);
	rs.next();
	totalReadQueries = rs.getInt(1);

	String unreadQueryRecordsSQL = "SELECT * FROM query_records WHERE message_status = \"unread\" ORDER BY query_id DESC";
	String readQueryRecordsSQL = "SELECT * FROM query_records WHERE message_status = \"read\" ORDER BY query_id DESC";

	if (queryId != null) {
		String updateQueryStatus = "UPDATE query_records SET message_status = \"read\" WHERE query_id = " + queryId;
		st.executeUpdate(updateQueryStatus);
	}

	if (opname.equals("unread")) {
		rs = st.executeQuery(unreadQueryRecordsSQL);
	} else if (opname.equals("read")) {
		rs = st.executeQuery(readQueryRecordsSQL);
	}
%>


<div class="dashboard-top-container">
	<div class="view-details" style="border-left: 10px solid orange;">
		<p id="appointments">
			Total Appointments:
			<%=totalAppointments%></p>
	</div>

	<div class="view-details"
		style="border-left: 10px solid rgb(1, 234, 255);">
		<p id="doctors">
			Total Doctors:
			<%=totalDoctors%></p>
	</div>

	<div class="view-details" style="border-left: 10px solid greenyellow;">
		<p id="patients">
			Total Patients:
			<%=totalPatients%></p>
	</div>
</div>

<div class="dashboard-bottom-container">
	<h3>Query List</h3>

	<div class="container-tabs">
		<p class="container-tabs-options" onclick="loadUnreadQueries()">Unread
			Queries</p>
		<p class="container-tabs-options" onclick="loadReadQueries()">Read
			Queries</p>

		<div id="query-count-container">
			<h3 id="query-count">
				Number of queries:
				<%
			int queriesTotal = 0;
			if (opname.equals("unread")) {
				queriesTotal = totalUnreadQueries;
			%>
				<%=totalUnreadQueries%>
				<%
				} else if (opname.equals("read")) {
				queriesTotal = totalReadQueries;
				%>
				<%=totalReadQueries%>
				<%
				}
				%>
			</h3>
		</div>
	</div>

	<div class="query-records-container">
		<table>
			<tr>
				<th>Date</th>
				<th>Name</th>
				<th>Subject</th>
				<th>View Message</th>
				<th>Email Address</th>
			</tr>

			<%
			for (int i = 1; i <= queriesTotal; i++) {
				rs.next();
			%>
			<tr>
				<td style="text-align: center"><%=rs.getString(7)%></td>
				<td><%=rs.getString(3)%></td>
				<td><%=rs.getString(4)%></td>
				<td style="text-align: center">
					<%
					if (rs.getString(6).equals("unread")) {
					%> <i class="fa-solid fa-envelope" onclick="showMessage(this)"></i>
					<%
					} else if (rs.getString(6).equals("read")) {
					%> <i class="fa-solid fa-envelope-open" onclick="showMessage(this)"></i>
					<%
					}
					%>

					<div class="message" id="<%=rs.getString(1)%>">
						<i class="fa-solid fa-square-xmark" id="<%=rs.getString(6)%>"
							onclick="closeMessage(this)"></i>
						<p><%=rs.getString(5)%></p>
					</div>
				</td>
				<td><%=rs.getString(2)%></td>
			</tr>
			<%
			}
			%>
		</table>
	</div>
</div>


<%
con.close();
} catch (Exception e) {
e.printStackTrace();
}
%>
