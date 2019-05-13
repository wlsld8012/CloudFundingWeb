<%@page import="dao.FundingMgr"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%
	String flag = request.getParameter("flag");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
	if(flag.equals("insert")) {
		boolean result = new FundingMgr().insertFunding(request);
		if(result == true) {
%>
	<script type="text/javascript">
				alert("입력에성공하였습니다.");
				window.location.href("FundingList.jsp");
			</script>
	<%			
		} else {
%>
	<script type="text/javascript">
				alert("입력에 실패하였습니다.");
				window.location.href("FundingList.jsp");
			</script>
	<%			
		}
	} else if (flag.equals("update")) {
		
	} else if (flag.equals("delete")) {
		
	}
%>
</body>
</html>