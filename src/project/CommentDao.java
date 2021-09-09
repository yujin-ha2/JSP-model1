package project;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class CommentDao {
	
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

	//답글 모두 조회
	public List<CommentDto> getReplies(int postIdx){
		List<CommentDto> list = new ArrayList<CommentDto>();
		CommentDto dto = null;
		String sql = "SELECT * FROM COMMENT WHERE POSTIDX = ? ORDER BY REGDATE DESC";
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			//Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(config.url, config.uId, config.uPwd);
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, postIdx);	
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				int idx = rs.getInt("idx");
				String content = rs.getString("content");
				String writerId = rs.getString("writer_id");
				int likeit = rs.getInt("likeit");
				Timestamp regdate = rs.getTimestamp("regdate");
				dto = new CommentDto(idx, postIdx, content, writerId, likeit, regdate);
				list.add(dto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			Close();
		}
		
		return list;
	}
	
	
	//답글의  해당하는 댓글들  조회
	public List<CommentDto> getComments(int postIdx, int parentIdx){
		List<CommentDto> list = null;
		CommentDto dto = null;
		String sql = "SELECT * FROM COMMENT WHERE POSTIDX = ? AND PARENTIDX = ? ORDER BY REGDATE DESC";
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			//Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(config.url, config.uId, config.uPwd);
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, postIdx);	
			pstmt.setInt(2, parentIdx);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				int idx = rs.getInt("idx");
				String content = rs.getString("content");
				String writerId = rs.getString("writer_id");
				int likeit = rs.getInt("likeit");
				Timestamp regdate = rs.getTimestamp("regdate");
				dto = new CommentDto(idx, postIdx, content, writerId, likeit, regdate);
				list.add(dto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			Close();
		}
		
		return list;
	}
	
	
	//답글 전체 개수
	public int getReplyCount(int postIdx) {
		
		int count = 0;
		String sql = "SELECT COUNT(*) AS COUNT FROM COMMENT WHERE POSTIDX = ? ORDER BY REGDATE DESC";
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			//Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(config.url, config.uId, config.uPwd);
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, postIdx);
			
			ResultSet rs = pstmt.executeQuery();	

			if(rs.next())
				count = rs.getInt("count");

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			Close();
		} 

		return count;
	}
	
	
	//답글에 해당하는 댓글의 전체 개수
	public int getCommentCount(int postIdx, int parentIdx) {
		int count = 0;
		String sql = "SELECT COUNT(IDX) COUNT FROM COMMENT WHERE POSTIDX = ? AND PARENTIDX = ? ORDER BY REGDATE DESC";
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			//Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(config.url, config.uId, config.uPwd);
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, postIdx);
			pstmt.setInt(2, parentIdx);
			
			ResultSet rs = pstmt.executeQuery();	

			if(rs.next())
				count = rs.getInt("count");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			Close();
		} 
		
		return count;
	}
	

	//답글 등록
	public int RegReply(CommentDto dto) {
		
		String sql = "INSERT INTO COMMENT(POSTIDX, CONTENT, WRITER_ID, BOARDTYPE) VALUES(?, ?, ?, ?)";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			//Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(config.url, config.uId, config.uPwd);
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, dto.getPostIdx());
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
	
	
	//답글 수정
	public int UpdateReply(int idx, String content) {  
		
		String sql = "UPDATE COMMENT SET CONTENT = ? WHERE IDX = ?";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			//Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(config.url, config.uId, config.uPwd);
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, content);
			pstmt.setInt(2, idx);
			
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			Close();
		}
		return 0;
	}

	
	//답글 삭제
	public int DeleteReply(int idx) {
		
		String sql = "DELETE FROM COMMENT WHERE IDX = ?";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			//Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(config.url, config.uId, config.uPwd);
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			Close();
		}
		
		return 0;
	}
	
	
	//댓글 등록
	public int RegComment(int postIdx, int parentIdx, CommentDto dto) {
		
		String sql = "INSERT INTO COMMENT(POSTIDX, PARENTIDX, CONTENT, WRITER_ID) VALUES(?, ?, ?, ?)";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			//Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(config.url, config.uId, config.uPwd);
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, postIdx);
			pstmt.setInt(2, parentIdx);
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getWriterId());
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			Close();
		}
		return 0;
	}
	
	
	//댓글 수정
	public int UpdateComment(int idx, String content) {  
		
		String sql = "UPDATE COMMENT SET CONTENT = ? WHERE IDX = ?";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			//Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(config.url, config.uId, config.uPwd);
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, content);
			pstmt.setInt(2, idx);
			
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			Close();
		}
		return 0;
	}
	
	
	//댓글 삭제
	public int DeleteComment(int idx) {
		
		String sql = "DELETE FROM COMMENT WHERE IDX = ?";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			//Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(config.url, config.uId, config.uPwd);
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			Close();
		}
		
		return 0;
	}
}
