<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>Practice</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
	<style>
		html, body {
			height: 100%;
			display: flex;
			justify-content: center;
			align-items: center;
		}
		.form-signin {
			text-align: center;
			width: 330px;
			margin: auto;
		}
	</style>
</head>
<body>
	<main class="form-signin">
		<form action="LoginCheck.jsp" method="post" class="mb-3">
			<h1 class="h3 mb-3 fw-nomal">로그인</h1>
			<% if ("true".equals(request.getParameter("loginFailed"))) { %>
				<div class="alert alert-danger" role="alert">
				    아이디와 비밀번호를 확인해주세요.
				</div>
			<% } %>
			<div class="form-floating">
				<input class="form-control" type="text" name="id" id="idInput" required><br/>
				<label for="idInput">아이디</label>
			</div>
			<div class="form-floating">
				<input class="form-control" type="password" name="pw" id="pwInput" required><br/>
				<label for="pwInput">비밀번호</label>
			</div>
			<input class="w-100 btn btn-lg btn-primary" type="submit" value="로그인"><br/>
		</form>
		<hr>
		<a class="w-100 btn btn-lg btn-secondary" href="Join.jsp">회원가입</a><br/>
	</main>
</body>
</html>