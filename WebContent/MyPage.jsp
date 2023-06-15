<%@page import="card.CardDAO"%>
<%@page import="card.CardBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>Practice</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
	<link href="css/cardView.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%@ include file="./templates/header.jsp" %>
	
	<div style="max-width: 1200px; margin: 4rem auto;">
		<h2 style="; margin-bottom: 3rem; text-align:center;">
			<% if (session.getAttribute("userID") == null) { %>
				<p>로그인 후 이용가능합니다.</p>
			<%}else {%>
				<%=session.getAttribute("userName") %>님
	    </h2>
	    <%
			List<CardBean> cardList = null;  // 그냥 선언만 해주면 오류 발생
			
			// BoardDAO 인스턴스 생성
			CardDAO cardDAO = new CardDAO();
			
			cardList = cardDAO.cardUserList((String)session.getAttribute("userID"));
		%>
	    <h3 style="text-align:center; margin-bottom: 3rem;">작성글</h3>
	    
	    <div class="row">
	    <% for (CardBean card : cardList) { %>
           <% if (card.getPassword() == null) {%>
            <div class="col">
	            <div id="card" class="card mb-3" style="width: 376px; height: 216px; margin: auto; cursor:pointer" onclick="redirectToPage('<%=card.getCardNo() %>')">
				  <div class="row g-0">
				    <div class="col-md-4 d-flex align-items-center" style="height:216px">
				      <img src="Media/card/<%=card.getImage() %>" class="img-thumbnail rounded-start ms-3" style="width: 150px; height: 200px;" alt="...">
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
			</div>
			<%} else  {%>
			<div class="col">
	           	<div id="card" class="card d-flex justify-content-center align-items-center mb-3" style="width: 376px; height: 216px; margin: auto; cursor:pointer" onclick="redirectToSecreatPage('<%=card.getCardNo() %>')" >
		      		<h4 class=""><%=card.getName() %>님의 비공개 명함</h4>
		      	</div>
			</div>
			<% } %>
		<% } %>
	        
		<% } %>
    </div>
	
	<%@ include file="./templates/footer.jsp" %>
</body>
</html>