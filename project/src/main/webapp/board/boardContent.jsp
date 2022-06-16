<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="jspstudy.domain.*"%>
<%@ page import="java.util.*"%>
<%@ page import="jspstudy.service.*"%>
<%
ArrayList<BoardVo> alist = (ArrayList<BoardVo>) request.getAttribute("alist");
%>
<%
PageMaker pm = (PageMaker) request.getAttribute("pm");
%>
<%
BoardVo bv = (BoardVo) request.getAttribute("bv");
%>
<!DOCTYPE html>
<html>
<head>
<title>자유게시판</title>
<script>
function check(){
	
	//alert("테스트");
	
	var fm = document.frm;
		//아이디 미입력 방지
	 if(fm.memberid.value==""){ 
		alert("아이디를 입력하세요");
		fm.memberid.focus();
		return;
		//비밀번호 미입력 방지
	}else if(fm.memberpwd.value==""){
		alert("비밀번호를 입력하세요");
		fm.memberpwd.focus();
		return; }
		
	alert("전송합니다.");
	fm.action ="<%=request.getContextPath()%>/member/memberLoginaction.do";
		fm.method = "post";
		fm.submit();
		return;
	}
</script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/boardcontent.css">


</head>



<body>
	<div id="header">
		<ul class="ul">
			<li><a href='<%=request.getContextPath()%>/main/index.do'><img src="/project/images/logo.png" width="50px" height="50px"></a></li>
			<li><a
				href="<%=request.getContextPath()%>/board/freeboardlist.do?boardtype=1<%-- <%=bv.getBoardtype()%> --%>">자유게시판</a></li>
			<li><a
				href="<%=request.getContextPath()%>/board/freeboardlist.do?boardtype=2">공략게시판</a></li>
			<li><a
				href="<%=request.getContextPath()%>/board/freeboardlist.do?boardtype=3">팁게시판</a></li>
			<li><a
				href="<%=request.getContextPath()%>/board/freeboardlist.do?boardtype=4">추천게시판</a></li>
			<li><a
				href="<%=request.getContextPath()%>/board/freeboardlist.do?boardtype=5">이미지게시판</a></li>
			<li><a href="<%=request.getContextPath()%>/member/memberlist.do">a</a></li>
		</ul>
	</div>
	
	<div id="menu">
		<br>
		<p style="font-weight:bold; font-size:2rem;">INVEN</p>
		<p style="font-weight:500;  font-size:1.2rem;">게임 커뮤니티 사이트</p>
		<p style="font-weight:200;  font-size:0.7rem;">저희 사이트를 찾아주셔서 감사합니다</p>

	</div>	
	
	<!-- 회원정보 폼 -->
	<div id="aside">
		<div id="nav">
			<%
			if (session.getAttribute("midx") == null) {
			%>
			<fieldset class="fieldset">
				<legend>로그인</legend>
				<form name="frm">
					<input type="text" value="아이디" name="memberid"> <input
						type="password" value="비밀번호" name="memberpwd">

					<button type="button" value="회원가입" onclick=loaction href="<%=request.getContextPath()%>/member/memberjoin.do">회원가입하기
					</button>
					<button type="submit" value="로그인" onclick="check();">로그인</button>
				</form>
			</fieldset>
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
		</div>
	</div>

	<div id="aside2"> dasd </div>>
	<!-- 게시글 출력 구간 -->
	<div id="main">
		<div id="section">
			<form class="form">
				<table border=1 class="table">
					<tr>
					<%if (bv.getBoardtype() == 1) {%>
						<th class="td" colspan="2">자유게시판</th>
					<%}if (bv.getBoardtype() == 2) {%>
						<th class="td" colspan="2">공략게시판</th>
					<%}if (bv.getBoardtype() == 3) {%>
						<th class="td" colspan="2">팁게시판</th>
					<%}if (bv.getBoardtype() == 4) {%>
						<th class="td" colspan="2">추천게시판</th>
					<%}if (bv.getBoardtype() == 5) {%>
						<th class="td" colspan="2">유튜브게시판</th>
					<%} %>
					</tr>
					
					<tr>
						<th class="th" id="subject_text">제목</th>
						<td>
						<%=bv.getSUBJECT()%> 
						<input type="hidden"value=<%=bv.getMIDX()%>> 
						<input type="hidden"value=<%=bv.getBIDX()%>>
						</td>
						<%-- <td><%=bv.getBIDX() %></td>
						<td><%=bv.getMIDX() %></td> --%>
						
					</tr>
					<tr >
						<th class="th_subject">내용</th>
						<td height=150px; width=500px  > <%=bv.getCONTENT() %>
							<%if (bv.getFilename() != null) {%>
							 <img src="<%=request.getContextPath()%>/images/<%=bv.getFilename()%>">
							<%}%>
						</td>
					</tr>


					<%if (bv.getFilename() != null) {%> 
					<tr>
						<th class="th">파일다운로드</th>
						<td>
							<a href="<%=request.getContextPath()%>/board/fileDownload.do?filename=<%=bv.getFilename()%>"><%=bv.getFilename()%></a>
						</td>
					</tr>
					<%}%>
					
					<tr>
						<th class="th">작성자</th>
						<td><%=bv.getMembernickname()%></td>
					</tr>
					<tr>
						<td colspan="2">
							<div class="btn_area">
								<%
								if (session.getAttribute("midx") != null && session.getAttribute("midx").equals(bv.getMIDX())) {
								%>
								<input type="button" value="수정" name="modify"
									onclick="location.href='<%=request.getContextPath()%>/board/boardModify.do?bidx=<%=bv.getBIDX()%>&boardtype=<%=bv.getBoardtype()%>'">
								<input type="button" value="삭제" name="Delete"
									onclick="location.href='<%=request.getContextPath()%>/board/boardDelete.do?bidx=<%=bv.getBIDX()%>&boardtype=<%=bv.getBoardtype()%>'">
								<%
								}
								%>
								<%
								if (session.getAttribute("midx") != null) {
								%>
									<input type="button" value="목록" name="list"
										onclick="location.href='<%=request.getContextPath()%>/board/freeboardlist.do?boardtype=<%=bv.getBoardtype()%>'">
									<input type="button" value="답변" name="reply"
										onclick="location.href='<%=request.getContextPath()%>/board/boardReply.do?bidx=<%=bv.getBIDX()%>&originbidx=<%=bv.getORIGINBIDX()%>&depth=<%=bv.getDepth()%>&level_=<%=bv.getLevel_()%>&boardtype=<%=bv.getBoardtype()%>'">
								<%
								}
								%>
								<% if (session.getAttribute("midx") == null) {%>
								<input type="button" value="목록" name="list"
										onclick="location.href='<%=request.getContextPath()%>/board/freeboardlist.do?boardtype=<%=bv.getBoardtype()%>'">
								<%
								}
								%>
							</div>
						</td>
					</tr>
				</table>
			</form>
		</div>>

		<!--페이징 처리 구간  -->

		<%-- <form name="frm"
			action="<%=request.getContextPath()%>/board/freeboardlist.do"
			method="post">
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
								<option value="4">추천</option>
								<option value="5">이미지</option>
						</select></td>
						<td><input type="text" name="keyword" size="30"></td>

						<td><input type="submit" name="submit" value="검색"></td>

						<td><input type="button" value="글쓰기"
							onclick="location.href='<%=request.getContextPath()%>/board/freeboardwrite.do'">
						</td>

					</tr>
				</table>
			</div>
		</form> --%>
	</div>

	
	<div id="footer">
		<div id="footer_logo">
	<img src="/project/images/game1.jpg" >
		</div> 
	</div>

</body>
</html>