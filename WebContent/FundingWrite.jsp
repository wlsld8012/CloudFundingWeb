<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�� �Է� ������</title>
</head>
<body>
	<form id="fundingform" method="post"
		action="FundingProc.jsp?flag=insert" enctype="multipart/form-data">
		<table border="2">
			<tr>
				<td colspan="2" align="middle">�ݵ� ���� �Է�</td>
			<tr>
			<tr>
				<td>����</td>
				<td><input type="text" name="title"></td>
			<tr>
			<tr>
				<td>��ǥ �ݾ�</td>
				<td><input type="text" name="goalMoney"></td>
			<tr>
			<tr>
				<td>����</td>
				<td><textarea rows="20" cols="20" name="content"></textarea></td>
			<tr>
			<tr>
				<td>�̹���</td>
				<td><input type="file" name="image"></td>
			<tr>
			<tr>
				<td colspan="2" align="middle"><input type="button"
					value="�ۼ��Ϸ�"
					onclick="document.getElementById('fundingform').submit()">
					<input type="button" value="�ٽ��ۼ�"
					onclick="document.getElementById('fundingform').reset()"></td>
			<tr>
		</table>
		<input type="hidden" name="writer"
			value="<%=session.getAttribute("mem_id")%>">
	</form>
</body>
</html>