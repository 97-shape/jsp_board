package board;

public class BoardBean{
	private int no;
	private String title;
	private String id;
	private String password;
	private String content;
	private String writeDate;
	private int readCount;
	private int ref;  // 원글
    private int re_step; // 답글 단계
    private int re_level; // 답글 순서
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(String writeDate) {
		this.writeDate = writeDate;
	}
	public int getReadCount() {
		return readCount;
	}
	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public int getRe_step() {
		return re_step;
	}
	public void setRe_step(int re_step) {
		this.re_step = re_step;
	}
	public int getRe_level() {
		return re_level;
	}
	public void setRe_level(int re_level) {
		this.re_level = re_level;
	}
	
	public BoardBean() {
		super();
	}
	
	public BoardBean(int no, String title, String id, String password, String content, String writeDate, int readCount) {
		super();
		this.no = no;
		this.title = title;
		this.id = id;
		this.password = password;
		this.content = content;
		this.writeDate = writeDate;
		this.readCount = readCount;
	}
    
	
}