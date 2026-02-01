import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Timestamp;
import java.util.Date;
import java.util.concurrent.ThreadLocalRandom; // Required for random ID

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ProcessPayment")
public class ProcessPayment extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = response.getWriter();

		String payMethod = request.getParameter("payMethod");
		String rentalIDStr = request.getParameter("rentalID");
		String amountStr = request.getParameter("amount");

		Connection conn = null;
		PreparedStatement stmt = null;

		try {
			if (rentalIDStr == null || amountStr == null) {
				out.print("{\"status\":\"error\", \"message\":\"Missing parameters\"}");
				return;
			}

			int payId = ThreadLocalRandom.current().nextInt(1000, 10000);

			int rentalID = Integer.parseInt(rentalIDStr);
			double amountPaid = Double.parseDouble(amountStr);

			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_db", "root", "trickortreat");

			String query = "INSERT INTO Payment (Pay_ID, Pay_Method, Pay_status, Rental_ID, Amount_Paid, Pay_Date_Time) VALUES (?, ?, ?, ?, ?, ?)";
			stmt = conn.prepareStatement(query);

			stmt.setInt(1, payId);
			stmt.setString(2, payMethod);
			stmt.setString(3, "Completed");
			stmt.setInt(4, rentalID);
			stmt.setDouble(5, amountPaid);

			Timestamp timestamp = new Timestamp(new Date().getTime());
			stmt.setTimestamp(6, timestamp);

			int rowsAffected = stmt.executeUpdate();

			if (rowsAffected > 0) {
				out.print("{\"status\":\"success\", \"payId\":" + payId + "}");
			} else {
				out.print("{\"status\":\"error\", \"message\":\"Database update failed\"}");
			}

		} catch (Exception e) {
			e.printStackTrace();
			out.print("{\"status\":\"error\", \"message\":\"" + e.getMessage() + "\"}");
		} finally {
			try {
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}