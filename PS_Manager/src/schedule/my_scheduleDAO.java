package schedule;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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
			System.out.println("my_schedule에 삽입된 행 개수 : " + res);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return res;
	}

	public String showMyschedule(String userid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String strMyschedule = "";

		try {
			conn = DB.dbConn();

			String sql = "select TO_CHAR(sday, 'YYYY/MM/DD'), TO_CHAR(eday, 'YYYY/MM/DD'), description from my_schedule where userid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();

			strMyschedule += "<myScheduleList>";
			String sday = "";
			String eday = "";
			String description = "";

			while (rs.next()) {
				strMyschedule += "<scheduleInfo>";
				sday = rs.getString(1);
				eday = rs.getString(2);
				description = rs.getString(3);
				strMyschedule += "<sday>" + sday + "</sday>";
				strMyschedule += "<eday>" + eday + "</eday>";
				strMyschedule += "<description>" + description + "</description>";
				strMyschedule += "</scheduleInfo>";
			}
			strMyschedule += "</myScheduleList>";

		} catch (Exception e) {
			e.printStackTrace();
		}
		return strMyschedule;
	}
}