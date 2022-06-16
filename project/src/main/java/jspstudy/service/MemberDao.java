package jspstudy.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import jspstudy.dbconn.Dbconn;
import jspstudy.domain.MemberVo;


public class MemberDao {
	//연결객체
	private Connection conn;
	//구문객체
	private PreparedStatement pstmt;
	
	public MemberDao() {
		Dbconn db = new Dbconn();
		this.conn = db.getConnection();
		
		
	}
	
	public int insertMember(String memberid, String memberpwd, String membername, String memberemail,String membergender, String memberaddr, String memberphone, String memberjumin, String hobby, String ip, String membernickname ){
		int value=0;
		
		String sql="insert into a_member(MEMBERID,MEMBERPWD,MEMBERNAME,MEMBEREMAIL,MEMBERGENDER,MEMBERADDR,MEMBERPHONE,MEMBERJUMIN,MEMBERHOBBY,MEMBERIP,MEMBERNICKNAME) "
					+"values(?,?,?,?,?,?,?,?,?,?,?)";
		try{
		//Statement stmt =conn.createStatement();
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, memberid);
		pstmt.setString(2, memberpwd);
		pstmt.setString(3, membername);
		pstmt.setString(4, memberemail);
		pstmt.setString(5, membergender);
		pstmt.setString(6, memberaddr);
		pstmt.setString(7, memberphone);
		pstmt.setString(8, memberjumin);
		pstmt.setString(9, hobby);
		pstmt.setString(10, ip);
		pstmt.setString(11, membernickname);
		
		value = pstmt.executeUpdate();
		
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return value;
		
	}
    
    public ArrayList<MemberVo> memberSelectAll(){
    	
    	//객체생성
    	ArrayList<MemberVo> alist = new ArrayList<MemberVo>();
    	ResultSet rs =null;
    	
    	String sql="select * from a_member where delyn='N' order by midx desc";
    	
    	try{
    	//Connection 객체를 통해서 문자를 쿼리화시킨다.
    	pstmt = conn.prepareStatement(sql);
    	//여러 데이터를 그대로 복사해서 담는 클래스 Resultset
    	rs = pstmt.executeQuery();
    	//반복문실행. rs.next()는 다음 행에 값이 있는지 없는지. 있으면 true 없으면 false. 있으면 그 행으로 이동
    	while(rs.next()){
    		
    		//객체생성
    		MemberVo mv = new MemberVo();
    		//옮겨담고
    		mv.setMidx(rs.getInt("midx"));
    		mv.setMembername(rs.getString("membername"));
    		mv.setMemberid(rs.getString("memberid"));
    		mv.setMembernickname(rs.getString("membernickname"));
    		mv.setMemberphone(rs.getString("memberphone"));
    		mv.setWriteday(rs.getString("writeday"));
    		//담은 mv를 alist에 추가한다.
    		alist.add(mv);
    		
    	}
    }catch(Exception e){
    	e.printStackTrace();
    }finally{ // try catch 이 모든것을 실행할때 반드시 지나가야하는부분
    	try{
    	conn.close();
    	rs.close();
    	pstmt.close();
    }catch(Exception e){
    	e.printStackTrace();
    	}
    }
    	return alist;
    }
    
    public MemberVo memberLogin(String memberid, String memberpwd) {
    	ResultSet rs = null;
    	MemberVo mv = null;
    	String sql = "select * from a_member where delyn='N' and memberid=? and memberpwd=?";
    	
        try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberid);
			pstmt.setString(2, memberpwd);
			rs = pstmt.executeQuery(); 
			//System.out.println("안됨");
			
			if(rs.next()) {
				mv = new MemberVo();
				mv.setMidx(rs.getInt("midx"));
				mv.setMemberid(rs.getString("memberid"));
				mv.setMembername(rs.getString("membername"));
				mv.setMembernickname(rs.getString("membernickname"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				rs.close();
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
        return mv;
    }
    
    public int memberupdate(String memberpwd, String memberemail, String memberaddr, String memberphone, String membernickname, int midx) {
    	int value = 0;
    	
    	String sql = "UPDATE a_member SET MEMBERPWD=?, MEMBEREMAIL=?, MEMBERADDR=?, MEMBERPHONE=?, MEMBERNICKNAME=? WHERE midx=?";
    	//UPDATE a_member SET MEMBERPWD='qwe', MEMBEREMAIL='1123123', MEMBERADDR='23453425', MEMBERPHONE='345', MEMBERNICKNAME='45' WHERE midx=1;

    	try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, memberpwd);
			pstmt.setString(2, memberemail);
			pstmt.setString(3, memberaddr);
			pstmt.setString(4, memberphone);
			pstmt.setString(5, membernickname);
			pstmt.setInt(6, midx);
			
			value = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
    	return value;
    }
    public MemberVo memberSelectOne(int midx) {
    	MemberVo mv = null;
    	ResultSet rs = null;
    	String sql = "SELECT * FROM a_member WHERE midx=?";
    	
    	try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, midx);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				mv = new MemberVo();
				mv.setMidx(rs.getInt("midx"));
				mv.setMemberid(rs.getString("memberid"));
				mv.setMemberpwd(rs.getString("memberpwd"));
				mv.setMembername(rs.getString("membername"));
				mv.setMemberemail(rs.getString("memberemail"));
				mv.setMembergender(rs.getString("membergender"));
				mv.setMemberaddr(rs.getString("memberaddr"));
				mv.setMemberphone(rs.getString("memberphone"));
			//	mv.setMemberjumin(rs.getString("memeberjumin"));
				mv.setMemberhobby(rs.getString("memberhobby"));
				mv.setWriteday(rs.getString("writeday"));
				mv.setMemberip(rs.getString("memberip"));
				mv.setMembernickname(rs.getString("membernickname"));
				
				}
			}catch (SQLException e) {
					e.printStackTrace();
			}
    	
    	return mv;
    }
    
    public int SelectAllId(String memberid) {
    	int value = -1; //오류발생
    	ResultSet rs = null;
    	String sql = "select memberid from a_member where memberid=?";
    	try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberid);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				value=1; //존재할경우(사용불가)
				System.out.println("value 값:"+value);
			}else {
				value=0;//존재하지 않을 경우 (사용가능)
				System.out.println("value 값:"+value);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
    	return value;
    }
    
    public int IdCheck(String memberid) {
    	int value = SelectAllId(memberid);
    	return value;
    }
}
