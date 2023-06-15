<%@page import="card.CardBean"%>
<%@page import="card.CardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("UTF-8");
	String name = request.getParameter("name");
	String pageStr = request.getParameter("page");
	String pageSizeStr = request.getParameter("size");
	
	if (name == null) {
		response.sendRedirect("CardList.jsp");
	}
	
	if (pageStr == null) {
		pageStr = "1";
	}
	
	if (pageSizeStr == null) {
		pageSizeStr = "6";
	}
	
	int currPage = Integer.parseInt(pageStr);
	int firstPage = currPage/6;
	int pageSize = Integer.parseInt(pageSizeStr);
	int start = (currPage - 1) * pageSize;
	
	List<CardBean> cardList = null;  // 그냥 선언만 해주면 오류 발생
	
	// BoardDAO 인스턴스 생성
	CardDAO cardDAO = new CardDAO();
	
	cardList = cardDAO.cardFilterListGet(start, pageSize, name);
	int loadSize = cardDAO.cardFilterTotalCount(name);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pratice</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
<script src="https://kit.fontawesome.com/23268a4293.js" crossorigin="anonymous"></script>
<style>
	.pagination-container {
	  display: flex;
	  justify-content: center;
	  margin-top: 2rem;
	}
	
	.pagination {
	  display: inline-flex;
	}
	
	.pagination .page-item:first-child .page-link {
	  margin-left: 0;
	}
	
	.pagination .page-item:last-child .page-link {
	  margin-right: 0;
	}
</style>
<link href="css/cardView.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%-- include를 이용한 header및 footer 가져오기 --%>
	<%@ include file="./templates/header.jsp" %>
	
	<div style="max-width: 1200px; margin: 4rem auto;">
		<h1 style="text-align: center">명함 목록</h1>
		<form action="CardFilteredList.jsp" method="post">
			<div class="input-group mb-3">
				<input type="text" class="form-control" placeholder="이름으로 검색" name="name" id="nameInput" value="<%=name%>">
				<button class="btn btn-outline-secondary" type="submit" id="nameSearch">검색</button>
			</div>
		</form>
		<div class="row row-cols-1 row-cols-md-3 g-4">
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
		</div>	
    <%
    	//로그인 여부 파악 후 명함 생성 가능하게
     	boolean isLoggedIn = (session != null && session.getAttribute("userID") != null);
    	if (isLoggedIn) {
    %>
    	<button type="button" class="btn btn-primary float-end" onclick="location.href='CardCreate.jsp'">등록하기</button>
    <%} %>
    <!-- pagination 5개씩 페이지 표현 -->
    <nav class="pagination-container">
	  <ul class="pagination">
	  <!-- 이전 버튼을 누르면 나오는 페이지가 있다 -->
	  <% if (currPage > 5) {%>
	  	<li class="page-item">
	      <a class="page-link" href="CardList.jsp?page=<%=firstPage%>&size=<%=pageSize%>" aria-label="Previous">
	        <span aria-hidden="true">&laquo;</span>
	      </a>
	    </li>
	  <%} else { %>
	  	<li class="page-item disabled">
	      <a class="page-link" href="#" aria-label="Previous">
	        <span aria-hidden="true">&laquo;</span>
	      </a>
	    </li>
	  <%} %>
	  	<% for (int i = firstPage * 5 +1; i <= Math.min((firstPage+1) * 5, (loadSize + pageSize - 1) / pageSize); i++) {
		%>
		    <li class="page-item">
		        <a class="page-link" href="CardList.jsp?page=<%=i%>&size=<%=pageSize%>"><%=i %></a>
		    </li>
		<%
		}
		%>
	  	<% if ((firstPage+1) * 5 > (loadSize + pageSize - 1) / pageSize) {%>
	  	<li class="page-item disabled">
	      <a class="page-link" href="#" aria-label="Next">
	        <span aria-hidden="true">&raquo;</span>
	      </a>
	    </li>
	  <%} else { %>
	  	<li class="page-item">
	      <a class="page-link" href="CardList.jsp?page=<%=firstPage+6%>&size=<%=pageSize%>" aria-label="Next">
	        <span aria-hidden="true">&raquo;</span>
	      </a>
	    </li>
	  <%} %>
	  </ul>
	</nav>
    </div>
	 <%@ include file="./templates/footer.jsp" %>
	 <script>
	    function redirectToPage(cardNo) {
	        var url = "CardView.jsp?cardNo=" + cardNo;
	        window.location.href = url;
	    }
	    
	    function redirectToSecreatPage(cardNo) {
	        var url = "PasswordCheck.jsp?cardNo=" + cardNo;
	        window.location.href = url;
	    }
	</script>	
</body>
</html>