package api;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.http.HttpServletRequest;

public class APIExamMemberProfile {
    public String getPersonalInfo(String accessToken) {
        String token = accessToken;// ���̹� �α��� ���� ��ū;
        String header = "Bearer " + token; // Bearer ������ ���� �߰�
        String email = null;
        String resultJSON = null;
        try {
            String apiURL = "https://openapi.naver.com/v1/nid/me";
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("Authorization", header);
            int responseCode = con.getResponseCode();
            BufferedReader br;
            if(responseCode==200) { // ���� ȣ��
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {  // ���� �߻�
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();
           resultJSON = response.toString();
        } catch (Exception e) {
            System.out.println(e);
        }
        return resultJSON;
    }
}
