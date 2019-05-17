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
			<td>����</td>
			<td><%= bean.getTitle()%></td>
		</tr>
		<tr>
			<td>����</td>
			<td><%= bean.getContent()%></td>
		</tr>
		<tr>
			<td>���� ��ݾ�</td>
			<td><%= bean.getCurrentMoney()%></td>
		</tr>
		<tr>
			<td>��ǥ ��ݾ�</td>
			<td><%= bean.getGoalMoney()%></td>
		</tr>
		<tr>
			<td>�̹���</td>
			<td><img src= '<%= uploadDir + bean.getImage()%>' width='100' height='100' /></td>
		</tr>
		<tr>
			<td colspan = "2" align = "middle">
				<input type = "button" value ="�������" onclick="window.location.href='FundingList.jsp'">
<%
		if(session.getAttribute("mem_id") != null) {
			if (session.getAttribute("mem_id").equals(bean.getWriter())) {
%>
				<input type = "button" value ="�� �����ϱ�" onclick="deleteFunding()">
<% 
			}
		}	
%>			
			</td>
		</tr>
		<!-- ��� �Է�â �� -->
		<tr>
			<form name = "commentForm" action = "CommentProc.jsp?flag=insert" method = "post">
				<table border = "2">
					<tr>
						<td><%if(session.getAttribute("mem_id") != null) out.print(session.getAttribute("mem_id"));%>&nbsp;��� �Է� â</td>
					</tr>
					<tr>
						<td><textarea cols = "100" rows = "5" name = "content"></textarea></td>
					</tr>
					<tr>
						<td align = "right">
							<input type = "button" value = "��� �Է�" onclick="document.commentForm.submit()">
							<input type = "button" value = "�ٽ� �Է�" onclick="document.commentForm.reset()">
							<input type = "hidden" name = "origin" value="<%=bean.getNo()%>">
						</td> 
					</tr>
				</table>
			</form>
		</tr>
<%
		// ����� �� ��ġ, �ݺ����� ����ؼ� �������� ���̺� ���� �ϳ��� �þ����
		int origin = bean.getNo();
		Vector<CommentInfo> conveyer = null;
		CommentMgr commentDao = new CommentMgr();
		conveyer = commentDao.getCommentList(origin);		

		for (int i = 0; i < conveyer.size(); i++) {
			CommentInfo commentBean = conveyer.elementAt(i);
%>		
		<tr>
			<td colspan = "2">
				<table> <!-- ���â -->
					<tr>
						<td><%=commentBean.getContent()%></td>
					</tr>
					<tr>
						<td>
							<input type = "button" value= "���ƿ�" onclick="document.getElementById('likeform').submit()">&nbsp;<%=commentBean.getLikes() %>&nbsp;&nbsp;
							<input type = "button" value= "�Ⱦ��" onclick="document.getElementById('dislikeform').submit()">&nbsp;<%=commentBean.getDislikes() %>
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
							�ۼ���: &nbsp; <%=commentBean.getWriter() %>
						</td>
					</tr>
					<tr>
						<td align = "right">
							�ۼ�����: &nbsp; <%=commentBean.getDate() %>
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

