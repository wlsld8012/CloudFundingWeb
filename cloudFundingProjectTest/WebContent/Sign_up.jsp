<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>회원 가입</title>
</head>
<body>
	<form id="memberform" action="Sign_up_ok.jsp" method="post">
		<table border="2">
			<tr>
				<td colspan="2" align="middle">회원가입</td>
			</tr>
			<tr>
				<td>아이디</td>
				<td><input type="text" name="id"></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="password"></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<td>메일 주소</td>
				<td><input type="text" name="email"></td>
			</tr>
			<tr>
				<td>권한</td>
				<td><input type="radio" name="privilege" value="special">특별회원<br>
					<input type="radio" name="privilege" value="ordinary">일반회원
				</td>
			</tr>
			<tr>
				<td><input type="button" value="전송하기"
					onclick="document.getElementById('memberform').submit()"> <input
					type="button" value="취소하기"
					onclick="document.getElementById('memberform').reset()"></td>
			</tr>
		</table>
	</form>
</body>
</html>