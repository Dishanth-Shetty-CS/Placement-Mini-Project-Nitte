import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UpdateCarServlet")
public class UpdateCarServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String carRegno = request.getParameter("id");

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_db",
					"root", "trickortreat")) {

				String query = "SELECT * FROM Car WHERE Car_Regno = ?";
				PreparedStatement preparedStatement = connection.prepareStatement(query);
				preparedStatement.setString(1, carRegno);

				ResultSet resultSet = preparedStatement.executeQuery();

				if (resultSet.next()) {
					request.setAttribute("regNo", resultSet.getString("Car_Regno"));
					request.setAttribute("model", resultSet.getString("Car_Model"));
					request.setAttribute("year", resultSet.getInt("Car_Year"));
					request.setAttribute("color", resultSet.getString("Car_Color"));
					request.setAttribute("status", resultSet.getString("Car_Status"));
					request.setAttribute("price", resultSet.getInt("Car_Price"));

					request.setAttribute("location", resultSet.getString("Car_Location"));
					request.getRequestDispatcher("update-car.jsp").forward(request, response);
				} else {
					response.sendRedirect("manage-cars.jsp?status=notfound");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().print("Error: " + e.getMessage());
		}
	}
}