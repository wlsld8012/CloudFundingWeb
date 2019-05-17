<%@page import="dao.FundingMgr"%>
<%@page import="java.util.Vector"%>
<%@page import="dto.FundingInfo"%>
<%@page import="dao.MemberMgr"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
	String isLogout = request.getParameter("isLogout");
	if(isLogout != null && isLogout.equals("true")) {
		session.removeAttribute("mem_id");
	}
	if(session.getAttribute("mem_id") == null) {
%>
	<jsp:include page="Login.jsp"></jsp:include><br>
	<a href="Sign_up.jsp">회원가입</a>
	<br>
	<% 
	} else {
		MemberMgr memberDao = new MemberMgr();
		String privilege = memberDao.getPrivilege((String)session.getAttribute("mem_id"));
		if(privilege.equals("ordinary")) {
%>
	<br>일반회원님 반갑습니다
	<br>
	<a href="FundingList.jsp?isLogout=true">로그아웃</a>
	<br>

	<% 			
		} else if(privilege.equals("special")) {
%>
	<br>특별회원님 반갑습니다
	<br>
	<a href="FundingWrite.jsp">글쓰기</a>
	<br>
	<a href="FundingList.jsp?isLogout=true">로그아웃</a>
	<br>
	<%			
		} else if(privilege.equals("naver")) {
			%>
			<br>네이버회원님 반갑습니다<br>
			<a href="FundingList.jsp?isLogout=true">로그아웃</a>
			<br>
			<%			
		}
	}
%>

	<br>글 목록 보여주는 곳<br>

<% 
				// 데이터 베이스에서 트랙리스트와 트랙 가져오기
				String uploadDir = "./data/";
				Vector trackList = null;
				Vector track = null;
				FundingMgr fundingDao = new FundingMgr();
				trackList = fundingDao.getFundingList();
				// 초기 표시 할 때, 현재 트랙 번호
				int currentTrack, leftTrack, rightTrack = 0; // 초기화
				int n = trackList.size(); // 트랙리스트의 마지막 값, dummy
				if(request.getParameter("currentTrack") == null) {
					currentTrack = 0;
				} else {
					currentTrack = Integer.parseInt(request.getParameter("currentTrack"));
				}				
				// 왼쪽 트랙번호 계산
				if (currentTrack == 0) {
					leftTrack = n - 1;
				} else {
					leftTrack = currentTrack - 1;
				}
				// 오른쪽 트랙번호 계산
				if (currentTrack == n - 1) {
					rightTrack = 0;
				} else {
					rightTrack = currentTrack + 1;
				}	
%>
			<!-- 글을 네개씩 뿌리고 좌우 옆으로 이동할 수 있도록 코딩 -->
	<table>
		<tr>
			<td colspan = "4" align = "right">	
				<input type = "button" value = "left" onclick = "window.location.href('FundingList.jsp?currentTrack=<%=leftTrack%>')">
				<input type = "button" value = "right" onclick = "window.location.href('FundingList.jsp?currentTrack=<%=rightTrack%>')">
			</td>
		</tr>
		<tr>
			 <!-- 반복문으로 4 개 나오도록 처리  -->
<%
				track = (Vector) trackList.get(currentTrack);
				for(int i = 0; i < track.size(); i++) {
					FundingInfo bean = (FundingInfo)track.elementAt(i);
%>
			<td>
				<table border="2" width = "200">
					<tr align = "middle"><td><a href="FundingDetail.jsp?fundingNo=<%=bean.getNo()%>"><img src="<%=uploadDir + bean.getImage()%>" width= "50" height="50" ></a></td></tr>
					<tr align = "middle"><td>제목:<%=bean.getTitle() %></td></tr>
					<tr align = "middle"><td>목표금액:<%=bean.getGoalMoney() %></td></tr>
					<tr align = "middle"><td><%=(double)bean.getCurrentMoney() / bean.getGoalMoney() * 100%> % 펀딩 완료</td></tr>
				</table>
			</td>	
<%					
				}
%>
		</tr>
	</table>
</body>
</html>