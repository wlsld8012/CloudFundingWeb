<%@page import="dao.CommentMgr"%>
<%@page import="dto.CommentInfo"%>
<%@page import="java.util.Vector"%>
<%@page import="dto.FundingInfo"%>
<%@page import="dao.FundingMgr"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% 
	int fundingNo = Integer.parseInt(request.getParameter("fundingNo"));
	FundingInfo bean = new FundingMgr().getFunding(fundingNo);
	String uploadDir = "./data/";
%>        
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<script type="text/javascript">
function deleteFunding() {
	document.hiddenform.submit();
}
</script>
<body>
	<table align = "middle" border = "2" width = "700">
		<tr>
			<td>제목</td>
			<td><%= bean.getTitle()%></td>
		</tr>
		<tr>
			<td>내용</td>
			<td><%= bean.getContent()%></td>
		</tr>
		<tr>
			<td>현재 모금액</td>
			<td><%= bean.getCurrentMoney()%></td>
		</tr>
		<tr>
			<td>목표 모금액</td>
			<td><%= bean.getGoalMoney()%></td>
		</tr>
		<tr>
			<td>이미지</td>
			<td><img src= '<%= uploadDir + bean.getImage()%>' width='100' height='100' /></td>
		</tr>
		<tr>
			<td colspan = "2" align = "middle">
				<input type = "button" value ="목록으로" onclick="window.location.href='FundingList.jsp'">
<%
		if(session.getAttribute("mem_id") != null) {
			if (session.getAttribute("mem_id").equals(bean.getWriter())) {
%>
				<input type = "button" value ="글 삭제하기" onclick="deleteFunding()">
<% 
			}
		}	
%>			
			</td>
		</tr>
		<!-- 댓글 입력창 행 -->
		<tr>
			<form name = "commentForm" action = "CommentProc.jsp?flag=insert" method = "post">
				<table border = "2">
					<tr>
						<td><%if(session.getAttribute("mem_id") != null) out.print(session.getAttribute("mem_id"));%>&nbsp;댓글 입력 창</td>
					</tr>
					<tr>
						<td><textarea cols = "100" rows = "5" name = "content"></textarea></td>
					</tr>
					<tr>
						<td align = "right">
							<input type = "button" value = "댓글 입력" onclick="document.commentForm.submit()">
							<input type = "button" value = "다시 입력" onclick="document.commentForm.reset()">
							<input type = "hidden" name = "origin" value="<%=bean.getNo()%>">
						</td> 
					</tr>
				</table>
			</form>
		</tr>
<%
		// 댓글이 들어갈 위치, 반복문을 사용해서 들어갈때마다 테이블 행이 하나씩 늘어나도록
		int origin = bean.getNo();
		Vector<CommentInfo> conveyer = null;
		CommentMgr commentDao = new CommentMgr();
		conveyer = commentDao.getCommentList(origin);		

		for (int i = 0; i < conveyer.size(); i++) {
			CommentInfo commentBean = conveyer.elementAt(i);
%>		
		<tr>
			<td colspan = "2">
				<table> <!-- 댓글창 -->
					<tr>
						<td><%=commentBean.getContent()%></td>
					</tr>
					<tr>
						<td>
							<input type = "button" value= "좋아요" onclick="document.getElementById('likeform').submit()">&nbsp;<%=commentBean.getLikes() %>&nbsp;&nbsp;
							<input type = "button" value= "싫어요" onclick="document.getElementById('dislikeform').submit()">&nbsp;<%=commentBean.getDislikes() %>
							<form action= "CommentProc.jsp" id="likeform">
								<input type="hidden" name="commentNo" value="<%=commentBean.getNo()%>">
								<input type="hidden" name="flag" value="like">
								<input type="hidden" name="origin" value="<%=bean.getNo()%>">
							</form>
							<form action= "CommentProc.jsp?flag=dislike" id="dislikeform">
								<input type="hidden" name="commentNo" value="<%=commentBean.getNo()%>">
								<input type="hidden" name="flag" value="dislike">
								<input type="hidden" name="origin" value="<%=bean.getNo()%>">
							</form>							
						</td>
					</tr>
					<tr>
						<td align = "right">
							작성자: &nbsp; <%=commentBean.getWriter() %>
						</td>
					</tr>
					<tr>
						<td align = "right">
							작성일자: &nbsp; <%=commentBean.getDate() %>
						</td>
					</tr>
				</table>				
			</td>
		</tr>
<%
		}
%>
	</table>
	<form name="hiddenform" method="post" action= "FundingProc.jsp?flag=delete">
		<input type="hidden" name="fundingNo" value = '<%=bean.getNo()%>'>
		<input type="hidden" name="image" value = '<%=bean.getImage()%>'>
	</form>
</body>
</html>

