package project_info;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import config.DB;

public class PjtInfo_DAO {
	public int insertPjt(PjtInfo_DTO dto) {
		int res = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = DB.dbConn();

			// pjt_info에 정보 삽입
			String sql = "insert into pjt_info values (seq_pnum.nextval,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getPname());
			pstmt.setString(2, dto.getPmanager());
			pstmt.setString(3, dto.getPdescription());

			res = pstmt.executeUpdate();
			System.out.println("pjt_info 정보 : " + res);

			// pjt_info의 pnum값 가져와서 coworker에 삽입
			sql = "insert into coworker values(?,(select pnum from pjt_info where pname =? and pmanager = ?))";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getPmanager());
			pstmt.setString(2, dto.getPname());
			pstmt.setString(3, dto.getPmanager());
			res = pstmt.executeUpdate();
			System.out.println("coworker �깮�꽦�맂 row�쓽 媛쒖닔 : " + res);

		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		} finally {
			try {
				if (conn != null)
					conn.close();
				if (pstmt != null)
					pstmt.close();
			} catch (Exception e2) {
				// TODO: handle exception
				e2.printStackTrace();
			}
		}
		return res;
	}

	public String showPjt(String userid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String strPjt = "";

		try {
			conn = DB.dbConn();
			String sql = "select pnum, pname from pjt_info where pnum in (select pnum from coworker where userid = ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			strPjt += "<pjtList>";
			String pnum = "";
			String pname = "";
			while (rs.next()) {
				strPjt += "<pjtInfo>";
				pnum = rs.getString(1);
				pname = rs.getString(2);
				strPjt += "<pnum>" + pnum + "</pnum>";
				strPjt += "<pname>" + pname + "</pname>";
				strPjt += "</pjtInfo>";
			}
			strPjt += "</pjtList>";

		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			try {
				if (conn != null)
					conn.close();
				if (pstmt != null)
					pstmt.close();
			} catch (Exception e2) {
				// TODO: handle exception
				e2.printStackTrace();
			}
		}
		return strPjt;
	}
}
