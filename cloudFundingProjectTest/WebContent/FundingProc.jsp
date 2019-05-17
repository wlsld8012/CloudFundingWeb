<%@page import="dao.FundingMgr"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%
	String flag = request.getParameter("flag");
	int fundingNo = 0;
	if (request.getParameter("fundingNo") != null) {
		fundingNo = Integer.parseInt(request.getParameter("fundingNo"));
	}
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
		String oldImage = request.getParameter("image");
		boolean result = new FundingMgr().deleteFunding(fundingNo, oldImage);
		if(result == true) {
%>
	<script type="text/javascript">
		alert("삭제에 성공하였습니다.");
		window.location.href("FundingList.jsp");
	</script>
<%			
		} else {
%>
	<script type="text/javascript">
		alert("삭제에 실패하였습니다.");
		window.location.href("FundingList.jsp");
	</script>
<%			
		}
	}
%>
</body>
</html>