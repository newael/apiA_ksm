<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="jspstudy.domain.*"%>
<%@ page import="java.util.*"%>
<%@ page import="jspstudy.service.*"%>	
<%ArrayList<BoardVo> alist = (ArrayList<BoardVo>) request.getAttribute("alist");%>
<%BoardVo bv = (BoardVo) request.getAttribute("bv");%>
<%PageMaker pm = (PageMaker) request.getAttribute("pm");%>

<!DOCTYPE html>
<html>
<head>
<!-- <script src="/project/js/jquery-3.6.0.min.js"></script> -->
<script src="<%= request.getContextPath() %>/js/jquery-3.6.0.min.js"></script>
<script>
$(function(){
	$("#frm").submit(function(){
		var value = $(this).find("input[name=memberid]").val();
		var password = $(this).find("input[name=memberpwd]").val();
		                      // find("input[name=memberid]").val();
		if(value == ""){
			alert("아이디를 입력해주세요");
			return false;
		}else if(password ==""){
			alert("비밀번호를 입력해주세요");
			return false;
		}else{
		//	return true;
		$(this).attr("action",'<%=request.getContextPath()%>/member/memberLoginaction.do');
		method="post";
		submit();
		}
	});
}); 
/* 	
$(function(){
    $("#frm").submit(function(){
       let value = $(this).find("input[name=memberid]").val();
       
       alert(value);
       
       return false;
    });
 }); */
	
	
/* 	
$(function(){
    $("#frm").submit(function(){
       let value = $(this).find("input[name=memberid]").val();
       
       if(value == ""){
          alert("입력좀");
       }
    });
 }); */
</script>
<<<<<<< HEAD
<title>메인페이지 입니까???zzzz</title>
=======
<title>메인페이지</title>
>>>>>>> branch 'master' of https://github.com/newael/apiA_ksm.git

<link rel="stylesheet"  href="${pageContext.request.contextPath}/css/basic.css">

</head>
<body >
	<div id="header">
		<ul  >
			<li><a id="ul" href='<%=request.getContextPath()%>/main/index.do' style="margin-right:100px"><img src="/project/images/logo.png" width="100px" height="60px"></a></li>
			<li><a id="ul" href="<%=request.getContextPath()%>/board/freeboardlist.do?boardtype=1">자유게시판</a></li>
			<li><a id="ul" href="<%=request.getContextPath()%>/board/freeboardlist.do?boardtype=2">공략게시판</a></li>
			<li><a id="ul"  href="<%=request.getContextPath()%>/board/freeboardlist.do?boardtype=3">팁게시판</a></li>
			<li><a id="ul" href="<%=request.getContextPath()%>/board/freeboardlist.do?boardtype=4">질문게시판</a></li>
			<li><a id="ul" href="<%=request.getContextPath()%>/board/freeboardlist.do?boardtype=5">이미지게시판</a></li>
		</ul>
	</div>
	
	<div id="menu">
	<br>
	<p style="font-weight:bold; font-size:2rem;">INVEN</p>
	<p style="font-weight:500;  font-size:1.2rem;">게임 커뮤니티 사이트</p>
	<p style="font-weight:200;  font-size:0.7rem;">저희 사이트를 찾아주셔서 감사합니다</p>
	</div>

	<div id="aside">
		<div id="nav">
			<%
			if (session.getAttribute("midx") == null) {
			%>
			<!-- action="/project/member/memberLoginaction.do" -->
			<legend>로그인</legend> 
			<form id="frm">
				
				<input type="text"  name="memberid" placeholder="아이디"> <br>
				<input type="password"  name="memberpwd"  placeholder="비밀번호">
				<br>
				<%-- <button type="button" onclick='loaction.href="<%=request.getContextPath()%>/member/memberjoin.do"'>회원가입</button> --%>
				<button type="button"  onclick="location.href='<%=request.getContextPath()%>/member/memberjoin.do'">회원가입하기</button> 
				<!-- <button type="submit" value="로그인" onclick="check();">로그2인</button> -->
				<input type="submit"  onclick="" value="로그인">
				<!-- <button type="submit"  value="로그인">로그인</button> -->
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
					<tr>
						<td>
						<a href="<%=request.getContextPath()%>/member/memberpage.do">마이페이지</a>
						</td>
					</tr>
				</table>
			</fieldset>
			<%
			}
			%>
		</div>
		<img src="/project/images/game2.jpg" id="game2">
	</div>
	
	<div id="aside2">
	asd
	
	</div>
	
	<div id="main">
		<!-- <div id="section"> -->
			<form name="frm">
				<table border="1" class="table2" align="left">
					<tr>
						<th class="td" colspan="3">자유게시판</th>
					</tr>
					<tr>
						<th class="td" width="50px">no.</th>
						<th class="td">제목</th>
						<th class="td">작성자</th>
					</tr>

					<%
					int j = 0;
					for (int i = 0; i < alist.size(); i++) {

						if (alist.get(i).getBoardtype() == 1) {
					%>
					<tr>
						<td class="td"><%=alist.get(i).getBIDX()%></td>
						<td class="td"><a href="<%=request.getContextPath()%>/board/boardContent.do?bidx=<%=alist.get(i).getBIDX()%>"><%=alist.get(i).getSUBJECT()%></a></td>
						<td class="td"><%=alist.get(i).getMembernickname()%></td>
					</tr>
					<%
					j++;
					if (j > 4)
						break;
					}
					}
					%>
				</table>
			</form>
			<form name="frm">
				<table border="1" class="table2" align="left">
					<tr>
						<th class="td" colspan="3">공략게시판</th>
					</tr>
					<tr>
						<th class="td" width="50px">no.</th>
						<th class="td">제목</th>
						<th class="td">작성자</th>
					</tr>

					<%
					int o = 0;
					for (int i = 0; i < alist.size(); i++) {

						if (alist.get(i).getBoardtype() == 2) {
					%>
					<tr>
						<td class="td"><%=alist.get(i).getBIDX()%></td>
						<td class="td"><a href="<%=request.getContextPath()%>/board/boardContent.do?bidx=<%=alist.get(i).getBIDX()%>"><%=alist.get(i).getSUBJECT()%></a></td>
						<td class="td"><%=alist.get(i).getMembernickname()%></td>
					</tr>
					<%
					o++;
					if (o > 4)
						break;
					}
					}
					%>
				</table>
			</form>

