package jspstudy.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.InetAddress;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import jspstudy.domain.BoardVo;
import jspstudy.domain.Criteria;
import jspstudy.domain.MemberVo;
import jspstudy.domain.PageMaker;
import jspstudy.domain.SearchCriteria;
import jspstudy.service.BoardDao;
import jspstudy.service.MemberDao;

import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jspstudy.domain.BoardVo;
import jspstudy.domain.SearchCriteria;
import jspstudy.service.BoardDao;

/**
 * Servlet implementation class MainController
 */
@WebServlet("/MainController")
public class MainController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public MainController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		// 가상경로 추출
		String uri = request.getRequestURI();
		String pj = request.getContextPath();
		String command = uri.substring(pj.length());

		BoardDao bd = new BoardDao();
		BoardVo bv = new BoardVo();

		if (command.equals("/main/index.do")) {
			// 1.파라미터가 넘어옴
			int boardtype_ = 0;

			if (request.getParameter("boardtype") == null) {
				boardtype_ = 1;
			} else {
				boardtype_ = Integer.parseInt(request.getParameter("boardtype"));
			}

			/* int boardtype = Integer.parseInt( request.getParameter("boardtype")); */

			SearchCriteria scri = new SearchCriteria();
			scri.setBoardtype(0);

			int cnt = bd.boardTotal(scri);
			System.out.println("cnt" + cnt);

			// 2.처리함
			ArrayList<BoardVo> alist = bd.boardSelectFive(scri, 0);
			request.setAttribute("alist", alist);
			System.out.println(alist.get(0).getBIDX() + "alist");

			// 3.이동
			RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
			rd.forward(request, response);

		} else if (command.equals("/member/memberLogin.do")) {

			RequestDispatcher rd = request.getRequestDispatcher("/member/memberLogin.jsp");
			// 클라이언트가 가상경로를 실행하면 가상경로를 대신해 실제 경로를 나타내줄 방식 forward
			rd.forward(request, response);

		} else if (command.equals("/member/memberLoginaction.do")) {

			// 1.넘어온 값을 받는다. Parameter 로 넘어오면 무조건 문자형이기 때문에 String 으로 받아야함
			String memberid = request.getParameter("memberid");
			String memberpwd = request.getParameter("memberpwd");
			// 2.처리
			MemberDao md = new MemberDao();
			MemberVo mv = md.memberLogin(memberid, memberpwd);

			HttpSession session = request.getSession();
			// 3.이동 session은 정보를 담고있는 일정한 공간.
			if (mv != null) {
				session.setAttribute("midx", mv.getMidx());// 세션에 값을 담음
				session.setAttribute("memberid", mv.getMemberid());// 세션에 값을 담음
				session.setAttribute("membername", mv.getMembername());// 세션에 값을 담음
				session.setAttribute("membernickname", mv.getMembernickname());// 세션에 값을 담음
				// System.out.println(membernickname);

				if (session.getAttribute("saveurl") != null) {
					response.sendRedirect((String) session.getAttribute("saveurl"));
				} else {
					response.sendRedirect(request.getContextPath() + "/main/index.do");
					/*
					 * RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
					 * rd.forward(request, response);
					 */
				}

			} else {
				response.sendRedirect(request.getContextPath() + "/member/memberLogin.do");
			}
			/*
			 * RequestDispatcher rd = request.getRequestDispatcher("/main/index.do");
			 * rd.forward(request, response);
			 */
		} else if (command.equals("/member/memberLogout.do")) {

			HttpSession session = request.getSession();
			session.invalidate();
			response.sendRedirect(request.getContextPath() + "/main.jsp");
				
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
