package project;

import java.sql.Timestamp;

public class NoticeDto {

	private int id;
	private String title;
	private String content;
	private String files;
	private String writerId;
	private int hit;
	private Timestamp regdate;
	private int pos;
	private int depth;

	public NoticeDto() {
		
	}
	
	public NoticeDto(int id, String title, String content, String files) {
		this.id = id;
		this.title = title;
		this.content = content;
		this.files = files;
	}


	public NoticeDto(int id, String title, String content, String files, String writerId, int hit, Timestamp regdate) {
		this.id = id;
		this.title = title;
		this.content = content;
		this.files = files;
		this.writerId = writerId;
		this.hit = hit;
		this.regdate = regdate;
	}
	
	public NoticeDto(int id, String title, String content, String files, String writerId, int hit,	Timestamp regdate, int pos, int depth) {
		this.id = id;
		this.title = title;
		this.content = content;
		this.files = files;
		this.writerId = writerId;
		this.hit = hit;
		this.regdate = regdate;
		this.pos = pos;
		this.depth = depth;
	}

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
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
	public String getFiles() {
		return files;
	}
	public void setFiles(String files) {
		this.files = files;
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
	public Timestamp getRegdate() {
		return regdate;
	}
	public void setRegdate(Timestamp regdate) {
		this.regdate = regdate;
	}
	public int getPos() {
		return pos;
	}
	public void setPos(int pos) {
		this.pos = pos;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
}
