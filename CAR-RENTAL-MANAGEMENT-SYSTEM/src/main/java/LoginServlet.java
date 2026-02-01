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

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String email = request.getParameter("Cust_Email").trim();
		String password = request.getParameter("Cust_Password").trim();

		// System.out.println("Login attempt: Email='" + email + "', Password='" +
		// password + "'");

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

			String query = "SELECT Cust_Name, Cust_Password FROM Customer WHERE LOWER(Cust_Email) = LOWER(?)";
			ps = connection.prepareStatement(query);
			ps.setString(1, email);

			rs = ps.executeQuery();

			if (rs.next()) {
				String customerName = rs.getString("Cust_Name");
				String hashedPassword = rs.getString("Cust_Password");

				if (BCrypt.checkpw(password, hashedPassword)) {
					HttpSession session = request.getSession();
					session.setAttribute("customerEmail", email);
					session.setAttribute("customerName", customerName);
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
