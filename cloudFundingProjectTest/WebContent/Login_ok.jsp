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
	request.setCharacterEncoding("euc-kr");
	String id_in = request.getParameter("id");
	String password_in = request.getParameter("password");
	MemberMgr memberDao = new MemberMgr();
	boolean isMember = memberDao.isMember(id_in, password_in);

	
	if(isMember) {
		
		session.setAttribute("mem_id", id_in);
%>
	<script type="text/javascript">
		alert("�α��� �Ǿ����ϴ�.");
		window.location.href("FundingList.jsp");
	</script>
	<% 		
		}  else {
%>	
	<script type="text/javascript">
		alert("�α����� �����Ͽ����ϴ�.");
		window.location.href("FundingList.jsp");
	</script>
	<% 
	}
%>
</body>
</html>