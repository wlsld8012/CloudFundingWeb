<%@page import="dao.CommentMgr"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<% 
	if(session.getAttribute("mem_id") == null) {
%>
		<script type="text/javascript">
			alert("로그인이 필요합니다.");
			history.back();
		</script>
<%		
	} else {
		request.setCharacterEncoding("euc-kr");
%>
	<jsp:useBean id="bean" class = "dto.CommentInfo"></jsp:useBean>
	<jsp:setProperty property="*" name="bean"/>
	<jsp:setProperty property="writer" name="bean" value='<%=session.getAttribute("mem_id")%>'/>	
<%	
	String flag = request.getParameter("flag");
	boolean result;
	
	if (flag.equals("insert")) {
		CommentMgr commentDao = new CommentMgr();
		result = commentDao.commentInsert(bean);
		if (result) {
%>
			<script type="text/javascript">
				alert("성공적으로 입력되었습니다.");
				window.location.href('FundingDetail.jsp?fundingNo=<%=bean.getOrigin()%>');
			</script>
<%					
		} else {
%>
			<script type="text/javascript">
				alert("입력에 실패하였습니다.");
				history.back();
			</script>		
<%
		}
	} else if (flag.equals("like")) {
		int commentNo = Integer.parseInt(request.getParameter("commentNo"));
		CommentMgr commentDao = new CommentMgr();
		result = commentDao.likePlus(commentNo);
		if (result) {
			%>
						<script type="text/javascript">
							alert("성공적으로 입력되었습니다.");
							window.location.href('FundingDetail.jsp?fundingNo=<%=bean.getOrigin()%>');
						</script>
			<%					
					} else {
			%>
						<script type="text/javascript">
							alert("입력에 실패하였습니다.");
							history.back();
						</script>		
			<%
		}
	} else if (flag.equals("dislike")) {
		int commentNo = Integer.parseInt(request.getParameter("commentNo"));
		CommentMgr commentDao = new CommentMgr();
		result = commentDao.dislikePlus(commentNo);
		if (result) {
			%>
						<script type="text/javascript">
							alert("성공적으로 입력되었습니다.");
							window.location.href('FundingDetail.jsp?fundingNo=<%=bean.getOrigin()%>');
						</script>
			<%					
					} else {
			%>
						<script type="text/javascript">
							alert("입력에 실패하였습니다.");
							history.back();
						</script>		
			<%
		}
	}
%>

<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

</body>
</html>

<%
	}
%>