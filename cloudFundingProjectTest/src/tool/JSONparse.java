package tool;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class JSONparse {
	public String getAccessToken(String JSONString) {
		JsonObject obj = new JsonParser().parse(JSONString).getAsJsonObject();
		String access_token = obj.get("access_token").getAsString();
		return access_token;
	}
	public String getEmail(String JSONString) {
		JsonObject obj = new JsonParser().parse(JSONString).getAsJsonObject();
		String email = obj.getAsJsonObject("response").get("email").getAsString();
		return email;
	}
}
