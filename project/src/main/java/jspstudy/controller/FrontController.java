package jspstudy.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/FrontController")
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
				//주소의 풀경로를 추출하는 메소드
				String uri = request.getRequestURI();
				//프로젝트 이름을 추출
				String pj = request.getContextPath();
				//전체경로에서 프로젝트 이름을 뺀 나머지 가상경로 추출
				String command = uri.substring(pj.length());
				//ex) /member/memberList.do
				
				String[] subpath =  command.split("/");
				String location = subpath[1]; //2번째 문자열 추출 ex) member
				
				if(location.equals("member")) {
					MemberController mc = new MemberController();
					mc.doGet(request, response); 
					
				}else if (location.equals("board")) {
					BoardController bc = new BoardController();
					bc.doGet(request, response);
					
				}else if (location.equals("main")) {
					MainController MC = new MainController();
					MC.doGet(request, response);
					
				}
				String boardtype = request.getParameter("boardtype");
				System.out.println(boardtype+"boardtype front");
				
				String subject = request.getParameter("subject");
				System.out.println(subject+"subject???");
				String content = request.getParameter("content");
				System.out.println(content+"content???");
				String writer = request.getParameter("writer");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
