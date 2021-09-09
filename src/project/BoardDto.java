package project;

import java.sql.Timestamp;

public class BoardDto {

	private int idx;
	private String title;
	private String content;
	private String writerId;
	private int hit;
	private int likeit;
	private Timestamp regdate;
	private String boardType;
	
	public BoardDto() {
		
	}
	
	public BoardDto(int idx, String title, String content, String writerId, int hit, int likeit, Timestamp regdate) {
		this.idx = idx;
		this.title = title;
		this.content = content;
		this.writerId = writerId;
		this.hit = hit;
		this.likeit = likeit;
		this.regdate = regdate;
	}

	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
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
	public String getWriterId() {
		return writerId;
	}
	public void setWriterId(String writerId) {
		this.writerId = writerId;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public int getLikeit() {
		return likeit;
	}
	public void setLikeit(int likeit) {
		this.likeit = likeit;
	}
	public Timestamp getRegdate() {
		return regdate;
	}
	public void setRegdate(Timestamp regdate) {
		this.regdate = regdate;
	}
	public String getBoardType() {
		return boardType;
	}
	public void setBoardType(String boardType) {
		this.boardType = boardType;
	}
}