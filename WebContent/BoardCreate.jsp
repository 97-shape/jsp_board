<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pratice</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
<script src="https://kit.fontawesome.com/23268a4293.js" crossorigin="anonymous"></script>
</head>
<body>
	<%@ include file="./templates/header.jsp" %>
	
	<%
		request.setCharacterEncoding("UTF-8");
		session.getAttribute("userID");
	%>
	
	<form action="BoardCreateServlet" encType = "multipart/form-data" method="post" class="mb-3" style="max-width: 540px; margin: auto;">
		<div class="input-group mb-3" style="width: 100%; margin: auto;">
			<label class="input-group-text" for="titleInput">제목</label>
		  	<input type="text" class="form-control" name="title" id="titleInput" required>
		</div>
		<div class="form-floating mb-2" style="width: 100%; height:300px; margin: auto;">
			<textarea class="form-control" name="content" placeholder=" " id="contentInput" style="height: 300px; resize: none;"></textarea>
			<label for="contentInput">내용</label>
		</div>
		<div class="input-group mb-3" style="max-width: 540px; margin: auto;">
		  	<label class="input-group-text" for="inputFile">첨부파일</label>
		  	<input type="file" class="form-control" name="file" id="inputFile">
		</div>
		<div class="input-group mb-3" style="max-width: 540px; margin: auto;">
			<label class="input-group-text" for="passwordCheckInput">비밀글</label>
		  	<div class="input-group-text">
		    	<input class="form-check-input mt-0" type="checkbox" id="passwordCheckInput" onclick="togglePasswordInput()" value="">
		  	</div>
		  	<input type="password" class="form-control" name="password" id="passwordInput" disabled>
		</div>
		<input type="hidden" name="ref" value="<%= request.getParameter("ref") %>">
	  	<input type="hidden" name="ref_level" value="<%= request.getParameter("ref_level") %>">
	  	<input type="hidden" name="ref_step" value="<%= request.getParameter("ref_step") %>">
		<div class="text-center">
    		<input type="submit" class="btn btn-dark rounded-pill col-6 mt-3" value="작성">
    	</div>
	</form>
	<%@ include file="./templates/footer.jsp" %>
<script>
	
	//비밀글 체크 시 활성화 및 필수 입력 처리
  	function togglePasswordInput() {
    	var passwordInput = document.getElementById("passwordInput");
    	var passwordCheckInput = document.getElementById("passwordCheckInput");

    	if (passwordCheckInput.checked) {
      		 passwordInput.disabled = false;
      		passwordInput.setAttribute("required", "required");
    	} else {
      		passwordInput.disabled = true;
      		passwordInput.removeAttribute("required");
      		passwordInput.value = "";
    	}
  	}
</script>
</body>
</html>