package project;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class BoardDao {
		
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	Config config = new Config();
	
	public void Close() {
		try {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(con != null) con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public int RegisterBoard(BoardDto dto) {
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			//Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(config.url, config.uId, config.uPwd);
			
			String sql = "INSERT INTO BOARD (TITLE, CONTENT, WRITER_ID, BOARDTYPE) VALUES(?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getWriterId());
			pstmt.setString(4, dto.getBoardType());
			
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			Close();
		}
		return 0;
	}

	
	public List<BoardDto> getNoticeAll(String boardType, String keyField, String keyword, int page) {
		List<BoardDto> list = new ArrayList<BoardDto>();
		BoardDto boardDto = null;
		
		String sql = "";
		
		if(keyword == null || keyword.isEmpty()) 
			sql = "SELECT * FROM BOARD WHERE BOARDTYPE = ? ORDER BY REGDATE DESC LIMIT ?, 5";
		else
			sql = "SELECT * FROM BOARD WHERE BOARDTYPE = ? AND " + keyField + " LIKE '%" + keyword + "%' ORDER BY REGDATE DESC LIMIT ?, 5";
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			//Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(config.url, config.uId, config.uPwd);
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, boardType);
			pstmt.setInt(2, (page-1)*3);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				int idx = rs.getInt("idx");
				String title = rs.getString("title");
				String content = rs.getString("content");
				String writerId = rs.getString("writer_id");
				int hit = rs.getInt("hit");
				int likeit = rs.getInt("likeit");
				Timestamp regdate = rs.getTimestamp("regdate");
				boardDto = new BoardDto(idx, title, content, writerId, hit, likeit, regdate);
				list.add(boardDto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			Close();
		}
		return list;
	}
	
	
	public int getNoticeCount(String boardType, String keyField, String keyword) {  //게시판 글 전체 개수
		int count = 0;
		
		String sql = "SELECT COUNT(IDX) COUNT FROM BOARD WHERE BOARDTYPE = ? AND " + keyField + " LIKE '%" + keyword + "%' ORDER BY REGDATE DESC";
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			//Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(config.url, config.uId, config.uPwd);
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, boardType);
			
			ResultSet rs = pstmt.executeQuery();	

			if(rs.next())
				count = rs.getInt("count");

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			Close();
		}
		
		return count;
	}
	
	
	public BoardDto getNotice(String boardType, int idx) {
		BoardDto boardDto = null;
		String sql = "";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			//Class.forName("com.mysql.jdbc.Driver");
			sql = "UPDATE BOARD SET HIT = HIT + 1 WHERE BOARDTYPE = ? AND IDX = ?";
			con = DriverManager.getConnection(config.url, config.uId, config.uPwd);
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,  boardType);
			pstmt.setInt(2, idx);
			pstmt.executeUpdate();
			
			sql = "SELECT * FROM BOARD WHERE BOARDTYPE = ? AND IDX = ?";
			con = DriverManager.getConnection(config.url, config.uId, config.uPwd);
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,  boardType);
			pstmt.setInt(2, idx);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				String title = rs.getString("title");
				String writerId = rs.getString("writer_id");
				String content = rs.getString("content");
				int hit = rs.getInt("hit");
				int likeit = rs.getInt("likeit");
				Timestamp regdate = rs.getTimestamp("regdate");
				boardDto = new BoardDto(idx, title, content, writerId, hit, likeit, regdate);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			Close();
		}
		return boardDto;
	}
	
	
	public int UpdateNotice(BoardDto dto) {  //게시판 글 전체 개수
		
		String sql = "UPDATE BOARD SET TITLE = ?, CONTENT = ? WHERE BOARDTYPE=? AND IDX = ?";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			//Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(config.url, config.uId, config.uPwd);
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getBoardType());
			pstmt.setInt(4, dto.getIdx());
			
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			Close();
		}
		return 0;
	}
	
	
	public int DeleteBoard(String boardType, int idx) {
		
		String sql = "DELETE FROM BOARD WHERE BOARDTYPE = ? AND IDX = ?";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			//Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(config.url, config.uId, config.uPwd);
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, boardType);
			pstmt.setInt(2, idx);
			
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			Close();
		}
		
		return 0;
	}
	
	
	public List<BoardDto> getUserAllBoard(String userId, int page){
		List<BoardDto> list = new ArrayList<BoardDto>();
		BoardDto boardDto = null;
		
		String sql = "SELECT * FROM BOARD WHERE WRITER_ID = ? ORDER BY REGDATE DESC LIMIT ?, 5";
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			//Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(config.url, config.uId, config.uPwd);
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userId);
			pstmt.setInt(2, (page-1)*3);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				int idx = rs.getInt("idx");
				String title = rs.getString("title");
				String content = rs.getString("content");
				String writerId = rs.getString("writer_id");
				int hit = rs.getInt("hit");
				int likeit = rs.getInt("likeit");
				Timestamp regdate = rs.getTimestamp("regdate");
				String boardType = rs.getString("boardType");
				boardDto = new BoardDto(idx, title, content, writerId, hit, likeit, regdate);
				boardDto.setBoardType(boardType);
				list.add(boardDto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			Close();
		}
		return list;
	}
	
	
	public BoardDto getMainNotice(String boardType) {
		BoardDto boardDto = null;
		String sql = "";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			//Class.forName("com.mysql.jdbc.Driver");			
			sql = "select * from board where boardType = ? order by hit desc, regdate desc limit 1";
			con = DriverManager.getConnection(config.url, config.uId, config.uPwd);
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,  boardType);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				int idx = rs.getInt("idx");
				String title = rs.getString("title");
				String writerId = rs.getString("writer_id");
				String content = rs.getString("content");
				boardDto = new BoardDto();
				boardDto.setIdx(idx);
				boardDto.setTitle(title);
				boardDto.setWriterId(writerId);
				boardDto.setContent(content);
				boardDto.setBoardType(boardType);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			Close();
		}
		return boardDto;
	}
}

