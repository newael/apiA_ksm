<%@page import="jspstudy.domain.BoardVo"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="jspstudy.controller.*"%>
<%@page import="jspstudy.service.*"%>
<%
BoardVo bv = (BoardVo) request.getAttribute("bv");
%>

<%
	/* Stirng midx = request.getParameter("midx");
	int midx_ = Integer.parseInt(midx); */
%>
<%-- <%
if (session.getAttribute("midx") == null) {
	out.println("<script>alert('글수정은 회원만 가능합니다.'); location.href='" + request.getContextPath()
	+ "/member/memberLogin.do'</script>");
} else if (session.getAttribute("midx") != ("midx")) {
	out.println("<script> alert('본인의 글만 수정할 수 있습니다.' + midx); location.href='" + request.getContextPath()
	+ "/board/boardlist.do'</script>");

}
%> --%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/boardmodify.css">
<script type="text/javascript"  src="<%=request.getContextPath() %>/se2/js/HuskyEZCreator.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/se2/js/jindo.min.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/se2/photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js" charset="utf-8"></script>

<meta charset="utf-8">
<title>게시글 수정하기</title>
<script>

function check1(){
	
	//alert("테스트");
	
	var fm = document.frm;
	
	oEditors.getById["textAreaContent"].exec("UPDATE_CONTENTS_FIELD", []);
	
		//제목 미입력 방지
	if(fm.subject.value==""){ 
		alert("제목을 입력해주세요");
		fm.subject.focus();
		return;
		//내용 미입력 방지
	}else if(fm.content.value==""){
		alert("내용을 입력해주세요");
		fm.content.focus();
		return;
		//작성자 미입력 방지
	}else if(fm.writer.value==""){
		alert("작성자 이름을 입력해주세요");
		fm.writer.focus();
		return;
  	} 
		
	
	//가상경로를 사용해서 페이지 이동시킨다.
		
	//alert("글을 작성했습니다.");
	<%-- fm.action ="<%=request.getContextPath()%>/board/boardModifyaction.do"; --%>
	fm.action = "<%=request.getContextPath()%>/board/boardModifyaction.do";
		fm.method = "post";
		fm.submit();
		return;
}
</script>
</head>
<body>
	<header>
	<ul class="ul" id="menu">
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
	</header>
	
	<menu>
	asd
	</menu>
	
	<!-- 회원정보 폼 -->
	<aside>
		<nav>
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
		</nav>
	</aside>

	<aside2> dasd </aside2>
	<!-- 게시글 출력 구간 -->
	<main>
			<form name="frm" enctype="multipart/form-data" method="post">
			<table class="Table" border=1>
				<tr>
					<th>제목</th>
					<td><input type="text" name="subject" size=40
						value=<%=bv.getSUBJECT()%>> 
					<input type="text" name="boardtype" value="<%=bv.getBoardtype()%>">
						<input type="hidden" name="bidx" value=<%=bv.getBIDX()%>></td>
				</tr>
				
				<tr>
					<td>
						<select name="boardtype">
						<!-- 디폴트 벨류  -->
						<% if(bv.getBoardtype() != 0){ %>
						<option value="1">자유게시판</option>
						<option value="2">공략게시판</option>
						<option value="3">팁게시판</option>
						<option value="4">질문게시판</option>
						<option value="5">유튜브게시판</option>
						<%} %>
						</select> 
					</td>
				</tr>
				
				<tr>
					<td class="th">내용</td>
					<td><textarea  name="content" id="textAreaContent" rows="10" cols="100"   class="form"></textarea>
							<!-- textarea 밑에 script 작성하기 -->
					<%-- <script id="smartEditor" type="text/javascript"> 
						var oEditors = [];
						nhn.husky.EZCreator.createInIFrame({
					    oAppRef: oEditors,
					    elPlaceHolder: "txtContent",  //textarea ID 입력
					    sSkinURI: "../libs/smarteditor/SmartEditor2Skin.html",  //martEditor2Skin.html 경로 입력
					    fCreator: "createSEditor2",
					    fOnAppLoad : function(){
                            let sHTML = '<%=bv.getCONTENT()%>';
                           oEditors.getById["txtContent"].exec("PASTE_HTML", [sHTML]);
                         },
					  
					    htParams : { 
					    	// 툴바 사용 여부 (true:사용/ false:사용하지 않음) 
					        bUseToolbar : true, 
						// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음) 
						bUseVerticalResizer : false, 
						// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음) 
						bUseModeChanger : false 
					    }
						});
					</script> --%>
					<script>
						var oEditors = [];
					nhn.husky.EZCreator.createInIFrame({
					    oAppRef: oEditors,
					    elPlaceHolder: "textAreaContent",
					    sSkinURI: "<%=request.getContextPath() %>/se2/SmartEditor2Skin.html",
					    fCreator: "createSEditor2",
					    fOnAppLoad : function(){
                            let sHTML = '<%=bv.getCONTENT()%>';
                           oEditors.getById["textAreaContent"].exec("PASTE_HTML", [sHTML]);
                         },
					});
					//‘저장’ 버튼을 누르는 등 저장을 위한 액션을 했을 때 submitContents가 호출된다고 가정한다.
					function submitContents(elClickedObj) {
					    // 에디터의 내용이 textarea에 적용된다.
					    oEditors.getById["textAreaContent"].exec("UPDATE_CONTENTS_FIELD", [ ]);
					 
					    // 에디터의 내용에 대한 값 검증은 이곳에서
					    // document.getElementById("textAreaContent").value를 이용해서 처리한다.
					  
					    try {
					        elClickedObj.form.submit();
					    } catch(e) {
					     
					    }
					}
					</script>
					
					
					<td>
						<div id="preview">
						<!-- 미리보기 공간 -->					
						</div>
						
					</td>
				</tr>

				<tr>
					<th>작성자</th>
					<td><input type="text" name="membernickname"
						value="<%=session.getAttribute("membernickname")%>"
						readonly="readonly">
					<input type="hidden" name="writer"
						value="<%=session.getAttribute("membername")%>"
						readonly="readonly"></td>
				</tr>
			</table>

			<div>
				<button type="button" value="작성" name="btn" onclick="check1();">작성</button>
				<input type="reset" value="리셋">
			</div>
		</form>

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
	</main>

	<div class="clear"></div>



	<footer> </footer>

</body>
</html>