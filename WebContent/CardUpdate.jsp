<%@page import="card.CardDAO"%>
<%@page import="card.CardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Practice</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
<script src="https://kit.fontawesome.com/23268a4293.js" crossorigin="anonymous"></script>
<link href="css/cardView.css" rel="stylesheet" type="text/css">
</head>
<%
		String method = request.getMethod();
		CardBean card = null;
		boolean status = false;
		
		if (method.equals("GET")) {
		    status = false;
		} else if (method.equals("POST")) {
			CardDAO cardDAO = new CardDAO();
			String cardNo = request.getParameter("cardNo");
			if (cardNo != null){
				card = cardDAO.cardView(Integer.parseInt(cardNo));
				status = true;
			}
		}
	%>
<body>
	<%@ include file="./templates/header.jsp" %>
	<% if (status) {%>
	<form action="CardUpdateServlet" encType = "multipart/form-data" method="post" class="mb-3" style="max-width: 540px; margin: auto;">
		<div id="card" class="card mb-3">
		  <div class="row g-0">
		    <div>
		      <div class="card-body ms-3">
		      	<input class="form-control mb-2" style="width:50%;" type="text" name="role" id="roleInput" placeholder="직책" required value="<%=card.getRole()%>">
		        <h5 class="card-title">
		        	<input class="form-control" type="text" name="name" id="nameInput" placeholder="이름" required value="<%=card.getName()%>"><br/>
				</h5>
				<div class="input-group mb-2">
				  <span class="input-group-text"><i class="fa-solid fa-mobile"></i></span>
				  <input class="form-control" type="text" name="phone" id="phoneInput" placeholder="전화번호" required value="<%=card.getPhone()%>"><br/>
				</div>
				<div class="input-group mb-2">
				  <span class="input-group-text"><i class="fa-solid fa-phone"></i></span>
				  <input class="form-control" type="text" name="company_phone" id="company_phoneInput" placeholder="회사번호" required value="<%=card.getCompany_number()%>"><br/>
				</div>
				<div class="input-group mb-2">
				  <span class="input-group-text"><i class="fa-solid fa-envelope"></i></span>
				  <input class="form-control" type="text" name="email" id="emailInput" placeholder="이메일" required value="<%=card.getEmail()%>"><br/>
				</div>
				<div class="input-group mb-2">
				  <span class="input-group-text"><i class="fa-solid fa-building"></i></span>
				  <input class="form-control" type="text" name="company_address" id="company_addressInput" placeholder="주소" required value="<%=card.getCompany_address()%>"><br/>
				</div>
		      </div>
		    </div>
		  </div>
		</div>
		<div>기존 파일: <%=card.getImage() %></div>
		<div class="input-group mb-3" style="max-width: 540px; margin: auto;">
		  	<label class="input-group-text" for="inputGroupFile01">사진</label>
		  	<input type="file" class="form-control" name="image" id="inputGroupFile01" value="<%=card.getImage() %>">	
		</div>
		<div class="input-group mb-3" style="max-width: 540px; margin: auto;">
			<label class="input-group-text" for="passwordCheckInput">비밀글</label>
		  	<% if (card.getPassword() != null) {%>
			  	<div class="input-group-text">
			    	<input class="form-check-input mt-0" type="checkbox" id="passwordCheckInput" onclick="togglePasswordInput()" value="" checked>
			  	</div>
		  		<input type="password" class="form-control" name="password" id="passwordInput" value=<%=card.getPassword() %>>
		  	<%} else {%>
			  	<div class="input-group-text">
			    	<input class="form-check-input mt-0" type="checkbox" id="passwordCheckInput" onclick="togglePasswordInput()" value="">
			  	</div>
		  		<input type="password" class="form-control" name="password" id="passwordInput" disabled>
		  	<%} %>
		</div>
		<input type="hidden" name="originImg" value="<%=card.getImage()%>">
		<input type="hidden" name="cardNo" value="<%=card.getCardNo()%>">
		<div class="text-center">
    		<input type="submit" class="btn btn-dark rounded-pill col-6 mt-3" value="작성">
    	</div>
	</form>
	<%} else { %>
		<div style="text-align: center">
			<h1>잘못된 접근입니다.</h1>
		</div>
	<%} %>
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