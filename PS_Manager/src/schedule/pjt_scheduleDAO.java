package schedule;

import java.sql.Connection;
import java.sql.PreparedStatement;

import config.DB;

public class pjt_scheduleDAO {
	public int showPjtSchedule(pjt_scheduleDTO dto) {
		int res = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = DB.dbConn();
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return res;
	}
	
	public int addPjtSchedule(pjt_scheduleDTO dto) {
		int res = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = DB.dbConn();
			
			String sql = "insert into pjt_schedule values(seq_psnum.nextval,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getPnum());
			pstmt.setString(2, dto.getSday());
			pstmt.setString(3, dto.getEday());
			pstmt.setString(4, dto.getDescription());
			
			res = pstmt.executeUpdate();
			System.out.println("pjt_schedule 생성된 row의 개수 : " + res);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

}
