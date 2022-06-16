package jspstudy.domain;
//게시판 검색기능을 만드는 클래스
public class SearchCriteria extends Criteria{
	
	private String searchtype;
	private String keyword;
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

	public String getSearchtype() {
		return searchtype;
	}

	public void setSearchtype(String searchtype) {
		this.searchtype = searchtype;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public SearchCriteria() {
		this.searchtype = "";
		this.keyword = "";
		
	}
}
