package jspstudy.domain;

//값을 담는 객체 Vo (Value object)
public class BoardVo {

	private int BIDX;
	private String SUBJECT;
	private String CONTENT;
	private String WRITER;
	private String WRITEDAY;
	private String iP;
	private String DELYN;
	private int MIDX;
	private int ORIGINBIDX;
	private int level_;
	private int depth;
	private String filename;
	private int boardtype;
	private String membernickname;
	
	public String getMembernickname() {
		return membernickname;
	}
	public void setMembernickname(String membernickname) {
		this.membernickname = membernickname;
	}
	public int getBoardtype() {
		return boardtype;
	}
	public void setBoardtype(int boardtype) {
		this.boardtype = boardtype;
	}
	
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public int getMIDX() {
		return MIDX;
	}
	public void setMIDX(int mIDX) {
		MIDX = mIDX;
	}
	public int getLevel_() {
		return level_;
	}
	public void setLevel_(int level_) {
		this.level_ = level_;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	public int getORIGINBIDX() {
		return ORIGINBIDX;
	}
	public void setORIGINBIDX(int oRIGINBIDX) {
		ORIGINBIDX = oRIGINBIDX;
	}
	public int getBIDX() {
		return BIDX;
	}
	public void setBIDX(int bIDX) {
		BIDX = bIDX;
	}
	public String getSUBJECT() {
		return SUBJECT;
	}
	public void setSUBJECT(String sUBJECT) {
		SUBJECT = sUBJECT;
	}
	public String getCONTENT() {
		return CONTENT;
	}
	public void setCONTENT(String cONTENT) {
		CONTENT = cONTENT;
	}
	public String getWRITER() {
		return WRITER;
	}
	public void setWRITER(String wRITER) {
		WRITER = wRITER;
	}
	public String getWRITEDAY() {
		return WRITEDAY;
	}
	public void setWRITEDAY(String wRITEDAY) {
		WRITEDAY = wRITEDAY;
	}
	public String getiP() {
		return iP;
	}
	public void setiP(String iP) {
		this.iP = iP;
	}
	public String getDELYN() {
		return DELYN;
	}
	public void setDELYN(String dELYN) {
		DELYN = dELYN;
	}
	
	
	
	
}
