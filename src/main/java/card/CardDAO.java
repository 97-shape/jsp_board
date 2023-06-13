package card;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import board.BoardBean;
import db.JdbcMySQLUtil;

public class CardDAO {
	private Connection conn; //db 접근 객체 
	private PreparedStatement pstmt;
	private ResultSet rs; // db 결과를 담는 객체
	
	public CardDAO() {}
	// CREATE
	public int cardCreate(CardBean cardBean) {
		String sql = "INSERT INTO card (name, role, phone, email, company_number, company_address, image, userID, password)"
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			conn = JdbcMySQLUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, cardBean.getName());
			pstmt.setString(2, cardBean.getRole());
			pstmt.setString(3, cardBean.getPhone());
			pstmt.setString(4, cardBean.getEmail());
			pstmt.setString(5, cardBean.getCompany_number());
			pstmt.setString(6, cardBean.getCompany_address());
			pstmt.setString(7, cardBean.getImage());
			pstmt.setString(8, cardBean.getUserID());
			pstmt.setString(9, cardBean.getPassword());

			int result = pstmt.executeUpdate();
			conn.commit();
            return result;
            	
		}catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			JdbcMySQLUtil.close(pstmt);
			JdbcMySQLUtil.close(conn);
		}
		return -2; //DB 오류 
	}
	
	// DB UPDATE
	public int cardUpdate(CardBean cardBean) {
		String sql = "update card set name=?, role=?, phone=?, email=?, company_number=?, company_address=?, image=?, userID=?, password=?"
				+ " where cardNo=?";
        try {
			conn = JdbcMySQLUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, cardBean.getName());
			pstmt.setString(2, cardBean.getRole());
			pstmt.setString(3, cardBean.getPhone());
			pstmt.setString(4, cardBean.getEmail());
			pstmt.setString(5, cardBean.getCompany_number());
			pstmt.setString(6, cardBean.getCompany_address());
			pstmt.setString(7, cardBean.getImage());
			pstmt.setString(8, cardBean.getUserID());
			pstmt.setString(9, cardBean.getPassword());
			pstmt.setInt(10, cardBean.getCardNo());
			
			System.out.print(pstmt);

			int result = pstmt.executeUpdate();
			conn.commit();
            return result;
            	
		}catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			JdbcMySQLUtil.close(pstmt);
			JdbcMySQLUtil.close(conn);
		}
		return -2; //DB 오류 
	}
	// DB DELETE
	public int cardDelete(int cardNo) {
		String sql = "DELETE FROM card WHERE cardNo = ?";
		 try {
			conn = JdbcMySQLUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, cardNo);
			System.out.print(pstmt);
	
			int result = pstmt.executeUpdate();
			conn.commit();
	        return result;
	        	
		}catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			JdbcMySQLUtil.close(pstmt);
			JdbcMySQLUtil.close(conn);
		}
		return -2; //DB 오류 
	}
	
	// DB LIST
	public ArrayList<CardBean> cardListGet (int start, int end){
		String sql="select * from card order by cardNo desc limit ?,?";
		ArrayList<CardBean> cardList = new ArrayList<CardBean>();
		CardBean card = null;
		
		try {
			conn = JdbcMySQLUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				card = new CardBean();
				card.setCardNo(rs.getInt("cardNo"));
				card.setName(rs.getString("name"));
				card.setRole(rs.getString("role"));
				card.setPhone(rs.getString("phone"));
				card.setEmail(rs.getString("email"));
				card.setCompany_number(rs.getString("company_number"));
				card.setCompany_address(rs.getString("company_address"));
				card.setImage(rs.getString("image"));
				card.setUserID(rs.getString("userID"));
				card.setPassword(rs.getString("password"));
				
				cardList.add(card);
				
			}
		}catch (Exception ex){
			ex.printStackTrace();
		}finally {
			JdbcMySQLUtil.close(rs);
			JdbcMySQLUtil.close(pstmt);
			JdbcMySQLUtil.close(conn);
		}
		return cardList;
	}
	// VIEW
	public CardBean cardView (int cardNo) {
		String sql="select * from card where cardNo=?";
		CardBean card = null;
		
		try {
			conn = JdbcMySQLUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cardNo);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				card = new CardBean();
				card.setCardNo(rs.getInt("cardNo"));
				card.setName(rs.getString("name"));
				card.setRole(rs.getString("role"));
				card.setPhone(rs.getString("phone"));
				card.setEmail(rs.getString("email"));
				card.setCompany_number(rs.getString("company_number"));
				card.setCompany_address(rs.getString("company_address"));
				card.setImage(rs.getString("image"));
				card.setUserID(rs.getString("userID"));
				card.setPassword(rs.getString("password"));
			}
		}catch (Exception ex){
			ex.printStackTrace();
		}finally {
			JdbcMySQLUtil.close(rs);
			JdbcMySQLUtil.close(pstmt);
			JdbcMySQLUtil.close(conn);
		}
		return card;
	}
	
	// PASSWORD CHECK
	public String cardPasswordCheck(int cardNo) {
		String sql="select password from card where cardNo=?";
		String password = null;
		
		try {
			conn = JdbcMySQLUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cardNo);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				password = rs.getString("password");
			}
		}catch (Exception ex){
			ex.printStackTrace();
		}finally {
			JdbcMySQLUtil.close(rs);
			JdbcMySQLUtil.close(pstmt);
			JdbcMySQLUtil.close(conn);
		}
		return password;
	}
}
