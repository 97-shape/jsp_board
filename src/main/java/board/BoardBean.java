package board;

public class BoardBean{
	private int no;
	private String title;
	private String id;
	private String password;
	private String content;
	private String writeDate;
	private String src;
	private int readCount;
	private int ref;  // 원글
    private int ref_step; // 답글 단계
    private int ref_level; // 답글 순서
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
	public int getRef_step() {
		return ref_step;
	}
	public void setRef_step(int ref_step) {
		this.ref_step = ref_step;
	}
	public int getRef_level() {
		return ref_level;
	}
	public void setRef_level(int ref_level) {
		this.ref_level = ref_level;
	}
	public String getSrc() {
		return src;
	}
	public void setSrc(String src) {
		this.src = src;
	}
	
	public BoardBean() {}
	
	public BoardBean(int no, String title, String id, String password, String content, String writeDate, String src, int readCount,
			int ref, int ref_step, int ref_level) {
		super();
		this.no = no;
		this.title = title;
		this.id = id;
		this.password = password;
		this.content = content;
		this.writeDate = writeDate;
		this.readCount = readCount;
		this.ref = ref;
		this.ref_step = ref_step;
		this.ref_level = ref_level;
		this.src = src;
	}
    
    
}