<%@ page import="java.net.URLEncoder" %>
<%@page import="java.math.BigInteger"%>
<%@page import="java.security.SecureRandom"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>로그인 페이지</title>
</head>
<body>
	<form id ="loginform" method = "post" action = "Login_ok.jsp">
		<table>
			<tr>
				<td>id</td>
				<td><input type = "text" name = "id"></td>
			</tr>
			<tr>
				<td>password</td>
				<td><input type = "password" name = "password"></td>
			</tr>
			<tr>
				<td colspan = "2">
					<input type = "button" value = "확인" onclick = "document.getElementById('loginform').submit()">
					<input type = "button" value = "취소" onclick = "document.getElementById('loginform').reset()">					
				</td>
			</tr>
		</table>
	</form>
<%
    String clientId = "zPAg_LxkOAFDVLVvfUnw";//애플리케이션 클라이언트 아이디값";
    String redirectURI = URLEncoder.encode("http://localhost:8888/cloudFundingProject/Login_ok_naver.jsp", "UTF-8");
    SecureRandom random = new SecureRandom();
    String state = new BigInteger(130, random).toString();
    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
    apiURL += "&client_id=" + clientId;
    apiURL += "&redirect_uri=" + redirectURI;
    apiURL += "&state=" + state;
    session.setAttribute("state", state);
 %>
  <a href="<%=apiURL%>"><img height="50" src="http://static.nid.naver.com/oauth/small_g_in.PNG"/></a>	
	
</body>
</html>