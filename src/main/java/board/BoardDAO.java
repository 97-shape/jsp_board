package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import db.JdbcMySQLUtil;

public class BoardDAO {
	private Connection conn; 
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	
	public BoardDAO() {}
	
	public int boardCreate(BoardBean boardBean) {
		String SQL = "INSERT INTO board (title, userid, password, content, writedate, readcount, ref, step, level)"
				+ " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			conn = JdbcMySQLUtil.getConnection();
			
			pstmt.setString(1, boardBean.getTitle());
			pstmt.setString(2, boardBean.getId());
			pstmt.setString(3, boardBean.getPassword());
			pstmt.setString(4, boardBean.getContent());
			pstmt.setString(5, boardBean.getWriteDate());
			pstmt.setInt(6, boardBean.getReadCount());
			pstmt.setInt(7, boardBean.getRef());
			pstmt.setInt(8, boardBean.getRe_step());
			pstmt.setInt(9, boardBean.getRe_level());
            
            return pstmt.executeUpdate();
            	
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
	
	public int boardCount() {
		int count = 0;
		try {
			conn = JdbcMySQLUtil.getConnection();
			String sql="select count(*) from board";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery(sql);
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}catch(Exception ex) {
			
		}finally {
			JdbcMySQLUtil.close(rs);
			JdbcMySQLUtil.close(pstmt);
			JdbcMySQLUtil.close(conn);
		}

		return count;
	}
	
	// 페이지네이션 적용
	public ArrayList<BoardBean> boardListGet (int start, int end){
		String sql="select * from board order by ref desc, re_step asc limit ?,?";
		ArrayList<BoardBean> boardList = new ArrayList<BoardBean>();
		BoardBean board = null;
		
		try {
			conn = JdbcMySQLUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				board = new BoardBean();
				board.setNo(rs.getInt("no"));
				board.setTitle(rs.getString("title"));
				board.setId(rs.getString("userid"));
				board.setPassword(rs.getString("password"));
				board.setContent(rs.getString("content"));
				board.setWriteDate(rs.getString("writedate"));
				board.setReadCount(rs.getInt("readcount"));
				board.setRef(rs.getInt("ref"));
				board.setRe_step(rs.getInt("re_step"));
				board.setRe_level(rs.getInt("re_level"));
				
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
}