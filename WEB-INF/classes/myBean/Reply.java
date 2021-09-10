package myBean;

import java.sql.Date;

public class Reply { // 답글을 쉽게 등록, 수정, 삭제할 수 있도록 reply 객체 선언

	
	private int id;
	private int idx;
	private String replyContent;
	private String writer;
	private Date date;
	// getter 와 setter 부분
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getReplyContent() {
		return replyContent;
	}
	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	
}
