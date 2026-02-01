import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

@WebServlet("/UpdateRentalActionServlet")
public class UpdateRentalActionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			int rentalId = Integer.parseInt(request.getParameter("rentalId"));
			String rentalName = request.getParameter("rentalName");
			String startStr = request.getParameter("rentStartDate");
			String endStr = request.getParameter("rentEndDate");
			String rentalStatus = request.getParameter("rentalStatus");
			String custEmail = request.getParameter("custEmail");
			String carRegno = request.getParameter("carRegno");

			if (startStr == null || endStr == null || startStr.isEmpty() || endStr.isEmpty()) {
				response.sendRedirect("manage-rentals.jsp?status=error");
				return;
			}

			Date rentStartDate = Date.valueOf(startStr);
			Date rentEndDate = Date.valueOf(endStr);

			Class.forName("com.mysql.cj.jdbc.Driver");
			try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_db",
					"root", "trickortreat")) {

				String query = "UPDATE Rental SET Rental_Name = ?, Rent_Start_Date = ?, Rent_End_Date = ?, Rental_Status = ?, Cust_Email = ?, Car_Regno = ? WHERE Rental_ID = ?";

				PreparedStatement preparedStatement = connection.prepareStatement(query);
				preparedStatement.setString(1, rentalName);
				preparedStatement.setDate(2, rentStartDate);
				preparedStatement.setDate(3, rentEndDate);
				preparedStatement.setString(4, rentalStatus);
				preparedStatement.setString(5, custEmail);
				preparedStatement.setString(6, carRegno);
				preparedStatement.setInt(7, rentalId);

				int rowsAffected = preparedStatement.executeUpdate();
				if (rowsAffected > 0) {
					response.sendRedirect("manage-rentals.jsp?status=updated");
				} else {
					response.sendRedirect("manage-rentals.jsp?status=error");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("manage-rentals.jsp?status=error");
		}
	}
}