<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.awt.Graphics2D" %>
<%@ page import="java.awt.image.renderable.ParameterBlock" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="javax.media.jai.JAI" %>
<%@ page import="javax.media.jai.RenderedOp" %>
<%@ page import="javax.imageio.ImageIO" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*"%>
<%@ page import="jspstudy.service.*"%>
<%@ page import="jspstudy.domain.*"%>
<%
ArrayList<BoardVo> alist = (ArrayList<BoardVo>) request.getAttribute("alist");
%>
<%
PageMaker pm = (PageMaker) request.getAttribute("pm");
%>

<%-- <%
    ServletContext context = request.getServletContext();
    String imagePath=context.getRealPath("image");
    
    int size = 1*1024*1024 ;
    String filename="";
    
    try{
        MultipartRequest multi=    new MultipartRequest(request,
                                imagePath,
                              size,
                              "euc-kr",
                            new DefaultFileRenamePolicy());
        
        Enumeration files=multi.getFileNames();
        
        String file =(String)files.nextElement();
        filename=multi.getFilesystemName(file);
    }catch(Exception e){
        e.printStackTrace();
    }
    
    ParameterBlock pb=new ParameterBlock();
    pb.add(imagePath+"/"+filename);
    RenderedOp rOp=JAI.create("fileload",pb);
    
    BufferedImage bi= rOp.getAsBufferedImage();
    BufferedImage thumb=new BufferedImage(100,100,BufferedImage.TYPE_INT_RGB);
    
    Graphics2D g=thumb.createGraphics();
    g.drawImage(bi,0,0,100,100,null);
    
    File file=new File(imagePath+"/sm_"+filename);
    ImageIO.write(thumb,"jpg",file);
%> --%>


