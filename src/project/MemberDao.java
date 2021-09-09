package project;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;

public class MemberDao {

	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	Config config = new Config();

	public void Close() {
		try {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	public int addMember(MemberDto dto) {
		int result = 0;
		String sql = "INSERT INTO MEMBER(ID, PWD, NAME, EMAIL, WORK) VALUES(?,?,?,?,?)";

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			// Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(config.url, config.uId, config.uPwd);
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPwd());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getEmail());
			pstmt.setString(5, dto.getWork());

			result = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("addMember() 오류 발생 " + e);
		} finally {
			Close();
		}

		return result;
	}

	public int login(MemberDto dto) {
		String sql = "SELECT * FROM MEMBER WHERE ID = ?";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			// Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(config.url, config.uId, config.uPwd);
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			rs = pstmt.executeQuery();

			if (rs.next()) {
				if (rs.getString("pwd").equals(dto.getPwd())) {
					if(rs.getBoolean("isSuspend") == false)
						return 1; // 로그인 성공
					else
						return 3;
				}
				return 2; // 비밀번호가 틀림
			} else {
				return 0; // 해당 사용자가 존재하지 않음
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			Close();
		}

		return -1;
	}

	public boolean isIdCheck(String Id) {
		boolean result = true;
		String sql = "SELECT * FROM MEMBER WHERE ID  = ?";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			// Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(config.url, config.uId, config.uPwd);
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, Id);
			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				result = false;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			Close();
		}

		return result;
	}

	public boolean isNickNameCheck(String Nickname) {
		boolean result = true;
		String sql = "SELECT NICKNAME FROM MEMBER WHERE NICKNAME = ?";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			// Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(config.url, config.uId, config.uPwd);
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, Nickname);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				result = false;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			Close();
		}
		return result;

	}

	public int updatePwd(String id, String newPwd) {
		int result = 0;
		String sql = "UPDATE MEMBER SET PWD = ? WHERE ID = ?";

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			// Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(config.url, config.uId, config.uPwd);
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, newPwd);
			pstmt.setString(2, id);
			result = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("addMember() 오류 발생 " + e);
		} finally {
			Close();
		}

		return result;
	}

	public MemberDto getMyInfo(String id) {
		MemberDto dto = null;
		String sql = "SELECT * FROM MEMBER WHERE ID = ?";

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			// Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(config.url, config.uId, config.uPwd);
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				String pwd = rs.getString("pwd");
				String name = rs.getString("name");
				String email = rs.getString("email");
				String work = rs.getString("work");
				dto = new MemberDto(id, pwd, name, email, work);
			}

		} catch (Exception e) {
			System.out.println("addMember() 오류 발생 " + e);
		} finally {
			Close();
		}
		return dto;
	}

	public int updateMyInfo(MemberDto dto) {
		int result = 0;
		String sql = "UPDATE MEMBER SET EMAIL = ?, WORK = ? WHERE ID = ?";

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			// Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(config.url, config.uId, config.uPwd);
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getEmail());
			pstmt.setString(2, dto.getWork());
			pstmt.setString(3, dto.getId());
			result = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("addMember() 오류 발생 " + e);
		} finally {
			Close();
		}

		return result;
	}

	public List<MemberDto> getAllMember(String keyfield, String keyword, int page) {
		List<MemberDto> list = new ArrayList<MemberDto>();
		MemberDto dto = null;

		String sql = "";

		if (keyword == null || keyword.isEmpty())
			sql = "SELECT * FROM MEMBER ORDER BY REGDATE DESC LIMIT ?, 3";
		else
			sql = "SELECT * FROM MEMBER WHERE " + keyfield + " LIKE '%" + keyword
					+ "%' ORDER BY REGDATE DESC LIMIT ?, 3";

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			// Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(config.url, config.uId, config.uPwd);
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, (page - 1) * 3);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				String id = rs.getString("id");
				String name = rs.getString("name");
				String pwd = rs.getString("pwd");
				String email = rs.getString("email");
				String work = rs.getString("work");
				Timestamp regdate = rs.getTimestamp("regdate");
				boolean issuspend = rs.getBoolean("isSuspend");
				dto = new MemberDto(id, pwd, name, email, work, regdate, issuspend);
				list.add(dto);
			}

		} catch (Exception e) {
			System.out.println("addMember() 오류 발생 " + e);
		} finally {
			Close();
		}

		return list;
	}

	// 회원수(수정전)
	public int getAllMemberCount(String keyField, String keyword) { // 게시판 글 전체 개수
		int count = 0;

		String sql = "SELECT COUNT(ID) COUNT FROM MEMBER WHERE " + keyField + " LIKE '%" + keyword
					+ "%' ORDER BY REGDATE DESC";

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			// Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(config.url, config.uId, config.uPwd);
			pstmt = con.prepareStatement(sql);

			ResultSet rs = pstmt.executeQuery();

			if (rs.next())
				count = rs.getInt("count");

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			Close();
		}

		return count;
	}

	public int SuspendedOrUsing(String[] ids, String value) {
		int result = 0;
		String sql = "";
		String params = "";

		for (int i = 0; i < ids.length; i++) {
			params += ("'"+ids[i]+"'");

			if (i < ids.length - 1)
				params += ",";
		}
		System.out.println(params);
		
		if(value.equals("계정 정지")){ 
			System.out.println("suspended=1");
			sql = "UPDATE MEMBER SET ISSUSPEND = 1 WHERE ID IN(" + params + ")"; 
		}else { 
			sql = "UPDATE MEMBER SET ISSUSPEND = 0 WHERE ID IN(" + params + ")"; 
		}
		 
		try { Class.forName("com.mysql.cj.jdbc.Driver");
			//Class.forName("com.mysql.jdbc.Driver"); 
			Connection con = DriverManager.getConnection(config.url, config.uId, config.uPwd); 
			pstmt = con.prepareStatement(sql); 
			result = pstmt.executeUpdate();
		 
		}catch(Exception e) { 
			System.out.println("SuspendedOrUsing() 오류 발생 " + e); 
		}finally { 
			Close(); 
		}

		return result;
	}

	
	public int DeleteMember(String id, String pwd) {
		int result = 0;
		String sql = "DELETE FROM MEMBER WHERE ID = ? AND PWD = ?";

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			// Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(config.url, config.uId, config.uPwd);
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			result = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("DeleteMember() 오류 발생 " + e);
		} finally {
			Close();
		}

		return result;
	}
}



