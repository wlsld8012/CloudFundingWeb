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
%>
	<jsp:useBean id="bean" class="dto.MemberInfo"></jsp:useBean>
	<jsp:setProperty property="*" name="bean" />
	<%
	boolean succeed = new MemberMgr().insertMember(bean);
	if (succeed) {
		out.print("���������� �ԷµǾ����ϴ�");
		
%>
	<script type="text/javascript">
			alert("���������� �ԷµǾ����ϴ�.");
			window.location.href("FundingList.jsp");
		</script>
<%
	} else {
		out.print("�Է¿� �����Ͽ����ϴ�");
	}
%>
</body>
</html>