package util;

import java.sql.*;


public class DBUtil {
	public Connection getConnection() throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		String dbUrl="jdbc:mariadb://127.0.0.1:3306/cashbook";
		String dbUser="root";
		String dbPw="java1234";
		Connection conn =DriverManager.getConnection(dbUrl,dbUser,dbPw);
		return conn;
	}
	public void close(ResultSet rs, PreparedStatement stmt, Connection conn ) throws Exception {
		if(rs!=null) {rs.close();
		}
		if(rs!=null) {stmt.close();
		}
		if(rs!=null) {conn.close();
		}
	}
}
