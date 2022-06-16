package jspstudy.dbconn;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Dbconn {

	
		
	  //접속정보
		private Connection conn;
		
		String url="jdbc:mysql://localhost:3306/mysql?severTimezone=UTC&characterEncoding=UTF-8";
		String user="root";
		String password ="1234";
		
		public Connection getConnection() {
			Connection conn = null;

			try {
				// 해당패키지에 있는 클래스를 가져온다.
				System.out.println("생성자");
				Class.forName("com.mysql.jdbc.Driver");
				// 접속정보를 활용해서 연결객체를 가져온다.
				conn = DriverManager.getConnection(url, user, password);
				System.out.println("드라이버 로딩 성공");
			} catch (Exception e) {
				System.out.println("드라이버 로딩 실패");
				try {
					conn.close();
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
			}
			return conn;
		}
	}