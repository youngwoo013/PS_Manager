package project_info;

import java.sql.Connection;
import java.sql.PreparedStatement;

import config.DB;

public class PjtInfo_DAO {
	public int insertPjt(PjtInfo_DTO dto) {
		int res = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = DB.dbConn();
			String sql = "insert into pjt_info values (seq_pnum.nextval,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getPname());
			pstmt.setString(2, dto.getPmanager());
			pstmt.setString(3, dto.getPdescription());

			res = pstmt.executeUpdate();
			System.out.println("pjt_info 생성된 row의 개수 : " + res);

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
		return res;
	}
}
