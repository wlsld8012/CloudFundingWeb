package dao;

import java.io.*;
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
		String uploadDir = "D:\\javaBigData2th\\myworkJSP\\cloudFundingProjectTest\\WebContent\\data\\";
		int maxImageSize = 5 * 1024 * 1024;
		
		try {
			MultipartRequest multiReq = new MultipartRequest(request, uploadDir, maxImageSize, "euc-kr");
			
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

	public boolean deleteFunding(int fundingNo, String oldImage) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean result = false;
		String uploadDir = "D:\\javaBigData2th\\myworkJSP\\cloudFundingProjectTest\\WebContent\\data\\";
		
		// image 삭제
		File oldImageFile = new File(uploadDir + oldImage);
		if(oldImageFile.exists()) {
			oldImageFile.delete();
		}
	
		try {
			conn = pool.getConnection();
			String sqlQuery = " delete from funding where no = ?";
			pstmt = conn.prepareStatement(sqlQuery);
			pstmt.setInt(1, fundingNo);
			int resultCheck = pstmt.executeUpdate();
			if (resultCheck == 1) {
				result = true;
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			pool.freeConnection(conn, pstmt);
		}
		return result;
	}
	
	public Vector getFundingList() {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Vector<FundingInfo> conveyer = null;
		Vector trackList = null;
		try {
			
			conn = pool.getConnection();
			String sqlQuery = "select * from funding order by no desc";
			pstmt = conn.prepareStatement(sqlQuery);
			rs = pstmt.executeQuery();
			conveyer = new Vector<FundingInfo>();
			trackList = new Vector(); // 엘리먼트를 추가
			Vector track = null; // 네개씩 담기
			
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
			// method making the list of funding into track
			int n = conveyer.size();
			for(int i = 0; 4 * i < n - 1; i++) {
				if(4 * (i + 1) > n - 1) {
					track = new Vector();
					for(int j = 4 * i;j < n; j++) {
						track.add(conveyer.elementAt(j));
					}
					trackList.add(track);
				} else {
					track = new Vector();
					for(int j = 4 * i; j < 4 * (i + 1); j++) {
						track.add(conveyer.elementAt(j));
					}
					trackList.add(track);
				}
			}		
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}		
		return trackList;
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
