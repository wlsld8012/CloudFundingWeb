package dao;

import java.sql.*;
import java.util.*;

import javax.servlet.http.*;

import com.oreilly.servlet.*;

import connectionPool.*;
import dto.*;

public class FundingMgr {
	private DBConnectionMgr pool;
	
	public FundingMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch(Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	public boolean insertFunding(HttpServletRequest request) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String uploadDir = "d:\\";
		int maxImageSize = 5 * 1024 * 1024;
		
		try {
			MultipartRequest multiReq = new MultipartRequest(request, uploadDir, maxImageSize);
			conn = pool.getConnection();
			String sqlQuery = "insert into funding (title, writer, content, image, currentMoney, goalMoney) values (?, ?, ?, ?, 0, ?)";
			pstmt = conn.prepareStatement(sqlQuery);
			pstmt.setString(1, multiReq.getParameter("title"));
			pstmt.setString(2, multiReq.getParameter("writer"));
			pstmt.setString(3, multiReq.getParameter("content"));
			pstmt.setString(4, multiReq.getFilesystemName("image"));
			pstmt.setInt(5, Integer.parseInt(multiReq.getParameter("goalMoney")));
			pstmt.execute();
		} catch(Exception e) {
			System.out.println(e.getMessage());
			return false;
		} finally {
			pool.freeConnection(conn, pstmt);
		}
		return true;
	}

	public Vector<FundingInfo> getFundingList() {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Vector<FundingInfo> conveyer = null;
		
		try {
			
			conn = pool.getConnection();
			String sqlQuery = "select * from funding order by no desc";
			pstmt = conn.prepareStatement(sqlQuery);
			rs = pstmt.executeQuery();
			conveyer = new Vector<FundingInfo>(); 
			
			while(rs.next()) {
				FundingInfo bean = new FundingInfo();
				bean.setNo(rs.getInt("no"));
				bean.setTitle(rs.getString("title"));
				bean.setContent(rs.getString("content"));
				bean.setCurrentMoney(rs.getInt("currentMoney"));
				bean.setGoalMoney(rs.getInt("goalMoney"));
				bean.setWriter(rs.getString("writer"));
				bean.setImage(rs.getString("image"));
				conveyer.add(bean);
			}
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		
		return conveyer;
	}

	public FundingInfo getFunding(int no) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		FundingInfo bean = new FundingInfo();
		
		try {
			conn = pool.getConnection();
			String query = "select * from funding where no = ?";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setNo(Integer.parseInt(rs.getString("no")));
				bean.setContent(rs.getString("content"));
				bean.setCurrentMoney(Integer.parseInt(rs.getString("currentMoney")));
				bean.setGoalMoney(Integer.parseInt(rs.getString("goalMoney")));
				bean.setTitle(rs.getString("title"));
				bean.setImage(rs.getString("image"));
				bean.setWriter(rs.getString("writer"));				
			} else {
				throw new Exception("db에서 글 정보 꺼내기 실패");
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return bean;
	}
}
