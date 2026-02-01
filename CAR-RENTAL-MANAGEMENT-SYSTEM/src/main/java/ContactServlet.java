import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.concurrent.ThreadLocalRandom;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ContactServlet")
public class ContactServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String name = request.getParameter("userName");
		String email = request.getParameter("userEmail");
		String car = request.getParameter("userCar");
		String msg = request.getParameter("userMsg");

		int contactId = ThreadLocalRandom.current().nextInt(1000, 10000);

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_db", "root",
					"trickortreat");

			String sql = "INSERT INTO contact_requests (id, full_name, email, preferred_vehicle, message) VALUES (?, ?, ?, ?, ?)";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, contactId);
			pstmt.setString(2, name);
			pstmt.setString(3, email);
			pstmt.setString(4, car);
			pstmt.setString(5, msg);

			int row = pstmt.executeUpdate();
			conn.close();

			if (row > 0) {
				response.getWriter().write("SUCCESS");
			} else {
				response.getWriter().write("FAIL");
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().write("ERROR: " + e.getMessage());
		}
	}
}