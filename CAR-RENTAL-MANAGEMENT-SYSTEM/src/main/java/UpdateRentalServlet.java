import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UpdateRentalServlet")
public class UpdateRentalServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String rentalIdParam = request.getParameter("id");

		if (rentalIdParam == null || rentalIdParam.isEmpty()) {
			response.sendRedirect("manage-rentals.jsp?status=error");
			return;
		}

		try {
			int rentalId = Integer.parseInt(rentalIdParam);
			Class.forName("com.mysql.cj.jdbc.Driver");

			try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_db",
					"root", "trickortreat")) {

				String query = "SELECT Rental_ID, Rental_Name, Rent_Start_Date, Rent_End_Date, Rental_Status, Cust_Email, Car_Regno FROM Rental WHERE Rental_ID = ?";

				PreparedStatement preparedStatement = connection.prepareStatement(query);
				preparedStatement.setInt(1, rentalId);
				ResultSet resultSet = preparedStatement.executeQuery();

				if (resultSet.next()) {
					request.setAttribute("rentalId", resultSet.getInt("Rental_ID"));
					request.setAttribute("rentalName", resultSet.getString("Rental_Name"));
					request.setAttribute("rentStartDate", resultSet.getDate("Rent_Start_Date").toString());
					request.setAttribute("rentEndDate", resultSet.getDate("Rent_End_Date").toString());
					request.setAttribute("rentalStatus", resultSet.getString("Rental_Status"));
					request.setAttribute("custEmail", resultSet.getString("Cust_Email"));
					request.setAttribute("carRegno", resultSet.getString("Car_Regno"));

					request.getRequestDispatcher("/update-rental-form.jsp").forward(request, response);
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