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
	<script src="https://kit.fontawesome.com/23268a4293.js" crossorigin="anonymous"></script>
</head>
<body>
	<%@ include file="./templates/header.jsp" %>
	
	<div style="max-width: 1200px; margin: 4rem auto;">
		<h2 style="; margin-bottom: 3rem; text-align:center;">
			<% if (session.getAttribute("userID") == null) { %>
				<p>로그인 후 이용가능합니다.</p>
			<%}else {%>
				<%=session.getAttribute("userName") %>님
				<button type="button" class="btn btn-primary" onclick="location.href='ChangeInfo.jsp'">정보 수정하기</button>
	    </h2>
	    <%
			List<CardBean> cardList = null;  // 그냥 선언만 해주면 오류 발생
			
			// BoardDAO 인스턴스 생성
			CardDAO cardDAO = new CardDAO();
			
			cardList = cardDAO.cardUserList((String)session.getAttribute("userID"));
		%>
		<% } %>
    </div>
	
	<%@ include file="./templates/footer.jsp" %>
</body>
</html>