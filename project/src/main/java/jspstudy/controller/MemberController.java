package jspstudy.controller;

import java.io.IOException;
import java.net.InetAddress;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import jspstudy.domain.MemberVo;
import jspstudy.service.MemberDao;
//�����θ� 
@WebServlet("/MemberController")
public class MemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		HttpSession session = request.getSession();
		//주소의 풀경로를 추출하는 메소드
		String uri = request.getRequestURI();
		//프로젝트 이름을 추출
		String pj = request.getContextPath();
		//프로젝트 이름을 뺀 나머지 가상경로 추출
		String command = uri.substring(pj.length());
		System.out.println("command"+command);
		
		if(command.equals("/member/memberjoinaction.do")) {
			System.out.println("test");
		//input 객체의 이름을 담은 파라미터를 호출하면 그 객체의 값을 리턴한다.
		String memberid = request.getParameter("memberid");
		String memberpwd = request.getParameter("memberpwd");
		String membername = request.getParameter("membername");
		String memberemail = request.getParameter("memberemail");
		String membergender = request.getParameter("membergender");
		String memberaddr = request.getParameter("memberaddr");
		String memberphone = request.getParameter("memberphone");
		String memberjumin = request.getParameter("memberjumin");
		String membernickname = request.getParameter("membernickname");

	 	//호스트 정보를 가져오는것.   
	 	String ip = InetAddress.getLocalHost().getHostAddress();
	 
		MemberDao md = new MemberDao();
		int value = md.insertMember(memberid, memberpwd, membername, memberemail, membergender, memberaddr, memberphone, memberjumin, null, ip, membernickname);
		System.out.println(value);
		

		
		//PrintWriter out = response.getWriter();
			if(value==1){
					//sendRedirect 클라이언트가 페이지를 요청하게되면 다시 재요청을하여 페이지를 이동하는 방식. 외부주소를 새롭게 사용.
					response.sendRedirect(request.getContextPath()+"/member/memberlist.do");
					//out.println("<script>alert('회원가입성공');location.href='"+request.getContextPath()+"/index.jsp'</script>");
					
				}else{
					
					response.sendRedirect(request.getContextPath()+"/member/memberjoin.do");
					//out.println("<script>alert('회원가입실패');location.href='"+request.getContextPath()+"/index.jsp'</script>");
					
					}   
			} else if (command.equals("/member/memberjoin.do")) {
				// 회원가입 페이지로 들어오면 처리를 함
				// 넘어오는 페이지를 이동시키는 방법 / 가상경로를 사용하지만 실제로 나타내야할 페이지 경로를 지정하는 메서드
				RequestDispatcher rd = request.getRequestDispatcher("/member/memberjoin.jsp");
				// 클라이언트가 가상경로를 실행하면 가상경로를 대신해 실제 경로를 나타내줄 방식 forward
				rd.forward(request, response);

		}else if(command.equals("/member/memberlist.do")) {
			//회원목록 페이지
			
			MemberDao md = new MemberDao();
			ArrayList<MemberVo> alist = md.memberSelectAll();
			
			request.setAttribute("alist", alist);
			
			RequestDispatcher rd = request.getRequestDispatcher("/member/memberlist.jsp");
			// 클라이언트가 가상경로를 실행하면 가상경로를 대신해 실제 경로를 나타내줄 방식 forward
			rd.forward(request, response);
			
		}else if(command.equals("/member/memberLogin.do")) {
			
			RequestDispatcher rd = request.getRequestDispatcher("/member/memberLogin.jsp");
			// 클라이언트가 가상경로를 실행하면 가상경로를 대신해 실제 경로를 나타내줄 방식 forward
			rd.forward(request, response);
			
		}else if(command.equals("/member/memberLoginaction.do")) {
			
			//1.넘어온 값을 받는다.   Parameter 로 넘어오면 무조건 문자형이기 때문에 String 으로 받아야함
			String memberid = request.getParameter("memberid");
			String memberpwd = request.getParameter("memberpwd");
			//2.처리
			MemberDao md = new MemberDao();
			MemberVo mv = md.memberLogin(memberid, memberpwd);
			
			//3.이동  session은 정보를 담고있는 일정한 공간. 
			if(mv != null ) {
				session.setAttribute("midx", mv.getMidx());// 세션에 값을 담음
				session.setAttribute("memberid", mv.getMemberid());// 세션에 값을 담음
				session.setAttribute("membername", mv.getMembername());// 세션에 값을 담음
				session.setAttribute("membernickname", mv.getMembernickname());// 세션에 값을 담음
				//System.out.println(membernickname);

				if (session.getAttribute("saveurl") != null) {
					response.sendRedirect((String) session.getAttribute("saveurl"));
				} else {
					response.sendRedirect(request.getContextPath() + "/main/index.do");
					/*
					 * RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
					 * rd.forward(request, response);
					 */
				}
			}else {
				response.sendRedirect(request.getContextPath()+"/member/memberLogin.do");
				/*
				 * RequestDispatcher rd = request.getRequestDispatcher("/main/index.do");
				 * rd.forward(request, response);
				 */
			}
			
		}else if(command.equals("/member/memberLogout.do")) {
			
			session.invalidate();
			response.sendRedirect(request.getContextPath()+"/main.jsp");
			
		}else if (command.equals("/member/memberpage.do")) {/*마이페지이 출력*/
			//1.변수가 넘어옴
			int midx = (int)session.getAttribute("midx");
			//2.처리
			MemberDao md = new MemberDao();
			MemberVo mv = md.memberSelectOne(midx);
			request.setAttribute("mv", mv);
			//3.이동
			RequestDispatcher rd = request.getRequestDispatcher("/member/memberpage.jsp");
			rd.forward(request, response);
			
		}else if (command.equals("/member/memberpageaction.do")) {
		
			
			String memberpwd = request.getParameter("memberpwd");
			String memberemail = request.getParameter("memberemail");
			String memberaddr = request.getParameter("memberaddr");
			String memberphone = request.getParameter("memberphone");
			String membernickname = request.getParameter("membernickname");
			int midx = (int)session.getAttribute("midx");
			MemberDao md = new MemberDao();
			int value = md.memberupdate(memberpwd, memberemail, memberaddr, memberphone, membernickname, midx);
			System.out.println("수정완료");
			
			if(value == 1) {
				response.sendRedirect(request.getContextPath()+"/member/memberpage.do");
			}else {
				response.sendRedirect(request.getContextPath()+"/main/index.do");
			}
		}else if(command.equals("/member/Checkmemberid.do")) {//중복체크
			MemberDao md = new MemberDao();
			String memberid = request.getParameter("memberid");
			System.out.println("id 가져옴"+memberid);
			
			int value = md.IdCheck(memberid);
			session.setAttribute("value", value);
			//nextPage="/project/CheckId.jsp";
			
			RequestDispatcher rd = request.getRequestDispatcher("/member/Checkmemberid.jsp?memberid="+memberid);
			rd.forward(request, response);
			
		}
		
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