<!DOCTYPE html>
<html>
<head>
<title>자유게시판</title>
<script src="<%= request.getContextPath() %>/js/jquery-3.6.0.min.js"></script>
<script>
$(function(){
	$("#frm").submit(function(){
		var value = $(this).find("input[name=memberid]").val();
		var password = $(this).find("input[name=memberpwd]").val();
		                      // find("input[name=memberid]").val();
		if(value == ""){
			alert("아이디 입력좀");
			return false;
		}else if(password ==""){
			alert("비밀번호 입력좀");
			return false;
		}else{
		//	return true;
		$(this).attr("action",'<%=request.getContextPath()%>/member/memberLoginaction.do');
		method="post";
		submit();
		}
	});
}); 
</script>
<link rel="stylesheet"  href="${pageContext.request.contextPath}/css/freeboardlist.css">
</head>
<body>
	<div id="header">
		<div id="logo">
		<ul class="ul" >
			<li><a href='<%=request.getContextPath()%>/main/index.do'><img src="/project/images/logo.png" width="100px" height="60px"></a></li>
			<li><a href="<%=request.getContextPath()%>/board/freeboardlist.do?boardtype=1<%-- <%=bv.getBoardtype()%> --%>">자유게시판</a></li>
			<li><a href="<%=request.getContextPath()%>/board/freeboardlist.do?boardtype=2">공략게시판</a></li>
			<li><a href="<%=request.getContextPath()%>/board/freeboardlist.do?boardtype=3">팁게시판</a></li>
			<li><a href="<%=request.getContextPath()%>/board/freeboardlist.do?boardtype=4">추천게시판</a></li>
			<li><a href="<%=request.getContextPath()%>/board/freeboardlist.do?boardtype=5">이미지게시판</a></li>
			<li><a href="<%=request.getContextPath()%>/member/memberlist.do">a</a></li>
		</ul>
		</div>
	</div>
	
	<div id="menu">
		<br>
		<p style="font-weight:bold; font-size:2rem;">INVEN</p>
		<p style="font-weight:500;  font-size:1.2rem;">게임 커뮤니티 사이트</p>
		<p style="font-weight:200;  font-size:0.7rem;">저희 사이트를 찾아주셔서 감사합니다</p>
	</div>
	<!-- 회원정보 폼 -->
	<div id="aside">
		<nav>
			<%
			if (session.getAttribute("midx") == null) {
			%>
				<legend>로그인</legend>
				<form id="frm" >
									<%-- 	"<%=request.getContextPath()%>/member/memberLoginaction.do" --%>
					<input type="text"  name="memberid"> 
					<input type="password"  name="memberpwd">

					<button type="button"  onclick="location.href='<%=request.getContextPath()%>/member/memberjoin.do'">
					회원가입하기
					</button>
					<!-- <button type="submit" value="로그인" onclick="check();">로그2인</button> -->
					<button type="submit" >로그인</button>
				</form>
			<%
			}
			%>
			<%
			if (session.getAttribute("midx") != null) {
			%>
			<fieldset class="fieldset">
				<table>
					<tr>
						<td>
							<%
							out.println("회원닉네임:" + session.getAttribute("membernickname") + "<br>");
							%>
						</td>
					</tr>
					<tr>
						<td>
							<%
							out.println("<a href='" + request.getContextPath() + "/member/memberLogout.do'>로그아웃</a>");
							%>
						</td>
					</tr>
				</table>
			</fieldset>
			<%
			}
			%>
		</nav>
	</div>
	
	<div id="aside2">
	asd
	
	</div>
	
	<!-- 게시글 출력 구간 -->
	<div id="main">
			<table border="1" width="1200px" height="700" class="table">
				<tr>
					<%
					String boardtype = request.getParameter("boardtype");
					int boardtype_ = Integer.parseInt(boardtype);
					if (boardtype_ == 1) {
					%>
					<td align="center" class="td" colspan="4">자유게시판</td>
					<%
					}
					%>
					<%
					if (boardtype_ == 2) {
					%>
					<td align="center" class="td"colspan="4">공략게시판</td>
					<%
					}
					%>
					<%
					if (boardtype_ == 3) {
					%>
					<td align="center" class="td"colspan="4">팁게시판</td>
					<%
					}
					%>
					<%
					if (boardtype_ == 4) {
					%>
					<td align="center" class="td"colspan="4">추천게시판</td>
					<%
					}
					%>
					<%
					if (boardtype_ == 5) {
					%>
					<td align="center" class="td"colspan="4">유튜브게시판</td>
					<%
					}
					%>
				</tr>

				<tr>
					<th class="th_no,td" >no.</th>
					<th class="th_subject">제목</th>
					<th class="th_writer" width="100px">작성자</th>
					<th class="th_date">작성일</th>
				</tr>


				<%
				for (BoardVo bv : alist) {
				%>
				
				
				<tr>
					<td class="td"><%=bv.getBIDX()%></td>
					<td class="td">
						<%-- <%
						for (int i = 1; i <= bv.getLevel_(); i++) {
							out.print("&nbsp;&nbsp;"); //nbsp 출력문을 약간 옆으로 이동
							if (i == bv.getLevel_()) {
								out.println("ㄴ");
							}
						}
						%>  --%>
						<a href="<%=request.getContextPath()%>/board/boardContent.do?bidx=<%=bv.getBIDX()%>"><%=bv.getSUBJECT()%></a>
					</td>
					<td class="td"><%=bv.getMembernickname()%></td>
					<td class="td"><%=bv.getWRITEDAY()%></td>
				</tr>
				
				<%
				}
				%>
			</table>
		<!--페이징 처리 구간  -->
		<form align="center">
			<table align="center">
				<tr>
					<td>
						<%
						if (pm.isPrev() == true) {
							out.println("<a href='" + request.getContextPath() + "/board/freeboardlist.do?page=" + (pm.getStartPage() - 1)
							+ "&keyword=" + pm.encoding(pm.getScri().getKeyword()) + "&searchtype=" + pm.getScri().getSearchtype()
							+ "&boardtype=" + pm.getScri().getBoardtype() + "'>◀</a>");
						}
						%>
					</td>

					<td>
						<%
						for (int i = pm.getStartPage(); i <= pm.getEndPage(); i++) {
							out.println("<a href='" + request.getContextPath() + "/board/freeboardlist.do?page=" + i + "&keyword="
							+ pm.encoding(pm.getScri().getKeyword()) + "&searchtype=" + pm.getScri().getSearchtype() + "&boardtype="
							+ pm.getScri().getBoardtype() + "'>" + i + "</a>");
						}
						%>
					</td>

					<td>
						<%
						if (pm.isNext() && pm.getEndPage() > 0) {
							out.println("<a href='" + request.getContextPath() + "/board/freeboardlist.do?page=" + (pm.getEndPage() + 1)
							+ "&keyword=" + pm.encoding(pm.getScri().getKeyword()) + "&searchtype=" + pm.getScri().getSearchtype()
							+ "&boardtype=" + pm.getScri().getBoardtype() + "'>▶</a>");
						}
						%>
					</td>
				</tr>

			</table>
		</form>
		<form name="frm"action="<%=request.getContextPath()%>/board/freeboardlist.do"method="post">
			<div align="center">
				<table>
					<tr>
						<td><select name="searchtype">
								<option value="subject">제목</option>
								<option value="membernickname">작성자</option>
						</select></td>
						<td><input type="hidden" value=""> <select
							name="boardtype">
								<option value="1">자유</option>
								<option value="2">공략</option>
								<option value="3">팁</option>
						</select></td>
						<td><input type="text" name="keyword" size="30"></td>

						<td><input type="submit" name="submit" value="검색"></td>

						<td><input type="button" value="글쓰기"
							onclick="location.href='<%=request.getContextPath()%>/board/freeboardwrite.do'">
						</td>

					</tr>
				</table>
			</div>
		</form>

	</div>

	<div class="clear"></div>



	<div id="footer"> </div>

</body>
</html>