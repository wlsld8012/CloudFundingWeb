<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>ȸ�� ����</title>
</head>
<body>
	<form id="memberform" action="Sign_up_ok.jsp" method="post">
		<table border="2">
			<tr>
				<td colspan="2" align="middle">ȸ������</td>
			</tr>
			<tr>
				<td>���̵�</td>
				<td><input type="text" name="id"></td>
			</tr>
			<tr>
				<td>��й�ȣ</td>
				<td><input type="password" name="password"></td>
			</tr>
			<tr>
				<td>�̸�</td>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<td>���� �ּ�</td>
				<td><input type="text" name="email"></td>
			</tr>
			<tr>
				<td>����</td>
				<td><input type="radio" name="privilege" value="special">Ư��ȸ��<br>
					<input type="radio" name="privilege" value="ordinary">�Ϲ�ȸ��
				</td>
			</tr>
			<tr>
				<td><input type="button" value="�����ϱ�"
					onclick="document.getElementById('memberform').submit()"> <input
					type="button" value="����ϱ�"
					onclick="document.getElementById('memberform').reset()"></td>
			</tr>
		</table>
	</form>
</body>
</html>