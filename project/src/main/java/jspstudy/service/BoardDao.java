package jspstudy.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import jspstudy.dbconn.Dbconn;
import jspstudy.domain.BoardVo;
import jspstudy.domain.Criteria;
import jspstudy.domain.SearchCriteria;

public class BoardDao {
		ResultSet rs = null;
		String sql;
	// 연결객체
	private Connection conn;
	// 쿼리를 실행시키는 객체
	private PreparedStatement pstmt;

	public BoardDao() {
		Dbconn db = new Dbconn();
		this.conn = db.getConnection();
	}

	public int insertboard(String subject, String content, String writer, String ip, int midx, String filename,
			String membernickname, int boardtype) {// 게시글을 db에 입력하게 해주는 함수
		int value = 0;
		System.out.println(subject);
		System.out.println(content);
		System.out.println(writer);
		System.out.println(ip);
		System.out.println(midx);
		System.out.println(filename);
		System.out.println(membernickname);
		System.out.println(boardtype);

		String sql = "INSERT INTO a_board(SUBJECT,CONTENT,WRITER,IP,MIDX,ORIGINBIDX,DEPTH,LEVEL_,FILENAME,MEMBERNICKNAME,BOARDTYPE)"
				+ "VALUES(?,?,?,?,?,0,0,0,?,?,?)";
		
		/*
		 * String
		 * sql="INSERT INTO a_board(BIDX,SUBJECT,CONTENT,WRITER,IP,MIDX,ORIGINBIDX,DEPTH,LEVEL_,filename,nickname)"
		 * + " VALUES(BIDX_SEQ.NEXTVAL,?,?,?,?,?,BIDX_SEQ.NEXTVAL,0,0,?,?)";
		 */
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, subject);
			pstmt.setString(2, content);
			pstmt.setString(3, writer);
			pstmt.setString(4, ip);
			pstmt.setInt(5, midx);
			pstmt.setString(6, filename);
			pstmt.setString(7, membernickname);
			pstmt.setInt(8, boardtype);
			value = pstmt.executeUpdate();
			
			
			//originbidx 디폴트 0 줬으니 밑에서 bdix 값을 추출해서 넣어주기 위한 부분
			try {
				//bidx 추출부분
				sql = "select bidx from a_board where ORIGINBIDX=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, 0);
					rs = pstmt.executeQuery();
					while(rs.next()) {
						//bidx 추출한걸 originbidx 안으로 넣어주는 부분
						sql = "update a_board SET originbidx = ? where bidx = ?";
							
							try {
								pstmt = conn.prepareStatement(sql);
								pstmt.setInt(1, rs.getInt("bidx"));
								pstmt.setInt(2, rs.getInt("bidx"));
								pstmt.executeUpdate();
							}catch(SQLException e) {
								e.printStackTrace();
							}
					}
			}catch(SQLException e){
				e.printStackTrace();
			}
			
		} catch (SQLException e) {
			e.printStackTrace();

		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return value;
	}

	public ArrayList<BoardVo> boardSelectAll(SearchCriteria scri, int boardtype) {// db를 기반으로 게시판 리스트를 화면에 출력해주는 함수

		ArrayList<BoardVo> alist = new ArrayList<BoardVo>();

		ResultSet rs = null;
		// 게시판 따로 보여주는 기능
		String str2 = "";
		if (scri.getBoardtype() != 0) {
			str2 = " and a.boardtype = ? ";
		}
		// 검색기능
		String str = "";
		if (scri.getSearchtype().equals("subject")) {
			str = " and a.subject like concat(?) ";
		} else {
			str = " and a.membernickname like concat(?) ";
		}
		
		/*
		 * String sql = "select  B.* from(" +
		 * "SELECT @rownum:=@rownum+1 as rnum, A.* FROM a_board,("
		 * +"SELECT * FROM a_board WHERE delyn='N'  " + str2 + "" + str
		 * +"ORDER BY originbidx desc, depth ASC) A where (@rownum:=0)=0 ) B" +
		 * " where B.rnum between ? and ?";
		 */
		String sql = "";
		sql += " select * from ";
		
		sql += " (select @rownum:=@rownum+1 as rnum,a.* from a_board a ";
		sql += " where (@rownum:=0)=0 and a.delyn = 'N' " + str2 + str +"  ORDER BY originbidx desc, depth ASC) b ";
				
		sql += " where b.rnum BETWEEN ? and ? ";
		 
		System.out.println("sql" + sql);

		try {
			// pstmt = conn.prepareStatement(sql2);
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, scri.getBoardtype());
			pstmt.setString(2,'%'+scri.getKeyword()+'%');
			pstmt.setInt(3, (scri.getPage() - 1) * 15 + 1);
			pstmt.setInt(4, (scri.getPage() * 15));
			rs = pstmt.executeQuery();
			// 다음값이 존재하면 true, 그 행으로 커서가 이동
			while (rs.next()) {
				BoardVo bv = new BoardVo();
				bv.setBIDX(rs.getInt("bidx")); // rs에 복사된 bidx를 bv에 옮겨 담는다
				bv.setSUBJECT(rs.getString("subject"));
				bv.setWRITER(rs.getString("writer"));
				bv.setWRITEDAY(rs.getString("writeday"));
				bv.setLevel_(rs.getInt("level_"));
				bv.setBoardtype(rs.getInt("boardtype"));
				bv.setMembernickname(rs.getString("membernickname"));
				alist.add(bv); // 각각의 bv 객체를 alist 에 추가한다.
				System.out.println(boardtype + "bt");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				// rs.close();
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return alist;
	}

	public BoardVo boardSelectOne(int bidx) { // 게시글을 클릭하면 글의 정보를 가져와주는 함수
		BoardVo bv = null;
		ResultSet rs = null;
		String sql = "select * from a_board where bidx=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bidx);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				bv = new BoardVo();
				bv.setBIDX(rs.getInt("bidx"));
				bv.setMIDX(rs.getInt("midx"));
				bv.setORIGINBIDX(rs.getInt("originbidx"));
				bv.setDepth(rs.getInt("depth"));
				bv.setLevel_(rs.getInt("level_"));
				bv.setSUBJECT(rs.getString("subject"));
				bv.setCONTENT(rs.getString("content"));
				bv.setWRITER(rs.getString("writer"));
				bv.setWRITEDAY(rs.getString("writeday"));
				bv.setFilename(rs.getString("filename"));
				bv.setBoardtype(rs.getInt("boardtype"));
				bv.setMembernickname(rs.getString("membernickname"));
			}
			System.out.println(bv.getBoardtype()+"bv");
			System.out.println(bv+"dd");
			System.out.println(rs+"dd");

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return bv;
	}

	// 글 수정하는 함수
	public int update(String subject, String content, String writer, String ip, int midx,int boardtype,String membernickname,int bidx) {
		//String sql = "update a_board set subject=?, content=?, writer=?,ip=?,midx=?,writeday=sysdate,boardtype=? where bidx=?";
		String sql= "update a_board set subject=?, content=?, writer=?,ip=?,midx=?,writeday=TO_char(SYSDATE,'yyyy-mm-dd-hh24:mi'),boardtype=?,membernickname=? where bidx=?";
		int value = 0;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, subject);
			pstmt.setString(2, content);
			pstmt.setString(3, writer);
			pstmt.setString(4, ip);
			pstmt.setInt(5, midx);
			pstmt.setInt(6, boardtype);
			pstmt.setString(7, membernickname);
			pstmt.setInt(8, bidx);
			System.out.println(boardtype +"dao 보드타입");
			value = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return value;
	}

	// 글 삭제하는 함수
	public int delete(int bidx, int midx) {
		String sql = "update a_board set delYn ='Y' where bidx=? and midx=?";

		int value = 0;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bidx);
			pstmt.setInt(2, midx);
			value = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println(sql);
		return value;
	}

	// 답변글 만드는 함수
	public int reply(BoardVo bv) {
		System.out.println(bv.getBoardtype());
		String sql1 = "update a_board set depth = depth+1 where originbidx =? and depth > ? and boardtype =?";
		// sql2 에서 level, depth, originbidx 가 ?인 이유 : 답글은 기존 글의 값을 받아와야 생성가능.
		String sql2 = "INSERT INTO a_board(BIDX,SUBJECT,CONTENT,WRITER,IP,MIDX,ORIGINBIDX,DEPTH,LEVEL_,boardtype,membernickname)"
				+ " VALUES(BIDX_SEQ.NEXTVAL,?,?,?,?,?,?,?,?,?,?)";
		int value = 0;
		
		try {
			conn.setAutoCommit(false); // java 내의 오라클 연동시 자동커밋 기능을 끔

			pstmt = conn.prepareStatement(sql1);
			pstmt.setInt(1, bv.getORIGINBIDX());
			pstmt.setInt(2, bv.getDepth());
			pstmt.setInt(3, bv.getBoardtype());
			value = pstmt.executeUpdate();

			pstmt = conn.prepareStatement(sql2);
			pstmt.setString(1, bv.getSUBJECT());
			pstmt.setString(2, bv.getCONTENT());
			pstmt.setString(3, bv.getWRITER());
			pstmt.setString(4, bv.getiP());
			pstmt.setInt(5, bv.getMIDX());
			pstmt.setInt(6, bv.getORIGINBIDX());
			pstmt.setInt(7, bv.getDepth() + 1);
			pstmt.setInt(8, bv.getLevel_() + 1);
			pstmt.setInt(9, bv.getBoardtype());
			pstmt.setString(10, bv.getMembernickname());
			value = pstmt.executeUpdate();
			
				
			
			
			conn.commit(); // 위에서 오토커밋 false 로 껐으니 커밋 코드를 입력
		} catch (SQLException e) {
			try {
				conn.rollback(); // 위의 sql1 ,2 둘 중 하나라도 실행되지 않으면 롤백시키도록함
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();

		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} // System.out.println(bv.getBoardtype()+"123");
		return value;
	}

	public int boardTotal(SearchCriteria scri) {// 페이징 처리해서 페이지의 수를 나타내주는 함수
		System.out.println(scri.getKeyword() + "scri");

		int cnt = 0;
		ResultSet rs = null;
		String str2 = "";
		if (scri.getBoardtype() != 0) {
			str2 = " and boardtype = ?";
		}
		String str = "";
		if (scri.getSearchtype().equals("subject")) {
			str = " and subject like ? ";
		} else {
			str = " and writer like ?";
		}

		String sql = "select count(*) as cnt from a_board where delyn='N' " + str2 + str + "";
		try {
			pstmt = conn.prepareStatement(sql);
			if (scri.getBoardtype() != 0) {
			
				pstmt.setInt(1, scri.getBoardtype());
				pstmt.setString(2, "%" + scri.getKeyword() + "%");
			
			}else {
				pstmt.setString(1, "%" + scri.getKeyword() + "%");	
			}
			
			rs = pstmt.executeQuery();

			if (rs.next()) {
				cnt = rs.getInt("cnt");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {

			try {
				rs.close();
				pstmt.close();
				// conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}

		}

		return cnt;
	}
	public ArrayList<BoardVo> boardSelectFive(SearchCriteria scri, int boardtype) { // 게시글을 클릭하면 글의 정보를 가져와주는 함수
		ArrayList<BoardVo> alist = new ArrayList<BoardVo>();
		System.out.println(boardtype+"boar");
		
		String str = "";
		if (scri.getBoardtype() != 0) {
			str = "and boardtype = ? ";
		}
		
		ResultSet rs = null;
		String sql = "select * from a_board where delyn = 'N' "+str+" order by WRITEDAY desc";
	//	String sql = "select * from a_board  order by WRITEDAY desc";
		try {
			pstmt = conn.prepareStatement(sql);
			if (scri.getBoardtype() != 0) {
			pstmt.setInt(1, scri.getBoardtype());
			}
			rs = pstmt.executeQuery();
			System.out.println(scri.getBoardtype()+"asdfsefasef");
			while (rs.next()) {
				BoardVo bv = new BoardVo();
				bv.setBIDX(rs.getInt("bidx")); // rs에 복사된 bidx를 bv에 옮겨 담는다
				bv.setSUBJECT(rs.getString("subject"));
				bv.setWRITER(rs.getString("writer"));
				bv.setCONTENT(rs.getString("content"));
				bv.setWRITEDAY(rs.getString("writeday"));
				bv.setLevel_(rs.getInt("level_"));
				bv.setBoardtype(rs.getInt("boardtype"));
				bv.setMembernickname(rs.getString("membernickname"));
				alist.add(bv); // 각각의 bv 객체를 alist 에 추가한다.
				System.out.println(boardtype + "bt");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				// rs.close();
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		System.out.println(sql);
		return alist;
	}
}
