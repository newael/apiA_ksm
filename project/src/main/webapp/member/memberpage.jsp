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
<%MemberVo mv =(MemberVo) request.getAttribute("mv"); %>
<%
BoardVo bv = (BoardVo) request.getAttribute("bv");
%>

<!DOCTYPE html>
<head>
<title>자유게시판</title>
<link rel="stylesheet"  href="${pageContext.request.contextPath}/css/freeboardlist.css">
<script src="<%= request.getContextPath() %>/js/jquery-3.6.0.min.js"></script>
<script>
<%-- $(function(){
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
});  --%>

$(function(){
	$("#frm").submit(function(){
		var password = $(this).find("input[name=memberpwd]").val();
		var password2 = $(this).find("input[name=memberpwd2]").val();
		//var nick = $(this).find("input[name=membernickname]").val();
		var email = $(this).find("input[name=memberemail]").val();
		//var phone = $(this).find("input[name=memberphone]").val();
		                      // find("input[name=memberid]").val();
		                      
		//닉네임 이메일 연락처
		if(password ==""){
			alert("비밀번호 입력해주세요");
			return false;
		}else if(password2 == ""){
			alert("비밀번호 확인을 입력해주세요.")
			return false;
		}else if(password != password2){
			alert("비밀번호가 다릅니다.")
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



</head>



<body>
	<header>
			<ul class="ul" id="menu">
			<li><a href='<%=request.getContextPath()%>/main/index.do'><img src="/project/images/logo.png" width="100px" height="60px"></a></li>
			<li><a href="<%=request.getContextPath()%>/board/freeboardlist.do?boardtype=1<%-- <%=bv.getBoardtype()%> --%>">자유게시판</a></li>
			<li><a href="<%=request.getContextPath()%>/board/freeboardlist.do?boardtype=2">공략게시판</a></li>
			<li><a href="<%=request.getContextPath()%>/board/freeboardlist.do?boardtype=3">팁게시판</a></li>
			<li><a href="<%=request.getContextPath()%>/board/freeboardlist.do?boardtype=4">질문게시판</a></li>
			<li><a href="<%=request.getContextPath()%>/board/freeboardlist.do?boardtype=5">이미지게시판</a></li>
			<li><a href="<%=request.getContextPath()%>/member/memberlist.do">a</a></li>
			</ul>
	</header>

	<menu>
		<br>
		<p style="font-weight:bold; font-size:2rem;">INVEN</p>
		<p style="font-weight:500;  font-size:1.2rem;">게임 커뮤니티 사이트</p>
		<p style="font-weight:200;  font-size:0.7rem;">저희 사이트를 찾아주셔서 감사합니다</p>
	</menu>

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
			</fieldset>
			<%
			}
			%>
		</nav>
	</aside>
	
	<aside2>
	asd
	
	</aside2>
	
	<!-- 게시글 출력 구간 -->
	<main>
		<section>
			<section>
				<form id="frm">
					<input type="hidden" value="<%=mv.getMidx() %>">
					<table border="1" width="1200px" height="700" class="table">
					<tr>
						<th class="td">아이디</th>
						<td class="td"><input type="text" name="memberid" value="<%=session.getAttribute("memberid")%>" readonly="readonly"></td>
					</tr>
					<tr>
						<th class="td">비밀번호</th>
						<td class="td"><input type="password" name="memberpwd"><td>
					</tr>
					<tr>
						<th class="td">비밀번호확인</th>
						<td class="td"><input type="password" name="memberpwd2"></td>
					</tr>
					<tr>
						<th class="td">닉네임</th>
						<td class="td"><input type="text" name="membernickname" value="<%=session.getAttribute("membernickname")%>"></td>
					</tr>
					<tr>
						<th class="td">이메일</th>			
						<td class="td"><input type="email" name="memberemail" value=""></td>
					</tr>
					<tr>
						<th class="td">연락처</th>			
						<td class="td"><input type="text" name="memberphone"></td>
					</tr>
					<tr>
					<th class="td">지역</th>
					<td class="td"><select name="memberaddr">
				            		<option value="서울">서울</option>
									<option value="부산">부산</option>
									<option value="광주">광주</option>
									<option value="울산">울산</option>
									<option value="대구">대구</option>
									<option value="인천">인천</option>
									<option value="대전">대전</option>
									<option value="경기도">경기도</option>
									<option value="충북">충북</option>
									<option value="충남">충남</option>
									<option value="전북">전북</option>
									<option value="전남">전남</option>
									<option value="경북">경북</option>
									<option value="경남">경남</option>
									<option value="강원">강원</option>
									<option value="제주">제주</option>
							</select> </td>
					</tr>
					<tr>
						<th></th>
							<td class="td">
							<button type="submit">수정완료</button>
							<button type="button" onclick="location.href='<%=request.getContextPath()%>/main/index.do'">취소</button>
							</td>
					</tr>
					</table> 
				</form>
		</section>
		</section>

		<!--페이징 처리 구간  -->
		
	
		<%-- <form name="frm"action="<%=request.getContextPath()%>/board/freeboardlist.do"method="post">
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
							onclick="location.href='<%=request.getContextPath()%>/main/index.do'">
						</td>

					</tr>
				</table>
			</div>
		</form> --%>
	</main>

	<div class="clear"></div>



	<footer> </footer>

</body>
</html>