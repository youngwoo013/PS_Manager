package schedule;

import java.sql.Connection;
import java.sql.PreparedStatement;

import config.DB;

public class my_scheduleDAO {
	public int addMySchedule(my_scheduleDTO dto) {
		int res = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = DB.dbConn();

			String sql = "insert into my_schedule values(seq_msnum.nextval,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUserid());
			pstmt.setString(2, dto.getSday());
			pstmt.setString(3, dto.getEday());
			pstmt.setString(4, dto.getDescription());

			res = pstmt.executeUpdate();
			System.out.println("my_schedule 생성된 row의 개수 : " + res);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return res;
	}
}
