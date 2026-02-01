package com.email;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.*;
import java.util.Random;

@WebServlet("/sendOTP")
public class SendOTP extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Connection con = null;
		Statement st = null;
		ResultSet rs = null;

		int checkEmail = 0;

		String user_table = request.getParameter("user_table");
		String email_address = request.getParameter("email_address");

		if (email_address != null) {
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aarogya_healthcare_db", "root",
						"trickortreat");

				st = con.createStatement();

				String storedEmailAddress = "SELECT COUNT(email_address) FROM " + user_table
						+ " WHERE email_address = \"" + email_address + "\"";
				rs = st.executeQuery(storedEmailAddress);
				rs.next();
				checkEmail = rs.getInt(1);

				if (checkEmail == 1) {
					Random rand = new Random();

					int randomOTP = 100000 + rand.nextInt(900000);

					HttpSession session = request.getSession();
					session.setAttribute("valueOTP", String.valueOf(randomOTP));

					JDBC data = new JDBC();

					GEmailSender gEmailSender = new GEmailSender();
					String to = email_address.trim();
					String from = data.getAdminData()[0];
					String subject = "OTP Verification";
					String text = "The verification code is " + randomOTP;
					boolean b = gEmailSender.sendEmail(to, from, subject, text);

					if (b) {
						response.setContentType("text/plain");
						response.getWriter().write("verify_otp.html");
					}

				} else {
					response.setContentType("text/plain");
					response.getWriter().write("Incorrect");
				}

				con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}

}
