<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="jspstudy.domain.BoardVo" %>
<%
if(session.getAttribute("midx") == null){
	out.println("<script>alert('답글은 회원만 쓸 수 있습니다.'); location.href='"+request.getContextPath()+"/member/memberLogin.do'</script>");
}//else if (session.getAttribute("midx") != )
%>
<% BoardVo bv = (BoardVo)request.getAttribute("bv"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>답변하기</title>
<script>

function check1(){
	
	//alert("테스트");
	
	var fm = document.frm;
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
	fm.action ="<%=request.getContextPath()%>/board/boardReplyaction.do";	
	fm.method="post";
	fm.submit();
	return;
}


</script>

<style>

.Table th{
			text-align : center;
			background-color :darkgrey;
			width : 50px;}


fieldset{border:0;}

table{
	border-collapse:collapse;
	  }

</style>


</head>
<body>

<fieldset>
<form name = "frm">
<input type ="hidden" name="bidx" value="<%=bv.getBIDX()%>">
<input type ="hidden" name="originbidx" value="<%=bv.getORIGINBIDX() %>">
<input type ="hidden" name="depth" value="<%=bv.getDepth() %>">
<input type ="hidden" name="level_" value="<%=bv.getLevel_() %>">
<input type ="hidden" name="boardtype" value="<%=bv.getBoardtype() %>">
<table  style="padding-top:50px;" align = center width=700 border=1 cellpadding=2 >
                <tr>
                <td height=20 align= center bgcolor=#ccc><font color=white>답글쓰기</font></td>
                </tr>
                <tr>
                <td bgcolor=white>
                <table class = "table2">
 
                        <tr>
                        <td>제목</td>
                        <td><input type = text name = subject size=60></td>
                        </tr>
 
                        <tr>
                        <td>내용</td>
                        <td><textarea name = content cols=85 rows=15></textarea></td>
                        </tr>
 
                        <tr>
                        <td>작성자</td>
                        <td><input type="text" name="membernickname" 
						value="<%=session.getAttribute("membernickname")%>"
						readonly="readonly">
						</td>
						<td><input type="hidden" name="writer" 
						value="<%=session.getAttribute("membername")%>"
						readonly="readonly"></td>
                        </tr>
                        
                        </table>
                </td>
                </tr>
        </table>



<div align = center> 
<button type="button" value="작성" name="btn" onclick="check1();">작성</button>
<input type="reset" value="리셋">
</div>
</form>
</fieldset>
</body>
</html>