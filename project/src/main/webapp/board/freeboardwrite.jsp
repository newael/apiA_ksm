<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="jspstudy.domain.*"%>
<%@ page import="java.util.*"%>
<%@ page import="jspstudy.service.*"%>
<%@ page import="java.util.UUID"%>
<%@ page import="java.io.FileOutputStream"%>
<%@ page import="java.io.OutputStream"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.io.File"%>
<%@ page import="java.util.List"%>
<%@ page import="org.apache.commons.fileupload.FileItem"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%
ArrayList<BoardVo> alist = (ArrayList<BoardVo>) request.getAttribute("alist");
%>
<%
PageMaker pm = (PageMaker) request.getAttribute("pm");
%>
<%
if (session.getAttribute("midx") == null) {

	session.setAttribute("saveurl", request.getRequestURI());

	out.println("<script>alert('글쓰기는 회원만 가능합니다.'); location.href='" + request.getContextPath()
	+ "/main.jsp'</script>");
}
%>

<%
BoardVo bv = (BoardVo) request.getAttribute("bv");
%>

<!DOCTYPE html>
<html>
<head>
<title>자유게시판</title>
<script  type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet"  href="${pageContext.request.contextPath}/css/boardwrite.css">
<%-- <script type="text/javascript" data-cfasync="false" src="${pageContext.request.contextPath }/smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script> --%>
<script type="text/javascript"  src="<%=request.getContextPath() %>/se2/js/HuskyEZCreator.js" ></script>

<script type="text/javascript" src="<%=request.getContextPath() %>/se2/js/jindo.min.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/se2/photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js" charset="utf-8"></script>

<!-- 2.10.0 버전엔 js 파일 일부분이 없어 오류 발생 ! -->

<script>

/* function save(){
	oEditors.getById["txtContent"].exec("UPDATE_CONTENTS_FIELD", []);  
    		//스마트 에디터 값을 텍스트컨텐츠로 전달
	var content = document.getElementById("smartEditor").value;
	alert(document.getElementById("txtContent").value); 
    		// 값을 불러올 땐 document.get으로 받아오기
	return; 
} */

</script>


<script>
function check(){
  	
  	var fm = document.frm;
	oEditors.getById["textAreaContent"].exec("UPDATE_CONTENTS_FIELD", []);
  	
  	if (fm.subject.value ==""){
  		alert("제목을 입력하세요");
  		fm.subject.focus();
  		return;
  	}else if (fm.content.value ==""){
  		alert("내용을 입력하세요");
  		fm.content.focus();
  		return;
  	}/* else if (fm.writer.value ==""){
  		alert("작성자를 입력하세요");
  		fm.writer.focus();
  		return;
  	}  */	
  	

		fm.action = "<%=request.getContextPath()%>/board/freeboardwriteaction.do";
  		fm.method = "post"; 
  		fm.enctype = "multipart/form-data";
  		fm.submit(); 

  
   return;
}

//textArea에 이미지 첨부
function pasteHTML(filepath){
   <%--  var sHTML = '<img src="<%=request.getContextPath()%>/request.getSession().getServletContext().getRealPath("/") + File.separator +"uploadimages"'+filepath+'">'; --%> 
    var sHTML = '<img src="<%=request.getContextPath()%>/uploadimages/'+filepath+'">'; 
    oEditors.getById["textAreaContent"].exec("PASTE_HTML", [sHTML]);
}

