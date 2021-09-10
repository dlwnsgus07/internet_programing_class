package myBean;
import java.sql.Date;

public class MovieInfo { // 영상에 대한 정보를 등록, 삭제, 수정하는데 있어 용이하도록 MovieInfo 객체를 선언
	private int idx;
	private String title;
	private String thumbnail;
	private String video;
	private String info;
	private String author;
	private Date date;
	
	
	//getter 와 setter 부분
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
	public String getThumbnail() {
		return thumbnail;
	}
	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}
	public String getVideo() {
		return video;
	}
	public void setVideo(String video) {
		this.video = video;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
}
