package project;

import java.sql.Timestamp;

public class CommentDto {

	private int idx;	//댓글 번호
	private int postIdx;		//게시물 번호(id)
    private String content;		//내용
    private String writerId;	//작성자
    private int likeit;			//좋아요
    private Timestamp regdate;	//등록 날짜
    private String boardType;
    
	public CommentDto() {
		
	}
    
    public CommentDto(int idx, int postIdx, String content, String writerId, int likeit, Timestamp regdate) {
    	this.idx = idx;
		this.postIdx = postIdx;
		this.content = content;
		this.writerId = writerId;
		this.likeit = likeit;
		this.regdate = regdate;
	}
	
    public int getIdx() {
    	return idx;
    }
    public void setIdx(int idx) {
    	this.idx = idx;
    }
	public int getPostIdx() {
		return postIdx;
	}
	public void setPostIdx(int postIdx) {
		this.postIdx = postIdx;
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
	public int getLikeit() {
		return likeit;
	}
	public void setLikeit(int likeit) {
		this.likeit = likeit;
	}
	public Timestamp getRegdate() {
		return regdate;
	}
	public void setRegDate(Timestamp regdate) {
		this.regdate = regdate;
	}

	public String getBoardType() {
		return boardType;
	}

	public void setBoardType(String boardType) {
		this.boardType = boardType;
	}
    
}

