<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import ="jspstudy.domain.*"%>
<%@ page import ="java.util.*" %>
<%
	
	//select 쿼리를 사용하기 위해서 function 에서 메소드를 만든다.
	//memberSelectAll 호출한다.
	//MemberDao md = new MemberDao();
	//ArrayList<MemberVo> alist = md.memberSelectAll();
	//out.println(alist.get(0).getMembername()+"<br>");
	
	ArrayList<MemberVo> alist = (ArrayList<MemberVo>)request.getAttribute("alist");
	
%>    
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"  href="${pageContext.request.contextPath}/css/memberlist.css">
<meta charset="utf-8">
<title>회원목록 리스트</title>

</head>

<body>
<input type="button" value="메인홈페이지"  onclick="location.href='<%=request.getContextPath()%>/main/index.do'" >
<br>
<h1 class="textcenter">회원목록 리스트</h1>

<table class="table" border=1 style="width:800px">
<tr>
<th>번호</th>
<th>회원이름</th>
<th>회원아이디</th>
<th>회원닉네임</th>
<th>회원연락처</th>
<th>작성일</th>
</tr>

<% for(MemberVo mv : alist){ %>

<tr>
<td><%=mv.getMidx() %></td>
<td><% out.println(mv.getMembername()); %></td>
<td><% out.println(mv.getMemberid()); %></td>
<td><% out.println(mv.getMembernickname()); %></td>
<td><% out.println(mv.getMemberphone()); %></td>
<td><% out.println(mv.getWriteday()); %></td>
</tr>
<% } %>
</table>
</body>
</html>