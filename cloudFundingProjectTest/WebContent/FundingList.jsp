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
	<a href="Sign_up.jsp">ȸ������</a>
	<br>
	<% 
	} else {
		MemberMgr memberDao = new MemberMgr();
		String privilege = memberDao.getPrivilege((String)session.getAttribute("mem_id"));
		if(privilege.equals("ordinary")) {
%>
	<br>�Ϲ�ȸ���� �ݰ����ϴ�
	<br>
	<a href="FundingList.jsp?isLogout=true">�α׾ƿ�</a>
	<br>

	<% 			
		} else if(privilege.equals("special")) {
%>
	<br>Ư��ȸ���� �ݰ����ϴ�
	<br>
	<a href="FundingWrite.jsp">�۾���</a>
	<br>
	<a href="FundingList.jsp?isLogout=true">�α׾ƿ�</a>
	<br>
	<%			
		} else if(privilege.equals("naver")) {
			%>
			<br>���̹�ȸ���� �ݰ����ϴ�<br>
			<a href="FundingList.jsp?isLogout=true">�α׾ƿ�</a>
			<br>
			<%			
		}
	}
%>

	<br>�� ��� �����ִ� ��<br>

<% 
				// ������ ���̽����� Ʈ������Ʈ�� Ʈ�� ��������
				String uploadDir = "./data/";
				Vector trackList = null;
				Vector track = null;
				FundingMgr fundingDao = new FundingMgr();
				trackList = fundingDao.getFundingList();
				// �ʱ� ǥ�� �� ��, ���� Ʈ�� ��ȣ
				int currentTrack, leftTrack, rightTrack = 0; // �ʱ�ȭ
				int n = trackList.size(); // Ʈ������Ʈ�� ������ ��, dummy
				if(request.getParameter("currentTrack") == null) {
					currentTrack = 0;
				} else {
					currentTrack = Integer.parseInt(request.getParameter("currentTrack"));
				}				
				// ���� Ʈ����ȣ ���
				if (currentTrack == 0) {
					leftTrack = n - 1;
				} else {
					leftTrack = currentTrack - 1;
				}
				// ������ Ʈ����ȣ ���
				if (currentTrack == n - 1) {
					rightTrack = 0;
				} else {
					rightTrack = currentTrack + 1;
				}	
%>
			<!-- ���� �װ��� �Ѹ��� �¿� ������ �̵��� �� �ֵ��� �ڵ� -->
	<table>
		<tr>
			<td colspan = "4" align = "right">	
				<input type = "button" value = "left" onclick = "window.location.href('FundingList.jsp?currentTrack=<%=leftTrack%>')">
				<input type = "button" value = "right" onclick = "window.location.href('FundingList.jsp?currentTrack=<%=rightTrack%>')">
			</td>
		</tr>
		<tr>
			 <!-- �ݺ������� 4 �� �������� ó��  -->
<%
				track = (Vector) trackList.get(currentTrack);
				for(int i = 0; i < track.size(); i++) {
					FundingInfo bean = (FundingInfo)track.elementAt(i);
%>
			<td>
				<table border="2" width = "200">
					<tr align = "middle"><td><a href="FundingDetail.jsp?fundingNo=<%=bean.getNo()%>"><img src="<%=uploadDir + bean.getImage()%>" width= "50" height="50" ></a></td></tr>
					<tr align = "middle"><td>����:<%=bean.getTitle() %></td></tr>
					<tr align = "middle"><td>��ǥ�ݾ�:<%=bean.getGoalMoney() %></td></tr>
					<tr align = "middle"><td><%=(double)bean.getCurrentMoney() / bean.getGoalMoney() * 100%> % �ݵ� �Ϸ�</td></tr>
				</table>
			</td>	
<%					
				}
%>
		</tr>
	</table>
</body>
</html>