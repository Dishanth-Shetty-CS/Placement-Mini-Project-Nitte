import java.io.IOException;
import java.sql.*;
import java.util.concurrent.ThreadLocalRandom;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ProcessRent")
public class ProcessRent extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		response.setContentType("application/json");

		if (session == null || session.getAttribute("customerEmail") == null) {
			response.getWriter().write("{\"status\":\"error\", \"message\":\"Session expired\"}");
			return;
		}

		String email = (String) session.getAttribute("customerEmail");
		int rentalId = ThreadLocalRandom.current().nextInt(1000, 10000);

		String name = request.getParameter("rentalName");
		String start = request.getParameter("rentStartDate");
		String end = request.getParameter("rentEndDate");
		String regno = request.getParameter("carRegno");
		String totalPriceStr = request.getParameter("totalCarPrice");

		Connection con = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_db", "root", "trickortreat");

			String sql = "INSERT INTO RENTAL (Rental_ID, Rental_Name, Rent_Start_Date, Rent_End_Date, Rental_Status, Cust_Email, Car_Regno, Total_Car_Price) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement ps = con.prepareStatement(sql);

			ps.setInt(1, rentalId);
			ps.setString(2, name);
			ps.setString(3, start);
			ps.setString(4, end);
			ps.setString(5, "Active");
			ps.setString(6, email);
			ps.setString(7, regno);
			ps.setDouble(8, Double.parseDouble(totalPriceStr));

			if (ps.executeUpdate() > 0) {
				response.getWriter().write("{\"status\":\"success\", \"rentalId\":\"" + rentalId + "\"}");
			}
			con.close();
		} catch (Exception e) {
			response.getWriter().write("{\"status\":\"error\", \"message\":\"" + e.getMessage() + "\"}");
		}
	}
}