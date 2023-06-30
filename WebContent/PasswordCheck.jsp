<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Practice</title>
</head>
<body>
<% 
	request.setCharacterEncoding("UTF-8"); // 글자 깨짐 방지
	String cardNo = request.getParameter("cardNo");
	String boardNo = request.getParameter("boardNo");
	String type="";
	String no="";
	if (cardNo != null){
		type = "Card";
		no = cardNo;
	}
	else if (boardNo != null){
		type = "Board";
		no = boardNo;
	}
	else
		response.sendRedirect("Main.jsp");
%>
<%@ include file="./templates/header.jsp" %>
	<div style="width: 470px; margin: 4rem auto; text-align: center;">
		<form action="<%=type %>PasswordCheckServlet" method="post" class="mb-3">
			<h1 class="h3 mb-3 fw-nomal">비공개</h1>
			<h6 class="fw-nomal">암호를 입력해 주세요</h6>
			<% if ("true".equals(request.getParameter("passwordWrong")))  {%>
				<div class="alert alert-danger" role="alert">
				    아이디와 비밀번호를 확인해주세요.
				</div>
			<% } %>
			<div class="form-floating w-30">
				<input class="form-control" type="password" name="pw" id="pwInput" required><br/>
				<label for="pwInput">비밀번호</label>
			</div>
			<input class="visually-hidden" name="no" value=<%=no %>>
			<input class="w-30 btn btn-lg btn-primary" type="submit" value="확인"><br/>
		</form>
	</div>
<%@ include file="./templates/footer.jsp" %>
</body>
</html>