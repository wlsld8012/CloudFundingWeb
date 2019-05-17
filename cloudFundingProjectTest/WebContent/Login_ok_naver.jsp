<%@page import="dao.MemberMgr"%>
<%@page import="tool.JSONparse"%>
<%@page import="api.APIExamMemberProfile"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.*"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
		String clientId = "zPAg_LxkOAFDVLVvfUnw";//���ø����̼� Ŭ���̾�Ʈ ���̵�";
		String clientSecret = "_VzO5TPCHU";//���ø����̼� Ŭ���̾�Ʈ ��ũ����";
		String code = request.getParameter("code");
		String state = request.getParameter("state");
		String redirectURI = URLEncoder.encode("http://localhost:8888/cloudFundingProject/Login_ok_naver.jsp",
				"UTF-8");
		String apiURL;
		apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
		apiURL += "client_id=" + clientId;
		apiURL += "&client_secret=" + clientSecret;
		apiURL += "&redirect_uri=" + redirectURI;
		apiURL += "&code=" + code;
		apiURL += "&state=" + state;
		String access_token = "";
		String refresh_token = "";
		String resultJSON = "";
		System.out.println("apiURL=" + apiURL);
		try {
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			int responseCode = con.getResponseCode();
			BufferedReader br;
			System.out.print("responseCode=" + responseCode);
			if (responseCode == 200) { // ���� ȣ��
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else { // ���� �߻�
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			StringBuffer res = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				res.append(inputLine);
			}
			br.close();
			if (responseCode == 200) {
				resultJSON = res.toString();
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		String accessToken = new JSONparse().getAccessToken(resultJSON);
		session.setAttribute("access", accessToken);

		String json = new APIExamMemberProfile().getPersonalInfo((String) session.getAttribute("access"));
		String email = new JSONparse().getEmail(json);

		MemberMgr memberDao = new MemberMgr();
		if (!memberDao.isMemberByEmail(email)) {
			if (memberDao.insertMemberNaver(email)) {
				session.setAttribute("mem_id", email);
	%>
	<script type="text/javascript">
		alert("���̹� ���̵�� �α��� �Ǿ����ϴ�. ������������ �̵��մϴ�.");
		window.location.href("FundingList.jsp?isLogout=false");
	</script>
	<%
		} else {
	%>
	<script type="text/javascript">
		alert("�α��ο� �����Ͽ����ϴ�. ������������ �̵��մϴ�.");
		window.location.href("FundingList.jsp?isLogout=true");
	</script>
	<%
		}
		} else {
			session.setAttribute("mem_id", email);
	%>
	<script type="text/javascript">
		alert("���̹� ���̵�� �α��� �Ǿ����ϴ�. ������������ �̵��մϴ�.");
		window.location.href("FundingList.jsp?isLogout=false");
	</script>
	<%
		}
	%>
</body>
</html>
2
