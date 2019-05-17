package dao;

import java.sql.*;
import java.util.*;

import connectionPool.*;
import dto.*;

public class CommentMgr {
	private DBConnectionMgr pool;
	
	public CommentMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}

	public boolean commentInsert(CommentInfo bean) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean result = false;
		
		try {
			//no, writer, likes, dislikes, floor, date, content, origin
			conn = pool.getConnection();
			String sqlQuery = "insert into comment (writer, likes, dislikes, floor, date, content, origin) values(?,?,?,1,now(),?,?)";
			pstmt = conn.prepareStatement(sqlQuery);
			pstmt.setString(1, bean.getWriter());
			pstmt.setInt(2, bean.getLikes());
			pstmt.setInt(3, bean.getDislikes());
			pstmt.setString(4, bean.getContent());
			pstmt.setInt(5, bean.getOrigin());
			int checker = pstmt.executeUpdate();
			if(checker == 1) {
				result = true;
			}
		} catch(Exception e) {
			System.out.println(e.getMessage());
		} finally {
			pool.freeConnection(conn, pstmt);
		}
		return result;
	}
	
	public boolean commentReplyInsert(CommentInfo bean) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean result = false;
		
		try {
			//no, writer, likes, dislikes, floor, date, content, origin
			conn = pool.getConnection();
			String sqlQuery = "insert into comment (writer, likes, dislikes, floor, date, content, origin) values(?,?,?,2,now(),?,?)";
			pstmt = conn.prepareStatement(sqlQuery);
			pstmt.setString(1, bean.getWriter());
			pstmt.setInt(2, bean.getLikes());
			pstmt.setInt(3, bean.getDislikes());
			pstmt.setString(4, bean.getContent());
			pstmt.setInt(5, bean.getOrigin());
			int checker = pstmt.executeUpdate();
			if(checker == 1) {
				result = true;
			}
		} catch(Exception e) {
			System.out.println(e.getMessage());
		} finally {
			pool.freeConnection(conn, pstmt);
		}
		return result;
	}

	public Vector<CommentInfo> getCommentList(int origin) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Vector<CommentInfo> conveyer = new Vector<CommentInfo>();
		try {
			conn = pool.getConnection();
			String sqlQuery = "select * from comment where floor = 1 and origin = ? order by no desc";
			pstmt = conn.prepareStatement(sqlQuery);
			pstmt.setInt(1, origin);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				CommentInfo bean = new CommentInfo();
				bean.setContent(rs.getString("content"));
				bean.setDate(rs.getString("date"));
				bean.setDislikes(rs.getInt("dislikes"));
				bean.setFloor(rs.getInt("floor"));
				bean.setLikes(rs.getInt("likes"));
				bean.setNo(rs.getInt("no"));
				bean.setOrigin(rs.getInt("origin"));
				bean.setWriter(rs.getString("writer"));
				conveyer.add(bean);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return conveyer;
	}

	public Vector<CommentInfo> getCommentReplyList(int origin) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Vector<CommentInfo> conveyer = new Vector<CommentInfo>();
		try {
			conn = pool.getConnection();
			String sqlQuery = "select * from comment where floor = 2 and origin = ? order by no desc";
			pstmt = conn.prepareStatement(sqlQuery);
			pstmt.setInt(1, origin);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				CommentInfo bean = new CommentInfo();
				bean.setContent(rs.getString("content"));
				bean.setDate(rs.getString("date"));
				bean.setDislikes(rs.getInt("dislikes"));
				bean.setFloor(rs.getInt("floor"));
				bean.setLikes(rs.getInt("likes"));
				bean.setNo(rs.getInt("no"));
				bean.setOrigin(rs.getInt("origin"));
				bean.setWriter(rs.getString("writer"));
				conveyer.add(bean);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return conveyer;
	}

	public boolean likePlus (int commentNo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean result = false;
		
		try {
			conn = pool.getConnection();
			String sqlQuery = "update comment set likes = likes + 1 where no = ? ";
			pstmt = conn.prepareStatement(sqlQuery);
			pstmt.setInt(1, commentNo);
			int checker = pstmt.executeUpdate();
			if (checker == 1) {
				result = true;
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			pool.freeConnection(conn, pstmt);
		}
		return result;
	}

	public boolean dislikePlus (int commentNo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean result = false;
		try {
			conn = pool.getConnection();
			String sqlQuery  = "update comment set dislikes = dislikes + 1 where no = ?";
			pstmt = conn.prepareStatement(sqlQuery);
			pstmt.setInt(1, commentNo);
			int checker = pstmt.executeUpdate();
			if (checker == 1) {
				result = true;
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			pool.freeConnection(conn, pstmt);
		}
		return result;
	}
}
