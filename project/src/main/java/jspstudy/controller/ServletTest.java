package jspstudy.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/ServletTest")
public class ServletTest extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ServletTest() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	//	response.getWriter().append("Served at: ").append(request.getContextPath()).append("first servlet");
	
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html;charset=utf-8");
		
		
	PrintWriter out = response.getWriter();	
	out.println("<html>"
			+ "<head>"
			+ "<title>하이</title>"
			+ "</head>"
			+ "<body>"
			+ "<h1>하이</h1>"
			+ "</body>"
			+ "</html>");
	
	
	
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
