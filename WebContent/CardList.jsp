<%@page import="card.CardBean"%>
<%@page import="card.CardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%!
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
    
<%

	String pageStr = request.getParameter("page");
	String pageSizeStr = request.getParameter("size");
	
	if (pageStr == null) {
		pageStr = "1";
	}
	
	if (pageSizeStr == null) {
		pageSizeStr = "10";
	}
	
	int currPage = Integer.parseInt(pageStr);
	int pageSize = Integer.parseInt(pageSizeStr);
	int start = (currPage - 1) * pageSize;
	int end = currPage * pageSize;
	
	List<CardBean> cardList = null;  // 그냥 선언만 해주면 오류 발생
	
	// BoardDAO 인스턴스 생성
	CardDAO cardDAO = new CardDAO();
	
	cardList = cardDAO.cardListGet(start, end);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
<script src="https://kit.fontawesome.com/23268a4293.js" crossorigin="anonymous"></script>

<link href="css/cardView.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%-- include를 이용한 header및 footer 가져오기 --%>
	<%@ include file="./templates/header.jsp" %>
	<%@ include file="./templates/footer.jsp" %>
	<div style="max-width: 720px; margin: 4rem auto;">
		<h1 style="text-align: center">게시판 목록</h1>
			<select class="form-select" aria-label="Default select example">
			  <option value="name" selected>이름</option>
			  <option value="role">직책</option>
			  <option value="">Two</option>
			  <option value="3">Three</option>
			</select>
            <% for (CardBean card : cardList) { %>
	            <div id="card" class="card mb-3" style="max-width: 540px; margin: auto; cursor:pointer" onclick="redirectToPage('<%=card.getCardNo() %>')">
				  <div class="row g-0">
				    <div class="col-md-4 d-flex align-items-center">
				      <img src="Media/card/<%=card.getImage() %>" class="img-thumbnail rounded-start ms-2" style="max-height:200px;" alt="...">
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
	        <% } %>
	        <%
	        	//로그인 여부 파악 후 명함 생성 가능하게
		        boolean isLoggedIn = (session != null && session.getAttribute("userID") != null);
	        	if (isLoggedIn) {
	        %>
	        	<button type="button" class="btn btn-primary float-end" onclick="downloadAsImage()">등록하기</button>
	        <%} %>
	 </div>
	 
	 <script>
	    function redirectToPage(cardNo) {
	        var url = "CardView.jsp?cardNo=" + cardNo;
	        window.location.href = url;
	    }
	</script>	
</body>
</html>