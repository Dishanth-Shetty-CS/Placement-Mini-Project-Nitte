import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.mindrot.jbcrypt.BCrypt;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/CustomerServlet")
public class CustomerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private static final String DB_URL = "jdbc:mysql://localhost:3306/car_rental_db";
	private static final String DB_USER = "root";
	private static final String DB_PASSWORD = "trickortreat";

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out = response.getWriter();

		String custName = request.getParameter("Cust_Name");
		String custAddress = request.getParameter("Cust_Address");
		String custPhone = request.getParameter("Cust_Phone");
		String custEmail = request.getParameter("Cust_Email");
		String custPassword = request.getParameter("Cust_Password");

		if (custName == null || custName.trim().isEmpty() || custEmail == null || custEmail.trim().isEmpty()
				|| custPhone == null || custPhone.trim().isEmpty() || custAddress == null
				|| custAddress.trim().isEmpty() || custPassword == null || custPassword.trim().isEmpty()) {

			out.write("{\"status\":\"error\", \"message\":\"All fields are required.\"}");
			return;
		}

		String hashedPassword = BCrypt.hashpw(custPassword, BCrypt.gensalt(12));

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

			String checkEmail = "SELECT Cust_Email FROM customer WHERE Cust_Email=?";
			stmt = conn.prepareStatement(checkEmail);
			stmt.setString(1, custEmail);
			rs = stmt.executeQuery();
			if (rs.next()) {
				out.write("{\"status\":\"error\", \"message\":\"Email already registered.\"}");
				return;
			}
			stmt.close();

			String sql = "INSERT INTO customer (Cust_Name, Cust_Address, Cust_Phone, Cust_Email, Cust_Password) VALUES (?, ?, ?, ?, ?)";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, custName);
			stmt.setString(2, custAddress);
			stmt.setString(3, custPhone);
			stmt.setString(4, custEmail);
			stmt.setString(5, hashedPassword);

			int rowsInserted = stmt.executeUpdate();
			if (rowsInserted > 0) {
				out.write(
						"{\"status\":\"success\", \"message\":\"Customer registered successfully!\", \"customerId\":\""
								+ custEmail + "\"}");
			} else {
				out.write("{\"status\":\"error\", \"message\":\"Customer registration failed.\"}");
			}

		} catch (Exception e) {
			e.printStackTrace();
			out.write("{\"status\":\"error\", \"message\":\"Error: " + e.getMessage().replace("\"", "'") + "\"}");
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (SQLException e) {
			}
			try {
				if (stmt != null)
					stmt.close();
			} catch (SQLException e) {
			}
			try {
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
			}
		}
	}
}
