<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>글 입력 페이지</title>
</head>
<body>
	<form id="fundingform" method="post"
		action="FundingProc.jsp?flag=insert" enctype="multipart/form-data">
		<table border="2">
			<tr>
				<td colspan="2" align="middle">펀딩 정보 입력</td>
			<tr>
			<tr>
				<td>제목</td>
				<td><input type="text" name="title"></td>
			<tr>
			<tr>
				<td>목표 금액</td>
				<td><input type="text" name="goalMoney"></td>
			<tr>
			<tr>
				<td>내용</td>
				<td><textarea rows="20" cols="20" name="content"></textarea></td>
			<tr>
			<tr>
				<td>이미지</td>
				<td><input type="file" name="image"></td>
			<tr>
			<tr>
				<td colspan="2" align="middle"><input type="button"
					value="작성완료"
					onclick="document.getElementById('fundingform').submit()">
					<input type="button" value="다시작성"
					onclick="document.getElementById('fundingform').reset()"></td>
			<tr>
		</table>
		<input type="hidden" name="writer"
			value="<%=session.getAttribute("mem_id")%>">
	</form>
</body>
</html>