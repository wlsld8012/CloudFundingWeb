package dto;

public class CommentInfo {
	private int no;
	private String writer;
	private int likes;
	private int dislikes;
	private int floor;
	private String date;
	private String content;
	private int origin;
	
	public CommentInfo() {
		this.likes=0;
		this.dislikes=0;	
	}
	
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
	public int getLikes() {
		return likes;
	}
	public void setLikes(int likes) {
		this.likes = likes;
	}
	public int getDislikes() {
		return dislikes;
	}
	public void setDislikes(int dislikes) {
		this.dislikes = dislikes;
	}
	public int getFloor() {
		return floor;
	}
	public void setFloor(int floor) {
		this.floor = floor;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getOrigin() {
		return origin;
	}
	public void setOrigin(int origin) {
		this.origin = origin;
	}
}
