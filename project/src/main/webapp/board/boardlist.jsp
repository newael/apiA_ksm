<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import ="jspstudy.domain.*"%>
<%@ page import ="java.util.*" %>
<%@ page import ="jspstudy.service.*" %>
<% ArrayList<BoardVo> alist = (ArrayList<BoardVo>) request.getAttribute("alist"); %>
<% PageMaker pm = (PageMaker)request.getAttribute("pm"); %>

<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
<title>게시글 목록</title>
<link rel="stylesheet"  href="${pageContext.request.contextPath}/css/boardlist.css">
</head>

<body>
<input type="button" value="메인"  onclick="location.href='<%=request.getContextPath()%>/index.jsp'" >
<header>
<h1 class="textcenter">게시판 리스트</h1>
</header>
<nav>
</nav>
<section>

<table class="table" border=1 style="width:800px">
<tr>
<th class="th_no"><font color = white>no.</font></th>
<th><font color = white> title </font></th>
<th class="th_writer"><font color = white> writer </font></th>
<th class="th_date"><font color = white> date </font></th>
</tr>
<% for(BoardVo bv : alist){ %>
<tr >
<td><%=bv.getBIDX() %></td>
<td  >
<%
for(int i=1; i<=bv.getLevel_(); i++){
	out.print("&nbsp;&nbsp;");  //nbsp 출력문을 약간 옆으로 이동
	if(i==bv.getLevel_()){
		out.println("ㄴ");
	}
}
%>
<a href="<%=request.getContextPath() %>/board/boardContent.do?bidx=<%=bv.getBIDX() %>"><%=bv.getSUBJECT()%></a>
</td>
<td><%=bv.getWRITER() %></td>
<td><%=bv.getWRITEDAY()%></td>
</tr>
<%} %>
</table>
</section>
<table align = "center">
<tr>
<td>
<% if(pm.isPrev()==true) {
out.println("<a href='"+request.getContextPath()+"/board/boardlist.do?page="+(pm.getStartPage()-1)+"&keyword="+pm.encoding(pm.getScri().getKeyword())+"&searchtype="+pm.getScri().getSearchtype()+"'>◀</a>");
}%> 
</td>

<td>
<%
for(int i=pm.getStartPage(); i<=pm.getEndPage(); i++){
	out.println("<a href='"+request.getContextPath()+"/board/boardlist.do?page="+i+"&keyword="+pm.encoding(pm.getScri().getKeyword())+"&searchtype="+pm.getScri().getSearchtype()+"'>"+i+"</a>");
}

%>
</td>

<td>
<% if(pm.isNext()&& pm.getEndPage() > 0) {
out.println("<a href='"+request.getContextPath()+"/board/boardlist.do?page="+(pm.getEndPage()+1)+"&keyword="+pm.encoding(pm.getScri().getKeyword())+"&searchtype="+pm.getScri().getSearchtype()+"'>▶</a>");
}%> 
</td>
</tr>
</table>
<br>

<footer>
<form name="frm" action="<%=request.getContextPath()%>/board/boardlist.do" method="post">
<div align="center">

<table>
<tr>

<td>
<select name="searchtype">
<option value="subject">제목</option>
<option value="writer">작성자</option>
</select>
</td>

<td>
<input type="text" name="keyword" size="30">
</td>

<td>
<input type="submit" name="submit" value ="검색">
</td>

<td>
<input type="button" value="글쓰기"   onclick="location.href='<%=request.getContextPath()%>/board/boardwrite.do'" >
</td>

</tr>
</table>
</div>
</form>

</footer>
</body>
</html>