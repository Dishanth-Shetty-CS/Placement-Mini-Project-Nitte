package com.email;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/verifyOTP")
public class VerifyOTP extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String verificationCode = request.getParameter("verification_code");

		if (verificationCode != null) {
			HttpSession session = request.getSession();
			String storedValue = (String) session.getAttribute("valueOTP");

			if (verificationCode.equals(storedValue)) {
				response.setContentType("text/plain");
				response.getWriter().write("change_password.jsp");
			} else {
				response.setContentType("text/plain");
				response.getWriter().write("Incorrect");
			}
		}

	}

}
