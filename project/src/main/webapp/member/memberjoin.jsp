<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<html>
<head>
<meta charset="utf-8">
<title>회원가입 페이지 만들기</title>
<script src="<%= request.getContextPath() %>/js/jquery-3.6.0.min.js"></script>
<script>
function check(){
	//alert("text")
	 var fm = document.frm;
		//아이디 미입력 방지
	if(fm.memberid.value==""){ 
		alert("아이디를 입력하세요");
		fm.memberid.focus();
		return;
		//비밀번호 미입력 방지
	}else if(fm.idDuplication.value != "idCheck"){
		alert("아이디 중복체크를 해주세요");
		return;
		//비밀번호2 미입력 방지
	}else if(fm.memberpwd.value==""){
		alert("비밀번호를 입력하세요");
		fm.memberpwd.focus();
		return;
		//비밀번호2 미입력 방지
	}else if(fm.memberpwd2.value==""){
		alert("비밀번호 확인을 입력하세요");
		fm.memberpwd2.value==""
		fm.memberpwd2.focus();
		return;
		//비밀번호 1 2 불일치
	}else if(fm.memberpwd.value != fm.memberpwd2.value){
		alert("비밀번호가 일치하지 않습니다.");
		fm.memberpwd2.focus();
		return;
		//닉넴 미입력 방지
	}else if (fm.membernickname.value == ""){
  		alert("닉네임을 입력하세요");  		
  		fm.membernickname.focus();
  		return;
  		//성별 미선택 방지
	}else if (fm.membername.value == ""){
  		alert("이름을 입력하세요");  		
  		fm.membername.focus();
  		return;
  		//성별 미선택 방지
  	}else if (fm.membergender.value == ""){
  		alert("성별을 선택해주세요.");  		
  		fm.membergender.focus();
  		return;
  		//주민번호 미입력 방지
  	}else if (fm.memberjumin.value == ""){
  		alert("주민번호를 입력하세요");  		
  		fm.memberjumin.focus();
  		return;
  		//이메일 미입력 방지
  	}else if (fm.memberemail.value == ""){
  		alert("이메일을 입력하세요");  		
  		fm.memberemail.focus();
  		return;
  		//연락처 미입력 방지
  	}else if (fm.memberphone.value == ""){
  		alert("연락처를 입력하세요");  		
  		fm.memberphone.focus();
  		return;
  	}
	//가상경로를 사용해서 페이지 이동시킨다.
	alert("전송합니다.");
	fm.action ="<%=request.getContextPath()%>/member/memberjoinaction.do";
	/* fm.action ="${contextPath}/member/memberjoinaction.do";	 */
	fm.method="post";
	fm.submit();
	return; 
}
function CheckId(){
	var fm = document.frm;
	var id = fm.memberid.value;
	if(fm.memberid.value==""){
	alert("아이디를 입력해주세요");
	fm.id.focus();
	}else{
		window.open("<%=request.getContextPath()%>/member/Checkmemberid.do?memberid="+id,"","width=500, height=300");
	alert("asdasd");
	}
}
function inputIdChk(){
	var fm = document.frm;
	var CheckId2 = document.frm.CheckId2;
	document.frm.idDuplication.value="idUncheck";
	CheckId2.disabled=false;
	CheckId2.style.opacity=1;
	CheckId2.style.cursor="pointer";
	
}
		
</script>

</head>
<body>

<h3>회원가입</h3>

    <form name="frm">
    <fieldset>
    <legend class="title">*필수입력정보</legend>
	<table class="Table">
	<tr>
	<th >아이디</th>
		<td>
			<input type="text" name="memberid"size=20 placeholder="아이디를 입력해주세요." onkeydown="inputIdChk()" > 
			<button type="button"  onclick="CheckId()" name="CheckId2" class="btn">중복확인</button>
			<!-- 아이디 중복체크 여부  -->
			<input type="hidden" name="idDuplication" value="idUnCheck">
		</td>
	</tr>


	<tr>
		<th>비밀번호</th>
		<td><input type="password" name="memberpwd"size=20 placeholder="비밀번호를 입력해주세요." class="textForm"></td>
	</tr>
	<tr>
		<th>비밀번호 확인</th>
		<td><input type="password" name="memberpwd2"size=20 placeholder="비밀번호를 입력해주세요." class="textForm"></td>
	</tr>
	
	<tr>
		<th>닉네임</th>
		<td><input type="text" name="membernickname" size="15" placeholder ="ㅇㅇㅇ"></td>
	</tr>
	
	
	<tr>
		<th>이름</th>
		<td><input type="text" name="membername" size="30" placeholder ="ㅇㅇㅇ"></td>
	</tr>
	
	<tr>
	<th>성별</th>
	<td>
		<input type="radio" name="membergender" value="M">M
		<input type="radio" name="membergender" value="F">F
		</td>
	</tr>
	
	
	<tr>
		<th>주민번호</th>
		<td><input type="text" name="memberjumin" size=15></td>
	</tr>
	
	<tr>
	<th>지역</th>
	<td><select name="memberaddr">
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
		<th>이메일</th>  
		<td><input type="email" name="memberemail" placeholder="xxxx@xxx.com"></td>
	</tr>
	
	<tr>
		<th>연락처</th>
		<td><input type="text" name="memberphone" size=15></td>
	</tr>
	
	<tr>
   	 	<th>개인정보 수집 내용 동의</th> 
   		<td>
   			<input type="radio" name="email" value="수신수락">수신동의
   			<input type="radio" name="email" value="수신거부">수신거부
		</td>
	</tr>
	
	
	
	</table>
	</fieldset>
	
	<div class="btn_area">
	<button type="button" value="취소"  onclick="location.href='<%=request.getContextPath()%>/index.jsp'" >취소</button>
	<button type="button" name="btn" class="btn_join" onclick="check();">회원가입</button> 
	</div>
	
	</form>
</body>
</html>