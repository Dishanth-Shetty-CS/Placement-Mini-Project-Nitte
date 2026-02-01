import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import org.mindrot.jbcrypt.BCrypt;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String email = request.getParameter("Admin_Email").trim();
		String password = request.getParameter("Admin_Password").trim();

		response.setContentType("text/plain");
		PrintWriter out = response.getWriter();

		Connection connection = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/car_rental_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC",
					"root", "trickortreat");

			String query = "SELECT Admin_Name, Admin_Password FROM administrator WHERE LOWER(Admin_Email) = LOWER(?)";
			ps = connection.prepareStatement(query);
			ps.setString(1, email);

			rs = ps.executeQuery();

			if (rs.next()) {
				String adminName = rs.getString("Admin_Name");
				String hashedPassword = rs.getString("Admin_Password");

				if (BCrypt.checkpw(password, hashedPassword)) {
					HttpSession session = request.getSession();
					session.setAttribute("adminEmail", email);
					session.setAttribute("adminName", adminName);
					session.setMaxInactiveInterval(30 * 60);

					out.write("Login successful");
				} else {
					out.write("Login failed");
				}
			} else {
				out.write("Login failed");
			}

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			out.write("Error: MySQL Driver not found");
		} catch (SQLException e) {
			e.printStackTrace();
			out.write("Error: " + e.getMessage());
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (SQLException e) {
			}
			try {
				if (ps != null)
					ps.close();
			} catch (SQLException e) {
			}
			try {
				if (connection != null)
					connection.close();
			} catch (SQLException e) {
			}
			out.flush();
		}
	}
}