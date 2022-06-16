<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
	Integer value = (Integer)session.getAttribute("value");
%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="memberid" value="${param.memberid }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Id 중복확인</title>
<script src="<%= request.getContextPath() %>/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	function sendCheckValue(){
		var openfrm = opener.document.frm;
		
		if(document.checkidForm.chResult.value=="N"){
			alert("이미 사용중인 아이디입니다.");
			openfrm.memberid.focus();
			
			window.close();
		}else{
			// 중복체크 결과인 idCheck 값을 전달
			
			openfrm.idDuplication.value="idCheck";
			openfrm.CheckId2.disabled=true;
			//openfrm.Checkmemberid.style.opacity=0;
			//openfrm.Checkmemberid.style.cursor="default";
			window.close(); 
		}
		
	}
</script>
</head>
<body>
	<b><font size="4" color="gray">ID 중복 확인</font></b>
	<br>
	
	<form name="checkidForm">
		<input type="text" name="memberid" value="${memberid}" id="memberid" disabled>
		
		<c:choose> 
		<c:when test="${value==1 }"> 
			<p style="color:red">이미 사용중인 아이디입니다.</p>
			<input type="hidden" name="chResult" value="N"/>
		</c:when>
		<c:when test="${value==0}">
			<p style="color:red">사용 가능한 아이디입니다.</p>
			<input type="hidden" name="chResult" value="Y">
		</c:when>
		<c:otherwise>  
			<p>오류발생(-1)</p>
			<input type="hidden" name="chResult" value="N"/>
		</c:otherwise>
		</c:choose>
		
		<input type="button" onclick="window.close()" value="취소"><br>
		<input type="button" onclick="sendCheckValue()" value="사용하기">
	
	
	
	</form>

</body>
</html>