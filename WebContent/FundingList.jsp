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
	<a href="Sign_in.jsp">ȸ������</a>
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

	<br>�� ��� �����ִ� ��
	<br>

	<%
		Vector<FundingInfo> conveyer = new Vector<FundingInfo>();
		conveyer = new FundingMgr().getFundingList();
		String uploadDir = "d:\\";
%>
	<table>
		<tr>
			<td>�̹���</td>
			<td>����</td>
			<td>�ۼ���</td>
			<td>����ݾ�</td>
			<td>��ǥ�ݾ�</td>
		</tr>
		<% 		
		
		for (int i = 0; i < conveyer.size(); i++) {
			FundingInfo bean = conveyer.elementAt(i);
%>
		<tr>
			<td><img src="<%=uploadDir + bean.getImage()%>" width="150"
				height="150"></td>
			<td><a href="FundingDetail.jsp?no=<%=bean.getNo()%>"><%=bean.getTitle()%></a></td>
			<td><%=bean.getWriter() %></td>
			<td><%=bean.getCurrentMoney() %></td>
			<td><%=bean.getGoalMoney() %></td>
		</tr>
		<%						
		}
%>
	</table>
</body>
</html>