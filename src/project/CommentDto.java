package project;

import java.sql.Timestamp;

public class CommentDto {

	private int idx;	//��� ��ȣ
	private int postIdx;		//�Խù� ��ȣ(id)
    private String content;		//����
    private String writerId;	//�ۼ���
    private int likeit;			//���ƿ�
    private Timestamp regdate;	//��� ��¥
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

