<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<html>
<head>
<meta charset="utf-8">
<title>회원가입 페이지 만들기</title>
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
	fm.method="post";
	fm.submit();
	return;
}
</script>

<link rel="stylesheet"  href="${pageContext.request.contextPath}/css/memberjoin.css">

</head>
<body>
    <form name="frm">
    <fieldset>
    <legend class="title">로그인</legend>
<table class="Table">
	<tr>
	<th >아이디</th>
	<td><input type="text" name="memberid"size=20 placeholder="아이디를 입력해주세요." class="textForm" > </td>
	</tr>


	<tr>
	<th>비밀번호</th>
	<td><input type="password" name="memberpwd"size=20 placeholder="비밀번호를 입력해주세요." class="textForm"></td>
	</tr>
	<tr>
	</table>
	</fieldset>

	
	
	<div class="btn_area">
	<button type="button"   onclick="location.href='<%=request.getContextPath()%>/index.jsp'" >취소</button>
	<button type="button" name="btn" class="btn_join" onclick="check();">로그인</button> 
	<button type="button"   onclick="location.href='<%=request.getContextPath()%>/member/memberjoin.do'" >회원가입</button>
	</div>
	
	</form>
</body>
</html>