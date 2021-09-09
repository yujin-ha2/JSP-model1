package project;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.sun.org.apache.xpath.internal.compiler.Keywords;

public class NoticeDao{
	
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

	public int RegisterNotice(NoticeDto dto) {
		
		String sql;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			//Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(config.url, config.uId, config.uPwd);
			sql = "UPDATE NOTICE SET POS = POS +1";
			pstmt = con.prepareStatement(sql);
			pstmt.executeUpdate();
			
			sql = "INSERT INTO NOTICE(TITLE, CONTENT, WRITER_ID, FILES) VALUES(?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getWriterId());
			pstmt.setString(4, dto.getFiles());
			
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			Close();
		}
		return 0;
	}
	
	public int getNoticeCount(String keyField, String keyword) {  //게시판 글 전체 개수
		int count = 0;
		
		String sql = "SELECT COUNT(ID) COUNT FROM NOTICE WHERE " + keyField + " LIKE '%" + keyword + "%' ORDER BY POS ASC";
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			//Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(config.url, config.uId, config.uPwd);
			PreparedStatement st = con.prepareStatement(sql);
			
			ResultSet rs = st.executeQuery();	

			if(rs.next())
				count = rs.getInt("count");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			Close();
		}
		
		return count;
	}
	
	
	public List<NoticeDto> getNoticeAll(String keyField, String keyword, int page) {
		List<NoticeDto> list = new ArrayList<NoticeDto>();
		NoticeDto ndto = null;
		
		String sql = "";
		
		if(keyword == null || keyword.isEmpty()) 
			sql = "SELECT * FROM NOTICE ORDER BY POS ASC LIMIT ?, 3";
		else
			sql = "SELECT * FROM NOTICE WHERE " + keyField + " LIKE '%" + keyword + "%' ORDER BY POS ASC LIMIT ?, 3";
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			//Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(config.url, config.uId, config.uPwd);
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, (page-1)*3);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				int id = rs.getInt("id");
				String title = rs.getString("title");
				String writerId = rs.getString("writer_id");
				String content = rs.getString("content");
				String files = rs.getString("files");
				int hit = rs.getInt("hit");
				Timestamp regdate = rs.getTimestamp("regdate");
				int pos = rs.getInt("pos");
				int depth = rs.getInt("depth");
				ndto = new NoticeDto(id, title, content, files, writerId, hit, regdate, pos, depth);
				list.add(ndto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			Close();
		}
		return list;
	}
	

	public NoticeDto getNotice(int id) {
		NoticeDto ndto = null;
		String sql = "";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			//Class.forName("com.mysql.jdbc.Driver");
			sql = "UPDATE NOTICE SET HIT = HIT + 1 WHERE ID = ?";
			con = DriverManager.getConnection(config.url, config.uId, config.uPwd);
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, id);
			pstmt.executeUpdate();
			
			sql = "SELECT * FROM NOTICE WHERE ID = ?";
			con = DriverManager.getConnection(config.url, config.uId, config.uPwd);
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				String title = rs.getString("title");
				String writerId = rs.getString("writer_id");
				String content = rs.getString("content");
				String files = rs.getString("files");
				int hit = rs.getInt("hit");
				Timestamp regdate = rs.getTimestamp("regdate");
				ndto = new NoticeDto(id, title, content, files, writerId, hit, regdate);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			Close();
		}
		return ndto;
	}
	
	
	
	public NoticeDto getNoticeInfo(int id) {
		NoticeDto ndto = null;
		String sql = "";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			//Class.forName("com.mysql.jdbc.Driver");
			
			sql = "SELECT * FROM NOTICE WHERE ID = ?";
			con = DriverManager.getConnection(config.url, config.uId, config.uPwd);
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				String title = rs.getString("title");
				String writerId = rs.getString("writer_id");
				String content = rs.getString("content");
				String files = rs.getString("files");
				int hit = rs.getInt("hit");
				int pos = rs.getInt("pos");
				int depth = rs.getInt("depth");
				
				Timestamp regdate = rs.getTimestamp("regdate");
				ndto = new NoticeDto(id, title, content, files, writerId, hit, regdate, pos, depth);
				System.out.println("getNoticeInfo");
				System.out.println(files);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			Close();
		}
		return ndto;
	}
	
	
	public int UpdateNotice(NoticeDto dto) {
		
		String sql = "UPDATE NOTICE SET TITLE = ?, CONTENT = ?, FILES = ? WHERE ID = ?";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			//Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(config.url, config.uId, config.uPwd);
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getFiles());
			pstmt.setInt(4, dto.getId());
			
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			Close();
		}
		return 0;
	}

	public int DeleteNotice(int id) {
		
		String sql = "DELETE FROM NOTICE WHERE ID = ?";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			//Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(config.url, config.uId, config.uPwd);
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, id);
			
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			Close();
		}
		
		return 0;
	}

	
	public void replyUpPos(int pos) {
		
		String sql = "UPDATE NOTICE SET POS = POS + 1 WHERE POS > ?";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			//Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(config.url, config.uId, config.uPwd);
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, pos);
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			Close();
		}
	}
	
	
	public int RegisterReply(NoticeDto dto) {
		
		String sql = "INSERT INTO NOTICE(TITLE, CONTENT, WRITER_ID, FILES, POS, DEPTH) VALUES(?, ?, ?, ?, ?, ?)";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			//Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(config.url, config.uId, config.uPwd);
			
			int pos = dto.getPos() + 1;
			int depth = dto.getDepth() + 1;
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getWriterId());
			pstmt.setString(4, dto.getFiles());
			pstmt.setInt(5, pos);
			pstmt.setInt(6, depth);
			
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			Close();
		}
		
		return 0;
	}
	
	public String UseDepth(int depth) {
		String result = "";
		
		for(int i=0; i<depth*2; i++) {
			result += "&nbsp";
		}
		
		return result;
	}
	
}
