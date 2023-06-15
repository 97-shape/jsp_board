<%@page import="card.CardDAO"%>
<%@page import="card.CardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!doctype html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
	<script src="https://kit.fontawesome.com/23268a4293.js" crossorigin="anonymous"></script>
	
	<link href="css/cardView.css" rel="stylesheet" type="text/css">
	
	<title>Practice</title>
	
	<!-- 파일 다운로드 파일 -->
	<script src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>
	<script>
	  function downloadAsImage() {
	  const div = document.getElementById("card");
	  const canvas = document.createElement("canvas");
	  const context = canvas.getContext("2d");
	  canvas.width = div.offsetWidth;
	  canvas.height = div.offsetHeight;
	
	  html2canvas(div).then((canvas) => {
	    const imageUrl = canvas.toDataURL("image/jpeg");
	    const link = document.createElement("a");
	    link.href = imageUrl;
	    link.download = "명함.jpg";
	    link.click();
	  });
	}
	</script>
	
	<!-- DB -->
	<%
		CardBean card = null;
		CardDAO cardDAO = new CardDAO();
		String cardNo = request.getParameter("cardNo");
		int card_authority = 0;
		// 비밀글인가? 암호가 일치하는가?를 확인
		try {
			card = cardDAO.cardView(Integer.parseInt(cardNo));
			if (card.getPassword() != null){
				card_authority = (Integer)session.getAttribute("card_authority");
				session.removeAttribute("card_authority");
			}
			else{
				card_authority = Integer.parseInt(cardNo);
			}
		}catch(Exception ex){
			
		}
	%>
    
  </head>
  <body>
    <%@ include file="./templates/header.jsp" %>
	<div style="width: 470px; margin: 4rem auto;">
		<% if (card == null || card_authority != Integer.parseInt(cardNo)) { %>
			<div style="text-align: center">
				<h1>잘못된 접근입니다.</h1>
			</div>
		<%}else {%>
		<div id="card" class="card mb-3" style="width: 470px; height: 270px; margin: auto;">
		  <div class="row g-0">
		    <div class="col-md-4 d-flex align-items-center" style="height:270px">
		      <img src="Media/card/<%=card.getImage() %>" class="img-thumbnail rounded-start ms-3" style="width: 180px; height: 240px;" alt="...">
		    </div>
		    <div class="col-md-8">
		      <div class="card-body ms-5">
		      	<p class="card-text"><small class="text-body-secondary"><%=card.getRole()%></small></p>
		        <h5 class="card-title mb-3"><%=card.getName() %></h5>
		        <p class="card-text"><i class="fa-solid fa-mobile"></i><%=card.getPhone() %></p>
		        <p class="card-text"><i class="fa-solid fa-phone"></i><%=card.getCompany_number() %></p>
		        <p class="card-text"><i class="fa-solid fa-envelope"></i><%=card.getEmail() %></p>
		        <p class="card-text"><i class="fa-solid fa-building"></i><%=card.getCompany_address() %></p>
		      </div>
		    </div>
		  </div>
		</div>
		<div>
			<button type="button" class="btn btn-primary float-end" onclick="downloadAsImage()">다운로드</button> <!-- 명함 다운로드 버튼 -->
			<%if (card.getUserID().equals(session.getAttribute("userID"))) {%>
				<form id="updateForm" action="CardDeleteServlet" method="post">
				  	<input type="hidden" name="cardNo" value="<%=cardNo%>">
				  	<button type="submit" class="btn btn-danger float-end me-2">삭제</button>
				</form>
				<form id="updateForm" action="CardUpdate.jsp" method="post">
				  	<input type="hidden" name="cardNo" value="<%=cardNo%>">
				  	<button type="submit" class="btn btn-secondary float-end me-2">수정</button>
				</form>
			<%} %>
		</div>
		<% } %>
      </div>
      <%@ include file="./templates/footer.jsp" %>
  </body>
</html>