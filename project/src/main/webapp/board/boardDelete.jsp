<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import ="jspstudy.controller.*" %>
<%@page import ="jspstudy.service.*" %>
<%@page import ="jspstudy.domain.*" %>



<% BoardDao bd = (BoardDao)request.getAttribute("value"); %>
<%
if(session.getAttribute("midx") == null){
	out.println("<script>alert('글 삭제는 회원만 가능합니다.'); location.href='"+request.getContextPath()+"/member/memberLogin.do'</script>");
}/* else if (session.getAttribute("midx") != request.getAttribute("midx")){
	out.println("<script> alert('본인의 글만 삭제 할 수 있습니다.' + midx); location.href='"+request.getContextPath()+"/board/boardlist.do'</script>" );
} */
%>
<% BoardVo bv = (BoardVo)request.getAttribute("bv"); 
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>게시글 삭제</title>
<script>
function deleteyes(){
	
	
	 var fm = document.frm;
	//제목 미입력 방지
/* if(fm.subject.value==""){ 
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
	}   */
	
	
	//alert("테스트");
	fm.action ="<%=request.getContextPath()%>/board/boardDeleteaction.do";	
	fm.method="post";
	fm.submit();
	alert("삭제하시겠습니까");
	return; 
}

</script>
</head>
<body>
<form name="frm">
<input type ="hidden" name="bidx" value=<%=bv.getBIDX() %>>
<input type="hidden" name="boardtype" value=<%=bv.getBoardtype() %>>
<h3>게시글을 삭제하시겠습니까?</h3>
<input type="button" value="삭제" name="Delete" onclick="deleteyes();" >
<input type="button" value="취소" name="modify" onclick="location.href='<%=request.getContextPath()%>/board/boardContent.do?bidx=<%=bv.getBIDX()%>'" > 
</form>
</body>
</html>