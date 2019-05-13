package dto;

public class FundingInfo {
	private String writer;
	private String title;
	private String content;
	private String image;
	private int goalMoney;
	private int currentMoney;
	private int no;
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public int getGoalMoney() {
		return goalMoney;
	}
	public void setGoalMoney(int goalMoney) {
		this.goalMoney = goalMoney;
	}
	public int getCurrentMoney() {
		return currentMoney;
	}
	public void setCurrentMoney(int currentMoney) {
		this.currentMoney = currentMoney;
	}
	
	
}