<hr>
<br>

		<form name="frm">
				<table border="1" class="table2" align="left">
					<tr>
						<th class="td" colspan="3">팁게시판</th>
					</tr>
					<tr>
						<th class="td" width="50px">no.</th>
						<th class="td">제목</th>
						<th class="td">작성자</th>
					</tr>

					<%
					int s = 0;
					for (int i = 0; i < alist.size(); i++) {

						if (alist.get(i).getBoardtype() == 3) {
					%>
					<tr>
						<td class="td"><%=alist.get(i).getBIDX()%></td>
						<td class="td"><a href="<%=request.getContextPath()%>/board/boardContent.do?bidx=<%=alist.get(i).getBIDX()%>"><%=alist.get(i).getSUBJECT()%></a></td>
						<td class="td"><%=alist.get(i).getMembernickname()%></td>
					</tr>
					<%
					s++;
					if (s > 4)
						break;
					}
					}
					%>
				</table>
			</form>
		<form name="frm">
				<table border="1" class="table2" align="right">
					<tr>
						<th class="td" colspan="3">질문게시판</th>
					</tr>
					<tr>
						<th class="td" width="50px">no.</th>
						<th class="td">제목</th>
						<th class="td">작성자</th>
					</tr>

					<%
					int e = 0;
					for (int i = 0; i < alist.size(); i++) {

						if (alist.get(i).getBoardtype() == 4) {
					%>
					<tr>
						<td class="td"><%=alist.get(i).getBIDX()%></td>
						<td class="td"><a href="<%=request.getContextPath()%>/board/boardContent.do?bidx=<%=alist.get(i).getBIDX()%>"><%=alist.get(i).getSUBJECT()%></a></td>
						<td class="td"><%=alist.get(i).getMembernickname()%></td>
					</tr>
					<%
					e++;
					if (e > 4)
						break;
					}
					}
					%>
				</table>
			</form>
				
				
				<hr>
				<div>
				<h2 >관리자 추천</h2>
				</div>
				<ul id="youtube_area">
							<%
							int f = 0;
							for (int i = 0; i < alist.size(); i++) {
		
								if (alist.get(i).getBoardtype() == 5) {
							%>
					<li>
						<ul id="ul_youtube"><!-- 게시글 하나 -->
							<%-- <li><a href="<%=request.getContextPath()%>/board/boardContent.do?bidx=<%=alist.get(i).getBIDX()%>"><%=alist.get(i).getSUBJECT()%></a></li> --%>
							<li ><%=alist.get(i).getCONTENT() %></li>
						</ul>
					</li>
							<%
							f++;
							if (f > 2)
								break;
								}
							}
							%>
				</ul>
	</div>

	<div id="footer">
		<div id="footer_logo">
	<img src="/project/images/game1.jpg" width="">
		</div> 
	</div>
</body>
</html>