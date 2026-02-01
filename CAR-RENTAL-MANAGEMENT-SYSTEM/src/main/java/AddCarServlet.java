import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/AddCarServlet")
public class AddCarServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String regNo = request.getParameter("carRegno");
		String model = request.getParameter("carModel");
		String yearStr = request.getParameter("carYear");
		String color = request.getParameter("carColor");
		String status = request.getParameter("carStatus");
		String priceStr = request.getParameter("carPrice");
		String location = request.getParameter("carLocation");

		try {
			int year = Integer.parseInt(yearStr);
			int price = Integer.parseInt(priceStr);

			Class.forName("com.mysql.cj.jdbc.Driver");
			try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_db", "root",
					"trickortreat")) {

				String sql = "INSERT INTO Car (Car_Regno, Car_Model, Car_Year, Car_Color, Car_Status, Car_Price, Car_Location) VALUES (?, ?, ?, ?, ?, ?, ?)";
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, regNo);
				pstmt.setString(2, model);
				pstmt.setInt(3, year);
				pstmt.setString(4, color);
				pstmt.setString(5, status);
				pstmt.setInt(6, price);
				pstmt.setString(7, location);

				int rows = pstmt.executeUpdate();
				if (rows > 0) {
					response.sendRedirect("add-new-car.jsp?status=success");
				} else {
					response.sendRedirect("add-new-car.jsp?status=failed");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("add-new-car.jsp.jsp?status=error");
		}
	}
}