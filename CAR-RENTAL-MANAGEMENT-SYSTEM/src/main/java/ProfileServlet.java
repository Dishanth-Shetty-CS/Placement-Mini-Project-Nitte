import java.io.IOException;
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
import jakarta.servlet.http.HttpSession;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String dbURL = "jdbc:mysql://localhost:3306/car_rental_db";
	private String dbUser = "root";
	private String dbPass = "trickortreat";

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("customerEmail") == null) {
			response.sendRedirect("customer-login.jsp");
			return;
		}
		String customerEmail = (String) session.getAttribute("customerEmail");
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPass)) {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String sql = "SELECT * FROM CUSTOMER WHERE Cust_Email = ?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, customerEmail);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				request.setAttribute("name", rs.getString("Cust_Name"));
				request.setAttribute("address", rs.getString("Cust_Address"));
				request.setAttribute("phone", rs.getString("Cust_Phone"));
				request.setAttribute("email", rs.getString("Cust_Email"));
				request.getRequestDispatcher("profile-update.jsp").forward(request, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("error.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("customerEmail") == null) {
			response.getWriter().write("Session Expired");
			return;
		}
		String oldEmail = (String) session.getAttribute("customerEmail");
		String name = request.getParameter("Cust_Name");
		String address = request.getParameter("Cust_Address");
		String phone = request.getParameter("Cust_Phone");
		String newEmail = request.getParameter("Cust_Email");
		String password = request.getParameter("Cust_Password");

		String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt(12));

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPass)) {
				String sql = "UPDATE CUSTOMER SET Cust_Name=?, Cust_Address=?, Cust_Phone=?, Cust_Email=?, Cust_Password=? WHERE Cust_Email=?";
				PreparedStatement preparedStatement = connection.prepareStatement(sql);
				preparedStatement.setString(1, name);
				preparedStatement.setString(2, address);
				preparedStatement.setString(3, phone);
				preparedStatement.setString(4, newEmail);
				preparedStatement.setString(5, hashedPassword);
				preparedStatement.setString(6, oldEmail);
				int rowsUpdated = preparedStatement.executeUpdate();
				if (rowsUpdated > 0) {
					session.setAttribute("customerEmail", newEmail);
					response.getWriter().write("Updated");
				} else {
					response.getWriter().write("Failed");
				}
			}
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
			response.getWriter().write("Error: " + e.getMessage());
		}
	}
}