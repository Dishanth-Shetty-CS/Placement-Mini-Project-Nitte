package com.email;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class JDBC {
	String url = "jdbc:mysql://localhost:3306/aarogya_healthcare_db";
	String username = "root";
	String password = "trickortreat";
	String[] result = new String[2];

	public String[] getAdminData() {
		String sql = "SELECT * FROM admin_email_credentials";

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, username, password);
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(sql);
			rs.next();
			for (int i = 1; i < 3; i++) {
				result[i - 1] = rs.getString(i);
			}
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return result;
	}
}
