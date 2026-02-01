import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UpdateCustomerServlet")
public class UpdateCustomerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String email = request.getParameter("email");

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_db", "root",
					"trickortreat")) {
				String sql = "SELECT * FROM Customer WHERE Cust_Email = ?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1, email);
				ResultSet rs = ps.executeQuery();

				if (rs.next()) {
					request.setAttribute("custName", rs.getString("Cust_Name"));
					request.setAttribute("custAddress", rs.getString("Cust_Address"));
					request.setAttribute("custPhone", rs.getString("Cust_Phone"));
					request.setAttribute("custEmail", rs.getString("Cust_Email"));
					request.getRequestDispatcher("update-customer-form.jsp").forward(request, response);
				} else {
					response.sendRedirect("update-customer-form.jsp?status=error");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("manage-customers.jsp?status=error");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String name = request.getParameter("custName");
		String address = request.getParameter("custAddress");
		String phone = request.getParameter("custPhone");
		String email = request.getParameter("custEmail");

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_db", "root",
					"trickortreat")) {
				String sql = "UPDATE Customer SET Cust_Name=?, Cust_Address=?, Cust_Phone=? WHERE Cust_Email=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1, name);
				ps.setString(2, address);
				ps.setString(3, phone);
				ps.setString(4, email);

				int rows = ps.executeUpdate();
				if (rows > 0) {
					response.sendRedirect("manage-customers.jsp?status=updated");
				} else {
					response.sendRedirect("manage-customers.jsp?status=error");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("manage-customers.jsp?status=error");
		}
	}
}