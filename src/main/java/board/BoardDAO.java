package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import card.CardBean;
import db.JdbcMySQLUtil;

public class BoardDAO {
	private Connection conn; 
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public BoardDAO() {}
	
	// CREATE
	public int boardCreate(BoardBean boardBean) {
		String sql = "INSERT INTO board (title, userID, password, content, src, writedate, readcount, ref, ref_level, ref_step)"
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			conn = JdbcMySQLUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, boardBean.getTitle());
			pstmt.setString(2, boardBean.getId());
			pstmt.setString(3, boardBean.getPassword());
			pstmt.setString(4, boardBean.getContent());
			pstmt.setString(5, boardBean.getSrc());
			pstmt.setString(6, boardBean.getWriteDate());
			pstmt.setInt(7, boardBean.getReadCount());
			pstmt.setInt(8, boardBean.getRef());
			pstmt.setInt(9, boardBean.getRef_level());
			pstmt.setInt(10, boardBean.getRef_step());

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
	
	// DELETE
	public int boardDelete(int boardNo) {
		String sql = "DELETE FROM board WHERE no = ?";
		 try {
			conn = JdbcMySQLUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, boardNo);
	
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
		
	//LIST
	public ArrayList<BoardBean> boardListGet (int start, int amount){
		String sql="select * from board order by ref desc,ref_level asc limit ?,10";
		ArrayList<BoardBean> boardList = new ArrayList<BoardBean>();
		BoardBean board = null;
		
		try {
			conn = JdbcMySQLUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			// pstmt.setInt(2, amount);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				board = new BoardBean();
				board.setNo(rs.getInt("no"));
				board.setTitle(rs.getString("title"));
				board.setId(rs.getString("userID"));
				board.setPassword(rs.getString("password"));
				board.setContent(rs.getString("content"));
				board.setWriteDate(rs.getString("writeDate"));
				board.setReadCount(rs.getInt("readCount"));
				board.setRef(rs.getInt("ref"));
				board.setRef_level(rs.getInt("ref_level"));
				board.setRef_step(rs.getInt("ref_step"));
				
				boardList.add(board);
				
			}
		}catch (Exception ex){
			ex.printStackTrace();
		}finally {
			JdbcMySQLUtil.close(rs);
			JdbcMySQLUtil.close(pstmt);
			JdbcMySQLUtil.close(conn);
		}
		return boardList;
	}
	
	
	// VIEW
	public BoardBean boardView (int boardNo) {
		boardReadCount(boardNo);
		String sql="select * from board where no=?";
		BoardBean board = null;
		
		try {
			conn = JdbcMySQLUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardNo);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				board = new BoardBean();
				board.setNo(boardNo);
				board.setTitle(rs.getString("title"));
				board.setId(rs.getString("userId"));
				board.setPassword(rs.getString("password"));
				board.setContent(rs.getString("content"));
				board.setSrc(rs.getString("src"));
				board.setWriteDate(rs.getString("writedate"));
				board.setReadCount(rs.getInt("readcount"));
				board.setRef(rs.getInt("ref"));
				board.setRef_level(rs.getInt("ref_level"));
				board.setRef_step(rs.getInt("ref_step"));
			}
		}catch (Exception ex){
			ex.printStackTrace();
		}finally {
			JdbcMySQLUtil.close(rs);
			JdbcMySQLUtil.close(pstmt);
			JdbcMySQLUtil.close(conn);
		}
		return board;
	}
	
	// PASSWORD CHECK
	public String boardPasswordCheck(int boardNo) {
		String sql="select password from board where no=?";
		String password = null;
		
		try {
			conn = JdbcMySQLUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardNo);
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
	
	//etc
	public int boardCount() {
		String sql="select count(*) from board";
		int count = 0;
		
		try {
			conn = JdbcMySQLUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
		
			
			if (rs.next()) {
				count = rs.getInt(1);
			}
		}catch (Exception ex){
			ex.printStackTrace();
		}finally {
			JdbcMySQLUtil.close(rs);
			JdbcMySQLUtil.close(pstmt);
			JdbcMySQLUtil.close(conn);
		}
		return count;
	}
	
	public int boardRef() {
		String sql="select max(ref) from board";
		int ref = -1;
		
		try {
			conn = JdbcMySQLUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
		
			
			if (rs.next()) {
				ref = rs.getInt(1)+1;
			}
		}catch (Exception ex){
			ex.printStackTrace();
		}finally {
			JdbcMySQLUtil.close(rs);
			JdbcMySQLUtil.close(pstmt);
			JdbcMySQLUtil.close(conn);
		}
		return ref;
	}
	
	public int boardRef_level(int ref, int ref_step) {
		String sql="select max(ref_level) from board where ref = ? and ref_step = ?";
		int result = 0;
		
		try {
			conn = JdbcMySQLUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ref);
			pstmt.setInt(2, ref_step);
			rs = pstmt.executeQuery();
		
			if (rs.next()) {
				result = rs.getInt(1)+1;
			}
		}catch (Exception ex){
			ex.printStackTrace();
		}finally {
			JdbcMySQLUtil.close(rs);
			JdbcMySQLUtil.close(pstmt);
			JdbcMySQLUtil.close(conn);
		}
		return result;
	}
	
	public void boardReadCount(int boardNo) {
		String sql = "update board set readcount = (readcount + 1) where no = ?";
		try {
			conn = JdbcMySQLUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardNo);
			pstmt.executeUpdate();
			conn.commit();
            	
		}catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			JdbcMySQLUtil.close(pstmt);
			JdbcMySQLUtil.close(conn);
		}
	}
		
}