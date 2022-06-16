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
import jspstudy.domain.PageMaker;
import jspstudy.domain.SearchCriteria;
import jspstudy.service.BoardDao;

@WebServlet("/BoardController")
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public BoardController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		//가상경로 추출
		String uri = request.getRequestURI();
		String pj = request.getContextPath();
		String command = uri.substring(pj.length());
		
		//여러곳에서 쓰니까 여기에 지정 (fileDownload.do랑 boardWriteAction.do에서 사용)
				String uploadPath = "C:\\dev\\project\\src\\main\\webapp\\";
				String saveFolder = "images";
				String saveFullPath = uploadPath + saveFolder;
		
				
				
		//글쓰기 
		if (command.equals("/board/freeboardwrite.do")){
			RequestDispatcher rd = request.getRequestDispatcher("/board/freeboardwrite.jsp");
			rd.forward(request, response);
			
		}else if(command.equals("/board/freeboardwriteaction.do")) {
			
			int sizeLimit = 1024*1024*100;
			
			MultipartRequest multi = null;
			/* new DefaultFileRenamePolicy() 파일네임 중복x 처리 밑의 괄호 안에 넣으면 적용 */
			multi = new MultipartRequest(request, saveFullPath, sizeLimit,"utf-8" );
		
			String subject = multi.getParameter("subject");
			String content = multi.getParameter("content");
			String writer = multi.getParameter("writer");
			String membernickname = multi.getParameter("membernickname");
			String boardtype = multi.getParameter("boardtype");
			int boardtype_ = Integer.parseInt(boardtype);
			
			
			
			//열거자에 저장될 파일을 담는 객체를 생성한다
			Enumeration files = multi.getFileNames();
			//담긴 파일의 객체의 파일 이름을 얻는다
			String file = (String)files.nextElement();			
			//저장되는 파일이름
			String fileName = multi.getFilesystemName(file);
			//원래 파일이름
			String originFileName = multi.getOriginalFileName(file);
			
			String ip =InetAddress.getLocalHost().getHostAddress();
			
			
		
			
			HttpSession session = request.getSession();
			
			int midx = (int) session.getAttribute("midx");
			BoardDao bd = new BoardDao();
			int value = bd.insertboard(subject, content, writer, ip, midx, fileName,membernickname,boardtype_);
		
			if (value ==1) {
				response.sendRedirect(request.getContextPath()+"/board/freeboardlist.do?boardtype="+boardtype);
				
			}else {
				response.sendRedirect(request.getContextPath()+"/board/freeboardlist.do");
				
			}
		}else if (command.equals("/board/freeboardlist.do")) {
			
			//게시판 종류
			String boardtype = request.getParameter("boardtype");
			int boardtype_ = Integer.parseInt(boardtype);
			//게시판 페이지
			String page = request.getParameter("page");
			if(page == null) page = "1";
		 	int page_ = Integer.parseInt(page);
			
		 	//게심판 검색기능 
		 	String keyword = request.getParameter("keyword");
		 	if(keyword == null) keyword = "";		 	
		 	String searchtype = request.getParameter("searchtype");
		 	if(searchtype == null) searchtype = "subject";

		 	int boardtype_2 = Integer.parseInt(boardtype);
		 	if(boardtype_2 == 0) boardtype_2 = boardtype_;
		 	
		 	
		 	SearchCriteria scri = new SearchCriteria();
		 	scri.setPage(page_);
		 	scri.setKeyword(keyword);
		 	scri.setSearchtype(searchtype);
		 	scri.setBoardtype(boardtype_);
			/*
			 * scri.setBoardtype(boardtype_); System.out.println(boardtype_+ "__ ");
			 * System.out.println(boardtype + "asd");
			 */
			BoardDao bd = new BoardDao();
		
			int cnt = bd.boardTotal(scri);
			System.out.println("cnt"+cnt);
			
			PageMaker pm = new PageMaker();
			pm.setScri(scri);
			pm.setTotalCount(cnt);
			
			ArrayList<BoardVo> alist = bd.boardSelectAll(scri, boardtype_); //이 부분 나중에 boardtype 가져올수 있게 해둘것 임시로 cnt
			request.setAttribute("alist", alist);  //데이터 자원을 담아두고 있으니 밑에서 써라.(공유)
			request.setAttribute("pm", pm);
			
			//이동
			RequestDispatcher rd = request.getRequestDispatcher("/board/freeboardlist.jsp");
			rd.forward(request, response);
			
			//게시글을 보여주는 부분
		}else if (command.equals("/board/boardContent.do")) {
			
			//1.파라미터가 넘어옴
			String bidx = request.getParameter("bidx");
			int bidx_ = Integer.parseInt(bidx);// integer.parseint 로 문자열로 받아온 bidx 를 int 형으로 바꿔줌
			System.out.println(bidx_ + "bidx");
			//2.처리함
			BoardDao bd = new BoardDao();
			BoardVo bv = bd.boardSelectOne(bidx_);
		
				//	BoardVo bv2 = bd.boardSelectOne(boardtype_);
			
			request.setAttribute("bv", bv); //내부적으로 자원공유.
				//	request.setAttribute("bv", bv2);
			
			//3.이동함
			
			  RequestDispatcher rd =request.getRequestDispatcher("/board/boardContent.jsp"); 
			  rd.forward(request,response);
			 
			
			
			//게시글 수정 버튼의 기능을 만든 함수
		}else if(command.equals("/board/boardModify.do")) {
			
			//1.파라미터가 넘어옴
			String bidx = request.getParameter("bidx");
			int bidx_ = Integer.parseInt(bidx);// integer.parseint 로 문자열로 받아온 bidx 를 int 형으로 바꿔줌
			String boardtype = request.getParameter("boardtype");
			System.out.println(boardtype+"보드타입");
			int boardtype_ = Integer.parseInt(boardtype);
//			//2.처리함
			BoardDao bd = new BoardDao();
			BoardVo bv = bd.boardSelectOne(bidx_);
			request.setAttribute("bv", bv); //내부적으로 자원공유.
//			
//			//3.이동함
			RequestDispatcher rd = request.getRequestDispatcher("/board/boardModify.jsp");
			rd.forward(request, response);
			
			//게시글의 수정 내용을 db에 입력해주는 함수
		}else if (command.equals("/board/boardModifyaction.do")) {
			int sizeLimit = 1024*1024*100;
			
			MultipartRequest multi = null;
			/* new DefaultFileRenamePolicy() 파일네임 중복x 처리 밑의 괄호 안에 넣으면 적용 */
			multi = new MultipartRequest(request, saveFullPath, sizeLimit,"utf-8" );

			
			String subject = multi.getParameter("subject");
			String content = multi.getParameter("content");
			String writer = multi.getParameter("writer");
			String ip =InetAddress.getLocalHost().getHostAddress();
			String bidx = multi.getParameter("bidx");
		
			String boardtype = multi.getParameter("boardtype");
			String membernickname = multi.getParameter("membernickname");
			HttpSession session = request.getSession();
			int midx = (int) session.getAttribute("midx");
			
			int boardtype_ = Integer.parseInt(boardtype);
			int bidx_ = Integer.parseInt(bidx);
			BoardDao bd = new BoardDao();
			
			System.out.println(boardtype_ +"보드타입 asd");
			
			
			
			int value = bd.update(subject, content, writer, ip, midx, boardtype_, membernickname, bidx_);
			
			if (value ==1) {
				response.sendRedirect(request.getContextPath()+"/board/freeboardlist.do?boardtype="+boardtype_);
			}else {
				response.sendRedirect(request.getContextPath()+"/board/freeboardlist.do");
				
			}
			
		}else if (command.equals("/board/boardDelete.do")) {
			//1.파라미터가 넘어옴
			String bidx = request.getParameter("bidx");
			int bidx_ = Integer.parseInt(bidx);// integer.parseint 로 문자열로 받아온 bidx 를 int 형으로 바꿔줌
			String boardtype = request.getParameter("boardtype");
			int boardtype_ = Integer.parseInt(boardtype);		
			
//			
			//2.처리함
			BoardDao bd = new BoardDao();
			BoardVo bv = bd.boardSelectOne(bidx_);
			//bv.setBIDX(Integer.parseInt(bidx));
			//bv.setBoardtype(Integer.parseInt(boardtype));
			request.setAttribute("bv", bv); 
			
			//3.이동함
			RequestDispatcher rd = request.getRequestDispatcher("/board/boardDelete.jsp");
			rd.forward(request, response);
			
		}else if (command.equals("/board/boardDeleteaction.do")) {
			
			String bidx = request.getParameter("bidx");
			int bidx_ = Integer.parseInt(bidx);// integer.parseint 로 문자열로 받아온 bidx 를 int 형으로 바꿔줌
			System.out.println("게시글 삭제 실행");
			System.out.println("bidx"+bidx);
			String boardtype = request.getParameter("boardtype");
			int boardtype_ = Integer.parseInt(boardtype);
			
			BoardDao bd = new BoardDao();
			 HttpSession session =request.getSession();
			int value = bd.delete(bidx_,(int)session.getAttribute("midx"));
			
			if (value ==1) {
				response.sendRedirect(request.getContextPath()+"/board/freeboardlist.do?boardtype="+boardtype_);
				
			}else {
				response.sendRedirect(request.getContextPath()+"/board/boardContent.do?bidx="+bidx_);
				
			}
		}else if (command.equals("/board/boardReply.do")) {
			//1.파라미터가 넘어옴
			String bidx = request.getParameter("bidx");
			String originbidx = request.getParameter("originbidx");
			String depth = request.getParameter("depth");
			String level_ = request.getParameter("level_");
			String membernickname = request.getParameter("membernickname");
			String boardtype = request.getParameter("boardtype");
			//int boardtype = (int) request.getAttribute("boardtype");
			//int boardtype_ = Integer.parseInt(boardtype);

			//2.처리함
			
			BoardVo bv = new BoardVo();
			bv.setBIDX(Integer.parseInt(bidx));
			bv.setORIGINBIDX(Integer.parseInt(originbidx));
			bv.setDepth(Integer.parseInt(depth));
			bv.setLevel_(Integer.parseInt(level_));
			bv.setBoardtype(Integer.parseInt(boardtype));
			bv.setMembernickname(membernickname);
			System.out.println("이부분이문제");
			request.setAttribute("bv", bv);
			
			
			//3.이동함
			RequestDispatcher rd = request.getRequestDispatcher("/board/boardReply.jsp");
			rd.forward(request, response);
		
		}else if (command.equals("/board/boardReplyaction.do")) {
			String bidx = request.getParameter("bidx");
			String originbidx = request.getParameter("originbidx");
			String depth = request.getParameter("depth");
			String level_ = request.getParameter("level_");
			String subject = request.getParameter("subject");
			String content = request.getParameter("content");
			String writer = request.getParameter("writer");
			String ip =InetAddress.getLocalHost().getHostAddress();
			String membernickname = request.getParameter("membernickname");
		//	int boardtype = (int) request.getAttribute("boardtype");
			String boardtype = request.getParameter("boardtype");
			int boardtype_ = Integer.parseInt(boardtype);
			
			HttpSession session = request.getSession();
			int midx = (int) session.getAttribute("midx");
			
			BoardVo bv = new BoardVo();
			BoardDao bd = new BoardDao();
			//넘어온 데이터를 bv에 담음
			bv.setBIDX(Integer.parseInt(bidx));
			bv.setORIGINBIDX(Integer.parseInt(originbidx));
			bv.setDepth(Integer.parseInt(depth));
			bv.setLevel_(Integer.parseInt(level_));
			bv.setSUBJECT(subject);
			bv.setCONTENT(content);
			bv.setWRITER(writer);
			bv.setiP(ip);
			bv.setMIDX(midx);
			bv.setMembernickname(membernickname);
			bv.setBoardtype(boardtype_);
			//bv.setBoardtype(Integer.parseInt(boardtype));
			int value = bd.reply(bv);
			
			if (value ==1) {
				response.sendRedirect(request.getContextPath()+"/board/boardContent.do?bidx="+bidx);
				
			}else {
				response.sendRedirect(request.getContextPath()+"/board/boardContent.do?bidx="+bidx);
				
			}
		}else if (command.equals("/board/fileDownload.do")) {
			//파일 이름을 넘겨받는다
			String filename = request.getParameter("filename");
			//파일의 전체 경로
			String filePath = saveFullPath + File.separator + filename;
			
			
			//해당위치에 있는 파일을 읽어들인다. 
			FileInputStream fileInputStream = new FileInputStream(filePath);
			
			Path source = Paths.get(filePath);
			String mimeType = Files.probeContentType(source);
			//헤더정보에 추출한 파일형식을 담는다.  
			response.setContentType(mimeType);
			
			String sEncoding = new String(filename.getBytes("UTF-8"));
			//헤더정보에 파일이름을 담는다
			response.setHeader("Content-Disposition", "attachment;fileName="+sEncoding);
			
			//파일쓰기 
			ServletOutputStream servletOutStream = response.getOutputStream();
			
			byte[] b = new byte[4096];
			int read = 0;
			while((read = fileInputStream.read(b, 0, b.length)) != -1) {
				servletOutStream.write(b, 0, read);
			}
			
			servletOutStream.flush();
			servletOutStream.close();
			fileInputStream.close();
		}
			
			
		
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
