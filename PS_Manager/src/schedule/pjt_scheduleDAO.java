package schedule;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import config.DB;

public class pjt_scheduleDAO {
	
	public String showPjtschedule(String pnum) {

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String strPjtschedule = "";

		try {
			conn = DB.dbConn();

			String sql = "select TO_CHAR(sday, 'YYYY/MM/DD'), TO_CHAR(eday, 'YYYY/MM/DD'), description from pjt_schedule where pnum = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pnum);
			rs = pstmt.executeQuery();

			strPjtschedule += "<pjtScheduleList>";
			String sday = "";
			String eday = "";
			String description = "";

			while (rs.next()) {
				strPjtschedule += "<scheduleInfo>";
				sday = rs.getString(1);
				eday = rs.getString(2);
				description = rs.getString(3);
				strPjtschedule += "<sday>" + sday + "</sday>";
				strPjtschedule += "<eday>" + eday + "</eday>";
				strPjtschedule += "<description>" + description + "</description>";
				strPjtschedule += "</scheduleInfo>";
			}
			strPjtschedule += "</pjtScheduleList>";
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return strPjtschedule;
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
			System.out.println("pjt_schedule에 삽입된 행 개수 : " + res);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

}
