package coworker;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import config.DB;

public class coworkerDAO {

	public int addCoworker(String pnum, String coworkers) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int res = 0;

		try {
			conn = DB.dbConn();
			String[] userid = coworkers.split("&");
			String temp;

			// id 존재 유무 확인
			for (int i = 0; i < userid.length; i++) {
				pstmt = null;
				rs = null;
				temp = null;

				// id 값만 분리
				temp = userid[i].substring(userid[i].indexOf('=') + 1, userid[i].length());
				if (temp.equals(""))
					continue;
				System.out.println("name = " + temp);

				String sql = "select userid from account where userid = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, temp);
				rs = pstmt.executeQuery();

				// userid 존재 X
				if (!rs.next())
					return -1;
			}

			// coworker에 추가
			for (int i = 0; i < userid.length; i++) {
				pstmt = null;
				rs = null;
				temp = null;

				// id 값만 분리
				temp = userid[i].substring(userid[i].indexOf('=') + 1, userid[i].length());
				if (temp.equals(""))
					continue;
				System.out.println("name = " + temp);

				String sql = "insert into coworker values(?, ?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, temp);
				pstmt.setString(2, pnum);
				res += pstmt.executeUpdate();
			}
			System.out.println("coworker에 삽입된 행 개수 : "+res);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

}
