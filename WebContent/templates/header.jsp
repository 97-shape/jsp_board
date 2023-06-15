<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
</head>
<body>
<div class="container">
	<header class="d-flex flex-wrap align-items-center justify-content-center justify-content-md-between py-3 mb-4 border-bottom">
		<a href="Main.jsp" class="d-flex align-items-center col-md-3 mb-2 mb-md-0 text-dark text-decoration-none">
			<h3>Practice</h3>
		</a>
		
		<ul class="nav col-12 col-md-auto mb-2 justify-content-center mb-md-0">
			<li><a href="Main.jsp" class="nav-link px-2 link-secondary">홈</a></li>
			<li><a href="BoardList.jsp" class="nav-link px-2 link-dark">게시판</a></li>
			<li><a href="CardList.jsp" class="nav-link px-2 link-dark">명함</a></li>
		</ul>
		<div class="col-md-3 text-end">
			<% if(session.getAttribute("userID")==null) { %>
				<button type="button" class="btn btn-outline-primary me-2" onclick="location.href='Login.jsp'">로그인</button>
				<button onclick="location.href='Join.jsp'" type="button" class="btn btn-outline-primary">회원가입</button>
			<% }else { %>
				<span class="me-2"><%=(String)session.getAttribute("userName") + "님 로그인 중"%></span>
				<button onclick="location.href='MyPage.jsp'" type="button" class="btn btn-secondary">마이 페이지</button>
				<button onclick="location.href='Logout.jsp'" type="button" class="btn btn-danger">로그아웃</button>
			<% } %>
		</div>
	</header>
</div>
</body>
</html>