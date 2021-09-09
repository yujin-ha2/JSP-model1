package project;

import java.sql.Timestamp;

public class MemberDto {

	private String id;
	private String pwd;
	private String name;
	private String email;
	private String work;
	private Timestamp regDate;
	private Boolean isSuspend;
	
	public MemberDto() {
	}
	
	public MemberDto(String id, String pwd, String name, String email, String work) {
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.email = email;
		this.work = work;
	}
	
	public MemberDto(String id, String pwd, String name, String email, String work, Timestamp regDate,
			Boolean isSuspend) {
		super();
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.email = email;
		this.work = work;
		this.regDate = regDate;
		this.isSuspend = isSuspend;
	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getWork() {
		return work;
	}
	public void setWork(String work) {
		this.work = work;
	}
	public Timestamp getRegDate() {
		return regDate;
	}
	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}
	public Boolean getIsSuspend() {
		return isSuspend;
	}
	public void setIsSuspend(Boolean isSuspend) {
		this.isSuspend = isSuspend;
	}
	
}

