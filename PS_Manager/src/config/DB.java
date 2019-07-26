package config;

import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DB {
	public static Connection dbConn() {
		DataSource ds = null;
		Connection conn = null;
		try {
			Context ctx = new InitialContext(); // context.xml 파일을 분석하는 클래스
			// Resource 태그에 설정된 정보를 읽어서  DB 커넥션을 받는 코드
			// java:comp/env/Resource태그의 이름
			ds = (DataSource)ctx.lookup("java:comp/env/psmDB");
			conn = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
}
