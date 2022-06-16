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
<% if(session.getAttribute("midx") == null){
	out.println("<script>alert('정보수정은 회원만 가능합니다'); location.href'"+request.getContextPath()+"/main/index.do'</script>");
%>
<!DOCTYPE html>
<head>
<meta charset="utf-8">
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
		$(this).attr("action",'<%=request.getContextPath()%>/member/memberpageaction.do');
		method="post";
		submit();
		}
	});
}); 
</script>
<link rel="stylesheet"  href="${pageContext.request.contextPath}/css/freeboardlist.css">

</head>
<body>
	<header>
		<div id="logo">
		<a href='<%=request.getContextPath()%>/main/index.do'>
		<img src="/project/images/logo.png" width="100px" height="60px"></a>
		</div>
	</header>
	<top>
		<ul class="ul" id="menu">
			<li><a href="<%=request.getContextPath()%>/board/freeboardlist.do?boardtype=1<%-- <%=bv.getBoardtype()%> --%>">자유게시판</a></li>
			<li><a href="<%=request.getContextPath()%>/board/freeboardlist.do?boardtype=2">공략게시판</a></li>
			<li><a href="<%=request.getContextPath()%>/board/freeboardlist.do?boardtype=3">팁게시판</a></li>
			<li><a href="<%=request.getContextPath()%>/board/freeboardlist.do?boardtype=4">추천게시판</a></li>
			<li><a href="<%=request.getContextPath()%>/board/freeboardlist.do?boardtype=5">이미지게시판</a></li>
			<li><a href="<%=request.getContextPath()%>/member/memberlist.do">a</a></li>
		</ul>
	</top>

	<!-- 회원정보 폼 -->
	<aside>
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
			<%
			}}
			%>
			</fieldset>
		</nav>
	</aside>
	
	<aside2>
	asd
	
	</aside2>
	
	<!-- 게시글 출력 구간 -->
	<main>
		<section>
			<!-- <table border="1" width="1200px" height="700" class="table">
			</table> -->
			<input type="text" name="memberid">아이디 기본값줄것
			<input type="password" name="memberpwd">비밀번호
			<input type="password" name="memberpwd2">비밀번호확인
			<input type="text" name="membernickname">닉네임
			<input type="email" name="memberemail">이메일
			<input type="text" name="memberphone">연락처
		</section>

		<!--페이징 처리 구간  -->
		
		
	</main>

	<div class="clear"></div>



	<footer> </footer>

</body>
</html>