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
	
	<title>명함</title>
	
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
		if (cardNo != null){
			card = cardDAO.cardView(Integer.parseInt(cardNo));
		}
	%>
    
  </head>
  <body>
    <%@ include file="./templates/header.jsp" %>
	<%@ include file="./templates/footer.jsp" %>
	<div style="max-width: 540px; margin: 4rem auto;">
		<% if (card == null) { %>
			<div style="text-align: center">
				<h1>잘못된 접근입니다.</h1>
			</div>
		<%}else {%>
		<div id="card" class="card mb-3" style="max-width: 540px; margin: auto;">
		  <div class="row g-0">
		    <div class="col-md-4 d-flex align-items-center">
		      <img src="Media/card/<%=card.getImage() %>" class="img-thumbnail rounded-start ms-2" alt="...">
		    </div>
		    <div class="col-md-8">
		      <div class="card-body ms-3">
		      	<p class="card-text"><small class="text-body-secondary"><%=card.getRole()%></small></p>
		        <h5 class="card-title"><%=card.getName() %></h5>
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
		</div>
		<% } %>
      </div>
  </body>
</html>