<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
		<form action="JoinProcess.jsp" method="post" class="mb-3">
			<h1 class="h3 mb-3 fw-nomal">회원가입</h1>
			<% if ("id".equals(request.getParameter("joinFailed"))) { %>
				<div class="alert alert-danger" role="alert">
				    이미 생성된 id 입니다.
				</div>
			<% } else if ("password".equals(request.getParameter("joinFailed"))) { %>
				<div class="alert alert-danger" role="alert">
				    비밀번호와 비밀번호 확인이 같지 않습니다.
				</div>
			<% } %>
			<div class="form-floating">
				<input class="form-control" type="text" name="id" id="idInput" maxlength="20" required><br/>
				<label for="idInput">아이디</label>
			</div>
			<div class="form-floating">
				<input class="form-control" type="password" name="pw" id="pwInput" maxlength="100" required><br/>
				<label for="pwInput">비밀번호</label>
			</div>
			<div class="form-floating">
				<input class="form-control" type="password" name="confirm" id="pwConfirm" maxlength="100" required><br/>
				<label for="pwConfirm">비밀번호 확인</label>
			</div>
			<div class="form-floating">
				<input class="form-control" type="text" name="name" id="nameInput" maxlength="20" required><br/>
				<label for="nameInput">사용자명</label>
			</div>
			<input class="w-100 btn btn-lg btn-primary" type="submit" value="회원가입"><br/>
		</form>
</main>

</body>
</html>