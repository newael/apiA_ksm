package jspstudy.domain;
//페이지 번호를 담기 위해서 만든 클래스
public class Criteria {
	private int page; //페이지
	private int perPageNum; //화면에 리스트 출력갯수
	public Criteria() {
		this.page = 1;
		this.perPageNum = 15;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		if(page <=1) {
			this.page = 1;
			return;
		}
		this.page = page;
	}
	public int getPerPageNum() {
		return perPageNum;
	}
	public void setPerPageNum(int perPageNum) {
		if(perPageNum <=0 || perPageNum > 100) {/*게시물이 10개 이하일때도(혹은 100개 넘을때도) 10개씩 페이징 처리하겠다.*/
			this.perPageNum = 10;
			return;
		}
		this.perPageNum = perPageNum;
	}
	
}
