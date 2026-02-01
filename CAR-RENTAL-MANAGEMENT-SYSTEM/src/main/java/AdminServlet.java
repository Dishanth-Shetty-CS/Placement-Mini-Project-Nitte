import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;

import org.mindrot.jbcrypt.BCrypt;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private String dbURL = "jdbc:mysql://localhost:3306/car_rental_db";
	private String dbUser = "root";
	private String dbPass = "trickortreat";

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("application/json");
		PrintWriter out = response.getWriter();

		String name = request.getParameter("Admin_Name");
		String email = request.getParameter("Admin_Email");
		String phone = request.getParameter("Admin_Phone");
		String rawPassword = request.getParameter("Admin_Password");
		String hashedPassword = BCrypt.hashpw(rawPassword, BCrypt.gensalt(12));

		Connection conn = null;
		PreparedStatement ps = null;

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

			String sql = "INSERT INTO administrator (Admin_Email, Admin_Name, Admin_Password) VALUES (?, ?, ?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, email);
			ps.setString(2, name);
			ps.setString(3, hashedPassword);

			int result = ps.executeUpdate();

			if (result > 0) {
				out.print("{\"status\":\"success\", \"adminEmail\":\"" + email + "\"}");
			} else {
				out.print("{\"status\":\"error\", \"message\":\"Registration failed. Please try again later.\"}");
			}

		} catch (SQLIntegrityConstraintViolationException e) {
			out.print("{\"status\":\"error\", \"message\":\"This email is already registered as an admin.\"}");
		} catch (Exception e) {
			e.printStackTrace();
			out.print("{\"status\":\"error\", \"message\":\"System Error: " + e.getMessage() + "\"}");
		} finally {
			try {
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			out.flush();
		}
	}
}