</script>
<!-- <script type="text/javascript" data-cfasync="false">
		var oEditors = [];
		$(function(){
		nhn.husky.EZCreator.createInIFrame({
			oAppRef : oEditors,
			elPlaceHolder : "content",											
			sSkinURI : " ${pageContext.request.contextPath}/smarteditor2/sample/SmartEditor2Skin.html",
			
			htParams : {
				//툴바 사용 여부
				bUseToolbar : true,
				// 입력창 크기 조절바 사용 여부
				bUseVerticalResizer : true,
				//모드 탭
				bUseModeChanger : true,
				fOnBeforUnload : function(){
					
				}
			},
			fOnAppLoad : function(){
				//textarea 내용을 에디터샵에 바로 뿌려주고자 할때 사용
				oEditors.getById["content"].exec("PASTE_HTML",["양식"]);
			},
			fCreator : "createSEditor2"
		});
</script> -->

</head>
<body><!-- 
<script>
window.onload = function() {
	const upload = document.querySelector('#upload');
	const preview = document.querySelector('#preview');
	upload.addEventListener('change',function(e){
		var get_file = e.target.files;
		
		var image = document.createElement('img');
		
		/* FileReader 객체 생성 */
		var reader = new FileReader();
		
		/* reader 시작시 함수 구현 */
		reader.onload = (function(aImg){
			console.log(1);
			
			return function(e){
				console.log(3);
				/* base64 인코딩 된 스트링 데이터 */
				aImg.src = e.target.result
			}
		})(image)
		
		if(get_file){
			/* get_file[0]을 읽어서 read 행위가 종료되면 loadend 이벤트가 트리거 되고 onload 에 설정했던 return으로 넘어간다.
			이와 함께 base64 인코딩 된 스트링 데이터가 result 속성에 담겨진다.*/
			reader.readAsDataURL(get_file[0]);
			console.log(2)
		}
		preview.appendChild(image);		
	})
}
</script> -->
	<header>
			<ul class="ul" id="menu">
			<li><a href='<%=request.getContextPath()%>/main/index.do'><img src="/project/images/logo.png" width="100px" height="60px"></a></li>
			<li><a href="<%=request.getContextPath()%>/board/freeboardlist.do?boardtype=1<%-- <%=bv.getBoardtype()%> --%>">자유게시판</a></li>
			<li><a href="<%=request.getContextPath()%>/board/freeboardlist.do?boardtype=2">공략게시판</a></li>
			<li><a href="<%=request.getContextPath()%>/board/freeboardlist.do?boardtype=3">팁게시판</a></li>
			<li><a href="<%=request.getContextPath()%>/board/freeboardlist.do?boardtype=4">질문게시판</a></li>
			<li><a href="<%=request.getContextPath()%>/board/freeboardlist.do?boardtype=5">이미지게시판</a></li>
			<li><a href="<%=request.getContextPath()%>/member/memberlist.do">a</a></li>
			</ul>
	</header>

	<menu>
		<br>
		<p style="font-weight:bold; font-size:2rem;">INVEN</p>
		<p style="font-weight:500;  font-size:1.2rem;">게임 커뮤니티 사이트</p>
		<p style="font-weight:200;  font-size:0.7rem;">저희 사이트를 찾아주셔서 감사합니다</p>
	</menu>

	<aside>
		<nav>
			<%
			if (session.getAttribute("midx") == null) {
			%>
			<fieldset class="fieldset">
				<table>
					<tr>
						<td>
							<%
							out.println("회원이름:" + session.getAttribute("membername") + "<br>");
							%>
						</td>
					</tr>
					<tr>
						<td>
							<%
							out.println("회원아이디:" + session.getAttribute("memberid") + "<br>");
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
					<%
					}
					%>
				</table>
			</fieldset>
			
			<%if(session.getAttribute("midx") != null){ %>
	<fieldset class="fieldset">
			<table>
			<tr>
			<td><% out.println("회원닉네임:"+session.getAttribute("membernickname")+"<br>"); %></td>
			</tr>
			<tr>
			<td><%out.println("<a href='"+request.getContextPath()+"/member/memberLogout.do'>로그아웃</a>"); %> </td>
			</tr>	
			</table>
	</fieldset>
	<% }%>
			
		</nav>
	</aside>

	
	<aside2>
	
	</aside2>
	
	<main>
		<form name="frm" enctype="multipart/form-data" method="post" class="form">
			<table  border="1" class="table">
				<tr >
					<th class="td" colspan="2">글쓰기</th>
				</tr>
				<tr >
					<td class="th" >제목</td>
					<td><input type=text name="subject" size=30 id="subject_text" > </td>
				</tr>
				<tr>
					<td>
					<select name="boardtype">
					<option value="1">자유게시판</option>
					<option value="2">공략게시판</option>
					<option value="3">팁게시판</option>
					<option value="4">질문게시판</option>
					<option value="5">유튜브게시판</option>
					</select> 
					</td>
				</tr>
				<tr>
					<td class="th">내용</td>
					<td ><textarea  name="content" id="textAreaContent" class="textarea"></textarea></td>
					<script type="text/javascript">
					var oEditors = [];
					nhn.husky.EZCreator.createInIFrame({
					    oAppRef: oEditors,
					    elPlaceHolder: "textAreaContent",
					    sSkinURI: "<%=request.getContextPath() %>/se2/SmartEditor2Skin.html",
					    fCreator: "createSEditor2"
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
				</tr>
				<tr>
					<td class="th">작성자</td>
					<td><input type="text" name="membernickname" 
						value="<%=session.getAttribute("membernickname")%>"
						readonly="readonly">
						<input type="hidden" name="writer" 
						value="<%=session.getAttribute("membername")%>"
						readonly="readonly"></td>
				</tr>
				<tr>
					<td class="th">파일</td>
					<td><input  type="file" name="filename" id="upload" multiple></td>
				</tr>
				<tr>				
					<td>
						<div align=center>
							<button type="button" value="작성" name="btn" onclick="check();">작성</button>
							<input type="reset" value="리셋">
						</div>
					</td>
				<tr>
			</table>
		</form>
</main>
	<div class="clear"></div>

	<footer>
	<div id="footer_">
	<img src="/project/images/game1.jpg" width="">
	<p>ㅁㄴㅇ</p>	
	</div> 
	</footer>
</body>
<!-- <script type="text/javascript">
var oEditors = [];
 
$(function(){
   nhn.husky.EZCreator.createInIFrame({
      oAppRef: oEditors,
      elPlaceHolder: "content",
      //SmartEditor2Skin.html 파일이 존재하는 경로
      sSkinURI: "/smarteditor2/sample/SmartEditor2Skin.html",  
      htParams : {
          // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
          bUseToolbar : true,             
          // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
          bUseVerticalResizer : true,     
          // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
          bUseModeChanger : true,         
          fOnBeforeUnload : function(){
               
          }
      }, 
      fOnAppLoad : function(){
          //textarea 내용을 에디터상에 바로 뿌려주고자 할때 사용
          oEditors.getById["ir1"].exec("PASTE_HTML", ["ㅎㅇ 시작하자마자 이문구 작성됨."]);
      },
      fCreator: "createSEditor2"
      });
})
</script> -->
</html>