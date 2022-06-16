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
<script>
function check(){
	//alert("테스트22")
	
	var fm = document.frm;
	
	if(fm.memberid.value==""){
		alert("아이디를 입력하세요.");
		fm.memberid.focus();
		return;
	}else if(fm.memberpwd.value==""){
		alert("비밀번호를 입력하세요.");
		fm.memberpwd.focus();
		return;
	}
	
	alert("로그인합니다.");
	fm.action = "<%=request.getContextPath()%>/member/memberLoginaction.do";
		fm.method = "post";
		fm.submit();
	return;
	}
</script>
<title>메인페이지</title>

<link rel="stylesheet"  href="${pageContext.request.contextPath}/css/basic.css">

</head>
<body >
	<header>
		<a href='<%=request.getContextPath()%>/main/index.do'><img
			src="/project/images/logo.png" width="50px" height="50px"></a>
		<ul class="ul" id="menu">
			<li><a
				href="<%=request.getContextPath()%>/board/freeboardlist.do?boardtype=1<%-- <%=bv.getBoardtype()%> --%>">자유게시판</a></li>
			<li><a
				href="<%=request.getContextPath()%>/board/freeboardlist.do?boardtype=2">공략게시판</a></li>
			<li><a
				href="<%=request.getContextPath()%>/board/freeboardlist.do?boardtype=3">팁게시판</a></li>
			<li><a href="<%=request.getContextPath()%>/member/memberlist.do">a</a></li>
			<li>c</li>
			<li>d</li>
		</ul>
	</header>

	<aside>
		<nav>
			<%
			if (session.getAttribute("midx") == null) {
			%>
			<!-- action="/project/member/memberLoginaction.do" -->
			<legend>로그인</legend> 
			<form name="frm">
				
				<input type="text"  name="memberid"> 
				<input type="password"  name="memberpwd">

				<button type="button" value="회원가입" onclick="location.href='<%=request.getContextPath()%>/member/memberjoin.do'">회원가입하기</button>
				<!-- <button type="submit" value="로그인" onclick="check();">로그2인</button> -->
				<button type="submit" onclick="check();" value="로그인">로그인</button>
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

	<main>
		<section>
			<form name="frm">
				<table border="1" class="table2" align="left">
					<tr>
						<th>자유게시판</th>
					</tr>
					<tr>
						<th class="th_no" width="50px">no.</th>
						<th class="th_subject">제목</th>
						<th class="th_writer">작성자</th>
						<th class="th_date" width="180px">작성일</th>
					</tr>

					<%
					int j = 0;
					for (int i = 0; i < alist.size(); i++) {

						if (alist.get(i).getBoardtype() == 1) {
					%>
					<tr>
						<td><%=alist.get(i).getBIDX()%></td>
						<td><a
							href="<%=request.getContextPath()%>/board/boardContent.do?bidx=<%=alist.get(i).getBIDX()%>"><%=alist.get(i).getSUBJECT()%></a></td>
						<td><%=alist.get(i).getMembernickname()%></td>
						<td><%=alist.get(i).getWRITEDAY()%></td>
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
						<th>공략게시판</th>
					</tr>
					<tr>
						<th class="th_no" width="50px">no.</th>
						<th class="th_subject">제목</th>
						<th class="th_writer">작성자</th>
						<th class="th_date" width="180px">작성일</th>
					</tr>

					<%
					int u = 0;
					for (int i = 0; i < alist.size(); i++) {

						if (alist.get(i).getBoardtype() == 2) {
					%>
					<tr>
						<td><%=alist.get(i).getBIDX()%></td>
						<td><a
							href="<%=request.getContextPath()%>/board/boardContent.do?bidx=<%=alist.get(i).getBIDX()%>"><%=alist.get(i).getSUBJECT()%></a></td>
						<td><%=alist.get(i).getMembernickname()%></td>
						<td><%=alist.get(i).getWRITEDAY()%></td>
					</tr>
					<%
					u++;
					if (u > 4)
						break;
					}
					}
					%>
				</table>
			</form>
		</section>


		<section>
		<form name="frm">
				<table border="1" class="table2" align="left">
					<tr>
						<th>팁게시판</th>
					</tr>
					<tr>
						<th class="th_no">no.</th>
						<th class="th_subject">제목</th>
						<th class="th_writer">작성자</th>
						<th class="th_date">작성일</th>
					</tr>

					<%
					int s = 0;
					for (int i = 0; i < alist.size(); i++) {

						if (alist.get(i).getBoardtype() == 3) {
					%>
					<tr>
						<td><%=alist.get(i).getBIDX()%></td>
						<td><a
							href="<%=request.getContextPath()%>/board/boardContent.do?bidx=<%=alist.get(i).getBIDX()%>"><%=alist.get(i).getSUBJECT()%></a></td>
						<td><%=alist.get(i).getMembernickname()%></td>
						<td><%=alist.get(i).getWRITEDAY()%></td>
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
						<th>추천게시판</th>
					</tr>
					<tr>
						<th class="th_no">no.</th>
						<th class="th_subject">제목</th>
						<th class="th_writer">작성자</th>
						<th class="th_date">작성일</th>
					</tr>

					<%
					int e = 0;
					for (int i = 0; i < alist.size(); i++) {

						if (alist.get(i).getBoardtype() == 4) {
					%>
					<tr>
						<td><%=alist.get(i).getBIDX()%></td>
						<td><a
							href="<%=request.getContextPath()%>/board/boardContent.do?bidx=<%=alist.get(i).getBIDX()%>"><%=alist.get(i).getSUBJECT()%></a></td>
						<td><%=alist.get(i).getMembernickname()%></td>
						<td><%=alist.get(i).getWRITEDAY()%></td>
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
		</section>

	</main>

	<div class="clear"></div>

	<footer> footer </footer>

</body>
</html>