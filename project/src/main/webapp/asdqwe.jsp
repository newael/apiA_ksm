<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Layout3-1</title>
    <style>
        * {margin: 0; padding: 0;}
        body {background: #f3e5f5;}
        #wrap {width: 1200px; margin: 0 auto;} 
        header {width: 100%; height: 150px; background: #9575cd;}
        aside {float: left; width: 30%; height: 700px; background: #7e57c2;}
        section {float: left; width: 70%; height: 700px; background: #673ab7;}
        footer {clear: both; width: 100%; height: 150px; background: #5e35b1;}

        /* 화면 너비 0 ~ 1200px */
        @media (max-width: 1220px){
            #wrap {width: 95%;}
        }

        /* 화면 너비 0 ~ 768px */
        @media (max-width: 768px){
            #wrap {width: 100%;}
        }

        /* 화면 너비 0 ~ 480px */
        @media (max-width: 480px){
            #wrap {width: 100%;}
            header {height: 300px;}
            aside {float: none; width: 100%; height: 300px;}
            section {float: none; width: 100%; height: 300px;}
        }
    </style>
</head>
<body>
    <div id="wrap">
        <header></header>
        <aside></aside>
        <section></section>
        <footer></footer>
    </div>
</body>
</html>