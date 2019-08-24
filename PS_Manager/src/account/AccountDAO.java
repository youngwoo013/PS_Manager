package account;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import config.DB;


public class AccountDAO {
	public String loginCheck(String userid, String passwd) {
		String name = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DB.dbConn();
			String sql = "select * from account where userid = ? and passwd = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setString(2, passwd);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				name = rs.getString(3);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			try {
				if (conn != null)
					conn.close();
				if (pstmt != null)
					pstmt.close();
				if (rs != null)
					rs.close();
			} catch (Exception e2) {
				// TODO: handle exception
				e2.printStackTrace();
			}
		}
		return name;
	}

	public void insertAccount(AccountDTO dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DB.dbConn();
			String sql = "insert into account values (?, ?, ?, ?, ?, ?, null)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUserid());
			pstmt.setString(2, dto.getPasswd());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getPhonenum());
			pstmt.setString(5, dto.getEmail());
			pstmt.setInt(6, dto.getBirth());
			int r = pstmt.executeUpdate();
			System.out.println("account �깮�꽦�맂 row�쓽 媛쒖닔 : " + r);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
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
	}
	
	public boolean validateID(String userid) {
		String name = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean exist = false;
		try {
			conn = DB.dbConn();
			String sql = "select userid from account where userid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				name = rs.getString(1);
			}
			if(name != null) exist = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			try {
				if (conn != null)
					conn.close();
				if (pstmt != null)
					pstmt.close();
				if (rs != null)
					rs.close();
			} catch (Exception e2) {
				// TODO: handle exception
				e2.printStackTrace();
			}
		}
		return exist;
	}
	
	public void updateAccount(AccountDTO dto) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			System.out.println("ㅅㅂ");
			conn = DB.dbConn();
			String sql = "update account set userid=?, passwd=?, name=?, phonenum=?, email=?, birth=?, photo=? where userid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUserid());
			pstmt.setString(2, dto.getPasswd());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getPhonenum());
			pstmt.setString(5, dto.getEmail());
			pstmt.setInt(6, dto.getBirth());
			pstmt.setString(7,  dto.getPhoto());
			pstmt.setString(8, dto.getUserid());
			pstmt.executeUpdate();
			System.out.println("수정완료 ");
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
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
	}
	
	
	public void profile(String Userid, String Userprofile) { //프로필사진 업데이트용 method
		System.out.println("userid");
		System.out.println("Userprofile");
		Connection conn=null;
		PreparedStatement pstmt=null;
		try {
			System.out.println("ㅅㅂ");
			conn = DB.dbConn();
			String sql = "update account set photo=? where userid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, Userprofile);
			pstmt.setString(2, Userid);
			
			System.out.println(Userid+Userprofile+"업데이트 완료");
			pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null)
					conn.close();
				if (pstmt != null)
					pstmt.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
	}
}
