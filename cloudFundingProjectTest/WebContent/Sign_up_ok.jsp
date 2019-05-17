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
		out.print("성공적으로 입력되었습니다");
		
%>
	<script type="text/javascript">
			alert("성공적으로 입력되었습니다.");
			window.location.href("FundingList.jsp");
		</script>
<%
	} else {
		out.print("입력에 실패하였습니다");
	}
%>
</body>
</html>