<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- script type="text/javascript"  src="<%=request.getContextPath() %>/js/HuskyEZCreator.js" ></script> -->


<script>
/*
Copyright (C) NAVER corp.  

This library is free software; you can redistribute it and/or  
modify it under the terms of the GNU Lesser General Public  
License as published by the Free Software Foundation; either  
version 2.1 of the License, or (at your option) any later version.  

This library is distributed in the hope that it will be useful,  
but WITHOUT ANY WARRANTY; without even the implied warranty of  
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU  
Lesser General Public License for more details.  

You should have received a copy of the GNU Lesser General Public  
License along with this library; if not, write to the Free Software  
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA  
*/
if(typeof window.nhn=='undefined') window.nhn = {};
if (!nhn.husky) nhn.husky = {};

/**
 * @fileOverview This file contains application creation helper function, which would load up an HTML(Skin) file and then execute a specified create function.
 * @name HuskyEZCreator.js
 */
nhn.husky.EZCreator = new (function(){
	this.nBlockerCount = 0;

	this.createInIFrame = function(htOptions){
		if(arguments.length == 1){
			var oAppRef = htOptions.oAppRef;
			var elPlaceHolder = htOptions.elPlaceHolder;
			var sSkinURI = htOptions.sSkinURI;
			var fCreator = htOptions.fCreator;
			var fOnAppLoad = htOptions.fOnAppLoad;
			var bUseBlocker = htOptions.bUseBlocker;
			var htParams = htOptions.htParams || null;
		}else{
			// for backward compatibility only
			var oAppRef = arguments[0];
			var elPlaceHolder = arguments[1];
			var sSkinURI = arguments[2];
			var fCreator = arguments[3];
			var fOnAppLoad = arguments[4];
			var bUseBlocker = arguments[5];
			var htParams = arguments[6];
		}

		if(bUseBlocker) nhn.husky.EZCreator.showBlocker();

		var attachEvent = function(elNode, sEvent, fHandler){ 
			if(elNode.addEventListener){
				elNode.addEventListener(sEvent, fHandler, false);
			}else{
				elNode.attachEvent("on"+sEvent, fHandler);
			}
		} 

		if(!elPlaceHolder){
			alert("Placeholder is required!");
			return;
		}

		if(typeof(elPlaceHolder) != "object")
			elPlaceHolder = document.getElementById(elPlaceHolder);

		var elIFrame, nEditorWidth, nEditorHeight;
		 

		try{
			elIFrame = document.createElement("<IFRAME frameborder=0 scrolling=no>");
		}catch(e){
			elIFrame = document.createElement("IFRAME");
			elIFrame.setAttribute("frameborder", "0");
			elIFrame.setAttribute("scrolling", "no");
			elIFrame.setAttribute("id", "smarteditor");
		}
		
		elIFrame.style.width = "1px";
		elIFrame.style.height = "1px";
		elPlaceHolder.parentNode.insertBefore(elIFrame, elPlaceHolder.nextSibling);
		
		attachEvent(elIFrame, "load", function(){
			fCreator = elIFrame.contentWindow[fCreator] || elIFrame.contentWindow.createSEditor2;
			
//			top.document.title = ((new Date())-window.STime);
//			window.STime = new Date();
			
			try{
			
				nEditorWidth = elIFrame.contentWindow.document.body.scrollWidth || "500px";
				nEditorHeight = elIFrame.contentWindow.document.body.scrollHeight + 12;
				elIFrame.style.width =  "100%";
				elIFrame.style.height = nEditorHeight+ "px";
				elIFrame.contentWindow.document.body.style.margin = "0";
			}catch(e){
				nhn.husky.EZCreator.hideBlocker(true);
				elIFrame.style.border = "5px solid red";
				elIFrame.style.width = "500px";
				elIFrame.style.height = "500px";
				alert("Failed to access "+sSkinURI);
				return;
			}
			
			var oApp = fCreator(elPlaceHolder, htParams);	// oEditor
			

			oApp.elPlaceHolder = elPlaceHolder;

			oAppRef[oAppRef.length] = oApp;
			if(!oAppRef.getById) oAppRef.getById = {};
			
			if(elPlaceHolder.id) oAppRef.getById[elPlaceHolder.id] = oApp;

			oApp.run({fnOnAppReady:fOnAppLoad}); 
			
//			top.document.title += ", "+((new Date())-window.STime);
			nhn.husky.EZCreator.hideBlocker();
		});
//		window.STime = new Date();
		elIFrame.src = sSkinURI;
		this.elIFrame = elIFrame;
	};
	
	this.showBlocker = function(){
		if(this.nBlockerCount<1){
			var elBlocker = document.createElement("DIV");
			elBlocker.style.position = "absolute";
			elBlocker.style.top = 0;
			elBlocker.style.left = 0;
			elBlocker.style.backgroundColor = "#FFFFFF";
			elBlocker.style.width = "100%";

			document.body.appendChild(elBlocker);
			
			nhn.husky.EZCreator.elBlocker = elBlocker;
		}

		nhn.husky.EZCreator.elBlocker.style.height = Math.max(document.body.scrollHeight, document.body.clientHeight)+"px";
		
		this.nBlockerCount++;
	};
	
	this.hideBlocker = function(bForce){
		if(!bForce){
			if(--this.nBlockerCount > 0) return;
		}
		
		this.nBlockerCount = 0;
		
		if(nhn.husky.EZCreator.elBlocker) nhn.husky.EZCreator.elBlocker.style.display = "none";
	}
})();


</script>
<script>

function save(){
	oEditors.getById["txtContent"].exec("UPDATE_CONTENTS_FIELD", []);  
    		//스마트 에디터 값을 텍스트컨텐츠로 전달
	var content = document.getElementById("smartEditor").value;
	alert(document.getElementById("txtContent").value); 
    		// 값을 불러올 땐 document.get으로 받아오기
	return; 
}

</script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/src/main/webapp/editorcss/css/ko_KR/smart_editor2.css">
</head>
<body>

<textarea  name="content "id="txtContent" rows="10" cols="100" style="width: 100%;"></textarea>

<script id="smartEditor" type="text/javascript"> 
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
   oAppRef: oEditors,
   elPlaceHolder: "txtContent",  //textarea ID 입력
   sSkinURI: "../editor/SmartEditor2Skin.html",  //martEditor2Skin.html 경로 입력
   fCreator: "createSEditor2",
   htParams : { 
   	// 툴바 사용 여부 (true:사용/ false:사용하지 않음) 
       bUseToolbar : true, 
// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음) 
bUseVerticalResizer : false, 
// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음) 
bUseModeChanger : false 
   }
});
</script>

<div id="se2_sample" style="margin:10px 0;">
	<input type="button" onclick="save();" value="본문 내용 가져오기">	
</div>
</body>
</html>