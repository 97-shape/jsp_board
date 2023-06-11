package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import db.JdbcMySQLUtil;

public class UserDAO {
	private Connection conn; //db 접근 객체 
	private PreparedStatement pstmt;
	private ResultSet rs; // db 결과를 담는 객체
	
	public UserDAO() {}
	
	// 로그인
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM user WHERE userID = ?";
		System.out.println(userID + " " + userPassword);
		try {
			conn = JdbcMySQLUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery(); 
			if (rs.next()) {
				if (rs.getString(1).equals(userPassword)) // 비밀번호 확인
					return 1; //로그인 성공
			}
		}catch(Exception e) {
			e.printStackTrace();
			
		}
		finally {
			JdbcMySQLUtil.close(rs);
			JdbcMySQLUtil.close(pstmt);
			JdbcMySQLUtil.close(conn);
		}
		return -2; //DB 오류 
	}
	
	// 사용자 이름 가져오기
	
	public String username(String userID) {
		String SQL = "SELECT userName FROM user WHERE userID = ?";
		try {
			conn = JdbcMySQLUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery(); 
			if (rs.next()) {
				return rs.getString(1);
			} 
		}catch(Exception e) {
			e.printStackTrace();
			
		}
		finally {
			JdbcMySQLUtil.close(rs);
			JdbcMySQLUtil.close(pstmt);
			JdbcMySQLUtil.close(conn);
		}
		return "error";
	}
	
	// 회원가입
	public int join(UserBean user) {
		String SQL = "INSERT INTO user (userID, userPassword, userName) VALUES (?, ?, ?)";
		try {
			conn = JdbcMySQLUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			
			if(pstmt.executeUpdate() == 1) {
				conn.commit();
				return 1;
			} 
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcMySQLUtil.close(rs);
			JdbcMySQLUtil.close(pstmt);
			JdbcMySQLUtil.close(conn);
		}
		return -2; // error
	}
	
	// 중복 검사
	public int isUniqueId(String id) {
		String SQL = "SELECT userID FROM user WHERE userID = ?";
		try {
			conn = JdbcMySQLUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery(); 
			if (rs.next()) {
				return 0;  // 아이디 중복됨 
			} else {
				return 1; // 아이디 중복 없음
			}
		}catch(Exception e) {
			e.printStackTrace();
			
		}
		finally {
			JdbcMySQLUtil.close(rs);
			JdbcMySQLUtil.close(pstmt);
			JdbcMySQLUtil.close(conn);
		}
		return -2; //DB 오류 
	}
}