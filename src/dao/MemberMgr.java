package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import connectionPool.DBConnectionMgr;
import dto.MemberInfo;

public class MemberMgr {
	private DBConnectionMgr pool;
	public MemberMgr() {		
		try {
			pool = DBConnectionMgr.getInstance();			
		} catch(Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	public boolean insertMember(MemberInfo bean) { 
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = pool.getConnection();
			String sql = "insert into member (id, password, name, email, privilege) values (?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bean.getId());
			pstmt.setString(2, bean.getPassword());
			pstmt.setString(3, bean.getName());
			pstmt.setString(4, bean.getEmail());
			pstmt.setString(5, bean.getPrivilege());
			pstmt.execute();
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return false;
		} finally {
			pool.freeConnection(conn, pstmt);
		}
		return true;
	}

	public boolean isMember(String id_in, String password_in) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean result = false;
		
		try {
			conn = pool.getConnection();
			String sql = "select password from member where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id_in);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(password_in)) {
					return true;
				}
			}
		} catch(Exception e) {
			System.out.println(e.getMessage());
		} finally {
			pool.freeConnection(conn, pstmt);
		}		
		return result;
	}

	public String getPrivilege(String member_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String result = null;
		try {
			conn = pool.getConnection();
			String sql = "select privilege from member where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member_id);
			rs = pstmt.executeQuery();
			if(rs.next() == false)
				new Exception().printStackTrace();
			else 
				result = rs.getString(1);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return result;
	}

	public boolean isMemberByEmail(String email) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean result = false;
		
		try {
			
			conn = pool.getConnection();
			String mysqlQuery = "select * from member where email = ?";
			pstmt = conn.prepareStatement(mysqlQuery);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			result = rs.next();
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return result;
	}

	public boolean insertMemberNaver(String email) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean result = false;
		
		try {
			conn = pool.getConnection();
			String sqlQuery = "insert into member (id, email, privilege, name, password) values (?,?,?,?,?)";
			pstmt = conn.prepareStatement(sqlQuery);
			pstmt.setString(1, email);
			pstmt.setString(2, email);
			pstmt.setString(3, "naver");
			pstmt.setString(4, "-");
			pstmt.setString(5, "-");
			if(pstmt.executeUpdate() == 1) {
				result = true;
			}
		} catch(Exception e) {
			System.out.println(e.getMessage());
		} finally {
			pool.freeConnection(conn, pstmt);
		}
		return result;
	}
}
